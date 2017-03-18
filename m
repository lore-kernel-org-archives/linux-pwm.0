From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Sat, 18 Mar 2017 16:37:53 +0100
Message-ID: <20170318153753.GA22088@lunn.ch>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com>
 <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:52627 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbdCRPjD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 18 Mar 2017 11:39:03 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ralph Sennhauser <ralph.sennhauser@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Imre Kaloz <kaloz@openwrt.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

> > +static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwmd)
> > +{
> > +       struct mvebu_pwm *pwm = to_mvebu_pwm(chip);
> > +       struct gpio_desc *desc = gpio_to_desc(pwmd->pwm);
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&pwm->lock, flags);
> > +       gpiod_free(desc);
> > +       pwm->used = false;
> > +       spin_unlock_irqrestore(&pwm->lock, flags);
> > +}
> 
> No need to set the output value to zero or something here?
> And turn off blinking? Or is that done some other way?

Hi Linus

The disable op will turn of blinking. I've not checked, but i assume
the PWM core will not allow you to free an enabled PWM?

> I think both of these need to be tagged __maybe_unused to not give
> noise in randconfig builds.

I've not seen any 0-day patch emails giving warnings. So i suspect it
is O.K.

   Andrew
