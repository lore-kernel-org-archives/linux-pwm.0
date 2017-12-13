From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 4/4] ARM: pinctrl: sunxi-pinctrl: fix pin funtion can
 not be match correctly.
Date: Wed, 13 Dec 2017 16:45:49 +0100
Message-ID: <20171213154549.5zn4uxhsssqw3pb7@flea.lan>
References: <20171213144748.GA18267@arx-s1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7fibj5sxfyoheezo"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38685 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbdLMPpv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Dec 2017 10:45:51 -0500
Content-Disposition: inline
In-Reply-To: <20171213144748.GA18267@arx-s1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: hao_zhang <hao5781286@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org


--7fibj5sxfyoheezo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your patch!

On Wed, Dec 13, 2017 at 10:47:48PM +0800, hao_zhang wrote:
> Pin function can not be match correctly when SUNXI_PIN describe with
> mutiple variant and same function.
>=20
> such as:
> on pinctrl-sun4i-a10.c
>=20
> SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
> 		SUNXI_FUNCTION(0x0, "gpio_in"),
> 		SUNXI_FUNCTION(0x1, "gpio_out"),
> 		SUNXI_FUNCTION_VARIANT(0x2, "pwm",    /* PWM0 */
> 			PINCTRL_SUN4I_A10 |
> 			PINCTRL_SUN7I_A20),
> 		SUNXI_FUNCTION_VARIANT(0x3, "pwm",    /* PWM0 */
> 			PINCTRL_SUN8I_R40)),
>=20
> it would always match to the first variant function
> (PINCTRL_SUN4I_A10, PINCTRL_SUN7I_A20)
>=20
> so we should add variant compare on it.
>=20
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunx=
i/pinctrl-sunxi.c
> index 4b6cb25..f23e74e 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -83,9 +83,11 @@ sunxi_pinctrl_desc_find_function_by_name(struct sunxi_=
pinctrl *pctl,
>  			struct sunxi_desc_function *func =3D pin->functions;
> =20
>  			while (func->name) {
> -				if (!strcmp(func->name, func_name))
> +				if (!strcmp(func->name, func_name)) {
> +					if (!(func->variant) ||
> +					   (func->variant & pctl->variant))

I guess it would be better to have:
	if (!strcmp(func->name, func_name) &&
	    (!func->variant || (func->variant & pctl->variant)))

Once fixed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--7fibj5sxfyoheezo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAloxSyoACgkQ0rTAlCFN
r3TSDg/9E7vpgikt5S3ycM1TUVZA6IbxYUJZB9Q82EYIQix+dEmNPGTeErPl3AtJ
Ob0CiSmWSMPhqMuZh+WmxBjkZ4dEXFOwRdnqJ1ChOH5gzXTqVUi5UZ5tl27blV2P
oex4ngR45l6oROKhBdR4t/qh0S6s9SgrgHsuqCOIHMraeKiumRYg6XcE5xSciigp
whOV/qtf09bzZGBXDn2KjK45P1b7brqsd7j43q/VAPitAtfYkJvT/hx/ro4Mx+IB
UIwcKUvrA9hWTK51fl5Yg8jPMcKyJjacoNu92iE0e2TQ3YDn3+eeWIrnWwOZZBvw
FlDqs9Y+rhOEStMokyaauV4Xg3jLd1cZ8ByH+v77F/fLLuKwsGFUsyMz25TEWWyB
dgwxmyvFnpaB3v23KwDJ6to3Q1Xf3OiOMVlLbnCzgyJwyKOvdONO0MnCDKF9PtBm
xPfYs0fHsopBrupoet9ZGacMkPFRHdhICeqeRo/WvEESyvdMrFjsc/Mdo6h3MAYz
Cx1yZXRTDFOrZEKICn5iylX3oSvA3IOoJ1tVO1flVlmyfXk+BFOF68/wQd2tXELR
+fA+F6A6vmHuuS+y85E2Ie/pXnB45cFdEk5DF9Z3NEW8CmU4e8rYf7iZrQ79iWUl
JAPwGBRmn5hjQ5FF42S2Irf9xdG8Jp/SK0N7ja94ueICCasy5OU=
=qWcZ
-----END PGP SIGNATURE-----

--7fibj5sxfyoheezo--
