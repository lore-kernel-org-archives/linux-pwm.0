From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
Date: Fri, 5 Jun 2020 13:48:27 +0300
Message-ID: <CAHp75Vf00w_UUvXULVd=OgSVM+p_pmNMJRPVnf8GNZW10c_j5w@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-3-michael@walle.cc>
 <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com> <8ed988b3e0bc48ea9219d0847c1b1b8e@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <8ed988b3e0bc48ea9219d0847c1b1b8e@walle.cc>
Sender: linux-hwmon-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 1:09 PM Michael Walle <michael@walle.cc> wrote:
> Am 2020-06-05 10:01, schrieb Andy Shevchenko:
> > On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:

...

> >> +       bool "Kontron sl28 core driver"
> >> +       depends on I2C=y
> >
> > Why not module?
>
> There are users of the interupt lines provided by the interrupt
> controller.
> For example, the gpio-button driver. If this is compiled into the kernel
> (which it is by default in the arm64 defconfig), probing will fail
> because
> the interrupt is not found. Is there a better way for that? I guess the
> same
> is true for the GPIO driver.

And GPIO nicely handles this via deferred probe mechanism. Why it
can't be used here?
So, we really need to have a strong argument to limit module nowadays
to be only builtin.

...

> >> +       depends on OF
> >
> > I didn't find an evidence this is needed.

> >> +#include <linux/of_platform.h>
> >
> > No evidence of user of this.
> > I think you meant mod_devicetable.h.
>
> devm_of_platform_populate(), so I need CONFIG_OF, too right?

Ah, this explains header, thanks!
But it doesn't explain depends OF.

So, perhaps,

depends OF || COMPILE_TEST will be more informative, i.e.
tells "okay, this driver can be compiled w/o OF, but won't be functional".

-- 
With Best Regards,
Andy Shevchenko
