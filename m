From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 09/16] gpiolib: Introduce gpiochip_irqchip_add_domain()
Date: Mon, 27 Apr 2020 19:49:21 +0200
Message-ID: <43af0bff6fee64687ac4e0d1ded14c4d@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-10-michael@walle.cc>
 <87mu6xqhny.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <87mu6xqhny.fsf@nanos.tec.linutronix.de>
Sender: linux-hwmon-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@ke>
List-Id: linux-pwm@vger.kernel.org

Am 2020-04-27 13:42, schrieb Thomas Gleixner:
> Michael Walle <michael@walle.cc> writes:
>> This connects an IRQ domain to a gpiochip and reuses
>> gpiochip_to_irq().
> 
> A little bit more context and explanation why this function is useful
> would be appreciated.

Ok I'll try to be a bit more elaborate the in the next version, (if
this function is still there).

For now:

gpiochip_irqchip_add_domain() allows to use reqmap-irq, which exports
an irqdomain, with gpiolib while reusing gpiochip_to_irq(). Both
gpiochip_irqchip_* and regmap_irq partially provides the same
functionality. The new function will help to connect just the
minimal functionality of the gpiochip_irqchip which is needed to
work together with regmap-irq.

> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/gpio/gpiolib.c      | 20 ++++++++++++++++++++
>>  include/linux/gpio/driver.h |  3 +++
>>  2 files changed, 23 insertions(+)
>> 
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 40f2d7f69be2..7b3d7f496b9a 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -2722,6 +2722,26 @@ int gpiochip_irqchip_add_key(struct gpio_chip 
>> *gc,
>>  }
>>  EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_key);
>> 
>> +/**
>> + * gpiochip_irqchip_add_key() - adds an irqdomain to a gpiochip
> 
> Copy & paste is wonderful

whoops.

-michael

> 
>> + * @gc: the gpiochip to add the irqchip to
>> + * @domain: the irqdomain to add to the gpiochip
>> + *
>> + * This function adds an IRQ domain to the gpiochip.
>> + */
>> +int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
>> +				struct irq_domain *domain)
>> +{
>> +	if (!domain)
>> +		return -EINVAL;
>> +
>> +	gc->to_irq = gpiochip_to_irq;
>> +	gc->irq.domain = domain;
>> +
>> +	return 0;
>> +}
> 
> Thanks,
> 
>         tglx
