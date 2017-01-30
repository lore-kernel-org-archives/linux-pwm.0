From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 03/11] pwm: imx: Add separate set of pwm ops for PWMv1
 and PWMv2
Date: Mon, 30 Jan 2017 10:04:24 +0100
Message-ID: <20170130090424.GR3585@ulmo.ba.sec>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
 <1485726855-16236-4-git-send-email-lukma@denx.de>
 <20170130072312.GI3585@ulmo.ba.sec>
 <20170130074318.GK3585@ulmo.ba.sec>
 <20170130093649.236e67b1@jawa>
 <20170130084513.GO3585@ulmo.ba.sec>
 <20170130095504.57e4ee3e@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3gk1bTGVZuaU9V5/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33574 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbdA3JEg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 04:04:36 -0500
Content-Disposition: inline
In-Reply-To: <20170130095504.57e4ee3e@jawa>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>, Sascha Hauer <s.hauer@pengutronix.de>, Lothar Wassmann <LW@karo-electronics.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>


--3gk1bTGVZuaU9V5/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 09:55:04AM +0100, Lukasz Majewski wrote:
> Hi Thierry,
>=20
> > On Mon, Jan 30, 2017 at 09:36:49AM +0100, Lukasz Majewski wrote:
> > > Hi Thierry,
> > >=20
> > > > On Mon, Jan 30, 2017 at 08:23:12AM +0100, Thierry Reding wrote:
> > > > > On Sun, Jan 29, 2017 at 10:54:07PM +0100, Lukasz Majewski wrote:
> > > > > > From: Lukasz Majewski <l.majewski@majess.pl>
> > > > > >=20
> > > > > > This patch provides separate set of pwm ops utilized by
> > > > > > i.MX's PWMv1 and PWMv2.
> > > > > >=20
> > > > > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > > > > > Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > > > > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > > > > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > > > > > Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > ---
> > > > > > Changes for v5:
> > > > > > - None
> > > > > >=20
> > > > > > Changes for v4:
> > > > > > - None
> > > > > >=20
> > > > > > Changes for v3:
> > > > > > - Adjust the code to work with ipg clock removed
> > > > > >=20
> > > > > > Changes for v2:
> > > > > > - New patch
> > > > > > ---
> > > > > >  drivers/pwm/pwm-imx.c | 17 ++++++++++++++---
> > > > > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > > > > index b1d1e50..0fa480d 100644
> > > > > > --- a/drivers/pwm/pwm-imx.c
> > > > > > +++ b/drivers/pwm/pwm-imx.c
> > > > > > @@ -239,7 +239,14 @@ static void imx_pwm_disable(struct
> > > > > > pwm_chip *chip, struct pwm_device *pwm)
> > > > > > clk_disable_unprepare(imx->clk_per); }
> > > > > > =20
> > > > > > -static struct pwm_ops imx_pwm_ops =3D {
> > > > > > +static struct pwm_ops imx_pwm_ops_v1 =3D {
> > > > > > +	.enable =3D imx_pwm_enable,
> > > > > > +	.disable =3D imx_pwm_disable,
> > > > > > +	.config =3D imx_pwm_config,
> > > > > > +	.owner =3D THIS_MODULE,
> > > > > > +};
> > > > > > +
> > > > > > +static struct pwm_ops imx_pwm_ops_v2 =3D {
> > > > >=20
> > > > > Can't these two be const? No need to respin for only this, just
> > > > > let me know and I can make the change while applying.
> > > >=20
> > > > Nevermind that. I just remembered that I had picked up a patch to
> > > > make the original imx_pwm_ops a const and things still work fine
> > > > if I make both of the above const, so I just had to manually
> > > > apply your patch, but other than that it seems fine. Let me apply
> > > > the rest of this set and push out. It'd be great if you could
> > > > check afterwards that it's all still what you expect.
> > >=20
> > > I will do that. Thanks for integrating the patch series :-).
> >=20
> > Thanks for sticking with it. I know the initial patches for optional
> > polarity support have been around for years, and it took a really long
> > time for this all to come together.
> >=20
> > But I think the end result is sound and looks really good.
>=20
> You are welcome :-)
>=20
> >=20
> > The one remaining bit that I'm not 100% happy about is that the v1
> > support is not atomic while the v2 support is.
>=20
> Here the only limitation is the lack of v1 HW.

That doesn't have to be a blocker. If you're willing to invest some more
work to do the additional conversion (I think it would be a fairly minor
change, looking at the existing v1 code), I'm sure we can find someone
with the hardware to test it.

Sascha, Lothar, Fabio, Shawn: do you guys have access to v1 hardware, or
know of anyone who might?

Thierry

--3gk1bTGVZuaU9V5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliPAZgACgkQ3SOs138+
s6FcQQ/7BVg9CARmrv40n0nn8LxvuOtGoxv0uEY1uFWw3tYUG+xj8xttWLclk2fQ
FDJ3Jk+zeI9qQgYRADNNyOlPWLkax/SHMSVDF1Hh500Nr9d+OK0WZnSHDQok5cKq
FpSp084TJ+O3B5VrRhA/3cNcprLNBRjyEgGXNybfmFv4Rnoprg+HwoHdtR5wAQVn
wBzKkbP/eTnnWFcuiv+HsdTJ0WRnAe/hcMXb/uI4csD1w/NVznfJLkk3fNr4iZBp
ECdtLhA152dcp3Z/YKaUQ7LBXW0sdh+i6tEN0Xu8W9jBpqI09mx9YTcHQAVThV60
3RtLjlUa7q6EYvvyMuoTYSNQH8roze4NQRgVRdtreihvXf/mweFA+Awbd4bzyu88
m44ooTwHBN9g+zjgrR0Usr4109PLadHENwvjkpFtE9BBTdy9GIfeNY0+LXy2Ow0h
aeikEvsOQRGIhqJuDtnuuJacKDwh7pNGoazANxCKmM2+NmM4oiIw2BnP8qRH5NMo
S9Zhpe4iy+2Vp96E8XON65Dly8EUnA77ntW5NVhs0PGkYoJq3vXqVjMakhIERZ6f
ElGOrtb1WHHTSCzgFY52c22gmyokhSFz6VEE5j6WhfIrUB48Kzohgbt/sCSctDkU
nq1wu0lYC8dgXuG330C8lIFDf708eKLzvQD9TJp7TPsAk2vuIvY=
=Aetz
-----END PGP SIGNATURE-----

--3gk1bTGVZuaU9V5/--
