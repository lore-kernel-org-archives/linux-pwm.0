From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
Date: Wed, 31 Aug 2016 18:20:02 +0200
Message-ID: <20160831162002.GI14379@lukather>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-2-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160831082520.25962-2-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Milo,

On Wed, Aug 31, 2016 at 05:25:17PM +0900, Milo Kim wrote:
> H3 PA5 pin is assigned for single PWM channel.
>=20
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3=
=2Edtsi
> index fdf9fdb..05d0c4b 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -360,6 +360,13 @@
>  				allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
>  			};
> =20
> +			pwm0_pin_a: pwm0@0 {
> +				allwinner,pins =3D "PA5";
> +				allwinner,function =3D "pwm0";
> +				allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +

Is it used on any boards?

If not, we have the policy of not merging the pinctrl nodes that are
not used by anyone to avoid bloating the DT for no particular reason.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxwOyAAoJEBx+YmzsjxAgZMoP/1O0ZF37IA20Go5n0MZxA/yw
r86DSQ7NLprXdtaJ8L6C8RrgSruwiPyHlFrPl6i7v4qsxIe8bYungEZhbkQ4jdkJ
4benjUJIqjB3p/aQUDZKM/ZA82rxO/agyIAbM4Fad3/7UdOulLzUUHizjCQRrqxS
NWF44R+PI8c6IBMBrBbUadooc17eZ7Xps+P2UUuT5uLJ7AGd6f5bD3qpP2dopx7K
wXmoElVQp2686IItnVT/BOUWax9c8XEV7tddET0+0TMa4+q2PEPXSTA9BO6UoOn4
5X7XHuYvSKFL9D4T0oNuIMfIzA8Z9y0HgNa/Y6OwDUwTvp6fLzK2LVNXe2Zoojaq
aQtu/jwdxHF0qgpGTNe5ZO2P9BxoLlP3jPjJXMW99Y+hKeNielKE8Qs3b29/RvrL
smok0LTqq2YdfsYdD8aFjISAvo4MoLKbBxRLL5iC8QOCJAFgmdeJ7Ojrn/yFxrNa
czcvWjFGAgWZ5+CYaBzQNlmje/nkIMsMtcVeojnQ/u19f8hbykD6lNI14OPLm3mK
kh6X/thuw6pCdngNvIvm1AzkM+9coqBd7j0RYWqXX0nmcemgdhpOxTiDcbe/eHwC
1UpDL4VeJY/UVOYIOMXuwpChZuEq+OiAKEhefAnHSuE1YFvoH5UaM9L6mFqgL5wH
O2pUHDeUMtvJgVEPkUaT
=ZJMN
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--
