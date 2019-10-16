From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Fix incorrect calculation of
 duty_cycle/period
Date: Wed, 16 Oct 2019 09:40:28 +0200
Message-ID: <20191016074028.GD1296874@ulmo>
References: <20191014135303.2944058-1-megous@megous.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191014135303.2944058-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
To: megous@megous.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 03:53:03PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> Since 5.4-rc1, pwm_apply_state calls ->get_state after ->apply
> if available, and this revealed an issue with integer precision
> when calculating duty_cycle and period for the currently set
> state in ->get_state callback.
>=20
> This issue manifested in broken backlight on several Allwinner
> based devices.
>=20
> Previously this worked, because ->apply updated the passed state
> directly.
>=20
> Fixes: deb9c462f4e53 ("pwm: sun4i: Don't update the state for the caller =
of pwm_apply_state")
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 6f5840a1a82d..05273725a9ff 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -137,10 +137,10 @@ static void sun4i_pwm_get_state(struct pwm_chip *ch=
ip,
> =20
>  	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
> =20
> -	tmp =3D prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
> +	tmp =3D (u64)prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
>  	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
> =20
> -	tmp =3D prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
> +	tmp =3D (u64)prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
>  	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
>  }
> =20
> --=20
> 2.23.0
>=20

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2myWoACgkQ3SOs138+
s6HjJQ//cOaa+rQbHDiozVxUr5QyYpNUKhyDd8gH07OijRllOYlt+NRxTwhjh47l
MEYxoNRg9rBZZxqA/G7qbnGCL1iDBNAP0cWSBlHpIalVi9GVIEuIfTzI0SPeoSws
EDIr7PI6Dhv2xO3IHjkrkNCUNwQgSVdmx5gxRyKRyzmuYdCHDAV9dP9ElSK7up/9
sMNEQdl/Jh1FizoXJP397H4rWTXhhHdlboh0uZ95/LIFZtIF2vBV0QXwt8Y9H9+a
Vdu8DTpAwdDvKbBFga6fnrI7lfNkw8tco0j4xMeK3Nva+aBBCfb28uF8hNazLQ29
k/b94765M6z3Lk4CbxCKJSlRHZSuhCsBb8Fd1kSrt3/eqZhlU3yWcOWVmCwxSvkj
RCwZnPah5NtvS1DtgTawURbayZ5/Q7zJIXg218OEh0TyWabeTCckbb1HLYcDAox9
46m3GK1C64yFUHn7X21lwN9yzd9p7V06YJ+j55TIxjwDuGHffVlTNELmZmRqXop3
MVUjsx3KhAc/O93GTAUAKh0LDsqbgu7Iu3trGK2i9zyzmAsAj0Cb0BjqV9kDLlyK
JeKTFZH4Rqg8vXuN9Jh4g5DxYmyupcgFBsITECvHD8SZoukUkW9Of80lBe+NPCyV
dkrit/vckMiUWbG3fSvGDGNSoxZlC1PKZHEK3tuqZk1/UP5UQqU=
=DSZ5
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
