From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Thu, 16 Apr 2020 11:34:26 +0200
Message-ID: <576a6244fa3b996327c49023fe953215@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
 <62d157198a75a59ada15c496deeab49b@walle.cc>
 <eab972adf53bbac20b5a9e613fcfb5b0@walle.cc>
 <CACRpkdZPZ4nFQ6B3tGG9wvceoTWqAkfY0r1UKs2pf_c=ZNBG=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <CACRpkdZPZ4nFQ6B3tGG9wvceoTWqAkfY0r1UKs2pf_c=ZNBG=w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-devicetree <devicetree@vger.kernel.org>, Jean Delvare <jdelvare@suse.com>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Am 2020-04-16 11:20, schrieb Linus Walleij:
> On Tue, Apr 14, 2020 at 9:57 PM Michael Walle <michael@walle.cc> wrote:
> 
>> So what about the following:
>> 
>> #define GPIO_REGMAP_ADDR_ZERO (unsigned int)(-1)
> 
> Yeah with regmap explicitly using int I guess we can't use
> S32_MAX, so that is fair.
> 
>> So this way the user might assign the base addresses the normal way
>> except when he wants to use zero, in that case he has to use
>> 
>>    ->base_adr = GPIO_REGMAP_ADDR_ZERO;
>> 
>> gpio-regmap.c could use then:
>> 
>> if (base_addr)
>>    something_useful(gpio_regmap_addr(base_addr));
>> 
>> unsigned int gpio_regmap_addr(unsigned int addr)
>> {
>>    return (addr == GPIO_REGMAP_ADDR_ZERO) ? 0 : addr;
>> }
> 
> That's reasonably clean.

Ok, at least on that side. For my sl28 gpio driver I then have
the problem that depending on 'base' I might have to use
GPIO_REGMAP_ADDR_ZERO:

   #define GPIO_REG_DIR 0
   config.reg_dir_out_base = base + GPIO_REG_DIR;

So there is still a convenience macro:
   #define GPIO_REGMAP_ADDR(addr) ((addr) ? addr : GPIO_REGMAP_ADDR_ZERO)

which you can use if you can't be sure that the address is not non-zero.
So the code in my sl28 gpio driver looks like:

  config.reg_dir_out_base = GPIO_REGMAP_ADDR(base + GPIO_REG_DIR);

I'll respin the patch with the current remarks.

-michael
