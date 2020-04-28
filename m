From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld
 management controller
Date: Tue, 28 Apr 2020 17:49:58 +0300
Message-ID: <20200428144958.GZ185537@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-6-michael@walle.cc>
 <20200428125049.GU185537@smile.fi.intel.com>
 <5e2d486077f9e2ce8bd9b171cf806fd9@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e2d486077f9e2ce8bd9b171cf806fd9@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel>
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 28, 2020 at 04:43:24PM +0200, Michael Walle wrote:
> Am 2020-04-28 14:50, schrieb Andy Shevchenko:
> > On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
> > > This patch adds core support for the board management controller found
> > > on the SMARC-sAL28 board. It consists of the following functions:
> > >  - watchdog
> > >  - GPIO controller
> > >  - PWM controller
> > >  - fan sensor
> > >  - interrupt controller
> > 
> > ...
> > 
> > >  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> > > 
> > >  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> > > +
> > > +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
> > 
> > Perhaps keep an order?
> 
> I don't see any order in that makefile. Looked to me like every new
> file was added at the end.

Okay, just didn't note from above context.

-- 
With Best Regards,
Andy Shevchenko
