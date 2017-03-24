From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] gpio: mvebu: Add limited PWM support
Date: Fri, 24 Mar 2017 10:18:29 -0500
Message-ID: <20170324151829.awmhshsent4ngqb5@rob-hp-laptop>
References: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
 <20170318154305.28348-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32914 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbdCXPUE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Mar 2017 11:20:04 -0400
Content-Disposition: inline
In-Reply-To: <20170318154305.28348-2-ralph.sennhauser@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: linux-gpio@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Sat, Mar 18, 2017 at 04:43:01PM +0100, Ralph Sennhauser wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Armada 370/XP devices can 'blink' gpio lines with a configurable on
> and off period. This can be modelled as a PWM.
> 
> However, there are only two sets of PWM configuration registers for
> all the gpio lines. This driver simply allows a single gpio line per
> gpio chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
> 
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the gpio driver. Thus the gpio driver has been
> extended with a PWM driver.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427287/
> URL: https://patchwork.ozlabs.org/patch/427295/
> [Ralph Sennhauser:
>   * port forward
>   * merge pwm portion into gpio-mvebu.c
>   * merge documentation patch
>   * update MAINTAINERS]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> ---
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  31 +++
>  MAINTAINERS                                        |   2 +
>  drivers/gpio/gpio-mvebu.c                          | 291 +++++++++++++++++++--
>  3 files changed, 307 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> index a6f3bec..86932e3 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> @@ -38,6 +38,23 @@ Required properties:
>  - #gpio-cells: Should be two. The first cell is the pin number. The
>    second cell is reserved for flags, unused at the moment.
>  
> +Optional properties:
> +
> +In order to use the gpio lines in PWM mode, some additional optional
> +properties are required. Only Armada 370 and XP support these properties.
> +
> +- reg: an additional register set is needed, for the GPIO Blink
> +  Counter on/off registers.
> +
> +- reg-names: Must contain an entry "pwm" corresponding to the
> +  additional register range needed for pwm operation.
> +
> +- #pwm-cells: Should be two. The first cell is the pin number. The

s/pin number/gpio line/ ?

> +  second cell is reserved for flags and should be set to 0, so it has a
> +  known value. It then becomes possible to use it in the future.
> +
> +- clocks: Must be a phandle to the clock for the gpio controller.
> +
>  Example:
>  
>  		gpio0: gpio@d0018100 {
> @@ -51,3 +68,17 @@ Example:
>  			#interrupt-cells = <2>;
>  			interrupts = <16>, <17>, <18>, <19>;
>  		};
> +
> +		gpio1: gpio@18140 {
> +			compatible = "marvell,orion-gpio";

If only 370 and XP support this, I'd expect a compatible string for one 
of them here.

> +			reg = <0x18140 0x40>, <0x181c8 0x08>;
> +			reg-names = "gpio", "pwm";
> +			ngpios = <17>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			#pwm-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			interrupts = <87>, <88>, <89>;
> +			clocks = <&coreclk 0>;
> +		};
