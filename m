From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 11/15] pwm: add the core infrastructure to allow
 atomic update
Date: Mon, 20 Jul 2015 12:04:51 +0200
Message-ID: <20150720100451.GW29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-12-git-send-email-boris.brezillon@free-electrons.com>
 <20150720085939.GL29614@ulmo>
 <20150720114827.2e5d52a5@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UTjKcilERHWBCdCp"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34332 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbbGTKFF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 06:05:05 -0400
Content-Disposition: inline
In-Reply-To: <20150720114827.2e5d52a5@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>


--UTjKcilERHWBCdCp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 11:48:27AM +0200, Boris Brezillon wrote:
> On Mon, 20 Jul 2015 10:59:40 +0200 Thierry Reding <thierry.reding@gmail.c=
om> wrote:
> > On Wed, Jul 01, 2015 at 10:21:57AM +0200, Boris Brezillon wrote:
[...]
> > > +int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *=
state)
> > > +{
> > > +	int err =3D 0;
> > > +
> > > +	if (!pwm)
> > > +		return -EINVAL;
> > > +
> > > +	if (!memcmp(state, &pwm->state, sizeof(*state)))
> > > +		return 0;
> > > +
> > > +	if (pwm->chip->ops->apply) {
> > > +		err =3D pwm->chip->ops->apply(pwm->chip, pwm, state);
> > > +		if (!err)
> > > +			pwm->state =3D *state;
> >=20
> > Maybe we want pwm_set_state() for this?
>=20
> I'm not opposed to the addition of the pwm_set_state() function as long
> as it's a private one: I don't want to let PMW drivers or users mess up
> with the current PWM state.

Yeah, it could be a static function in core.c. What I want to avoid is
having to change a bunch of code if ever state assignment becomes
something other than merely copying a structure.

[...]
> > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > index b47244a..7e99679 100644
> > > --- a/include/linux/pwm.h
> > > +++ b/include/linux/pwm.h
> > > @@ -151,6 +151,29 @@ static inline enum pwm_polarity pwm_get_polarity=
(const struct pwm_device *pwm)
> > >  	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
> > >  }
> > > =20
> > > +/*
> > > + * pwm_apply_state - apply a new state to the PWM device
> > > + */
> > > +int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *=
state);
> >=20
> > If you add kerneldoc, please add it properly. It should start with /**
> > and you need to list at least the parameters and return value.
>=20
> Yes, I'll fix that.
> BTW, I remember that you were expecting another name for this function
> (pwm_update IIRC).

I don't mind the pwm_apply_state() name very much. It's pretty accurate
with regards to what it does.

Thierry

--UTjKcilERHWBCdCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrMfCAAoJEN0jrNd/PrOhplEP/38xJM/nYyT1+LWqxsnNyxRe
oRc/XLOaMHzNqZoYwKeJtoqsr4LaB1kcPVF2M5W1Wqih0z/jABGYHE4jJun+mJK9
67iMb2GI9QtBjJee1DgX+K6SPJNA5OjGHpOMS3YdcvY03/1OsvLqZMK0wJAxw7Wc
Jguplm7Cm7CeDN7kJ+xE3bhe5fNCQa4OSPnSCubBzjdi9+N6yrE+FLXXqBrGYRR3
y05BRt8YG1I/Mc0OPhIywLYfz3rbcYlOBJRMOma4iNHWTi0XSi9LVNxwndu8IgFM
L5tHTBuGaQ12naGcZJRrCWYYHfECVYyN15FXzwiFi0n92JEwueL6IyFJIdDBuuOn
xUVUmnByb+b9pkI8579r6m4bEB07/yzoC1WW4qsLyvAKoKNJo7q/Y1ax1c6KDan3
SadAgM8J0G5pCliaI5Ff0bk++EaGedBM7kxht+61YHqReFiz5KnHmU1CmTNdxrDn
ZUEcQUyMdn/+Rr571j/b68iAt9TukMBrhKDon2C4geQdNFFdiPKXsPaP6TCqx+qX
MiBUu66wlnFZMNYFMAQzGFXC5nIkskrCSr1nHWrneZ9pqt0dvxTPCi/jduwqunu4
rKKro9Y3G4u2AcjgV0K0ygLBGMeS3pa1UzqSw0abKAUr4MDXmotMACzV3dd9rsiP
N3iABoGYaLAxNiu6zwy6
=UNA8
-----END PGP SIGNATURE-----

--UTjKcilERHWBCdCp--
