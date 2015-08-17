From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 2/2] pwm: core: Set enable state properly on failed
 call to enable
Date: Mon, 17 Aug 2015 16:31:09 +0200
Message-ID: <20150817143108.GD6891@ulmo.nvidia.com>
References: <1434403262-24198-1-git-send-email-jonathar@broadcom.com>
 <1434403262-24198-3-git-send-email-jonathar@broadcom.com>
 <557F5E33.2050706@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34705 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbbHQOcQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2015 10:32:16 -0400
Content-Disposition: inline
In-Reply-To: <557F5E33.2050706@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2015 at 04:22:27PM -0700, Jonathan Richardson wrote:
> On 15-06-15 02:21 PM, Jonathan Richardson wrote:
> > The pwm_enable function didn't clear the enabled bit if a call to a
> > clients enable function returned an error. The result was that the state
> > of the pwm core was wrong. Clearing the bit when enable returns an error
> > ensures the state is properly set.
> >=20
> > Tested-by: Jonathan Richardson <jonathar@broadcom.com>
> > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> > ---
> >  drivers/pwm/core.c  |   19 ++++++++++++++++---
> >  include/linux/pwm.h |    2 ++
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 76b0386..c255267 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -263,6 +263,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> >  		pwm->pwm =3D chip->base + i;
> >  		pwm->hwpwm =3D i;
> >  		pwm->polarity =3D polarity;
> > +		mutex_init(&pwm->lock);
> > =20
> >  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
> >  	}
> > @@ -474,10 +475,22 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
> >   */
> >  int pwm_enable(struct pwm_device *pwm)
> >  {
> > -	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
> > -		return pwm->chip->ops->enable(pwm->chip, pwm);
> > +	int err =3D 0;
> > =20
> > -	return pwm ? 0 : -EINVAL;
> > +	if (!pwm)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&pwm->lock);
> > +
> > +	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
> > +		err =3D pwm->chip->ops->enable(pwm->chip, pwm);
> > +		if (err)
> > +			clear_bit(PWMF_ENABLED, &pwm->flags);
> > +	}
> > +
> > +	mutex_unlock(&pwm->lock);
> > +
> > +	return err;
> >  }
> >  EXPORT_SYMBOL_GPL(pwm_enable);
>=20
> I meant to add the mutex check in disable also, but what about when
> PWMF_ENABLED is checked in pwm_set_polarity() and pwm_dbg_show()?

I think for debugfs we're fine since there's no potential to race there.
It'll simply show the state of the PWM at the point where it was queried
even though that may change immediately after. I suppose we could keep
the lock across the body of the loop just to make sure debugfs will show
a consistent view of the PWM.

For pwm_disable() I don't think we need the lock, since the test_and_
clear_bit() is atomic and ->disable() cannot fail.

As for pwm_set_polarity(), I think it would need to be something like
the below:

---- >8 ----

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3f9df3ea3350..8488c7a19bf6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -473,16 +473,22 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm=
_polarity polarity)
        if (!pwm->chip->ops->set_polarity)
                return -ENOSYS;
=20
-       if (pwm_is_enabled(pwm))
-               return -EBUSY;
+       mutex_lock(&pwm->lock);
+
+       if (pwm_is_enabled(pwm)) {
+               err =3D -EBUSY;
+               goto unlock;
+       }
=20
        err =3D pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
        if (err)
-               return err;
+               goto unlock;
=20
        pwm->polarity =3D polarity;
=20
-       return 0;
+unlock:
+       mutex_unlock(&pwm->lock);
+       return err;
 }
 EXPORT_SYMBOL_GPL(pwm_set_polarity);
=20

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV0fAsAAoJEN0jrNd/PrOhk8YP/RUQnhhXo/nt+mAzzTpqBH3b
BJ0Fx7NiAtFxwq9IAEFHDaA/lt4zwzutGIu3yU6T+7Pg4gaSWhxnDsZVzGpuzorb
q5a5Ly5hf+rdMZ0seN/BHezwRaktHlkd+s2YfXfprncKPUJUIhA9JOg2PS9UxTJI
0A0W3O1+dkL/WHGfMoOPjlbYHjzlLv3vHByVdGT8UaSYP++1E/Z1L6BrSkpruE8L
EDrtu3DTawgMjHFAcP9vGrmmE2YAUv6KxW9WnS8/lqs00cwUu/paljW92dV5tNXC
w513RkwVNREAhiVYvp95xZ4oxTfiZ8+ejuP1YwVGUJz07ZTkHmQaVWdojSEmFlEt
UJkcoQbEBeTnFzDxCn2k8Sg9LhNB6gHPzEFOdVplJGKEI/nFOfsjKa4/mruHk53b
4xyfxLjFw95kFlQp6/361PvRBA8MIOdgjXwDu+IrrNP3h735KbpXFMoGrs4Y+1fT
Q30pM9JVTd+hoaut2FOgqPOssMwddVbfpuFsTkyPDTVmh92E249XxKSGVNp69QTX
9H8n/y8oyKWdL2pr2FfJ5aXPmTLFFdlQN5MZR6LE+dW/iz77uXqD4W7KkiWxF7yi
qY5Dx1WH+QzNjXLBVHy7+3S7YOo2uSbBhEHCp00QlNYjXKzkM96Q0DeaZSMOYAAf
191FS6sFcDp6p5q5xM0G
=Qou0
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
