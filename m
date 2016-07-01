From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] ARM: at91: Document new TCB bindings
Date: Thu, 30 Jun 2016 20:27:43 -0500
Message-ID: <20160701012743.GA16698@rob-hp-laptop>
References: <1467039901-11297-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35918 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcGAB1q (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jun 2016 21:27:46 -0400
Content-Disposition: inline
In-Reply-To: <1467039901-11297-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Jun 27, 2016 at 05:05:01PM +0200, Alexandre Belloni wrote:
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
> 
> Changes in v2:
>  - added slow_clk in the examples
>  - removed linuxisms
> 
> Rob, does that fit what you wanted? I prefer getting your ack on that one before
> resending a 48 patches series.
> 
> 
>  .../devicetree/bindings/arm/atmel-at91.txt         | 32 -----------
>  .../devicetree/bindings/mfd/atmel-tcb.txt          | 62 ++++++++++++++++++++++
>  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      | 12 +++--
>  3 files changed, 69 insertions(+), 37 deletions(-)
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
> index 000000000000..71c8d83c01a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> @@ -0,0 +1,62 @@
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
> + * a clocksource and clockevent device

This still uses Linux terminology.

> +   - compatible: Should be "atmel,tcb-free-running-timer"
> +   - reg: Should contain the TCB channels to be used. If the
> +     counter width is 16 bits (at91rm9200-tcb), two consecutive
> +     channels are needed. Else, only one channel will be used.
> +
> + * a clockevent device
> +   - compatible: Should be "atmel,tcb-programmable-timer"

This still looks like assigning usage in DT. As I'm willing to accept 
that for PWM, either timer channels should be whatever channels are not 
assigned to PWM (i.e. not in DT) or they should just be "timer" and let 
the kernel decide their usage.

Rob
