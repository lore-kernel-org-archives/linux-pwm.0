From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 03/11] pwm: imx: Add separate set of pwm ops for PWMv1
 and PWMv2
Date: Mon, 30 Jan 2017 08:23:12 +0100
Message-ID: <20170130072312.GI3585@ulmo.ba.sec>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
 <1485726855-16236-4-git-send-email-lukma@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5uO961YFyoDlzFnP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33369 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdA3HYu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 02:24:50 -0500
Content-Disposition: inline
In-Reply-To: <1485726855-16236-4-git-send-email-lukma@denx.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>


--5uO961YFyoDlzFnP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2017 at 10:54:07PM +0100, Lukasz Majewski wrote:
> From: Lukasz Majewski <l.majewski@majess.pl>
>=20
> This patch provides separate set of pwm ops utilized by
> i.MX's PWMv1 and PWMv2.
>=20
> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Changes for v5:
> - None
>=20
> Changes for v4:
> - None
>=20
> Changes for v3:
> - Adjust the code to work with ipg clock removed
>=20
> Changes for v2:
> - New patch
> ---
>  drivers/pwm/pwm-imx.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index b1d1e50..0fa480d 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -239,7 +239,14 @@ static void imx_pwm_disable(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	clk_disable_unprepare(imx->clk_per);
>  }
> =20
> -static struct pwm_ops imx_pwm_ops =3D {
> +static struct pwm_ops imx_pwm_ops_v1 =3D {
> +	.enable =3D imx_pwm_enable,
> +	.disable =3D imx_pwm_disable,
> +	.config =3D imx_pwm_config,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static struct pwm_ops imx_pwm_ops_v2 =3D {

Can't these two be const? No need to respin for only this, just let me
know and I can make the change while applying.

Thierry

--5uO961YFyoDlzFnP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO6eAACgkQ3SOs138+
s6Hicw//R7/md7s9Fx/ColJxDjpFk6RQO5K9XBZ4i1BsnuuSiC9n1zFLZie7dYr0
rtLb9KdlaMTzz6QP7VPqs5VhHxeTHC3j5QjPlan9vJ5SP1GBYV5rGKHNlKFD9hsV
PrVygShq1SL3otelv+2O5OH8TzcsStKbmOZGy0KwtuaoFBEjGRrO0LycYjbDp1Zw
MEFAkt/t7SJcRyIFxXO1ZI7d3WWULpKi7i3CPYsAI9k+HEQNc3dX6w0i/5u2k9wd
F/rLCNsPuEP/Mog8Jzp6zZ6bKXlptQ13yGQyQq6ZG73Te0JybMHp38ZujXNC16dd
2aoDbm/q/DVd+3cK5jrJJkmnl0kU4zXiMDzrd4q9ODgaSh6Sr3ud5RDj6RjlRxC5
JFC4OWHWpJvjF6YDL4BsIDvuL7sp+qXAqgiGtP/B0QIYTqJt73SVaSng5ouBxTHF
YG9YsCYcnxyVcJm1eiHTrLEg5grByJA109tskOYSO8RRtMcUQflm/AEJ6PkMKP/v
oXCcIW2dhnf4vmVFMKRUFij69LKJhcqi4Gx1GEjowUG10320NTm8IQ1ixmcXzMxJ
9lL+VkQhX7xpBr/+ULlHbfVYliS/c3AYB1y5bUWTsq0/lcQEbx4SWutA+6h/1nh+
anXzOlNzC+IGpLq/SnxRh39GVXA4xFRhbbzwZG2OdS6CkhHGU68=
=niP5
-----END PGP SIGNATURE-----

--5uO961YFyoDlzFnP--
