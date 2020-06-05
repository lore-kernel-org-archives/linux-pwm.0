From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 06/11] gpio: add support for the sl28cpld GPIO controller
Date: Sat, 6 Jun 2020 00:19:10 +0300
Message-ID: <CAHp75Vcqv8rdqfBdttLb2vgj12AOUAOFK+ya7MZtRT+0_U+rYA@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-7-michael@walle.cc>
 <CAHp75VfRhL1f-XD=PMbqd3BLeJQzQMFAupSzqAvx0g7-X_2VhQ@mail.gmail.com>
 <216db3154b46bd80202873df055bb3f3@walle.cc> <20200605131525.GK2428291@smile.fi.intel.com>
 <bf587fc3f907d58609a0ea3d65cd5b37@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <bf587fc3f907d58609a0ea3d65cd5b37@walle.cc>
Sender: linux-hwmon-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 9:44 PM Michael Walle <michael@walle.cc> wrote:
> Am 2020-06-05 15:15, schrieb Andy Shevchenko:
> > On Fri, Jun 05, 2020 at 02:42:53PM +0200, Michael Walle wrote:
> >> Am 2020-06-05 14:00, schrieb Andy Shevchenko:
> >> > On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:

...

> >> > > +       if (irq_support &&
> >> >
> >> > Why do you need this flag? Can't simple IRQ number be sufficient?
> >>
> >> I want to make sure, the is no misconfiguration. Eg. only GPIO
> >> flavors which has irq_support set, have the additional interrupt
> >> registers.
> >
> > In gpio-dwapb, for example, we simple check two things: a) hardware
> > limitation
> > (if IRQ is assigned to a proper port) and b) if there is any IRQ comes
> > from DT,
> > ACPI, etc.
>
> I can't follow you here. irq_support is like your (a); or the
> "pp->idx == 0" in your example.

And you have type already. Why do you need to duplicate it? Moreover,
is it protection from wrong type to have interrupts?

You can move this all stuff under corresponding switch-case.

> >> > > +           device_property_read_bool(&pdev->dev,
> >> > > "interrupt-controller")) {
> >> > > +               irq = platform_get_irq(pdev, 0);
> >> > > +               if (irq < 0)
> >> > > +                       return irq;
> >> > > +
> >> > > +               ret = sl28cpld_gpio_irq_init(&pdev->dev, gpio, regmap,
> >> > > +                                            base, irq);
> >> > > +               if (ret)
> >> > > +                       return ret;
> >> > > +
> >> > > +               config.irq_domain =
> >> > > regmap_irq_get_domain(gpio->irq_data);


-- 
With Best Regards,
Andy Shevchenko
