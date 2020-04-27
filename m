From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller
 support
Date: Mon, 27 Apr 2020 19:40:11 +0200
Message-ID: <87f141bce0a4fda04b550647306be296@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-7-michael@walle.cc>
 <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87pnbtqhr1.fsf-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz@ke>
List-Id: linux-pwm@vger.kernel.org

Hi Thomas,

thanks for the review.

Am 2020-04-27 13:40, schrieb Thomas Gleixner:
> Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> writes:
> 
>> This patch adds support for the interrupt controller inside the sl28
> 
> git grep 'This patch' Documentation/process/

ok.

> 
>> CPLD management controller.
>> 
>> +static int sl28cpld_intc_probe(struct platform_device *pdev)
>> +{
>> +	struct sl28cpld_intc *irqchip;
>> +	struct resource *res;
>> +	unsigned int irq;
>> +	int ret;
>> +
>> +	if (!pdev->dev.parent)
>> +		return -ENODEV;
>> +
>> +	irqchip = devm_kzalloc(&pdev->dev, sizeof(*irqchip), GFP_KERNEL);
>> +	if (!irqchip)
>> +		return -ENOMEM;
>> +
>> +	irqchip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!irqchip->regmap)
>> +		return -ENODEV;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
>> +	if (!res)
>> +		return -EINVAL;
>> +
>> +	irqchip->chip.name = "sl28cpld-intc";
>> +	irqchip->chip.irqs = sl28cpld_irqs;
>> +	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
>> +	irqchip->chip.num_regs = 1;
>> +	irqchip->chip.status_base = res->start + INTC_IP;
>> +	irqchip->chip.mask_base = res->start + INTC_IE;
>> +	irqchip->chip.mask_invert = true,
>> +	irqchip->chip.ack_base = res->start + INTC_IP;
>> +
>> +	ret = devm_regmap_add_irq_chip(&pdev->dev, irqchip->regmap, irq,
>> +				       IRQF_SHARED | IRQF_ONESHOT, 0,
> 
> What's the point of IRQF_SHARED | IRQF_ONESHOT here?

IRQF_SHARED because this interrupt is shared with all the blocks
which can generate interrupts, i.e. the GPIO contollers.

IRQF_ONESHOT, because its is a threaded interrupt with no primary
handler. But I just noticed, that regmap-irq will also set the
IRQF_ONESHOT. But that the commit 09cadf6e088b ("regmap-irq:
set IRQF_ONESHOT flag to ensure IRQ request") reads like it is
just there to be sure. So I don't know if it should also be set
here.

-michael

> 
>> +				       &irqchip->chip, &irqchip->irq_data);
> 
> Thanks,
> 
>         tglx
