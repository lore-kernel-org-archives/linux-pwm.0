From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Thu, 15 Jan 2015 10:52:51 +0100
Message-ID: <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
	<1420846493-31647-4-git-send-email-andrew@lunn.ch>
	<CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
	<20150113024256.GH19533@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150113024256.GH19533@lunn.ch>
Sender: linux-gpio-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jan 13, 2015 at 3:42 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> So i thought about this some more. What would an MFD based solution
> look like?
>
> First issue is backwards compatibility. There are currently around 90
> .dts files using this gpio driver. I could imagine a few of these
> being changed to make use of an MFD based driver to make us of the new
> features, but the rest expect backwards compatibility.

Good point.

> I think the only sensible way to achieve this is that the gpio driver
> keeps its existing binding.

Yup.

> This does not really describe the hardware. The hardware is more like:
>
>         gpio: gpio {
>                 compatible = "marvell,orion-gpio";
>                 reg = <0xd0018100 0x40>;
>                 ngpios = <32>;
>                 gio-controller;
>                 #gpio-cells = <2>;
>                 interrupt-controller;
>                 #interrupt-cells = <2>;
>                 interrupts = <16>, <17>, <18>, <19>;
>                 clocks = <&coreclk 0>;
>
>                 pwm: pwm {
>                         compatible = "marvell,armada-pwm";
>                         reg = <0xd00181c0 0x08>;
>                         #pwm-cells = <2>;
>                         clocks = <&coreclk 0>;
>                 };
>         };
>
> but i don't think MFD supports that sort of structure?

No it would have to be some custom DT code in the GPIO driver
spawning the PWM platform device.

I think it's better if we either go with the first solution of a combined
GPIO+PWM node (it's also elegant in a way, and perfectly
OK with device tree I think) but I want the PWM maintainer to
say if it's OK to have a PWM driver inside a GPIO driver.

Yours,
Linus Walleij
