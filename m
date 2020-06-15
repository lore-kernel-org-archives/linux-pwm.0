From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit
 format specifier
Date: Mon, 15 Jun 2020 17:18:16 +0200
Message-ID: <20200615151816.wrhqwffvw3h436ar@taurus.defre.kleine-koenig.org>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="deic5xssjaudhrig"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbgFOPST (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2020 11:18:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0436C061A0E
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jun 2020 08:18:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200615141606.2814208-2-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lee Jones <lee.jones@linaro.org>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--deic5xssjaudhrig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 15, 2020 at 04:16:05PM +0200, Thierry Reding wrote:
> The PWM core will soon change the duty cycle and period of PWMs to 64
> bits to allow for a broader range of values. Use a 64-bit format
> specifier to avoid a warning when that change is made.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 8e06ba912d60..09425ec317ba 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -312,7 +312,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>  		/* Enable the PWM */
>  		pwm_enable(par->pwm);
> =20
> -		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
> +		dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
>  			par->pwm->pwm, pwm_get_period(par->pwm));

I wonder a bit about the driver accessing par->pwm->pwm, but that's
orthogonal to this patch.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--deic5xssjaudhrig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7nkTUACgkQwfwUeK3K
7AmU3Qf/Rsruxiv5Xc2fp4ZdL87Rvbku+2jHQyQqS/qEgxFaucX6fBOJX3zMIXeL
Q+CHvMMgGG6CI9Sz3/lxHWAO5cXxltczQ/QmUgw+kww8oY7ELz2zHTBkcEzf7367
n05218CG9XvT2M+gKffAs65I72gXuENMQoisIWvsqiD9RJjEMobzaKrwCYimH1nT
fnpiYHAnHGoKkb/wmP4THIHy7lQ63y9/P3OTQszVcCgOzCvBbvrlN/wonz7D/VKw
HKotGZVc+et+uZ1W14xpw89HONC3Px58WG1Jv6w+hWs23QdETY9Ot7HAZct5/l2s
qE3gQjMjajnEny8IsF/oG9dNZczgrg==
=XuMV
-----END PGP SIGNATURE-----

--deic5xssjaudhrig--
