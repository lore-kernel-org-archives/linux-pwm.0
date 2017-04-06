From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 2/4] pwm: tegra: Increase precision in pwm rate
 calculation
Date: Thu, 6 Apr 2017 18:28:26 +0200
Message-ID: <20170406162826.GA24332@ulmo.ba.sec>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com>
 <1491488461-24621-3-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491488461-24621-3-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 07:50:59PM +0530, Laxman Dewangan wrote:
> The rate of the PWM calculated as follows:
> 	hz =3D NSEC_PER_SEC / period_ns;
>  	rate =3D (rate + (hz / 2)) / hz;
>=20
> This has the precision loss in lower PWM rate.
> Changing this to have more precision as:
> 	hz =3D DIV_ROUND_CLOSE(NSEC_PER_SEC * 100, period_ns);
> 	rate =3D DIV_ROUND_CLOSE(rate * 100, hz)

DIV_ROUND_CLOSEST(). Also I very much prefer this notation over the
actual code below. I don't think we need a local variable to hold the
precision.

Thierry

> Example:
> 1. period_ns =3D 16672000, PWM clock rate is 200KHz.
> 	Based on old formula
> 		hz =3D NSEC_PER_SEC / period_ns
> 		   =3D 1000000000ul/16672000
> 		   =3D 59 (59.98)
> 		rate =3D (200K + 59/2)/59 =3D 3390
>=20
> 	Based on new method:
> 		hz =3D 5998
> 		rate =3D DIV_ROUND_CLOSE(200000*100, 5998) =3D 3334
>=20
> 	If we measure the PWM signal rate, we will get more accurate period
> 	with rate value of 3334 instead of 3390.
>=20
> 2.  period_ns =3D 16803898, PWM clock rate is 200KHz.
> 	Based on old formula:
> 		hz =3D 60, rate =3D 3333
> 	Based on new formula:
> 		hz =3D 5951, rate =3D 3360
>=20
> 	The rate of 3360 is more near to requested period then the 3333.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Changes from V1:
> - None
>=20
>  drivers/pwm/pwm-tegra.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 0a688da..e9c4de5 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -76,6 +76,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
>  	unsigned long long c =3D duty_ns;
>  	unsigned long rate, hz;
> +	unsigned long long ns100 =3D NSEC_PER_SEC;
> +	unsigned long precision =3D 100; /* Consider 2 digit precision */
>  	u32 val =3D 0;
>  	int err;
> =20
> @@ -94,9 +96,11 @@ static int tegra_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
>  	 */
>  	rate =3D clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
> -	hz =3D NSEC_PER_SEC / period_ns;
> =20
> -	rate =3D (rate + (hz / 2)) / hz;
> +	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> +	ns100 *=3D precision;
> +	hz =3D DIV_ROUND_CLOSEST_ULL(ns100, period_ns);
> +	rate =3D DIV_ROUND_CLOSEST(rate * precision, hz);
> =20
>  	/*
>  	 * Since the actual PWM divider is the register's frequency divider
> --=20
> 2.1.4
>=20

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmbKoACgkQ3SOs138+
s6Flsw/+JRZIQJnTD+nnvTOQVRWS5Oc+dC/+WROzKZrmupfkP15NTmAxVOqn6BIW
hvSRc5zIIKXKqO8erHrsTeeLbsmNp906GrV8oNqEkJ5mUWIs1BXo8qlA+1UQx49S
e7Srl0LF0GIZ92lKtqMy/grk/Jvs22hqDjNiuwRK35x9MBIG4g/MJiUhOXY91t3H
4sjJkG4d1r1b2+oRZk2+2RemBUzf6lczjTyA30Thn36nounGmYuW5Gz0+o76Om5x
gRJW61MTD9pgM0ry8qhhFIWF4MuIzbciItyyvljZTK0KZY9CSyu1QQrh5K/Nzu61
EHrU8HL01q1LutGOGIzmD9fSh4+ag9iQKSkDChrNX9V+N6is54FrFHWfjCCOiUpi
HBjMFZfudP1f7lkQpprip4cgGv2n1iqe24AqulQWZRska621FU0PGQx4XPPClpXJ
tJYoP0cdg+uC2DD/S6rn2Ow6WkTYCq+KmDwtgFGQzK82g155uBooDWxMgXKJrwkZ
HIav3ApdFHRkdLlROymvxSwpadEXDtKucBx91u7Uxiffl/Ss0tfswIxO7dLf1Kma
LvVezF3v8tEYKWNLd/yHEduSlpG2zIfB8aaJV7KLTm1RUfwIwqvxK/nQgGtsGvfS
5XBLk58pADECt3kLB0vEIwKlGLLU0Xd1jHpacxf1RZF1DcMq4Y4=
=2/xf
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
