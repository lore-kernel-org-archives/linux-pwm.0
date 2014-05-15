From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [rfc]pwm: add xilinx pwm driver
Date: Thu, 15 May 2014 14:20:11 +0200
Message-ID: <5049141.XmehsUeakV@wuerfel>
References: <1400066773-14393-1-git-send-email-bart.tanghe@thomasmore.be> <53748D84.5040005@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53748D84.5040005-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Cc: Bart Tanghe <bart.tanghe-2dq7lIxLGp5qkBXjtECzWg@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thursday 15 May 2014 11:48:52 Michal Simek wrote:
> On 05/14/2014 01:26 PM, Bart Tanghe wrote:
> > 	add Xilinx PWM support - axi timer hardware block 
> > 
> > Signed-off-by: Bart Tanghe <bart.tanghe-2dq7lIxLGp5qkBXjtECzWg@public.gmane.org>
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-xlnx.txt b/Documentation/devicetree/bindings/pwm/pwm-xlnx.txt
> > new file mode 100644
> > index 0000000..cb48926
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-xlnx.txt
> > @@ -0,0 +1,20 @@
> > +Xilinx PWM controller
> > +
> > +Required properties:
> > +- compatible: should be "xlnx,pwm-xlnx"
> > +- add a clock source to the description
> > +
> > +Examples:
> > +
> > +		axi_timer_0: timer@42800000 {
> > +			clock-frequency = <100000000>;
> 
> just remove this from example it is not needed and unused.
> 
> 
> > +			clocks = <&clkc 15>;
> > +			compatible = "xlnx,xlnx-pwm";
> > +			reg = <0x42800000 0x10000>;
> > +			xlnx,count-width = <0x20>;
> > +			xlnx,gen0-assert = <0x1>;
> > +			xlnx,gen1-assert = <0x1>;
> > +			xlnx,one-timer-only = <0x0>;
> > +			xlnx,trig0-assert = <0x1>;
> > +			xlnx,trig1-assert = <0x1>;
> > +		} ;
> 
> ok. This has to be done completely differently.
> I have looked around and found one a little bit older
> example but it is in the Linux kernel.
> It is pwm-atmel-tcb.c driver and atmel_tclib.c and tcb_clksrc.c.
> 
> Arnd: Isn't there any newer better example how to manage it?

Note that we have two atmel pwm drivers: drivers/misc/atmel_pwm.c 
and drivers/pwm/pwm-atmel.c. If you want to take that as an example,
make sure you use base on the latter.

> Back to atmel example - they are maintaining
> internal list of timers (atmel_tclib.c)
> and then clocksource driver (tcb_clksrc.c) is asking with atmel_tc_alloc() for it.
> The same is for pwm driver (pwm-atmel-tcb.c).
> 
> They probably have all timers the same which is not
> our case because they can be different but this can be solved
> with flags.
> 
> From DT point of view I think this is the reasonable description
> 
> axi_timer_0: timer@42800000 {
> 	clocks = <&clkc 15>;
> 	compatible = "xlnx,xps-timer-1.00.a";
> 	interrupt-parent = <&xps_intc_0>;
> 	interrupts = < 3 2 >;
> 	reg = <0x42800000 0x10000>;
> 	xlnx,count-width = <0x20>;
> 	xlnx,gen0-assert = <0x1>;
> 	xlnx,gen1-assert = <0x1>;
> 	xlnx,one-timer-only = <0x0>;
> 	xlnx,trig0-assert = <0x1>;
> 	xlnx,trig1-assert = <0x1>;
> } ;
> 
> 
> pwm {
>         compatible = "xlnx,timer-pwm";
>         #pwm-cells = <2>;
>         timer = <&axi_timer_0>;
> };
> 
> 
> Allocation function will also require to do a change
> in clocksource driver because currently the first
> timer in the DTS/system is taken for clocksource/clockevents
> (others are just ignored).
> That's why will be necessary to add clock-handle property
> to cpu node to exactly describe which timer is system timer.
> The same as is for interrupt-handle (more intc's can be in design).

If there is just one set of registers, I wouldn't object to
having just a single node in DT, and just one driver that registers
to both the clocksource and the PWM interfaces. That might
simplify the code.

> 	cpus {
> 		#address-cells = <1>;
> 		#cpus = <1>;
> 		#size-cells = <0>;
> 		microblaze_0: cpu@0 {
> 			compatible = "xlnx,microblaze-8.50.a";
> 			interrupt-handle = <&microblaze_0_intc>;
> 			...
> 			clock-handle = <&axi_timer_X>;
> 			...
> 		} ;
> 	} ;
> 
> Then clocksource driver will ask just exact timer which is suitable
> to provide clocksource/clockevent. It can be also split and
> use 2 cells format to specify which timer should be used.
> clocksource-handle = <&axi_timer_X 0>;
> clockeven-handle = <&axi_timer_X 1>;

This seems fine, too.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
