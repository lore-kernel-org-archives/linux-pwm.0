From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 03/11] pwm: imx: Add separate set of pwm ops for PWMv1
 and PWMv2
Date: Mon, 30 Jan 2017 08:43:18 +0100
Message-ID: <20170130074318.GK3585@ulmo.ba.sec>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
 <1485726855-16236-4-git-send-email-lukma@denx.de>
 <20170130072312.GI3585@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DfnuYBTqzt7sVGu3"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36252 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbdA3HnW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 02:43:22 -0500
Content-Disposition: inline
In-Reply-To: <20170130072312.GI3585@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>


--DfnuYBTqzt7sVGu3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 08:23:12AM +0100, Thierry Reding wrote:
> On Sun, Jan 29, 2017 at 10:54:07PM +0100, Lukasz Majewski wrote:
> > From: Lukasz Majewski <l.majewski@majess.pl>
> >=20
> > This patch provides separate set of pwm ops utilized by
> > i.MX's PWMv1 and PWMv2.
> >=20
> > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > Changes for v5:
> > - None
> >=20
> > Changes for v4:
> > - None
> >=20
> > Changes for v3:
> > - Adjust the code to work with ipg clock removed
> >=20
> > Changes for v2:
> > - New patch
> > ---
> >  drivers/pwm/pwm-imx.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index b1d1e50..0fa480d 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -239,7 +239,14 @@ static void imx_pwm_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
> >  	clk_disable_unprepare(imx->clk_per);
> >  }
> > =20
> > -static struct pwm_ops imx_pwm_ops =3D {
> > +static struct pwm_ops imx_pwm_ops_v1 =3D {
> > +	.enable =3D imx_pwm_enable,
> > +	.disable =3D imx_pwm_disable,
> > +	.config =3D imx_pwm_config,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static struct pwm_ops imx_pwm_ops_v2 =3D {
>=20
> Can't these two be const? No need to respin for only this, just let me
> know and I can make the change while applying.

Nevermind that. I just remembered that I had picked up a patch to make
the original imx_pwm_ops a const and things still work fine if I make
both of the above const, so I just had to manually apply your patch, but
other than that it seems fine. Let me apply the rest of this set and
push out. It'd be great if you could check afterwards that it's all
still what you expect.

Thierry

--DfnuYBTqzt7sVGu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO7pQACgkQ3SOs138+
s6FaZw//VtD1DTXyPXWa0IGcFwPvVW/gxKuERWU9BSJipajhEUarRIa6YVeNt2lM
G9L/BmE4F0o3E0x1WN4kZ4WD9CV6vktPlTx7SCLDWM9GR9CFBGHHKSXtfmteGQDq
st04xBTSZIPeBajTlguVGXzEMw3vsPGhvE894ISUbVuz6a23ICf2YIK/Ijb30Zlp
FF2nE3OKll9+d556l6doW1RO1ZQ+WBm7aZQfieEuzR0qtVj8GmmGexDZMssuivw/
IGHh7l2sJJl9KRrY2d53kbMjl5ZndaZyDSIpFwXvcsqFMSxcSYmF+tIJT/PKOtAo
wCAWMwiEO30E5EOfK2/CjJhHcjxRyUR4TO9Ab/iMpyYJFsbIvbclRnjDpbQF13lW
A7EQCZlwf+tzM8+74yq9vheRryeSHJdr3gWy1sHF+G2OfsQUDGoj2g1VRn1wlyPt
KvLg/+BTlWrPCxPMQ9ne8md2A8sGBbfLR+U1xk4fvWYd8+qnO92ui1PCL5uFaZH+
VYKSl15YBINXkjQZLEIGdUB807Q0klwD13DaU9XDszF4cSmvVuz/8s3yetAtBb7h
fXzDwtIKTGBWADHNu4eHt7mLpJQGUD+GSY5/eMBag6FSCAfxpQpO4JQHzJMNTmZ0
EpqC/+1d3ZO/uDUsBU4vjTxLgaJqBR+xRwEGECRb4COstzCGZHc=
=L3D6
-----END PGP SIGNATURE-----

--DfnuYBTqzt7sVGu3--
