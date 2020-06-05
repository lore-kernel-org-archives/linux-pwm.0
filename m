From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 03/11] irqchip: add sl28cpld interrupt controller support
Date: Fri, 5 Jun 2020 11:07:32 +0300
Message-ID: <CAHp75VfMSbAMPg2ZLO6kE-9vkQCt0a+=Lji8V5ngY7xdUbfiMQ@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-4-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200604211039.12689-4-michael@walle.cc>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 12:13 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support for the interrupt controller inside the sl28 CPLD management
> controller.
>
> The interrupt controller can handle at most 8 interrupts and is really
> simplistic and consists only of an interrupt mask and an interrupt
> pending register.

...

> +config SL28CPLD_INTC
> +       bool

Same Q: Why not module?

...

> +static const struct of_device_id sl28cpld_intc_of_match[] = {
> +       { .compatible = "kontron,sl28cpld-intc" },

> +       {},

There is no point to have comma in terminator line.

> +};


-- 
With Best Regards,
Andy Shevchenko
