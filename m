From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
Date: Fri, 5 Jun 2020 11:02:54 +0300
Message-ID: <CAHp75VfKtt7ZnVdE+n7JjGH-MXsOch-GNZpbv5r780a=VsgZXQ@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-3-michael@walle.cc>
 <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 11:01 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:

...

> > Please note that the MFD driver is defined as bool in the Kconfig
> > because the next patch will add interrupt support.

> > +       bool "Kontron sl28 core driver"
> > +       depends on I2C=y
>
> Why not module?

To be clear, I have read above, but it didn't shed a light.

-- 
With Best Regards,
Andy Shevchenko
