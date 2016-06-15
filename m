From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 02/48] ARM: at91: Document new TCB bindings
Date: Wed, 15 Jun 2016 09:29:55 +0200
Message-ID: <20160615092955.261f14fb@bbrezillon>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
	<1465596231-21766-3-git-send-email-alexandre.belloni@free-electrons.com>
	<20160614214737.GA10294@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59611 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751429AbcFOHaJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jun 2016 03:30:09 -0400
In-Reply-To: <20160614214737.GA10294@rob-hp-laptop>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, 14 Jun 2016 16:47:37 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, Jun 11, 2016 at 12:03:05AM +0200, Alexandre Belloni wrote:
> > The current binding for the TCB is not flexible enough for some use cases
> > and prevents proper utilization of all the channels.
> > 
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: linux-pwm@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  .../devicetree/bindings/arm/atmel-at91.txt         | 32 -----------
> >  .../devicetree/bindings/mfd/atmel-tcb.txt          | 62 ++++++++++++++++++++++
> >  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      | 12 +++--
> >  3 files changed, 69 insertions(+), 37 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt  
> 
> [...]
> 
> > diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> > new file mode 100644
> > index 000000000000..48196752c78f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> > @@ -0,0 +1,62 @@
> > +* Device tree bindings for Atmel Timer Counter Blocks
> > +- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
> > +  <chip> can be "at91rm9200" or "at91sam9x5"
> > +- reg: Should contain registers location and length
> > +- #address-cells: has to be 1
> > +- #size-cells: has to be 0
> > +- interrupts: Should contain all interrupts for the TC block
> > +  Note that you can specify several interrupt cells if the TC
> > +  block has one interrupt per channel.
> > +- clock-names: tuple listing input clock names.
> > +	Required elements: "t0_clk", "slow_clk"
> > +	Optional elements: "t1_clk", "t2_clk"
> > +- clocks: phandles to input clocks.  
> 
> What is the order of clocks?
> 
> > +
> > +The TCB can expose multiple subdevices:
> > + * a clocksource and clockevent device  
> 
> No. These compatible names are linuxisms. Describe features of the 
> timers to be able to select which timer to use if you need to pick 
> certain timers. For example, interrupt capability could be used to 
> select the clkevt.

Would 'atmel,tcb-free-running-timer' (to replace 'atmel,tcb-clksrc') and
'atmel,tcb-programmable-timer' (to replace 'atmel,tcb-clkevt') be
acceptable?

> 
> > +   - compatible: Should be "atmel,tcb-clksrc"
> > +   - reg: Should contain the TCB channels to be used. If the
> > +     counter width is 16 bits (at91rm9200-tcb), two consecutive
> > +     channels are needed. Else, only one channel will be used.
> > +
> > + * a clockevent device
> > +   - compatible: Should be "atmel,tcb-clkevt"
> > +   - reg: Should contain the TCB channel to be used
> > +
> > + * a PWM chip: see ../pwm/atmel-tcb-pwm.txt
> > +
> > +Examples:
> > +
> > +One interrupt per TC block:
> > +	tcb0: timer@fff7c000 {
> > +		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		reg = <0xfff7c000 0x100>;
> > +		interrupts = <18 4>;
> > +		clocks = <&tcb0_clk>;
> > +		clock-names = "t0_clk";  
> 
> Missing slow_clk
> 
> > +
> > +		timer@0 {
> > +			compatible = "atmel,tcb-clksrc";
> > +			reg = <0>, <1>;
> > +		};
> > +
> > +		timer@2 {
> > +			compatible = "atmel,tcb-clkevt";
> > +			reg = <2>;
> > +		};
> > +	};
> > +
> > +One interrupt per TC channel in a TC block:
> > +	tcb1: timer@fffdc000 {
> > +		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		reg = <0xfffdc000 0x100>;
> > +		interrupts = <26 4>, <27 4>, <28 4>;
> > +		clocks = <&tcb1_clk>;
> > +		clock-names = "t0_clk";
> > +	};
> > +
> > +
> > diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > index 8031148bcf85..ab8fbd5ba184 100644
> > --- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > @@ -2,15 +2,17 @@ Atmel TCB PWM controller
> >  
> >  Required properties:
> >  - compatible: should be "atmel,tcb-pwm"
> > +- reg: tcb channel to use. Each channel can export 2 PWMs  
> 
> Is there a difference in channels? If not, then this compatible should 
> go.

This one I don't understand.
The TCB (Timer Counter Block) is an MFD containing 3 Timer Counter
devices. Each of these devices (also called channels) can be assigned a
specific mode:
- timer mode (free-running of programmable)
- waveform generator mode (IOW, a PWM)
- capture mode (an IIO device, but we don't have any driver for that
  right now)

So each sub-device of the TCB is represented as a sub-node with its own
compatible. Is there a problem with that?

> 
> >  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> >    the cells format. The only third cell flag supported by this binding is
> >    PWM_POLARITY_INVERTED.
> > -- tc-block: The Timer Counter block to use as a PWM chip.
> >  
> >  Example:
> >  
> > -pwm {
> > -	compatible = "atmel,tcb-pwm";
> > -	#pwm-cells = <3>;
> > -	tc-block = <1>;
> > +tcb0: timer@f800c000 {
> > +	pwm@0 {
> > +		compatible = "atmel,tcb-pwm";
> > +		reg = <0>;
> > +		#pwm-cells = <3>;
> > +	};
> >  };
> > -- 
> > 2.8.1
> >   



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
