From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Date: Fri, 05 Jun 2020 12:24:54 +0200
Message-ID: <8f042c2442852c29519c381833f3d289@walle.cc>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas
List-Id: linux-pwm@vger.kernel.org

Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Add support for the watchdog of the sl28cpld board management
>> controller. This is part of a multi-function device driver.
> 
> ...
> 
>> +#include <linux/of_device.h>
> 
> Didn't find a user of this.

I guess mod_devicetable.h then.

> 
> ...
> 
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, 0);
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started 
>> (default="
>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT) 
>> ")");
>> +
>> +static int timeout;
>> +module_param(timeout, int, 0);
>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> 
> Guenter ACKed this, but I'm wondering why we still need module 
> parameters...

How would a user change the nowayout or the timeout? For the latter 
there is
a device tree entry, but thats not easy changable by the user.

> 
> ...
> 
>> +       int ret;
>> +
>> +       ret = regmap_read(wdt->regmap, wdt->offset + WDT_COUNT, &val);
>> +
>> +       return (ret < 0) ? 0 : val;
> 
> Besides extra parentheses and questionable ' < 0' part, the following
> would look better I think
> 
> ret = ...
> if (ret)
>   return 0;
> 
> return val;

yes, you're right.

> 
> ...
> 
>> +       int ret;
>> +
>> +       ret = regmap_write(wdt->regmap, wdt->offset + WDT_TIMEOUT, 
>> timeout);
>> +       if (!ret)
>> +               wdd->timeout = timeout;
>> +
>> +       return ret;
> 
> Similar story here:
> 
> ret = ...
> if (ret)
>   return ret;
> 
> wdd->... = ...
> return 0;
> 
> ...

ok

> 
>> +       ret = regmap_read(wdt->regmap, wdt->offset + WDT_CTRL, 
>> &status);
> 
>> +       if (ret < 0)
> 
> What ' < 0' means? Do we have some positive return values?
> Ditto for all your code.

probably not, I'll go over all return values and change them.

>> +               return ret;
> 
> ...
> 
>> +       if (status & WDT_CTRL_EN) {
>> +               sl28cpld_wdt_start(wdd);
> 
>> +               set_bit(WDOG_HW_RUNNING, &wdd->status);
> 
> Do you need atomic op here? Why?

I'd say consistency, all watchdog drivers do it like that. I just
had a look at where this is used, but it looks like access from
userspace is protected by a lock.

> 
>> +       }
> 
> ...
> 
>> +static const struct of_device_id sl28cpld_wdt_of_match[] = {
>> +       { .compatible = "kontron,sl28cpld-wdt" },
> 
>> +       {},
> 
> No comma.

yeah ;)

-- 
-michael
