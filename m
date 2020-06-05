From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
Date: Fri, 05 Jun 2020 12:09:15 +0200
Message-ID: <8ed988b3e0bc48ea9219d0847c1b1b8e@walle.cc>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas
List-Id: linux-pwm@vger.kernel.org

Hi Andy,

Am 2020-06-05 10:01, schrieb Andy Shevchenko:
> On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Add the core support for the board management controller found on the
>> SMARC-sAL28 board. It consists of the following functions:
>>  - watchdog
>>  - GPIO controller
>>  - PWM controller
>>  - fan sensor
>>  - interrupt controller
>> 
>> At the moment, this controller is used on the Kontron SMARC-sAL28 
>> board.
>> 
>> Please note that the MFD driver is defined as bool in the Kconfig
>> because the next patch will add interrupt support.
> 
> ...
> 
>> +config MFD_SL28CPLD
>> +       bool "Kontron sl28 core driver"
>> +       depends on I2C=y
> 
> Why not module?

There are users of the interupt lines provided by the interrupt 
controller.
For example, the gpio-button driver. If this is compiled into the kernel
(which it is by default in the arm64 defconfig), probing will fail 
because
the interrupt is not found. Is there a better way for that? I guess the 
same
is true for the GPIO driver.

> 
>> +       depends on OF
> 
> I didn't find an evidence this is needed.

see below.

> 
> No Compile Test?

ok

>> +       select REGMAP_I2C
>> +       select MFD_CORE
> 
> ...
> 
>> +#include <linux/of_platform.h>
> 
> No evidence of user of this.
> I think you meant mod_devicetable.h.

devm_of_platform_populate(), so I need CONFIG_OF, too right?


>> +static struct i2c_driver sl28cpld_driver = {
>> +       .probe_new = sl28cpld_probe,
>> +       .driver = {
>> +               .name = "sl28cpld",
>> +               .of_match_table = of_match_ptr(sl28cpld_of_match),
> 
> Drop of_match_ptr(). It has a little sense in this context (depends 
> OF).
> It will have a little sense even if you drop depends OF b/c you will
> introduce a compiler warning.

ok

> 
>> +       },
>> +};

-- 
-michael
