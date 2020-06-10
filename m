From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
Date: Wed, 10 Jun 2020 09:49:04 +0200
Message-ID: <f7b2b690750edd022000ab56d2f58154@walle.cc>
References: <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc> <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc> <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc> <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc> <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc> <20200610071940.GS4106@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200610071940.GS4106@dell>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, david.m.ertman@intel.com, shiraz.saleem@intel.com, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K?=
List-Id: linux-pwm@vger.kernel.org

Am 2020-06-10 09:19, schrieb Lee Jones:
> On Wed, 10 Jun 2020, Michael Walle wrote:
>> Am 2020-06-09 21:45, schrieb Lee Jones:
>> > On Tue, 09 Jun 2020, Michael Walle wrote:
>> > > > We do not need a 'simple-regmap' solution for your use-case.
>> > > >
>> > > > Since your device's registers are segregated, just split up the
>> > > > register map and allocate each sub-device with it's own slice.
>> > >
>> > > I don't get it, could you make a device tree example for my
>> > > use-case? (see also above)
>> >
>> >     &i2cbus {
>> >         mfd-device@10 {
>> >             compatible = "simple-mfd";
>> >             reg = <10>;
>> >
>> >             sub-device@10 {
>> >                 compatible = "vendor,sub-device";
>> >                 reg = <10>;
>> >             };
>> >    };
>> >
>> > The Regmap config would be present in each of the child devices.
>> >
>> > Each child device would call devm_regmap_init_i2c() in .probe().
>> 
>> Ah, I see. If I'm not wrong, this still means to create an i2c
>> device driver with the name "simple-mfd".
> 
> Yes, it does.
> 
>> Besides that, I don't like this, because:
>>  - Rob already expressed its concerns with "simple-mfd" and so on.
> 
> Where did this take place?  I'd like to read up on this.

In this thread:
https://lore.kernel.org/linux-devicetree/20200604211039.12689-1-michael@walle.cc/T/#m16fdba5962069e7cd4aa817582ee358c9fe2ecbf

> 
>>  - you need to duplicate the config in each sub device
> 
> You can have a share a single config.
> 
>>  - which also means you are restricting the sub devices to be
>>    i2c only (unless you implement and duplicate other regmap configs,
>>    too). For this driver, SPI and MMIO may be viable options.
> 
> You could also have a shared implementation to choose between different
> busses.

Then what is the difference between to have this shared config in the
parent driver only and use the functions which are already there, i.e.
dev_get_regmap(parent). But see, below, I'll wait with what you're
coming up.

> 
>> Thus, I'd rather implement a simple-mfd.c which implement a common
>> I2C driver for now and populate its children using
>> devm_of_platform_populate(). This could be extended to support other
>> type of regmaps like SPI in the future.
>> 
>> Also some MFD drivers could be moved to this, a likely candidate is
>> the smsc-ece1099.c. Although I don't really understand its purpose,
>> if don't have CONFIG_OF.
>> 
>> Judging from the existing code, this simple-mfd.c wouldn't just be
>> "a list of compatible" strings but also additional quirks and tweaks
>> for particular devices in this list.
> 
> Hold off on the simple-mfd.c idea, as I'm not taken by it yet and
> wouldn't want you to waste your time.  I have another idea which would
> help.  Give me a few days to put something together.

Sure. I'm just glad there is now a discussion about this issue.

-michael
