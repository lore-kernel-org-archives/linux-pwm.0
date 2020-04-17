From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Fri, 17 Apr 2020 08:34:09 +0200
Message-ID: <f82706a8596436d13642c49e26233133@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CACRpkdaqgHhPwdKdUai4zvi21qR-cSQUKyzZ3SyfWBLPN9us3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaqgHhPwdKdUai4zvi21qR-cSQUKyzZ3SyfWBLPN9us3w@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

Am 2020-04-16 11:27, schrieb Linus Walleij:
> On Thu, Apr 2, 2020 at 10:37 PM Michael Walle <michael@walle.cc> wrote:
> 
>> There are quite a lot simple GPIO controller which are using regmap to
>> access the hardware. This driver tries to be a base to unify existing
>> code into one place. This won't cover everything but it should be a 
>> good
>> starting point.
>> 
>> It does not implement its own irq_chip because there is already a
>> generic one for regmap based devices. Instead, the irq_chip will be
>> instanciated in the parent driver and its irq domain will be associate
>> to this driver.
>> 
>> For now it consists of the usual registers, like set (and an optional
>> clear) data register, an input register and direction registers.
>> Out-of-the-box, it supports consecutive register mappings and mappings
>> where the registers have gaps between them with a linear mapping 
>> between
>> GPIO offset and bit position. For weirder mappings the user can 
>> register
>> its own .xlate().
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Overall I really like this driver and I think we should merge is as 
> soon
> as it is in reasonable shape and then improve on top so we can start
> migrating drivers to it.
> 
>> +static int gpio_regmap_to_irq(struct gpio_chip *chip, unsigned int 
>> offset)
>> +{
>> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
>> +       struct gpio_regmap *gpio = data->gpio;
>> +
>> +       /* the user might have its own .to_irq callback */
>> +       if (gpio->to_irq)
>> +               return gpio->to_irq(gpio, offset);
>> +
>> +       return irq_create_mapping(gpio->irq_domain, offset);
> 
> I think that should at least be irq_find_mapping(), the mapping should
> definately not be created by the .to_irq() callback since that is just
> a convenience function.

what do you mean by conenience function? are there other ways? if you 
use
irq_find_mapping() who will create the mappings? most gpio drivers use a
similar function like gpio_regmap_to_irq().

> 
>> +       if (gpio->irq_domain)
>> +               chip->to_irq = gpio_regmap_to_irq;
> 
> I don't know about this.
> (...)
>> + * @irq_domain:                (Optional) IRQ domain if the 
>> controller is
>> + *                     interrupt-capable
> (...)
>> +       struct irq_domain *irq_domain;
> 
> I don't think this is a good storage place for the irqdomain, we 
> already have
> gpio_irq_chip inside gpio_chip and that has an irqdomain, we should
> strive to reuse that infrastructure also for regmap GPIO I think, for 
> now
> I would just leave .to_irq() out of this and let the driver deal with 
> any
> irqs.

How would a driver attach the to_irq callback then? At the moment, the
gpio_regmap doesn't expose the gpio_chip. So either we have to do that 
or
the config still have to have a .to_irq property.

-michael
