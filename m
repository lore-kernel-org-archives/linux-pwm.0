From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Tue, 14 Apr 2020 20:41:45 +0200
Message-ID: <62d157198a75a59ada15c496deeab49b@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-gpio <linux-gpio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc
List-Id: linux-pwm@vger.kernel.org

Am 2020-04-14 19:00, schrieb Bartosz Golaszewski:
> wt., 14 kwi 2020 o 12:07 Michael Walle <michael@walle.cc> napisał(a):
>> >>
>> >> So the best from a user perspective I've could come up with was:
>> >>
>> >>    ->base_reg = GPIO_REGMAP_ADDR(addr);
>> >>
>> >> I'm open for suggestions.
>> >>
>> >
>> > Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
>> > IS_ERR() returning true?
>> 
>> Unfortunatly, its not a pointer, but only a regular unsigned int (ie
>> the type the regmap API has for its "reg" property). It could be a
>> pointer of course but then the user would have to allocate additional
>> memory.
>> 
>> -michael
>> 
> 
> Eek, of course it's not a pointer. If possible I'd like to avoid this
> GPIO_REGMAP_ADDR() macro, so how about having some separate field for
> invalid offsets making every offset 'valid' by default?

IMHO this has the same problems as mentioned in the response to Mark's
idea. Normally, the user sets only some addresses, thus he has to mark
all other as invalid. And if you add another address, you have to touch
all the drivers to mark it as invalid.

We could add some force bits like the "use_ack" flag in the bgpio 
driver,
where you can force the use of the value 0. But I'd really like to find
a better way..

-michael

> 
> Linus: do you have a better idea?
> 
> Bart
