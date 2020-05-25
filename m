From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Mon, 25 May 2020 16:25:21 +0300
Message-ID: <20200525132521.GZ1634618@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-11-michael@walle.cc>
 <CAMpxmJV3XTOxuoKeV-z2d75qWqHkgvV9419tfe3idDeKwoeoLA@mail.gmail.com>
 <75bff2917be1badd36af9f980cf59d2c@walle.cc>
 <CAMpxmJXctc5cbrjSeJxa7DfmjiVsbyhqAbEKt-gtayKhQj0Cnw@mail.gmail.com>
 <951244aab2ff553a463f7431ba09bf27@walle.cc>
 <CACRpkdZYEZk7o+Y2-AqnHGsY8N7KGGmPGSuSS=H7YY8VLZ3jZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZYEZk7o+Y2-AqnHGsY8N7KGGmPGSuSS=H7YY8VLZ3jZw@mail.gmail.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Pierre-louis Bossart <pierre-louis.bossart@intel.com>
Cc: Michael Walle <michael@walle.cc>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio <linux-gpio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Mon, May 25, 2020 at 02:59:36PM +0200, Linus Walleij wrote:
> On Mon, May 25, 2020 at 12:20 PM Michael Walle <michael@walle.cc> wrote:
> 
> > If you like I could submit this patch on its own. But then there
> > wouldn't be a user for it.
> 
> I'm pretty much fine with that, we do merge code that has no
> users if we anticipate they will be around the corner.

I remember we discussed with Pierre to use it for his ASoC work.
Pierre, does it sound useful for you?

-- 
With Best Regards,
Andy Shevchenko
