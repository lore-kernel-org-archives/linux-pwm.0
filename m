From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 3/4] ARM: dts: add pwm node for r40.
Date: Wed, 13 Dec 2017 16:57:42 +0100
Message-ID: <20171213155742.he2wmdf6camsua5k@flea.lan>
References: <20171213144628.GA18246@arx-s1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="42iglaxyb27fxpbd"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39101 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdLMP5o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Dec 2017 10:57:44 -0500
Content-Disposition: inline
In-Reply-To: <20171213144628.GA18246@arx-s1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: hao_zhang <hao5781286@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org


--42iglaxyb27fxpbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 13, 2017 at 10:46:28PM +0800, hao_zhang wrote:
> This patch add pwm node for r40.
>=20
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts |  6 ++++++
>  arch/arm/boot/dts/sun8i-r40.dtsi                  | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm=
/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 8c5efe2..6cf6273 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -196,6 +196,12 @@
>  	status =3D "okay";
>  };
> =20
> +&pwm {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pwm_pins>;
> +	status =3D "okay";
> +};
> +

Can you split this part into a separate patch?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--42iglaxyb27fxpbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAloxTfMACgkQ0rTAlCFN
r3T1JBAAkcNkMs6L2a036oSrW3tiMA8/E5fSwKdOOUvXiZcbj/FFwafcwctQdo7A
e8VIgTiPy4YecfG+8OZ6Bq9UkogINye6uZDBkJcy8VaF48a1rVMTHNAUha7Ft5CK
T9F8VknSpwUaGYxTda+4FHSQ43gMPYPJ+yo6LzTfwxd4t/E0mAl9OzyXnIeSDfzA
JlUzwfDFv483zZJ6b39tyDWGbBlTkFpHlcEdqJz3PaKThM8hVnC9kD5wnXFLs7Ln
duUQHOWvbg8gv/KCf0Mn68VONgR9MeUDzUUmlkNZfT4g1tn3I1xfOdbfMENT+Pqd
v5mHKU+ErE+dy8+hbqBoyLOc/Ch/e2ximpsEtBiLKrOLCr92CcgZCHxCk3bJMWuc
ynz43me38gOGzcF7y/JRCvXqyS6tX4CKT+/G9EBWqr9tiNcKIZN/vvcc4RHPwpGe
Vuzi2P0N+8j5gjzf8VkO89E7DbCX/Dkr3XEu5eAGdpzSHnY0/oatjVrJNtIFs05h
C/bElXdvucmAkDHcq1vwsLxtVkJsSuPdCFUKGbrBowGqrUxpQvi9giIDJQLLSBs7
1xG4GJlWRyCj+0uRQQeSxlLGmaPRx4Bn2uewr8PPcKnAxU/VO08n0Nf7SOWVVw5a
cYaVZ2D9ygubwx49bNeCOvmDcXIMJs3KUCyDH1E4Z6aj5pAZszI=
=5ADU
-----END PGP SIGNATURE-----

--42iglaxyb27fxpbd--
