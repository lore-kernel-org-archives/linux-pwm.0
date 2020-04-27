From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 11/16] gpio: add support for the sl28cpld GPIO
 controller
Date: Mon, 27 Apr 2020 13:45:00 +0200
Message-ID: <87k121qhj7.fsf@nanos.tec.linutronix.de>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-12-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200423174543.17161-12-michael@walle.cc>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Jean Delvare <jdelvare@suse.com>, Jason Cooper <jason@lakedaemon.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Li Yang <leoyang.li@nxp.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones <lee.jones@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pwm@vger.kernel.org

Michael Walle <michael@walle.cc> writes:
> +struct sl28cpld_gpio {
> +	struct regmap_irq_chip irq_chip;
> +	struct regmap_irq_chip_data *irq_data;
> +};
> +
> +static const struct regmap_irq sl28cpld_gpio_irqs[] = {
> +	REGMAP_IRQ_REG_LINE(0, 8),
> +	REGMAP_IRQ_REG_LINE(1, 8),
> +	REGMAP_IRQ_REG_LINE(2, 8),
> +	REGMAP_IRQ_REG_LINE(3, 8),
> +	REGMAP_IRQ_REG_LINE(4, 8),
> +	REGMAP_IRQ_REG_LINE(5, 8),
> +	REGMAP_IRQ_REG_LINE(6, 8),
> +	REGMAP_IRQ_REG_LINE(7, 8),
> +};

This is exactly the same as the one in the irq chip patch.

> +static int sl28cpld_gpio_irq_init(struct device *dev,
> +				  struct sl28cpld_gpio *gpio,
> +				  struct regmap *regmap, unsigned int base,
> +				  int irq)
> +{
> +	struct regmap_irq_chip *irq_chip = &gpio->irq_chip;
> +
> +	irq_chip->name = "sl28cpld-gpio-irq",
> +	irq_chip->irqs = sl28cpld_gpio_irqs;
> +	irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
> +	irq_chip->num_regs = 1;
> +	irq_chip->status_base = base + GPIO_REG_IP;
> +	irq_chip->mask_base = base + GPIO_REG_IE;
> +	irq_chip->mask_invert = true,
> +	irq_chip->ack_base = base + GPIO_REG_IP;
> +
> +	return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev), regmap,
> +					   irq, IRQF_SHARED | IRQF_ONESHOT, 0,
> +					   irq_chip, &gpio->irq_data);
> +}

And this looks pretty familiar as well. What's the point of duplicating
that code?

Thanks,

        tglx
