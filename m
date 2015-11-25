From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: berlin: Add PM support
Date: Wed, 25 Nov 2015 16:16:27 +0100
Message-ID: <20151125151627.GB31492@ulmo.nvidia.com>
References: <1448343785-1540-1-git-send-email-jszhang@marvell.com>
 <20151124162306.GC32623@ulmo.nvidia.com>
 <20151125163019.64e80799@xhacker>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34471 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbbKYPQb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Nov 2015 10:16:31 -0500
Content-Disposition: inline
In-Reply-To: <20151125163019.64e80799@xhacker>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: sebastian.hesselbarth@gmail.com, antoine.tenart@free-electrons.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2015 at 04:30:19PM +0800, Jisheng Zhang wrote:
> On Tue, 24 Nov 2015 17:23:06 +0100 Thierry Reding wrote:
> > On Tue, Nov 24, 2015 at 01:43:05PM +0800, Jisheng Zhang wrote:
> > > This patch adds S2R support for berlin pwm driver.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > ---
> > >  drivers/pwm/pwm-berlin.c | 57 ++++++++++++++++++++++++++++++++++++++=
+++++++++-
> > >  1 file changed, 56 insertions(+), 1 deletion(-)
[...]
> > > +	for (i =3D 0; i < pwm->chip.npwm; i++) {
> > > +		struct berlin_pwm_context *ctx =3D &pwm->ctx[i];
> > > +
> > > +		berlin_pwm_writel(pwm, i, ctx->ctrl, BERLIN_PWM_CONTROL);
> > > +		berlin_pwm_writel(pwm, i, ctx->duty, BERLIN_PWM_DUTY);
> > > +		berlin_pwm_writel(pwm, i, ctx->tcnt, BERLIN_PWM_TCNT);
> > > +		berlin_pwm_writel(pwm, i, ctx->enable, BERLIN_PWM_ENABLE);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
> > > +			 berlin_pwm_resume);
> > > +#define BERLIN_PWM_PM_OPS	(&berlin_pwm_pm_ops)
> > > +#else
> > > +#define BERLIN_PWM_PM_OPS	NULL
> > > +#endif =20
> >=20
> > This is a weird way of writing this. I think a more typical way would be
> > to have the #ifdef contain only the implementation and then define the
> > dev_pm_ops variable unconditonally, so you don't need a separate macro
> > for it.
> >=20
>=20
> The reason why I introduced one more macro is: struct dev_pm_ops contains
> 23 pointers now, if there's no BERLIN_PWM_PM_OPS macro, there will be alw=
ays a
> dev_pm_ops even if PM_SLEEP isn't enabled. I dunno whether there's any
> elegant solution for this case.

I wouldn't bother. PM_SLEEP is in almost all cases going to be enabled.
If it isn't enabled it's likely going to be in test builds, at which
point nobody will care about the extra 23 pointers.

> How about define SIMPLE_DEV_PM_OPS as NULL if PM_SLEEP isn't enabled?

That won't work, "static NULL;" wouldn't be valid syntax. Like I said,
if you go through the trouble of implementing suspend/resume, you're
almost certainly going to want to enable it, so just define it
unconditionally.

Thierry

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWVdDLAAoJEN0jrNd/PrOhhEwP/2jIcseXVE7UORX9/0+RYPGE
NiK0CsRN8TJSwVjBMmPigrxJ6NYl4Z8NzlurONGgbI6qWt3JgDy1sCmDMMq9d+ey
qFg5bsyDvhCMw8jf+XbSjsLRFMvyVK/1tui+uUpTaphvzW6pFZ3ia/uaZQk0yXf7
Xi/aOmad9WdIdBSWgObgnd6mC4/qBAe/ebXUsB6WSk0MQ2vpaibrUMe0Tpzh+Jic
GZ6n9eP1qCPJPvyPl8ObRQ+doq3M4AR+BkW4VUshEjP4Iw60Z8/Niyxg7lWNhSVJ
4mSBHACf0ZyYepJ7SyhCUgmW2W2jC1w8WQf+/EH/LVXUOsZLhWZlty+7+eA3OhBs
84R04bbGJaDwaDeJ5v9xNH+NE+pMSSzCsg/sE8Tl/bgioE8DEkO5tzHLCD+xtK4d
FIN2dFQeyLS2hiLu+LWRBfCedZ1cs1kn+BdaPQhoIpu6+bOZBvowXdKyY4A/bmBs
e5fNAlcXuOpfT6MRXsEjpwu/Zwx/Hyu9qaza/unbrhAbWFAT42AdLuB5jUIjhPnz
0tL5tiEGEi5cHfRdoyF8XG+hs+38msP0j6xJScrLlXDk96v2nSK0XnTBfP3wy4GB
42+yU9VWQDR7wyIftyeUNjjNryIqDQsmUq1J74a3OZFYojnY52tlBEn4yniI+0gb
pCKQWXJAkLZwbePxUTWh
=qsuD
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
