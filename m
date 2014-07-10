From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for atmel-hlcdc-dc driver
Date: Thu, 10 Jul 2014 13:16:21 +0200
Message-ID: <1584022.nQ4HpIUW7J@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com> <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:45747 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbaGJLPU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Jul 2014 07:15:20 -0400
In-Reply-To: <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience.de>

Hi Boris,

Thank you for the patch.

On Monday 07 July 2014 18:42:59 Boris BREZILLON wrote:
> The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> controller device.
> 
> The HLCDC block provides a single RGB output port, and only supports LCD
> panels connection to LCD panels for now.
> 
> The atmel,panel property link the HLCDC RGB output with the LCD panel
> connected on this port (note that the HLCDC RGB connector implementation
> makes use of the DRM panel framework).
> 
> Connection to other external devices (DRM bridges) might be added later by
> mean of a new atmel,xxx (atmel,bridge) property.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> 
> diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt new file mode
> 100644
> index 0000000..594bdb2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> @@ -0,0 +1,59 @@
> +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
> +
> +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more details.
> +
> +Required properties:
> + - compatible: value should be one of the following:
> +   "atmel,hlcdc-dc"
> + - interrupts: the HLCDC interrupt definition
> + - pinctrl-names: the pin control state names. Should contain "default",
> +   "rgb-444", "rgb-565", "rgb-666" and "rgb-888".
> + - pinctrl-[0-4]: should contain the pinctrl states described by pinctrl
> +   names.

Do you need to switch between the different pinctrl configurations at runtime, 
or is the configuration selected from the panel type, which doesn't change ?

> + - atmel,panel: Should contain a phandle with 2 parameters.
> +   The first cell is a phandle to a DRM panel device
> +   The second cell encodes the RGB mode, which can take the following
> values:
> +   * 0: RGB444
> +   * 1: RGB565
> +   * 2: RGB666
> +   * 3: RGB888
> +   The third cell encodes specific flags describing LCD signals
> configuration
> +   (see Atmel's datasheet for a full description of these
> fields):
> +   * bit 0: HSPOL: Horizontal Synchronization Pulse Polarity
> +   * bit 1: VSPOL: Vertical Synchronization Pulse Polarity
> +   * bit 2: VSPDLYS: Vertical Synchronization Pulse Start
> +   * bit 3: VSPDLYE: Vertical Synchronization Pulse End
> +   * bit 4: DISPPOL: Display Signal Polarity
> +   * bit 7: DISPDLY: LCD Controller Display Power Signal Synchronization
> +   * bit 12: VSPSU: LCD Controller Vertical synchronization Pulse Setup
> Configuration
> +   * bit 13: VSPHO: LCD Controller Vertical synchronization Pulse Hold
> Configuration
> +   * bit 16-20: GUARDTIME: LCD DISPLAY Guard Time

If I'm not mistaken, those are HLCDC configuration values that depend on the 
panel type and characteristics. Shouldn't they then be queries from the panel 
through the drm_panel API at runtime instead of being specified in DT ? This 
would likely require extending the drm_panel API.

> +
> +Example:
> +
> +	hlcdc: hlcdc@f0030000 {
> +		compatible = "atmel,sama5d3-hlcdc";
> +		reg = <0xf0030000 0x2000>;
> +		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
> +		clock-names = "periph_clk","sys_clk", "slow_clk";
> +		status = "disabled";
> +
> +		hlcdc-display-controller {
> +			compatible = "atmel,hlcdc-dc";
> +			interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
> +			pinctrl-names = "default", "rgb-444", "rgb-565", "rgb-666", 
"rgb-888";
> +			pinctrl-0 = <&pinctrl_lcd_base>;
> +			pinctrl-1 = <&pinctrl_lcd_base &pinctrl_lcd_rgb444>;
> +			pinctrl-2 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> +			pinctrl-3 = <&pinctrl_lcd_base &pinctrl_lcd_rgb666>;
> +			pinctrl-4 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> +		};
> +
> +		hlcdc_pwm: hlcdc-pwm {
> +			compatible = "atmel,hlcdc-pwm";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_lcd_pwm>;
> +			#pwm-cells = <3>;
> +		};
> +	};

-- 
Regards,

Laurent Pinchart

