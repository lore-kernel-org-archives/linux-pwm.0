From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 03/11] pwm: imx: Add separate set of pwm ops for PWMv1
 and PWMv2
Date: Mon, 30 Jan 2017 09:45:13 +0100
Message-ID: <20170130084513.GO3585@ulmo.ba.sec>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
 <1485726855-16236-4-git-send-email-lukma@denx.de>
 <20170130072312.GI3585@ulmo.ba.sec>
 <20170130074318.GK3585@ulmo.ba.sec>
 <20170130093649.236e67b1@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/d7X7C0hV/blnKmH"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36093 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbdA3Ixh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 03:53:37 -0500
Content-Disposition: inline
In-Reply-To: <20170130093649.236e67b1@jawa>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>


--/d7X7C0hV/blnKmH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 09:36:49AM +0100, Lukasz Majewski wrote:
> Hi Thierry,
>=20
> > On Mon, Jan 30, 2017 at 08:23:12AM +0100, Thierry Reding wrote:
> > > On Sun, Jan 29, 2017 at 10:54:07PM +0100, Lukasz Majewski wrote:
> > > > From: Lukasz Majewski <l.majewski@majess.pl>
> > > >=20
> > > > This patch provides separate set of pwm ops utilized by
> > > > i.MX's PWMv1 and PWMv2.
> > > >=20
> > > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > > > Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > > > Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > > Changes for v5:
> > > > - None
> > > >=20
> > > > Changes for v4:
> > > > - None
> > > >=20
> > > > Changes for v3:
> > > > - Adjust the code to work with ipg clock removed
> > > >=20
> > > > Changes for v2:
> > > > - New patch
> > > > ---
> > > >  drivers/pwm/pwm-imx.c | 17 ++++++++++++++---
> > > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > > index b1d1e50..0fa480d 100644
> > > > --- a/drivers/pwm/pwm-imx.c
> > > > +++ b/drivers/pwm/pwm-imx.c
> > > > @@ -239,7 +239,14 @@ static void imx_pwm_disable(struct pwm_chip
> > > > *chip, struct pwm_device *pwm)
> > > > clk_disable_unprepare(imx->clk_per); }
> > > > =20
> > > > -static struct pwm_ops imx_pwm_ops =3D {
> > > > +static struct pwm_ops imx_pwm_ops_v1 =3D {
> > > > +	.enable =3D imx_pwm_enable,
> > > > +	.disable =3D imx_pwm_disable,
> > > > +	.config =3D imx_pwm_config,
> > > > +	.owner =3D THIS_MODULE,
> > > > +};
> > > > +
> > > > +static struct pwm_ops imx_pwm_ops_v2 =3D {
> > >=20
> > > Can't these two be const? No need to respin for only this, just let
> > > me know and I can make the change while applying.
> >=20
> > Nevermind that. I just remembered that I had picked up a patch to make
> > the original imx_pwm_ops a const and things still work fine if I make
> > both of the above const, so I just had to manually apply your patch,
> > but other than that it seems fine. Let me apply the rest of this set
> > and push out. It'd be great if you could check afterwards that it's
> > all still what you expect.
>=20
> I will do that. Thanks for integrating the patch series :-).

Thanks for sticking with it. I know the initial patches for optional
polarity support have been around for years, and it took a really long
time for this all to come together.

But I think the end result is sound and looks really good.

The one remaining bit that I'm not 100% happy about is that the v1
support is not atomic while the v2 support is. Not a blocker, but it
looks as if it should be easy to convert over v1 as well. Any takers?

Thierry

--/d7X7C0hV/blnKmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO/RYACgkQ3SOs138+
s6Hskg//ZTcKRZLDYLfgu7USCgLGxCIJHugaknslw6GjUibDv4Pj4cyEmx488C0x
mPHpIaq1vwz0w/gvQfykzk4tFtMU7jtyZmfcyI94Ccc1hrViO3drQtSYvLcnOQ+i
0SFiEipImug8LwNqfNr/eF10EzCVN1Cp5zjZ8OLzY0sxW5gSAKyGswTP3bTuqC3i
aCrqURYwF8tlbttm8JG01/fj9JvbRXJZD8eDLLjvp/t9a/a5UlRzUJls7/foMhu8
B0uhMtkHFkTTg3YSO548tQjZa6+1VKlx9rnSCAujMfKVUedwEIRKZSj5IaX2asli
OcaWnGudI+npBfICRE7Rhr/NrRIgwpxYXXabxYCMqnDD9mXerCDbC8jjtjZvjXAf
7JWdTbQ/zKIepeYxhHLc5DILW3dhaKH/xYXwNok2EwwxmLHgUcurogQpxtdgpLJL
OS5FnjYKnkLZ5TZqvxVZQdfAIVRO1Owc3kJyt2gwxQpAxq38NyPmyjZ1ygCF21jj
LAmei3FBjOVMhOBL+SEuJNSQmEvQ9DDlwUqNQAZQX6tJNDj9uHFy6WETZf4rKva+
/5VJ4+KMeMxZ5POIQ/4j1hcr0iCX3BKdHeFtkDT6ahZlkMIgrDwceaOs9HZbLF9r
4MvVd9oL4TePnvuCUlirtQW3KWFIDulc0ATebaQUHDK9BFtzVTI=
=yO4D
-----END PGP SIGNATURE-----

--/d7X7C0hV/blnKmH--
