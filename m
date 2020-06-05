From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 06/11] gpio: add support for the sl28cpld GPIO controller
Date: Fri, 5 Jun 2020 15:00:48 +0300
Message-ID: <CAHp75VfRhL1f-XD=PMbqd3BLeJQzQMFAupSzqAvx0g7-X_2VhQ@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-7-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200604211039.12689-7-michael-QKn5cuLxLXY@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:

> Add support for the GPIO controller of the sl28 board management
> controller. This driver is part of a multi-function device.
>
> A controller has 8 lines. There are three different flavors:
> full-featured GPIO with interrupt support, input-only and output-only.

...

> +#include <linux/of_device.h>

I think also not needed.
But wait...

> +       return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev), regmap,

It seems regmap needs to be converted to use fwnode.

> +                                          irq, IRQF_SHARED | IRQF_ONESHOT, 0,
> +                                          irq_chip, &gpio->irq_data);

...

> +       if (!pdev->dev.parent)
> +               return -ENODEV;

Are we expecting to get shot into foot? I mean why we need this check?

> +       dev_id = platform_get_device_id(pdev);
> +       if (dev_id)
> +               type = dev_id->driver_data;

Oh, no. In new code we don't need this. We have facilities to provide
platform data in a form of fwnode.

> +       else
> +               type = (uintptr_t)of_device_get_match_data(&pdev->dev);

So does this. device_get_match_data().

> +       if (!type)
> +               return -ENODEV;

...

> +       if (irq_support &&

Why do you need this flag? Can't simple IRQ number be sufficient?

> +           device_property_read_bool(&pdev->dev, "interrupt-controller")) {
> +               irq = platform_get_irq(pdev, 0);
> +               if (irq < 0)
> +                       return irq;
> +
> +               ret = sl28cpld_gpio_irq_init(&pdev->dev, gpio, regmap,
> +                                            base, irq);
> +               if (ret)
> +                       return ret;
> +
> +               config.irq_domain = regmap_irq_get_domain(gpio->irq_data);
> +       }

...

> +static const struct of_device_id sl28cpld_gpio_of_match[] = {

> +       { .compatible = "kontron,sl28cpld-gpio",
> +         .data = (void *)SL28CPLD_GPIO },
> +       { .compatible = "kontron,sl28cpld-gpi",
> +         .data = (void *)SL28CPLD_GPI },
> +       { .compatible = "kontron,sl28cpld-gpo",
> +         .data = (void *)SL28CPLD_GPO },

All above can be twice less LOCs.

> +       {},

No comma.

> +};


...

> +               .name = KBUILD_MODNAME,

This actually not good idea in long term. File name can change and break an ABI.

-- 
With Best Regards,
Andy Shevchenko
