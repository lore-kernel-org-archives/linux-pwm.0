From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: pca9685: fix period change with same duty cycle
Date: Wed, 18 Jan 2017 11:56:50 +0100
Message-ID: <20170118105650.GL18989@ulmo.ba.sec>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrM5Z5VIJgwP9LWp"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36533 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbdARK75 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2017 05:59:57 -0500
Content-Disposition: inline
In-Reply-To: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--nrM5Z5VIJgwP9LWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 04:52:50PM +0100, Clemens Gruber wrote:
> When first implementing support for changing the output frequency, an
> optimization was added to continue the PWM after changing the prescaler
> without having to reprogram the ON and OFF registers for the duty cycle,
> in case the duty cycle stayed the same.
> This was flawed, because we compared the absolute value of the duty
> cycle in nanoseconds instead of the ratio to the period.
>=20
> Fix the problem by removing the shortcut.
>=20
> Fixes: 01ec8472009c9 ("pwm-pca9685: Support changing the output frequency=
")
> Cc: <stable@vger.kernel.org> # v4.3+
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 11 -----------
>  1 file changed, 11 deletions(-)

Mika, Andy, can you guys help review this and 2/2?

Thanks,
Thierry

>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 117fccf..01a6a83 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -65,7 +65,6 @@
>  #define PCA9685_MAXCHAN		0x10
> =20
>  #define LED_FULL		(1 << 4)
> -#define MODE1_RESTART		(1 << 7)
>  #define MODE1_SLEEP		(1 << 4)
>  #define MODE2_INVRT		(1 << 4)
>  #define MODE2_OUTDRV		(1 << 2)
> @@ -117,16 +116,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  			udelay(500);
> =20
>  			pca->period_ns =3D period_ns;
> -
> -			/*
> -			 * If the duty cycle did not change, restart PWM with
> -			 * the same duty cycle to period ratio and return.
> -			 */
> -			if (duty_ns =3D=3D pca->duty_ns) {
> -				regmap_update_bits(pca->regmap, PCA9685_MODE1,
> -						   MODE1_RESTART, 0x1);
> -				return 0;
> -			}
>  		} else {
>  			dev_err(chip->dev,
>  				"prescaler not set: period out of bounds!\n");
> --=20
> 2.10.2
>=20

--nrM5Z5VIJgwP9LWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/SfEACgkQ3SOs138+
s6HV9g/43NYFdkiTksOJBtPGrAbHxEKiz+5dRiuHujAutzJ/zu0c4RpNkoXUjGru
eG2w7GlGsFGSTJ7d4vS2QHpm+Mk6aq7FaFhqsO3jxLS6ymIKYd8WeAUjWTMfrQKx
zj/6P0hpHJvUWiq+sD1fB3Y/HeuTz+5gDBTC7s1izn9lzEoKgTFHkj2MYanGePQr
CzroNuEHVFx0XeuGxQVUj97bS6T6QGJZVtqtgaxsSChC3a8lLTFijti4p77DT6kL
ZErQXLgXa2ULxikKgXofJoX1XGg1PlfUvXktKZoCgsvebz/DIplg9DGLryz1B1jU
Bn9NpTnuFsm3yaXmsfMoS1Ek/9osl8718ZtblX0zrV9bM/2elFyo8rsaKiyezdPE
8sDtpCXlX5q+GXKogQcCO19wF1bAo43ZdzvBno+Q4T1yE1Jc8aKBMLRdko3MLK4n
Y5LQipNH700Elb9A3QRA5XkIxxZecRMN4L4dLcTUzFXLPJ8vnYoa9bMHZEuRotna
r8hgoTA2lYnnFWJRIiSHQm3JdYf+1PM2ea34cks4jTH4GwWe9ZiO395LK+xPIxRI
hIfDBRSvcwmL9gXdOTogWRIZEBPQcdGmVI5p9A42Uq41XeSq/Xv3aO5KJlaDPvbU
qpv52OF2n+yc1CPqyOm0ARsC5yPfAjCa9X5BMDXACRB/CZFe/w==
=SK76
-----END PGP SIGNATURE-----

--nrM5Z5VIJgwP9LWp--
