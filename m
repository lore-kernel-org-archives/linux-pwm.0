From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller
 support
Date: Mon, 27 Apr 2020 13:40:18 +0200
Message-ID: <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-7-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200423174543.17161-7-michael@walle.cc>
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

> This patch adds support for the interrupt controller inside the sl28

git grep 'This patch' Documentation/process/

> CPLD management controller.
>
> +static int sl28cpld_intc_probe(struct platform_device *pdev)
> +{
> +	struct sl28cpld_intc *irqchip;
> +	struct resource *res;
> +	unsigned int irq;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	irqchip = devm_kzalloc(&pdev->dev, sizeof(*irqchip), GFP_KERNEL);
> +	if (!irqchip)
> +		return -ENOMEM;
> +
> +	irqchip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!irqchip->regmap)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	irqchip->chip.name = "sl28cpld-intc";
> +	irqchip->chip.irqs = sl28cpld_irqs;
> +	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
> +	irqchip->chip.num_regs = 1;
> +	irqchip->chip.status_base = res->start + INTC_IP;
> +	irqchip->chip.mask_base = res->start + INTC_IE;
> +	irqchip->chip.mask_invert = true,
> +	irqchip->chip.ack_base = res->start + INTC_IP;
> +
> +	ret = devm_regmap_add_irq_chip(&pdev->dev, irqchip->regmap, irq,
> +				       IRQF_SHARED | IRQF_ONESHOT, 0,

What's the point of IRQF_SHARED | IRQF_ONESHOT here?

> +				       &irqchip->chip, &irqchip->irq_data);

Thanks,

        tglx
