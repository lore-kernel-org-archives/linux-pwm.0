From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Tue, 21 Mar 2017 15:50:56 +0100
Message-ID: <20170321145056.GA30655@lunn.ch>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com>
 <20170320134252.GM22463@ulmo.ba.sec>
 <20170321073618.2e4d41cc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321073618.2e4d41cc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> > > *mvebu_gpioreg_blink(struct mvebu_gpio_chip *mvchip) return
> > > mvchip->membase + GPIO_BLINK_EN_OFF; }
> > >  
> > > +static void __iomem *mvebu_gpioreg_blink_select(struct
> > > mvebu_gpio_chip *mvchip) +{
> > > +	return mvchip->membase + GPIO_BLINK_CNT_SELECT_OFF;
> > > +}  
> > 
> > That's a really weird thing to do. Why not just use this expression in
> > your calls to readl() and writel() directly? Seems a lot of additional
> > code for no gain.

This driver is made more complex by the Armada XP SMP handling. Some
GPIO registers are per-cpu, others are global. Registers for
interrupts in particular are per CPU. So there is a general trend in
this driver to have a function which returns the address of a
register, for a given SOC variant. In this case, it is fixed, so could
be collapsed into the actual read/write. But then it would be
different to all others in this driver...

> > > +	pwm->chip.dev = dev;
> > > +	pwm->chip.ops = &mvebu_pwm_ops;
> > > +	pwm->chip.base = mvchip->chip.base;
> > > +	pwm->chip.npwm = mvchip->chip.ngpio;  
> > 
> > Isn't that a lie? The code above suggests you can only ever have a
> > single GPIO turn into a PWM, so I'd expect ".npwm = 1" here.

Well, any of the 32 GPIOs can be a PWM. But only one can be enabled at
a time. What exactly does pwm->chip.npwm mean? If we say 1 here, how
at run time do we say which of the 32 GPIOs is used as a PWM output?
By saying 32, it is simpler, which ever is enabled first is the one to
use.

	Andrew
