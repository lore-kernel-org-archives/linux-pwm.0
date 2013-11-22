Return-Path: <thierry.reding@gmail.com>
Date: Fri, 22 Nov 2013 15:22:32 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
Message-ID: <20131122142231.GA1741@ulmo.nvidia.com>
References: <1385055795-24002-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <1385055795-24002-1-git-send-email-fabio.estevam@freescale.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: shawn.guo@linaro.org, marex@denx.de, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2013 at 03:43:15PM -0200, Fabio Estevam wrote:
> Commit 22ceeee1 (pwm-backlight: Add power supply support) caused breakage=
 on=20
> boards that do not define the backlight regulator on their dts files.
>=20
> Instead of making the backlight regulator mandatory, treat it as optional=
=20
> instead, so that we do not have breakage.
>=20
> This avoids the need for adding a dummy regulator on every dts file that =
uses=20
> the pwm-backlight.

That was actually part of an earlier version of this patch. It was
rejected on the grounds that regulators really aren't optional. They are
there, but in most cases just not described in DT (most likely because
they aren't controllable and always on).

But even so, the regulator core now has functionality to return a dummy
regulator if none is specified in DT, specifically so that users don't
have to special case the handling of "optional" regulators. That should
be enough to keep all boards working even if no power-supply property
was given in the DTS. As a matter of fact it's a constellation that I
explicitly tested and found to work well.

Cc'ing Mark Brown, perhaps he can help figure out what's causing this.

Thierry

>=20
> Tested on a mx6qsabresd.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  .../devicetree/bindings/video/backlight/pwm-backlight.txt |  2 +-
>  drivers/video/backlight/pwm_bl.c                          | 15 +++++++--=
------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backli=
ght.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.t=
xt
> index 764db86..ed3dc3c 100644
> --- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> @@ -10,13 +10,13 @@ Required properties:
>        last value in the array represents a 100% duty cycle (brightest).
>    - default-brightness-level: the default brightness level (index into t=
he
>        array defined by the "brightness-levels" property)
> -  - power-supply: regulator for supply voltage
> =20
>  Optional properties:
>    - pwm-names: a list of names for the PWM devices specified in the
>                 "pwms" property (see PWM binding[0])
>    - enable-gpios: contains a single GPIO specifier for the GPIO which en=
ables
>                    and disables the backlight (see GPIO binding[1])
> +  - power-supply: regulator for supply voltage
> =20
>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>  [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index fb80d68..fb3008c 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -50,9 +50,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data =
*pb, int brightness)
>  	if (pb->enabled)
>  		return;
> =20
> -	err =3D regulator_enable(pb->power_supply);
> -	if (err < 0)
> -		dev_err(pb->dev, "failed to enable power supply\n");
> +	if (!IS_ERR(pb->power_supply)) {
> +		err =3D regulator_enable(pb->power_supply);
> +		if (err < 0)
> +			dev_err(pb->dev, "failed to enable power supply\n");
> +	}
> =20
>  	if (gpio_is_valid(pb->enable_gpio)) {
>  		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
> @@ -80,7 +82,8 @@ static void pwm_backlight_power_off(struct pwm_bl_data =
*pb)
>  			gpio_set_value(pb->enable_gpio, 0);
>  	}
> =20
> -	regulator_disable(pb->power_supply);
> +	if (!IS_ERR(pb->power_supply))
> +		regulator_disable(pb->power_supply);
>  	pb->enabled =3D false;
>  }
> =20
> @@ -283,10 +286,6 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>  	}
> =20
>  	pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
> -	if (IS_ERR(pb->power_supply)) {
> -		ret =3D PTR_ERR(pb->power_supply);
> -		goto err_gpio;
> -	}
> =20
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
> --=20
> 1.8.1.2
>=20
>=20

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSj2inAAoJEN0jrNd/PrOhPp0QALbFvGJpVVfvp3QHc9MXXP8u
QJUMd8Q0cKjO5VCsl/aGwK4wSSDXzTOtbCLmS2F0ijMnIXEAc3lw9dLspCXIgu4N
5mcKcyl1GpNrW+X+Soosvrb4jO6qDw/xMA2hxu6lQoySj8I8lDU+0zpqyf7Q04JD
gPej6jelXAsY49vBuXdWGS/Wm8VpqwSiM6OvOvbJJRcVfRo0wgoM0LMJg1V314Qc
fNGC8cDnhkxymRXbp7DD0+p2XpJiE+LhCthVzxPKvZ9CQjH+bXh2ug0dPDfeGvPw
j9b1QVtgatf6uQARbNj7hVa1vtq+Jho3DOmGLZ6OcHge9ek5Cuqve+b5JuUzwSFL
PPb4J0qqlhway3cpZAGm7IuN2qNph4sqSxkc22wvUs0cG7rLv2BiAZ+3xQMBE/HU
1fuPs2ruH27/fUvyVyQnCyTyC7X6Nw691Gi6ZbebiH+omM8WgIRhAEtd9moigx8V
NUy5SWj2LsruDxWsl+lDnlGx8lpThdxGVuQcdxDJXvicIZfBQZlgCJywpab+6Zd4
5tClfLu5dBUf5arco+BR/vr63fGpcR54HoQkglR94Tci6JbhPTURG6J6KngRR0ia
fzbrmD5S67N8Ih0QYjCZvQGW2Zxwmedap8RUpJEBnoNXjE+F/6djF9Y+UJT3ZdoM
vkM/8I6Uvu2Qir9mNy8Q
=0UO6
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
