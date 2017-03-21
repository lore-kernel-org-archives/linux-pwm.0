From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Tue, 21 Mar 2017 07:36:18 +0100
Message-ID: <20170321073618.2e4d41cc@gmail.com>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com>
 <20170320134252.GM22463@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36194 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755772AbdCUGja (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Mar 2017 02:39:30 -0400
In-Reply-To: <20170320134252.GM22463@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-gpio@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Mon, 20 Mar 2017 14:42:52 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> > b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt index
> > a6f3bec..86932e3 100644 ---
> > a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt +++
> > b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt @@ -38,6
> > +38,23 @@ Required properties:
> >  - #gpio-cells: Should be two. The first cell is the pin number. The
> >    second cell is reserved for flags, unused at the moment.
> >  
> > +Optional properties:
> > +
> > +In order to use the gpio lines in PWM mode, some additional
> > optional +properties are required. Only Armada 370 and XP support
> > these properties. +
> > +- reg: an additional register set is needed, for the GPIO Blink
> > +  Counter on/off registers.
> > +
> > +- reg-names: Must contain an entry "pwm" corresponding to the
> > +  additional register range needed for pwm operation.
> > +
> > +- #pwm-cells: Should be two. The first cell is the pin number. The
> > +  second cell is reserved for flags and should be set to 0, so it
> > has a
> > +  known value. It then becomes possible to use it in the future.  
> 
> That's usually not how we do this. Either your hardware can support
> the flags (which at this point effectively means polarity) or it
> can't. Any potential future feature can be enabled when it emerges.
> No need to concern ourselves with something that doesn't exist yet.

So for short:
  #pwm-cells: Should be one. The first cell is the pin number.

or just a blatant copy of #gpio-cells as in the above hunk.

> > @@ -109,6 +139,11 @@ static void __iomem
> > *mvebu_gpioreg_blink(struct mvebu_gpio_chip *mvchip) return
> > mvchip->membase + GPIO_BLINK_EN_OFF; }
> >  
> > +static void __iomem *mvebu_gpioreg_blink_select(struct
> > mvebu_gpio_chip *mvchip) +{
> > +	return mvchip->membase + GPIO_BLINK_CNT_SELECT_OFF;
> > +}  
> 
> That's a really weird thing to do. Why not just use this expression in
> your calls to readl() and writel() directly? Seems a lot of additional
> code for no gain.
> 

How to hide a tree in the forest. Just following suite with the rest of
the file. So I'd leave it as is but certainly don't mind changing
it.

> > +
> > +static int mvebu_pwm_request(struct pwm_chip *chip, struct
> > pwm_device *pwmd) +{
> > +	struct mvebu_pwm *pwm = to_mvebu_pwm(chip);
> > +	struct mvebu_gpio_chip *mvchip = pwm->mvchip;
> > +	struct gpio_desc *desc = gpio_to_desc(pwmd->pwm);
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	spin_lock_irqsave(&pwm->lock, flags);
> > +	if (pwm->used) {
> > +		ret = -EBUSY;
> > +	} else {
> > +		if (!desc) {
> > +			ret = -ENODEV;
> > +			goto out;
> > +		}
> > +		ret = gpiod_request(desc, "mvebu-pwm");
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret = gpiod_direction_output(desc, 0);
> > +		if (ret) {
> > +			gpiod_free(desc);
> > +			goto out;
> > +		}
> > +
> > +		pwm->pin = pwmd->pwm - mvchip->chip.base;  
> 
> pwm->pin = pwmd->hwpwm? But then, why store something that you can
> always access directly?

Agreed.

> > +
> > +static const struct pwm_ops mvebu_pwm_ops = {
> > +	.request = mvebu_pwm_request,
> > +	.free = mvebu_pwm_free,
> > +	.config = mvebu_pwm_config,
> > +	.enable = mvebu_pwm_enable,
> > +	.disable = mvebu_pwm_disable,
> > +	.owner = THIS_MODULE,
> > +};  
> 
> Can you please implement the atomic PWM API? Specifically the
> ->apply() and ->get_state() implementations replace ->config(),
> ->enable() and ->disable().  
> 

Will do for v3.

> > +/*
> > + * Armada 370/XP has simple PWM support for gpio lines. Other SoCs
> > + * don't have this hardware. So if we don't have the necessary
> > + * resource, it is not an error.
> > + */  
> 
> There's a bit of inconsistency in this file regarding "pwm" -> "PWM"
> and "gpio" -> "GPIO". In prose, please always use the uppercase
> version for these abbreviations.

Will do as told for this series and maybe send another cleanup patch
as well.

> > +static int mvebu_pwm_probe(struct platform_device *pdev,
> > +		    struct mvebu_gpio_chip *mvchip,
> > +		    int id)  
> 
> Is there any reason why id would want to be negative?
> 

v2 dropped id from the function signature as I moved id to the
struct mvebu_gpio_chip. Then it's also apparent why not unsigned was
used. Cast it?

> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mvebu_pwm *pwm;
> > +	struct resource *res;
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > "pwm");
> > +	if (!res)
> > +		return 0;
> > +
> > +	pwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm),
> > GFP_KERNEL);
> > +	if (!pwm)
> > +		return -ENOMEM;
> > +	mvchip->pwm = pwm;
> > +	pwm->mvchip = mvchip;
> > +
> > +	pwm->membase = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(pwm->membase))
> > +		return PTR_ERR(pwm->membase);
> > +
> > +	if (id < 0 || id > 1)
> > +		return -EINVAL;  
> 
> You check for negative values here, so might as well turn id into an
> unsigned to prohibit them altogether.

See above. Though the test for id < 0 is redundant as we checked this
earlier already.

> 
> > +	pwm->id = id;
> > +
> > +	if (IS_ERR(mvchip->clk))
> > +		return PTR_ERR(mvchip->clk);
> > +
> > +	pwm->clk_rate = clk_get_rate(mvchip->clk);
> > +	if (!pwm->clk_rate) {
> > +		dev_err(dev, "failed to get clock rate\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	pwm->chip.dev = dev;
> > +	pwm->chip.ops = &mvebu_pwm_ops;
> > +	pwm->chip.base = mvchip->chip.base;
> > +	pwm->chip.npwm = mvchip->chip.ngpio;  
> 
> Isn't that a lie? The code above suggests you can only ever have a
> single GPIO turn into a PWM, so I'd expect ".npwm = 1" here.
> 

Agreed.

Thanks
Ralph
