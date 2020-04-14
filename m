From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Tue, 14 Apr 2020 20:36:23 +0200
Message-ID: <fa605af3aee48f0bc62133f398ed7c5d@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <20200414172129.GJ5412@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200414172129.GJ5412@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio <linux-gpio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pwm@vger.kernel.org

Am 2020-04-14 19:21, schrieb Mark Brown:
> On Tue, Apr 14, 2020 at 12:07:01PM +0200, Michael Walle wrote:
>> Am 2020-04-14 11:50, schrieb Bartosz Golaszewski:
> 
>> > Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
>> > IS_ERR() returning true?
> 
>> Unfortunatly, its not a pointer, but only a regular unsigned int (ie
>> the type the regmap API has for its "reg" property). It could be a
>> pointer of course but then the user would have to allocate additional
>> memory.
> 
> You could define REGMAP_INVALID_ADDR to be (unsigned int)(-1) or some
> other suitably implausible address and use that as a value.  It's
> possible that there might be a collision with a real address on some
> device but it should be sufficiently unlikely to be useful, especially
> if it's not something regmap in general goes and evaluates.  For extra
> safety we could have an API for allowing users to query the register
> validity information regmap has (or can be given) and gpiolib could 
> then
> use that to figure out if the value was actually a dummy value but
> that's probably overdoing it.

If possible, I'd like to have the opposite logic. That is, if it is not
set it should be invalid. If we have a magic macro like
REGMAP_INVALID_ADDR, we must assign it to all the unused addresses. Thus
every driver would have to assign all addresses and if in the future
there will be some added, we'd have to touch all the drivers which use
gpio_regmap.

-michael
