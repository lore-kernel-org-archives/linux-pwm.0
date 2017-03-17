From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Fri, 17 Mar 2017 10:17:47 +0100
Message-ID: <20170317101747.67a09ccd@gmail.com>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com>
 <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36391 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdCQJRw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Mar 2017 05:17:52 -0400
In-Reply-To: <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, 16 Mar 2017 17:03:05 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> 
> In essence I am very positive of this patch set and happy to merge
> it as a PWM driver inside of GPIO if Thierry is OK with it.

Hi Linus,

thanks for merging the cleanup patches. 


> 
> > +static void mvebu_pwm_free(struct pwm_chip *chip, struct
> > pwm_device *pwmd) +{
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
>

Heh, good point, will need to look into this.


> 
> > +       u = readl_relaxed(mvebu_gpioreg_blink_select(mvchip));
> > +       u &= ~(1 << pwm->pin);  
> 
> In GPIO code I usually do this:
> 
> #include <linus/bitops.h>
> 
> u &= ~BIT(pwm->pin);
>

linus/bitops.h ...
    ^
Another one of those nifty macros, sure, can do so for v2, though there
are many instances of this technique already, I'll send another cleanup
patch to convert them all for consistency sake.


> 
> > +       u |= (pwm->id << pwm->pin);
> 
> I don't understand this line. Above you mask BIT(pwm->pin)
> so we are only manipulating one bit, and then you ... shift the ID?
> Is the ID always 0 or 1? If that is the case then this
> is easier to understand:
> 
> if (pwm->id)
>   u |= BIT(pwm->pin);
> 
> + a comment
>

mvebu_pwm_probe returns -EINVAL if id isn't 0 or 1.

        if (id < 0 || id > 1)
                return -EINVAL;

Guess this needs commenting as well then.

> 
> > +static void mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
> > +static void mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
> 
> I think both of these need to be tagged __maybe_unused to not give
> noise in randconfig builds.

I haven't seen any warnings with CONFIG_PWM disabled. Which
configuration you expect to trigger a warning? mvebu_pwm_probe should
be the same, right?

> 
> Yours,
> Linus Walleij

Thanks for the review.
Ralph
