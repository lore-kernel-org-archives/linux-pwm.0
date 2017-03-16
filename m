From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Thu, 16 Mar 2017 17:03:05 +0100
Message-ID: <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com> <20170316064218.9169-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170316064218.9169-2-ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "open list:PWM SUBSYSTEM" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 16, 2017 at 7:42 AM, Ralph Sennhauser
<ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
>
> Armada 370/XP devices can 'blink' gpio lines with a configurable on
> and off period. This can be modelled as a PWM.
>
> However, there are only two sets of PWM configuration registers for
> all the gpio lines. This driver simply allows a single gpio line per
> gpio chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
>
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the gpio driver. Thus the gpio driver has been
> extended with a PWM driver.
>
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> URL: https://patchwork.ozlabs.org/patch/427287/
> URL: https://patchwork.ozlabs.org/patch/427295/
> [Ralph Sennhauser:
>   * port forward
>   * merge pwm portion into gpio-mvebu.c
>   * merge doc patch
>   * update MAINAINERS]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

In essence I am very positive of this patch set and happy to merge
it as a PWM driver inside of GPIO if Thierry is OK with it.

DT bindings look fine to me.

> +static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwmd)
> +{
> +       struct mvebu_pwm *pwm = to_mvebu_pwm(chip);
> +       struct gpio_desc *desc = gpio_to_desc(pwmd->pwm);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&pwm->lock, flags);
> +       gpiod_free(desc);
> +       pwm->used = false;
> +       spin_unlock_irqrestore(&pwm->lock, flags);
> +}

No need to set the output value to zero or something here?
And turn off blinking? Or is that done some other way?

> +       u = readl_relaxed(mvebu_gpioreg_blink_select(mvchip));
> +       u &= ~(1 << pwm->pin);

In GPIO code I usually do this:

#include <linus/bitops.h>

u &= ~BIT(pwm->pin);

> +       u |= (pwm->id << pwm->pin);

I don't understand this line. Above you mask BIT(pwm->pin)
so we are only manipulating one bit, and then you ... shift the ID?
Is the ID always 0 or 1? If that is the case then this
is easier to understand:

if (pwm->id)
  u |= BIT(pwm->pin);

+ a comment

> +static void mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
> +{
> +       struct mvebu_pwm *pwm = mvchip->pwm;
> +
> +       pwm->blink_select = readl_relaxed(mvebu_gpioreg_blink_select(mvchip));
> +       pwm->blink_on_duration =
> +               readl_relaxed(mvebu_pwmreg_blink_on_duration(pwm));
> +       pwm->blink_off_duration =
> +               readl_relaxed(mvebu_pwmreg_blink_off_duration(pwm));
> +}
> +
> +static void mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
> +{
> +       struct mvebu_pwm *pwm = mvchip->pwm;
> +
> +       writel_relaxed(pwm->blink_select, mvebu_gpioreg_blink_select(mvchip));
> +       writel_relaxed(pwm->blink_on_duration,
> +                      mvebu_pwmreg_blink_on_duration(pwm));
> +       writel_relaxed(pwm->blink_off_duration,
> +                      mvebu_pwmreg_blink_off_duration(pwm));
> +}

I think both of these need to be tagged __maybe_unused to not give
noise in randconfig builds.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
