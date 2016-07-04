From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3] ARM: at91: Document new TCB bindings
Date: Mon, 4 Jul 2016 12:24:52 +0200
Message-ID: <20160704122452.69dcddf0@bbrezillon>
References: <1467409925-17761-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37959 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752661AbcGDKZG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Jul 2016 06:25:06 -0400
In-Reply-To: <1467409925-17761-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On Fri,  1 Jul 2016 23:52:05 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> The current binding for the TCB is not flexible enough for some use cases
> and prevents proper utilization of all the channels.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.txt         | 32 ------------
>  .../devicetree/bindings/mfd/atmel-tcb.txt          | 58 ++++++++++++++++++++++
>  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      | 12 +++--
>  3 files changed, 65 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index e1f5ad855f14..3dc758403d03 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -60,38 +60,6 @@ System Timer (ST) required properties:
>  Its subnodes can be:
>  - watchdog: compatible should be "atmel,at91rm9200-wdt"
>  
> -TC/TCLIB Timer required properties:
> -- compatible: Should be "atmel,<chip>-tcb".
> -  <chip> can be "at91rm9200" or "at91sam9x5"
> -- reg: Should contain registers location and length
> -- interrupts: Should contain all interrupts for the TC block
> -  Note that you can specify several interrupt cells if the TC
> -  block has one interrupt per channel.
> -- clock-names: tuple listing input clock names.
> -	Required elements: "t0_clk", "slow_clk"
> -	Optional elements: "t1_clk", "t2_clk"
> -- clocks: phandles to input clocks.
> -
> -Examples:
> -
> -One interrupt per TC block:
> -	tcb0: timer@fff7c000 {
> -		compatible = "atmel,at91rm9200-tcb";
> -		reg = <0xfff7c000 0x100>;
> -		interrupts = <18 4>;
> -		clocks = <&tcb0_clk>;
> -		clock-names = "t0_clk";
> -	};
> -
> -One interrupt per TC channel in a TC block:
> -	tcb1: timer@fffdc000 {
> -		compatible = "atmel,at91rm9200-tcb";
> -		reg = <0xfffdc000 0x100>;
> -		interrupts = <26 4 27 4 28 4>;
> -		clocks = <&tcb1_clk>;
> -		clock-names = "t0_clk";
> -	};
> -
>  RSTC Reset Controller required properties:
>  - compatible: Should be "atmel,<chip>-rstc".
>    <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> new file mode 100644
> index 000000000000..693c7361e1ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> @@ -0,0 +1,58 @@
> +* Device tree bindings for Atmel Timer Counter Blocks
> +- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
> +  <chip> can be "at91rm9200" or "at91sam9x5"
> +- reg: Should contain registers location and length
> +- #address-cells: has to be 1
> +- #size-cells: has to be 0
> +- interrupts: Should contain all interrupts for the TC block
> +  Note that you can specify several interrupt cells if the TC
> +  block has one interrupt per channel.
> +- clock-names: tuple listing input clock names.
> +	Required elements: "t0_clk", "slow_clk"
> +	Optional elements: "t1_clk", "t2_clk"
> +- clocks: phandles to input clocks.
> +
> +The TCB can expose multiple subdevices:
> + * a timer
> +   - compatible: Should be "atmel,tcb-timer"
> +   - reg: Should contain the TCB channels to be used. If the
> +     counter width is 16 bits (at91rm9200-tcb), two consecutive
> +     channels are needed. Else, only one channel will be used.
> +
> + * a PWM chip: see ../pwm/atmel-tcb-pwm.txt
> +
> +Examples:
> +
> +One interrupt per TC block:
> +	tcb0: timer@fff7c000 {
> +		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0xfff7c000 0x100>;
> +		interrupts = <18 4>;
> +		clocks = <&tcb0_clk>, <&clk32k>;
> +		clock-names = "t0_clk", "slow_clk";
> +
> +		timer@0 {
> +			compatible = "atmel,tcb-timer";
> +			reg = <0>, <1>;
> +		};
> +
> +		timer@2 {
> +			compatible = "atmel,tcb-timer";
> +			reg = <2>;
> +		};

And how can you differentiate the clocksource from the clkevent?

> +	};
> +
> +One interrupt per TC channel in a TC block:
> +	tcb1: timer@fffdc000 {
> +		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0xfffdc000 0x100>;
> +		interrupts = <26 4>, <27 4>, <28 4>;
> +		clocks = <&tcb1_clk>, <&clk32k>;
> +		clock-names = "t0_clk", "slow_clk";
> +	};
> +
> +
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> index 8031148bcf85..ab8fbd5ba184 100644
> --- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> @@ -2,15 +2,17 @@ Atmel TCB PWM controller
>  
>  Required properties:
>  - compatible: should be "atmel,tcb-pwm"
> +- reg: tcb channel to use. Each channel can export 2 PWMs
>  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
>    the cells format. The only third cell flag supported by this binding is
>    PWM_POLARITY_INVERTED.
> -- tc-block: The Timer Counter block to use as a PWM chip.
>  
>  Example:
>  
> -pwm {
> -	compatible = "atmel,tcb-pwm";
> -	#pwm-cells = <3>;
> -	tc-block = <1>;
> +tcb0: timer@f800c000 {
> +	pwm@0 {
> +		compatible = "atmel,tcb-pwm";
> +		reg = <0>;
> +		#pwm-cells = <3>;
> +	};
>  };
