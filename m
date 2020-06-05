From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Date: Fri, 5 Jun 2020 11:14:17 +0300
Message-ID: <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-5-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEIOf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 04:14:35 -0400
In-Reply-To: <20200604211039.12689-5-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thom

On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support for the watchdog of the sl28cpld board management
> controller. This is part of a multi-function device driver.

...

> +#include <linux/of_device.h>

Didn't find a user of this.

...

> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int timeout;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");

Guenter ACKed this, but I'm wondering why we still need module parameters...

...

> +       int ret;
> +
> +       ret = regmap_read(wdt->regmap, wdt->offset + WDT_COUNT, &val);
> +
> +       return (ret < 0) ? 0 : val;

Besides extra parentheses and questionable ' < 0' part, the following
would look better I think

ret = ...
if (ret)
  return 0;

return val;

...

> +       int ret;
> +
> +       ret = regmap_write(wdt->regmap, wdt->offset + WDT_TIMEOUT, timeout);
> +       if (!ret)
> +               wdd->timeout = timeout;
> +
> +       return ret;

Similar story here:

ret = ...
if (ret)
  return ret;

wdd->... = ...
return 0;

...

> +       ret = regmap_read(wdt->regmap, wdt->offset + WDT_CTRL, &status);

> +       if (ret < 0)

What ' < 0' means? Do we have some positive return values?
Ditto for all your code.

> +               return ret;

...

> +       if (status & WDT_CTRL_EN) {
> +               sl28cpld_wdt_start(wdd);

> +               set_bit(WDOG_HW_RUNNING, &wdd->status);

Do you need atomic op here? Why?

> +       }

...

> +static const struct of_device_id sl28cpld_wdt_of_match[] = {
> +       { .compatible = "kontron,sl28cpld-wdt" },

> +       {},

No comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
