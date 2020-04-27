From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 11/16] gpio: add support for the sl28cpld GPIO
 controller
Date: Mon, 27 Apr 2020 19:58:22 +0200
Message-ID: <8acfbefeb9d7f59329f2899176059600@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-12-michael@walle.cc>
 <87k121qhj7.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <87k121qhj7.fsf@nanos.tec.linutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@ke>
List-Id: linux-pwm@vger.kernel.org

Am 2020-04-27 13:45, schrieb Thomas Gleixner:
> Michael Walle <michael@walle.cc> writes:
>> +struct sl28cpld_gpio {
>> +	struct regmap_irq_chip irq_chip;
>> +	struct regmap_irq_chip_data *irq_data;
>> +};
>> +
>> +static const struct regmap_irq sl28cpld_gpio_irqs[] = {
>> +	REGMAP_IRQ_REG_LINE(0, 8),
>> +	REGMAP_IRQ_REG_LINE(1, 8),
>> +	REGMAP_IRQ_REG_LINE(2, 8),
>> +	REGMAP_IRQ_REG_LINE(3, 8),
>> +	REGMAP_IRQ_REG_LINE(4, 8),
>> +	REGMAP_IRQ_REG_LINE(5, 8),
>> +	REGMAP_IRQ_REG_LINE(6, 8),
>> +	REGMAP_IRQ_REG_LINE(7, 8),
>> +};
> 
> This is exactly the same as the one in the irq chip patch.

To my knowledge this boilerplate is just to describe this
irqchip has 8 different IRQs.

>> +static int sl28cpld_gpio_irq_init(struct device *dev,
>> +				  struct sl28cpld_gpio *gpio,
>> +				  struct regmap *regmap, unsigned int base,
>> +				  int irq)
>> +{
>> +	struct regmap_irq_chip *irq_chip = &gpio->irq_chip;
>> +
>> +	irq_chip->name = "sl28cpld-gpio-irq",
>> +	irq_chip->irqs = sl28cpld_gpio_irqs;
>> +	irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
>> +	irq_chip->num_regs = 1;
>> +	irq_chip->status_base = base + GPIO_REG_IP;
>> +	irq_chip->mask_base = base + GPIO_REG_IE;
>> +	irq_chip->mask_invert = true,
>> +	irq_chip->ack_base = base + GPIO_REG_IP;
>> +
>> +	return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev), regmap,
>> +					   irq, IRQF_SHARED | IRQF_ONESHOT, 0,
>> +					   irq_chip, &gpio->irq_data);
>> +}
> 
> And this looks pretty familiar as well. What's the point of duplicating
> that code?

this is also just boilerplate to configure the irqchip. But there are 
two
distinct blocks inside the board management controller:
  - an interrupt controller (which has 8 interrupts)
  - and gpio controllers which also happen to have 8 interrupts and
    both have some shared semantics for now. But the GPIO building block
    might be extended to provide interrupt type settings, i.e. falling/
    rising/level triggered interrupts.

So yes both look similar, but they are two different blocks, they use
different registers and they might drift apart in the future.

-michael

> 
> Thanks,
> 
>         tglx
