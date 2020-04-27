From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller
 support
Date: Mon, 27 Apr 2020 20:01:14 +0200
Message-ID: <5d63026fc7c8700c2c7fb15267a9e441@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-7-michael@walle.cc>
 <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
 <87f141bce0a4fda04b550647306be296@walle.cc>
 <20200427174427.GE4383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200427174427.GE4383-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Jason Cooper <jason>
List-Id: linux-pwm@vger.kernel.org

Am 2020-04-27 19:44, schrieb Mark Brown:
> On Mon, Apr 27, 2020 at 07:40:11PM +0200, Michael Walle wrote:
> 
>> IRQF_ONESHOT, because its is a threaded interrupt with no primary
>> handler. But I just noticed, that regmap-irq will also set the
>> IRQF_ONESHOT. But that the commit 09cadf6e088b ("regmap-irq:
>> set IRQF_ONESHOT flag to ensure IRQ request") reads like it is
>> just there to be sure. So I don't know if it should also be set
>> here.
> 
> Looking at the changelog there the "we can't be sure" bit is that
> coccinelle couldn't follow the flags through from the caller to make
> sure that IRQF_ONESHOT is set so we're just oring it in 
> unconditionally.

So it is correct that IRQF_ONESHOT is also set in the driver which is
using regmap_add_irq_chip(), right?

-michael
