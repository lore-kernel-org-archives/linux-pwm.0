From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Date: Fri, 5 Jun 2020 08:05:42 -0700
Message-ID: <20200605150542.GA254229@roeck-us.net>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
 <8f042c2442852c29519c381833f3d289@walle.cc>
 <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
 <871a4990-5b94-3a17-01d4-74998375f08b@roeck-us.net>
 <20200605140911.GO2428291@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200605140911.GO2428291@smile.fi.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Walle <michael@walle.cc>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 05, 2020 at 05:09:11PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2020 at 06:52:00AM -0700, Guenter Roeck wrote:
> > On 6/5/20 3:50 AM, Andy Shevchenko wrote:
> > > On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael@walle.cc> wrote:
> > >> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> > >>> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
> 
> ...
> 
> > >>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
> > >>>> +module_param(nowayout, bool, 0);
> > >>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
> > >>>> (default="
> > >>>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
> > >>>> ")");
> > >>>> +
> > >>>> +static int timeout;
> > >>>> +module_param(timeout, int, 0);
> > >>>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> > >>>
> > >>> Guenter ACKed this, but I'm wondering why we still need module
> > >>> parameters...
> > >>
> > >> How would a user change the nowayout or the timeout? For the latter
> > >> there is
> > >> a device tree entry, but thats not easy changable by the user.
> > > 
> > > Yes, it's more question to VIm and Guenter than to you.
> > > 
> > 
> > Has support for providing module parameters with the kernel command line
> > been discontinued/deprecated, or did it run out of favor ? Sorry if I
> > missed that.
> 
> Latter according to Greg KH. One of the (plenty) examples [1].
> 
> [1]: https://www.mail-archive.com/driverdev-devel@linuxdriverproject.org/msg96495.html
> 
What is the suggested replacement ?

Guenter
