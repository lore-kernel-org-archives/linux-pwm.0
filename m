From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
Date: Wed, 12 Apr 2017 17:19:32 +0200
Message-ID: <20170412151932.GE7023@lunn.ch>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com>
 <20170412163128.5c985a26@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170412163128.5c985a26@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ralph Sennhauser <ralph.sennhauser@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Apr 12, 2017 at 04:31:28PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> Sorry for the late feedback about this.
> 
> On Sun,  9 Apr 2017 20:09:27 +0200, Ralph Sennhauser wrote:
> 
> > +		gpio1: gpio@18140 {
> > +			compatible = "marvell,armada-370-xp-gpio";
> > +			reg = <0x18140 0x40>, <0x181c8 0x08>;
> 
> One issue I see is that you have only two counters A and B. You
> associate counter A with the first bank of GPIOs, and counter B with
> the second bank of GPIOs.
> 
> Which means that if you need to PWM a GPIO from the third bank of
> GPIOs, you can't, even if the HW allows it.
>
> 
> While I'm fine with not supporting all the HW features, but it's a bit
> sad that this gets encoded into the DT.
> 
> But I guess the only way to make this possible would be to have a
> single node for all GPIOs rather than one per bank? Or do we have a way
> to have those counter A/B registers bound to a separate PWM driver, and
> then the GPIO driver being smart enough to select the counter to be
> used? Seems not easy to do though :-/

Hi Thomas

Yep. It was a compromise. By adding a new binding for the GPIO driver,
this might be possible. But it did not seem worth such a major change.

The prime use of this feature is for controlling a fan. So far, i've
not seen any hardware with more than one fan, i.e. needs more than one
PWM. Nor have i seen any hardware with the GPIO for the fan being on
the third bank. A hardware manufacture could add multiple fans, but i
doubt it, they make noise and fail. And if a manufacture does place a
fan on the third bank, it can still be controlled as a plain GPIO fan,
as we have been doing for the last few years.

So i personally think it is an O.K. compromise.

> > @@ -555,6 +842,10 @@ static const struct of_device_id mvebu_gpio_of_match[] = {
> >  		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ARMADAXP,
> >  	},
> >  	{
> > +		.compatible = "marvell,armada-370-xp-gpio",
> > +		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ORION,
> 
> Whum, what are you doing here?

Since you are late to the discussion, you probably missed this part.

Only 370 and XP have the hardware needed to do this. Kirkwood and
Orion5x does not. It was requested a compatible string was added to
indicate SoC has the needed hardware.

The driver was extended when XP was added, due it is per CPU
interrupts. However, that turned out to be broken. One CPU would
enable the interrupt, and it was delivered to another, causing it to
be missed. So XP was reverted to use the plan old ORION way of doing
interrupts.

So this patch adds in a new compatible string for 370 and XP, to
indicate the PWM hardware is available, and keeps using the ORION way
of handing interrupts.

   Andrew
