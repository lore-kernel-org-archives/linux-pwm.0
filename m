From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Tue, 13 Jan 2015 03:42:56 +0100
Message-ID: <20150113024256.GH19533@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
 <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> - Why is this not modeled as an MFD spawning a GPIO and a PWM cell,
>   as is custom? (Bringing MFD maintainers into the picture.)
> 
> So I am aware that this takes the problem from "quick fix extension to the GPIO
> driver" to "really nasty hairy re-engineering of the whole shebang" but there is
> a lot of precedents in the kernel for splitting up this type of hardware in
> separate drivers under an MFD hub.

Hi Linus

So i thought about this some more. What would an MFD based solution
look like?

First issue is backwards compatibility. There are currently around 90
.dts files using this gpio driver. I could imagine a few of these
being changed to make use of an MFD based driver to make us of the new
features, but the rest expect backwards compatibility.

I think the only sensible way to achieve this is that the gpio driver
keeps its existing binding.

We then need to add a new MFD binding, with sub sections for the gpio
driver and the PWM driver. At a first stab, it would look something
like:

armada-gpio {
	compatible = "marvell,armada-gpio";
        reg = <0xd0018100 0x40>,
              <0xd00181c0 0x08>;

	gpio: gpio {
		compatible = "marvell,armada-gpio-gpio";
		ngpios = <32>;
		gio-controller;
		#gpio-cells = <2>;
		interrupt-controller;
		#interrupt-cells = <2>;
		interrupts = <16>, <17>, <18>, <19>;
		clocks = <&coreclk 0>;
	};

	pwm: pwm {
		compatible = "marvell,armada-gpio-pwm";
		#pwm-cells = <2>;
		clocks = <&coreclk 0>;
	};
};

This does not really describe the hardware. The hardware is more like:

	gpio: gpio {
		compatible = "marvell,orion-gpio";
        	reg = <0xd0018100 0x40>;
		ngpios = <32>;
		gio-controller;
		#gpio-cells = <2>;
		interrupt-controller;
		#interrupt-cells = <2>;
		interrupts = <16>, <17>, <18>, <19>;
		clocks = <&coreclk 0>;

		pwm: pwm {
			compatible = "marvell,armada-pwm";
			reg = <0xd00181c0 0x08>;
			#pwm-cells = <2>;
			clocks = <&coreclk 0>;
		};
	};

but i don't think MFD supports that sort of structure?

So assuming we go with the first binding above, this means the gpio
driver gains a second binding, probe function, etc for when it is
probed as part of an MFD.

Now it starts getting nasty hairy. The MFD core driver should offer a
set of functions to access the hardware, which are shared by the
gpio-gpio driver and the gpio-pwm driver. However when the gpio driver
is probed using its current binding, not the MFD binding, it also
needs access functions.  So we need a library of access functions,
which can be used directly or via the MFD code. Where do we place
these? In the gpio driver would make sense, since gpio driver always
needs them, the MFD is optional. But they could be in the MFD
driver. The gpio driver is currently built in, meaning the MFD driver
would be built in, so even if the MFD driver is never probed, it can
still export functions.

Memory management then becomes fun. If the MFD is probed, it needs to
allocated the shared memory, used by the access functions etc. If the
standalone gpio driver is probed, it needs to allocated the memory
used by the access functions etc.

I'm also worried about race conditions during probe. The pwm driver is
not independent of the gpio driver. It is a child of the gpio
driver. It needs to know the gpiochip base and ngpio during its own
probe function. In effect, we need to ensure that the MFD gpio probe
has completed successfully before the MFD pwm probe is called.

Nothing completely unsolvable, it just seems ugly and complex.

Humm, that second binding just gave me an idea. The pwm driver is a
child of the gpio driver. That is the same relationship between an MFD
driver and its children. So maybe we should move mvebu-gpio.c into
drives/mfd and add some mfd functionality so it can mfd_add_device()
the pwm driver when it has completed its own probe? That nicely solves
the probe race issue, and the library of access functions etc. The
gpio binding is also backwards compatible since it is being extended
with an optional MFD child device.

    Andrew

