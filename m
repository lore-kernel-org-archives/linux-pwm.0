From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld
 management controller
Date: Tue, 28 Apr 2020 15:50:49 +0300
Message-ID: <20200428125049.GU185537@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-6-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200423174543.17161-6-michael@walle.cc>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
> This patch adds core support for the board management controller found
> on the SMARC-sAL28 board. It consists of the following functions:
>  - watchdog
>  - GPIO controller
>  - PWM controller
>  - fan sensor
>  - interrupt controller

...

>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> +
> +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o

Perhaps keep an order?

...

> +	return devm_mfd_add_devices(dev, -1, sl28cpld_devs,

-1 has its own definition.

> +				    ARRAY_SIZE(sl28cpld_devs), NULL,
> +				    i2c->irq, NULL);
> +}

-- 
With Best Regards,
Andy Shevchenko
