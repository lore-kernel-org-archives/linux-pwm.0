From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 2/4] pwm: tegra: Increase precision in pwm rate
 calculation
Date: Wed, 12 Apr 2017 19:19:31 +0200
Message-ID: <20170412171931.GE11964@ulmo.ba.sec>
References: <1491557642-15940-1-git-send-email-ldewangan@nvidia.com>
 <1491557642-15940-3-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491557642-15940-3-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 03:04:00PM +0530, Laxman Dewangan wrote:
> The rate of the PWM calculated as follows:
> 	hz =3D NSEC_PER_SEC / period_ns;
>  	rate =3D (rate + (hz / 2)) / hz;
>=20
> This has the precision loss in lower PWM rate.
>=20
> Change this to have more precision as:
> 	hz =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC * 100, period_ns);
> 	rate =3D DIV_ROUND_CLOSEST(rate * 100, hz)
>=20
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
> 		hz =3D 59, rate =3D 3390
> 	Based on new formula:
> 		hz =3D 5951, rate =3D 3360
>=20
> 	The PWM signal rate of 3360 is more near to requested period than 3333.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> ---
> Changes from v1:
> - None
>=20
> Changes from V2:
> - Fix the commit message with exact formula used.
> ---
>  drivers/pwm/pwm-tegra.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 0a688da..21518be 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -76,6 +76,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
>  	unsigned long long c =3D duty_ns;
>  	unsigned long rate, hz;
> +	unsigned long long ns100 =3D NSEC_PER_SEC;
>  	u32 val =3D 0;
>  	int err;
> =20
> @@ -94,9 +95,11 @@ static int tegra_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
>  	 */
>  	rate =3D clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
> -	hz =3D NSEC_PER_SEC / period_ns;
> =20
> -	rate =3D (rate + (hz / 2)) / hz;
> +	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> +	ns100 *=3D 100;
> +	hz =3D DIV_ROUND_CLOSEST_ULL(ns100, period_ns);

I think hz could overflow for small enough values of period_ns. I've
sent a patch that makes hz unsigned long long. While at it, the patch
also removes the ns100 variable which isn't really necessary here.

Thierry

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljuYaMACgkQ3SOs138+
s6EBYxAAmQdfxvQ/dAcjnqNJJAe4fpc3qP5GZdjXF0VXbD8FoOlvLC5BjufxJJmv
Q29D+Zcxhp/YutSjLkNr4GlWgvCfndZki1aGbiAOXMVUuPlyhh0kI0eM1w3UuKaS
QozK+LcI579Se5eZFmzFnCgiy9uBES/iL+xhS4hwqqhfFFI0DvGLo0VkO8R3ty5w
VDg5OoUPVBMLu9OlyNaKscavkqpRdPdNH8UsqY3pz3PCiBXop4dyWoefKTeWnNOr
/0UTdh2AbcmD4MzVAG9FglWlQuxsIvScru33Dql9wHh8V3krbDjLem2XOqxRvvsa
SUHz58g3/riejUE4ikAj8HipzSk0btf69GRdZitO912w8bvy2MKgav2pWlQvjRxm
MQdzneVxAhZPscu5tiYTaJZqz8tpci+TdRQ3tlFBA1UrzR7bij4rmQH5OyxLkpRx
hBT9ZDQBhnx+WR97r8MwGNcv57IuOmRuH28zAQ1dTOzmewfm2IbwnqyQKjT8bkvK
GcbbiwC5BWaoEkKWOOdk8KcILsvF4JeeTCmGJy84Qsmc+IEA1htPUbNwyCq74kSY
lMGozveMlbeM8KQPTIR2qZeQrq2AzKtH7bibRNoM2Z+5HUuc6uZ3p2rlXboSOcKC
xD2s5aD+yM06RY9kAP9dBnxxkIgonaOIijx/g7DcBD+L8dXYtb0=
=+uHw
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
