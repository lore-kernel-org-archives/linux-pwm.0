From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 2/2] pwm: add DT bindings documentation for
 atmel-hlcdc-pwm driver
Date: Tue, 7 Oct 2014 10:47:05 +0200
Message-ID: <20141007084705.GF24254@ulmo>
References: <1412604423-19329-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412604423-19329-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:53069 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbaJGIrI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 04:47:08 -0400
Content-Disposition: inline
In-Reply-To: <1412604423-19329-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 04:07:03PM +0200, Boris Brezillon wrote:
> The HLCDC IP available in some Atmel SoCs (i.e. sam9x5i.e. at91sam9n12,
> at91sam9x5 family or sama5d3 family) provide a PWM device.
>=20
> The DT bindings used for this PWM device is following the default 3 cells
> bindings described in Documentation/devicetree/bindings/pwm/pwm.txt.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    | 50 ++++++++++++++++=
++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/=
Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> new file mode 100644
> index 0000000..9f4f83a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> @@ -0,0 +1,50 @@
> +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) PWM driver
> +
> +The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
> +See ../mfd/atmel-hlcdc.txt for more details.
> +
> +Required properties:
> + - compatible: value should be one of the following:
> +   "atmel,hlcdc-pwm"
> + - pinctr-names: the pin control state names. Should contain "default".
> + - pinctrl-0: should contain the pinctrl states described by pinctrl
> +   default.
> + - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
> +   bindings defined in Documentation/devicetree/bindings/pwm/pwm.txt.

Maybe "... defined in pwm.txt in this directory."?

> +
> +Example:
> +
> +	hlcdc: hlcdc@f0030000 {
> +		compatible =3D "atmel,sama5d3-hlcdc";
> +		reg =3D <0xf0030000 0x2000>;
> +		clocks =3D <&lcdc_clk>, <&lcdck>, <&clk32k>;
> +		clock-names =3D "periph_clk","sys_clk", "slow_clk";
> +		status =3D "disabled";
> +
> +		hlcdc-display-controller {
> +			compatible =3D "atmel,hlcdc-display-controller";
> +			interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH 0>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@0 {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				reg =3D <0>;
> +
> +				hlcdc_panel_output: endpoint@0 {
> +					reg =3D <0>;
> +					remote-endpoint =3D <&panel_input>;
> +				};
> +			};
> +		};

Perhaps leave out the display controller node in this example since it
isn't relevant and could be confusing.

Both of the above are really only minor issues, so either way:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUM6iJAAoJEN0jrNd/PrOhxnsP/jG43h/NP0aIh2r9Rfq6CQjw
aJWRDPomfDIk6IyvZ2AUO/zsEJDqzkgv2edlB/fSdirFnrm47ZJxWxZQreEMgQ4g
Gmvd6Cj3UizD45jUKhBDL4fK4+f2y7KO+jikz4Og1tTKvxjTlhExdkFYmBzr/wyK
/yENzxawSr2DloVYM3DPee2YhrXAsNMThhWJP/iDb/9CHAOiU7aeBf9fDSypG2bO
dboXmYSlmABV5Nc30CugbaZhIXzxCepDNj5tdIfiSUadjI1hKK/sff1ow5BgPnNg
qJhw+SANGkXk1NXgE4n/Lb5FsA4g/B26qDPpPJ2mhcNo+CQ2oyga9fWP3jKkNMAj
twYb4xHoYMehjGEu/Jf70Od8NgIb7hXdXBV6FCkDS/EHk/qrg22cbTn/73WPifaf
RU38bmKrF3/UFpQ5Umw2wEMBk+abwySDmJgUPGAeGOT5hjcMk01r2qZfGv+Hkjz7
TBUwe65bCQVOBxEOjI9VkKXREFv2BQFhV1O7o40VpGENjryOa1zEl2WKWkiBWq6a
G961VliSAndCEersYpbsomcPC4sQY+85EPMY5nY/GNLA0/0m3igt8szsJaed5hYu
1jIA60Bx4PCpEjK6SKLba/dR1XTPk+Evej6CQwj5PkO2wbH3WEEeYh/e90Hp2pDA
UQeZJzgB9/PHhkG36i6q
=ZuYK
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
