From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 09/16] gpiolib: Introduce gpiochip_irqchip_add_domain()
Date: Mon, 27 Apr 2020 13:42:09 +0200
Message-ID: <87mu6xqhny.fsf@nanos.tec.linutronix.de>
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-10-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgD0LmV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Apr 2020 07:42:21 -0400
In-Reply-To: <20200423174543.17161-10-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle <michael@walle.cc>

Michael Walle <michael@walle.cc> writes:
> This connects an IRQ domain to a gpiochip and reuses
> gpiochip_to_irq().

A little bit more context and explanation why this function is useful
would be appreciated.

> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/gpio/gpiolib.c      | 20 ++++++++++++++++++++
>  include/linux/gpio/driver.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 40f2d7f69be2..7b3d7f496b9a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2722,6 +2722,26 @@ int gpiochip_irqchip_add_key(struct gpio_chip *gc,
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_key);
>  
> +/**
> + * gpiochip_irqchip_add_key() - adds an irqdomain to a gpiochip

Copy & paste is wonderful

> + * @gc: the gpiochip to add the irqchip to
> + * @domain: the irqdomain to add to the gpiochip
> + *
> + * This function adds an IRQ domain to the gpiochip.
> + */
> +int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
> +				struct irq_domain *domain)
> +{
> +	if (!domain)
> +		return -EINVAL;
> +
> +	gc->to_irq = gpiochip_to_irq;
> +	gc->irq.domain = domain;
> +
> +	return 0;
> +}

Thanks,

        tglx
