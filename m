From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ARM: at91: Document new TCB bindings
Date: Tue, 5 Jul 2016 10:40:22 -0500
Message-ID: <CAL_JsqL2Kjtf-BuCjK8ZHcDdbgVDy-L-_AN+=4HmxVAwy3ucdA@mail.gmail.com>
References: <1467039901-11297-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160701012743.GA16698@rob-hp-laptop> <20160704151058.44b679bf@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160704151058.44b679bf@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jul 4, 2016 at 8:10 AM, Boris Brezillon
<boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Thu, 30 Jun 2016 20:27:43 -0500
> Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> On Mon, Jun 27, 2016 at 05:05:01PM +0200, Alexandre Belloni wrote:
>> > The current binding for the TCB is not flexible enough for some use cases
>> > and prevents proper utilization of all the channels.
>> >
>> > Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> > Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> > Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> > ---
>> >
>> > Changes in v2:
>> >  - added slow_clk in the examples
>> >  - removed linuxisms
>> >
>> > Rob, does that fit what you wanted? I prefer getting your ack on that one before
>> > resending a 48 patches series.
>> >
>> >
>> >  .../devicetree/bindings/arm/atmel-at91.txt         | 32 -----------
>> >  .../devicetree/bindings/mfd/atmel-tcb.txt          | 62 ++++++++++++++++++++++
>> >  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      | 12 +++--
>> >  3 files changed, 69 insertions(+), 37 deletions(-)
>> >  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
>> > index e1f5ad855f14..3dc758403d03 100644
>> > --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
>> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
>> > @@ -60,38 +60,6 @@ System Timer (ST) required properties:
>> >  Its subnodes can be:
>> >  - watchdog: compatible should be "atmel,at91rm9200-wdt"
>> >
>> > -TC/TCLIB Timer required properties:
>> > -- compatible: Should be "atmel,<chip>-tcb".
>> > -  <chip> can be "at91rm9200" or "at91sam9x5"
>> > -- reg: Should contain registers location and length
>> > -- interrupts: Should contain all interrupts for the TC block
>> > -  Note that you can specify several interrupt cells if the TC
>> > -  block has one interrupt per channel.
>> > -- clock-names: tuple listing input clock names.
>> > -   Required elements: "t0_clk", "slow_clk"
>> > -   Optional elements: "t1_clk", "t2_clk"
>> > -- clocks: phandles to input clocks.
>> > -
>> > -Examples:
>> > -
>> > -One interrupt per TC block:
>> > -   tcb0: timer@fff7c000 {
>> > -           compatible = "atmel,at91rm9200-tcb";
>> > -           reg = <0xfff7c000 0x100>;
>> > -           interrupts = <18 4>;
>> > -           clocks = <&tcb0_clk>;
>> > -           clock-names = "t0_clk";
>> > -   };
>> > -
>> > -One interrupt per TC channel in a TC block:
>> > -   tcb1: timer@fffdc000 {
>> > -           compatible = "atmel,at91rm9200-tcb";
>> > -           reg = <0xfffdc000 0x100>;
>> > -           interrupts = <26 4 27 4 28 4>;
>> > -           clocks = <&tcb1_clk>;
>> > -           clock-names = "t0_clk";
>> > -   };
>> > -
>> >  RSTC Reset Controller required properties:
>> >  - compatible: Should be "atmel,<chip>-rstc".
>> >    <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
>> > diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>> > new file mode 100644
>> > index 000000000000..71c8d83c01a7
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>> > @@ -0,0 +1,62 @@
>> > +* Device tree bindings for Atmel Timer Counter Blocks
>> > +- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
>> > +  <chip> can be "at91rm9200" or "at91sam9x5"
>> > +- reg: Should contain registers location and length
>> > +- #address-cells: has to be 1
>> > +- #size-cells: has to be 0
>> > +- interrupts: Should contain all interrupts for the TC block
>> > +  Note that you can specify several interrupt cells if the TC
>> > +  block has one interrupt per channel.
>> > +- clock-names: tuple listing input clock names.
>> > +   Required elements: "t0_clk", "slow_clk"
>> > +   Optional elements: "t1_clk", "t2_clk"
>> > +- clocks: phandles to input clocks.
>> > +
>> > +The TCB can expose multiple subdevices:
>> > + * a clocksource and clockevent device
>>
>> This still uses Linux terminology.
>>
>> > +   - compatible: Should be "atmel,tcb-free-running-timer"
>> > +   - reg: Should contain the TCB channels to be used. If the
>> > +     counter width is 16 bits (at91rm9200-tcb), two consecutive
>> > +     channels are needed. Else, only one channel will be used.
>> > +
>> > + * a clockevent device
>> > +   - compatible: Should be "atmel,tcb-programmable-timer"
>>
>> This still looks like assigning usage in DT. As I'm willing to accept
>> that for PWM, either timer channels should be whatever channels are not
>> assigned to PWM (i.e. not in DT) or they should just be "timer" and let
>> the kernel decide their usage.
>
> I just reviewed Alexandre's new binding, and it makes the whole thing
> a lot more obscure: on older SoCs, we have to chain 2 channels to
> create an acceptable wraparound time (16 bits at 5MHz is generating too
> much interrupts to be acceptable).
>
> If we don't assign the mode from the DT, how should we know which
> channels should be chained to create the free-running timer? Note that
> not all channels can be chained together: they have to be part of the
> same timer counter block and have to be consecutive (0+1, 1+2 or 3+0).

The driver can have this knowledge if it is just picking 2 consecutive
timers. It should already know it has 16-bit timers based on the
compatible string. If it gets more complicated then the features or
limitations of the channels should be listed so the driver can make a
choice. OMAP is a good example of lots of timers with differing
features.

> Honestly, I don't see the difference between assigning the channel to a
> PWM mode and assigning it to a free-running or oneshot timer mode. Why
> is it more acceptable?

The difference is that pwm's have clients (e.g. a backlight) in DT and
timers do not. We could just make the pwm clients reference the parent
node, but then it is hard to figure out which channels are in use for
pwm. That could also be solved with a simple "pwm-channels" property
listing the channels in use.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
