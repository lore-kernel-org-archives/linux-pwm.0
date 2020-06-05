From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 07/11] hwmon: add support for the sl28cpld hardware
 monitoring controller
Date: Fri, 5 Jun 2020 15:06:35 +0300
Message-ID: <CAHp75Vd00VeL94S=U77NCm9-WNF6ZLAn4U9oUSov1R1QU4DjDg@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-8-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200604211039.12689-8-michael@walle.cc>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support for the hardware monitoring controller of the sl28cpld board
> management controller. This driver is part of a multi-function device.

...

> +#include <linux/of_device.h>

mod_devicetable.h ?

...


> +       hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +                               "sl28cpld_hwmon", hwmon,
> +                               &sl28cpld_hwmon_chip_info, NULL);
> +       if (IS_ERR(hwmon_dev)) {
> +               dev_err(&pdev->dev, "failed to register as hwmon device");

> +               return PTR_ERR(hwmon_dev);
> +       }
> +
> +       return 0;

PTR_ERR_OR_ZERO() ?

...

> +static const struct of_device_id sl28cpld_hwmon_of_match[] = {
> +       { .compatible = "kontron,sl28cpld-fan" },

> +       {},

No comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
