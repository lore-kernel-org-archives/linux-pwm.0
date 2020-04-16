From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Thu, 16 Apr 2020 11:27:49 +0200
Message-ID: <CACRpkdaqgHhPwdKdUai4zvi21qR-cSQUKyzZ3SyfWBLPN9us3w@mail.gmail.com>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200402203656.27047-11-michael@walle.cc>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 2, 2020 at 10:37 PM Michael Walle <michael@walle.cc> wrote:

> There are quite a lot simple GPIO controller which are using regmap to
> access the hardware. This driver tries to be a base to unify existing
> code into one place. This won't cover everything but it should be a good
> starting point.
>
> It does not implement its own irq_chip because there is already a
> generic one for regmap based devices. Instead, the irq_chip will be
> instanciated in the parent driver and its irq domain will be associate
> to this driver.
>
> For now it consists of the usual registers, like set (and an optional
> clear) data register, an input register and direction registers.
> Out-of-the-box, it supports consecutive register mappings and mappings
> where the registers have gaps between them with a linear mapping between
> GPIO offset and bit position. For weirder mappings the user can register
> its own .xlate().
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Overall I really like this driver and I think we should merge is as soon
as it is in reasonable shape and then improve on top so we can start
migrating drivers to it.

> +static int gpio_regmap_to_irq(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
> +       struct gpio_regmap *gpio = data->gpio;
> +
> +       /* the user might have its own .to_irq callback */
> +       if (gpio->to_irq)
> +               return gpio->to_irq(gpio, offset);
> +
> +       return irq_create_mapping(gpio->irq_domain, offset);

I think that should at least be irq_find_mapping(), the mapping should
definately not be created by the .to_irq() callback since that is just
a convenience function.

> +       if (gpio->irq_domain)
> +               chip->to_irq = gpio_regmap_to_irq;

I don't know about this.
(...)
> + * @irq_domain:                (Optional) IRQ domain if the controller is
> + *                     interrupt-capable
(...)
> +       struct irq_domain *irq_domain;

I don't think this is a good storage place for the irqdomain, we already have
gpio_irq_chip inside gpio_chip and that has an irqdomain, we should
strive to reuse that infrastructure also for regmap GPIO I think, for now
I would just leave .to_irq() out of this and let the driver deal with any
irqs.

Yours,
Linus Walleij
