From: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] pwm: sun4i: direct clock output support for Allwinner A64
Date: Tue, 28 Apr 2020 09:53:46 +0200
Message-ID: <20200428075346.xjzmmvios64emg5z@gilmour.lan>
References: <20200426101122.98318-1-peter.vasil@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sjnuyyybmloorp7b"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37117 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgD1Hxt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Apr 2020 03:53:49 -0400
Content-Disposition: inline
In-Reply-To: <20200426101122.98318-1-peter.vasil@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Peter Vasil <peter.vasil@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org


--sjnuyyybmloorp7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 26, 2020 at 12:11:22PM +0200, Peter Vasil wrote:
> Allwinner A64 is capable of a direct clock output on PWM (see A64
> User Manual chapter 3.10). Add support for this in the sun4i PWM
> driver and adjust compatibility in sun50i-a64 base device tree.
>=20
> Signed-off-by: Peter Vasil <peter.vasil@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++----
>  drivers/pwm/pwm-sun4i.c                       | 9 +++++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 31143fe64d91..c334fd106854 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -1069,8 +1069,7 @@ gic: interrupt-controller@1c81000 {
>  		};
> =20
>  		pwm: pwm@1c21400 {
> -			compatible =3D "allwinner,sun50i-a64-pwm",
> -				     "allwinner,sun5i-a13-pwm";
> +			compatible =3D "allwinner,sun50i-a64-pwm";
>  			reg =3D <0x01c21400 0x400>;
>  			clocks =3D <&osc24M>;
>  			pinctrl-names =3D "default";
> @@ -1252,8 +1251,7 @@ r_ir: ir@1f02000 {
>  		};
> =20
>  		r_pwm: pwm@1f03800 {
> -			compatible =3D "allwinner,sun50i-a64-pwm",
> -				     "allwinner,sun5i-a13-pwm";
> +			compatible =3D "allwinner,sun50i-a64-pwm";

There's no need to remove that compatible, it's actually working as intende=
d..

>  			reg =3D <0x01f03800 0x400>;
>  			clocks =3D <&osc24M>;
>  			pinctrl-names =3D "default";
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 5c677c563349..18fbbe3277d0 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -352,6 +352,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_=
bypass =3D {
>  	.npwm =3D 1,
>  };
> =20
> +static const struct sun4i_pwm_data sun50i_a64_pwm_data =3D {
> +	.has_prescaler_bypass =3D true,
> +	.has_direct_mod_clk_output =3D true,
> +	.npwm =3D 1,
> +};
> +
>  static const struct sun4i_pwm_data sun50i_h6_pwm_data =3D {
>  	.has_prescaler_bypass =3D true,
>  	.has_direct_mod_clk_output =3D true,
> @@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] =
=3D {
>  	}, {
>  		.compatible =3D "allwinner,sun8i-h3-pwm",
>  		.data =3D &sun4i_pwm_single_bypass,
> +	}, {
> +		.compatible =3D "allwinner,sun50i-a64-pwm",
> +		.data =3D &sun50i_a64_pwm_data,

Ie, if the OS only has support for the A13, then it will use it as an A13, =
and
if it has support for the A64 variant, then it can use some more advanced
features.

Maxime

--sjnuyyybmloorp7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfhCgAKCRDj7w1vZxhR
xWYNAP0XwagPq8Ucjl/id9ax9GqE/UVZAeVIhpIf1azXshxpKAEAjhQ3ptJzGoRq
WPVqQ9VSEdoRLsCRzcOfVK2X5rKvMQQ=
=sF/u
-----END PGP SIGNATURE-----

--sjnuyyybmloorp7b--
