From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
Date: Fri, 5 Jun 2020 11:01:26 +0300
Message-ID: <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-3-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200604211039.12689-3-michael-QKn5cuLxLXY@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>
> Add the core support for the board management controller found on the
> SMARC-sAL28 board. It consists of the following functions:
>  - watchdog
>  - GPIO controller
>  - PWM controller
>  - fan sensor
>  - interrupt controller
>
> At the moment, this controller is used on the Kontron SMARC-sAL28 board.
>
> Please note that the MFD driver is defined as bool in the Kconfig
> because the next patch will add interrupt support.

...

> +config MFD_SL28CPLD
> +       bool "Kontron sl28 core driver"
> +       depends on I2C=y

Why not module?

> +       depends on OF

I didn't find an evidence this is needed.

No Compile Test?

> +       select REGMAP_I2C
> +       select MFD_CORE

...

> +#include <linux/of_platform.h>

No evidence of user of this.
I think you meant mod_devicetable.h.

...

> +static struct i2c_driver sl28cpld_driver = {
> +       .probe_new = sl28cpld_probe,
> +       .driver = {
> +               .name = "sl28cpld",
> +               .of_match_table = of_match_ptr(sl28cpld_of_match),

Drop of_match_ptr(). It has a little sense in this context (depends OF).
It will have a little sense even if you drop depends OF b/c you will
introduce a compiler warning.

> +       },
> +};


-- 
With Best Regards,
Andy Shevchenko
