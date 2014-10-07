From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 2/2] mfd: add documentation for atmel-hlcdc DT bindings
Date: Tue, 7 Oct 2014 10:44:47 +0100
Message-ID: <20141007094447.GX25331@lee--X1>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412603324-18789-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46744 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbaJGJoy (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 05:44:54 -0400
Received: by mail-ie0-f171.google.com with SMTP id tr6so5013345ieb.30
        for <linux-pwm@vger.kernel.org>; Tue, 07 Oct 2014 02:44:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412603324-18789-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Mon, 06 Oct 2014, Boris Brezillon wrote:

> The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9=
x5
> family or sama5d3 family) exposes 2 subdevices:
> - a display controller (controlled by a DRM driver)
> - a PWM chip
>=20
> This patch adds documentation for atmel-hlcdc DT bindings.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  .../devicetree/bindings/mfd/atmel-hlcdc.txt        | 51 ++++++++++++=
++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc=
=2Etxt

Applied for v3.19.

> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/=
Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> new file mode 100644
> index 0000000..f64de95a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> @@ -0,0 +1,51 @@
> +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD dri=
ver
> +
> +Required properties:
> + - compatible: value should be one of the following:
> +   "atmel,sama5d3-hlcdc"
> + - reg: base address and size of the HLCDC device registers.
> + - clock-names: the name of the 3 clocks requested by the HLCDC devi=
ce.
> +   Should contain "periph_clk", "sys_clk" and "slow_clk".
> + - clocks: should contain the 3 clocks requested by the HLCDC device=
=2E
> + - interrupts: should contain the description of the HLCDC interrupt=
 line
> +
> +The HLCDC IP exposes two subdevices:
> + - a PWM chip: see ../pwm/atmel-hlcdc-pwm.txt
> + - a Display Controller: see ../drm/atmel-hlcdc-dc.txt
> +
> +Example:
> +
> +	hlcdc: hlcdc@f0030000 {
> +		compatible =3D "atmel,sama5d3-hlcdc";
> +		reg =3D <0xf0030000 0x2000>;
> +		clocks =3D <&lcdc_clk>, <&lcdck>, <&clk32k>;
> +		clock-names =3D "periph_clk","sys_clk", "slow_clk";
> +		interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH 0>;
> +		status =3D "disabled";
> +
> +		hlcdc-display-controller {
> +			compatible =3D "atmel,hlcdc-display-controller";
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
> +
> +		hlcdc_pwm: hlcdc-pwm {
> +			compatible =3D "atmel,hlcdc-pwm";
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&pinctrl_lcd_pwm>;
> +			#pwm-cells =3D <3>;
> +		};
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
