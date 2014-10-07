From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v9 2/2] pwm: add DT bindings documentation for atmel-hlcdc-pwm
 driver
Date: Tue, 7 Oct 2014 14:55:26 +0200
Message-ID: <5433E2BE.6020704@atmel.com>
References: <1412676860-12120-1-git-send-email-boris.brezillon@free-electrons.com> <1412676860-12120-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:29313 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbaJGMz2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 08:55:28 -0400
In-Reply-To: <1412676860-12120-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org

On 07/10/2014 12:14, Boris Brezillon :
> The HLCDC IP available in some Atmel SoCs (i.e. sam9x5i.e. at91sam9n12,

Ditto: sam9x5 doesn't exist.

> at91sam9x5 family or sama5d3 family) provide a PWM device.
> 
> The DT bindings used for this PWM device is following the default 3 cells
> bindings described in Documentation/devicetree/bindings/pwm/pwm.txt.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> new file mode 100644
> index 0000000..8a85244
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> @@ -0,0 +1,29 @@
> +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) PWM driver

s/High/High-end/

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
> +   bindings defined in pwm.txt in this directory.
> +
> +Example:
> +
> +	hlcdc: hlcdc@f0030000 {
> +		compatible = "atmel,sama5d3-hlcdc";
> +		reg = <0xf0030000 0x2000>;
> +		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
> +		clock-names = "periph_clk","sys_clk", "slow_clk";
> +
> +		hlcdc_pwm: hlcdc-pwm {
> +				
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_lcd_pwm>;
> +			#pwm-cells = <3>;
> +		};
> +	};
> 

otherwise,
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.
-- 
Nicolas Ferre
