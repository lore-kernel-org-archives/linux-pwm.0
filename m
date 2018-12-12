From: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: Re: [RFC v2] pwm: Add Xilinx AXI Timer in PWM mode support
Date: Wed, 12 Dec 2018 16:06:12 +0100
Message-ID: <20181212150610.GA17818@salem.gmr.ssr.upm.es>
References: <20180322135316.19685-1-alvaro.gamez@hazent.com>
 <20181212104241.GA17654@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181212104241.GA17654@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 12, 2018 at 11:42:41AM +0100, Thierry Reding wrote:
> Did any discussion regarding the above-mentioned issues ever ensue? How
> do you want to proceed? At the very least we'll need some sort of device
> tree binding for this driver, so perhaps start with a DT binding
> proposal and take it from there?

No, nothing ever came up about this.

When I sent v1 of this RFC patch I started using it on the application I
needed it for, so what I did was to copy standard DT binding for
xlnx,xps-timer-1.00.a (the one that arch/microblaze/kernel.c looks for) and
replace the compatible string with one I just came up with in the moment,
xlnx,axi-timer-2.0, but now I don't think this was a good name, and it'd
look better as xlnx,axi-pwm

This would be my preferred approach, choosing the driver to use for each
instance of the same IP core by changing the compatible string. I think it's
cleaner and less error prone, but I don't know if this is acceptable (two
identical hardware devices with different compatible strings).

For Xilinx IP cores there's an utility from Xilinx that generates DTS
entries, so leaving the rest of settings as they are could be acceptable,
meaning that DT binding for an AXI timer being used as a PWM driver would be
like this, where the only change is the compatible string:

pwm_0: timer@timer@41c10000 {
	clock-frequency = <83250000>; // Redundant given clocks property
	clocks = <&clk_bus_0>;
	compatible = "xlnx,axi-pwm";
	reg = <0x41c10000 0x10000>;
	xlnx,count-width = <0x20>; // Could be used as limiting factor
	xlnx,gen0-assert = <0x1>; // Not used
	xlnx,gen1-assert = <0x1>; // Not used
	xlnx,one-timer-only = <0x0>; // If 1, IP can't do PWM
	xlnx,trig0-assert = <0x1>; // Not used
	xlnx,trig1-assert = <0x1>; // Not used
}

Required properties:
- compatible: should be "xlnx,axi-pwm" or whatever we agree on
- reg: physical base address and length of the controller's registers
- clocks: This clock defines the base clock frequency of the PWM hardware
  system, the period and the duty_cycle of the PWM signal is a multiple of
  the base period.
- xlnx,one-timer-only: Should be 1.

Correct me if I'm mistaken, but clock-frequency is redundant both here and
in the timer definitions, right?

Property 'xlnx,one-timer-only' is also used by kernel.c to check that the IP
core was synthesized with two timers, needed also for PWM operation, so I'd
leave too with the same intent.

Thanks for your interest!

-- 
Alvaro G. M.
