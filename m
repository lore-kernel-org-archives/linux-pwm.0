From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
Date: Fri, 5 Jun 2020 11:15:54 +0300
Message-ID: <CAHp75VdMSoj2+jKkA=oais2QAWBmvgzE6PLJdm6rebooubLCcw@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-6-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200604211039.12689-6-michael@walle.cc>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support for the PWM controller of the sl28cpld board management
> controller. This is part of a multi-function device driver.
>
> The controller has one PWM channel and can just generate four distinct
> frequencies.

So same comments (extra comma, cargo cult headers, etc) are applied
here and perhaps to all other patches in the series.

-- 
With Best Regards,
Andy Shevchenko
