From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Tue, 14 Apr 2020 12:07:01 +0200
Message-ID: <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-gpio <linux-gpio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc
List-Id: linux-pwm@vger.kernel.org

Am 2020-04-14 11:50, schrieb Bartosz Golaszewski:
> pon., 6 kwi 2020 o 12:10 Michael Walle <michael@walle.cc> napisał(a):
>> 
>> 
>> Hi Bartosz, Hi Mark Brown,
>> 
>> Am 2020-04-06 09:47, schrieb Bartosz Golaszewski:
>> > czw., 2 kwi 2020 o 22:37 Michael Walle <michael@walle.cc> napisał(a):
>> >>
>> >> There are quite a lot simple GPIO controller which are using regmap to
>> >> access the hardware. This driver tries to be a base to unify existing
>> >> code into one place. This won't cover everything but it should be a
>> >> good
>> >> starting point.
>> >>
>> >> It does not implement its own irq_chip because there is already a
>> >> generic one for regmap based devices. Instead, the irq_chip will be
>> >> instanciated in the parent driver and its irq domain will be associate
>> >> to this driver.
>> >>
>> >> For now it consists of the usual registers, like set (and an optional
>> >> clear) data register, an input register and direction registers.
>> >> Out-of-the-box, it supports consecutive register mappings and mappings
>> >> where the registers have gaps between them with a linear mapping
>> >> between
>> >> GPIO offset and bit position. For weirder mappings the user can
>> >> register
>> >> its own .xlate().
>> >>
>> >> Signed-off-by: Michael Walle <michael@walle.cc>
>> >
>> > Hi Michael,
>> >
>> > Thanks for doing this! When looking at other generic drivers:
>> > gpio-mmio and gpio-reg I can see there are some corner-cases and more
>> > specific configuration options we could add
>> 
>> I didn't want to copy every bit without being able to test it.
>> 
> 
> Sure, I didn't mean we need to do it now - just set it as the future 
> goal.
> 
>> > but it's not a blocker,
>> > we'll probably be extending this one as we convert more drivers to
>> > using it.
>> 
>> correct, that was also my plan.
>> 
>> > Personally I'd love to see gpio-mmio and gpio-reg removed
>> > and replaced by a single, generic regmap interface eventually.
>> 
>> agreed.
>> 
>> 
> 
> [snip!]
> 
>> >> +
>> >> +/**
>> >> + * gpio_regmap_simple_xlate() - translate base/offset to reg/mask
>> >> + *
>> >> + * Use a simple linear mapping to translate the offset to the
>> >> bitmask.
>> >> + */
>> >> +int gpio_regmap_simple_xlate(struct gpio_regmap *gpio, unsigned int
>> >> base,
>> >> +                            unsigned int offset,
>> >> +                            unsigned int *reg, unsigned int *mask)
>> >> +{
>> >> +       unsigned int line = offset % gpio->ngpio_per_reg;
>> >> +       unsigned int stride = offset / gpio->ngpio_per_reg;
>> >> +
>> >> +       *reg = base + stride * gpio->reg_stride;
>> >> +       *mask = BIT(line);
>> >> +
>> >> +       return 0;
>> >> +}
>> >> +EXPORT_SYMBOL_GPL(gpio_regmap_simple_xlate);
>> >
>> > Why does this need to be exported?
>> 
>> Mh, the idea was that a user could also set this xlate() by himself 
>> (for
>> whatever reason). But since it is the default, it is not really
>> necessary.
>> That being said, I don't care if its only local to this module.
>> 
> 
> Let's only export symbols that have external users then.
> 
> [snip!]
> 
>> >> +
>> >> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
>> >> +MODULE_DESCRIPTION("GPIO generic regmap driver core");
>> >> +MODULE_LICENSE("GPL");
>> >> diff --git a/include/linux/gpio-regmap.h b/include/linux/gpio-regmap.h
>> >> new file mode 100644
>> >> index 000000000000..ad63955e0e43
>> >> --- /dev/null
>> >> +++ b/include/linux/gpio-regmap.h
>> >> @@ -0,0 +1,88 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0-only */
>> >> +
>> >> +#ifndef _LINUX_GPIO_REGMAP_H
>> >> +#define _LINUX_GPIO_REGMAP_H
>> >> +
>> >> +struct gpio_regmap_addr {
>> >> +       unsigned int addr;
>> >> +       bool valid;
>> >> +};
>> >
>> > I'm not quite sure what the meaning behind the valid field here is.
>> > When would we potentially set it to false?
>> 
>> Some base addresses are optional, but on the other hand, a base 
>> address
>> of 0 could also be valid. So I cannot use 0 as an indicator whether a
>> base address is set or not. The generic mmio driver has some special
>> case for the ack base, where there is a use_ack flag which forces to
>> use the ack register even if its zero. So I've had a look at the 
>> kernel
>> if there is a better idiom for that, but I haven't found anything.
>> 
>> So the best from a user perspective I've could come up with was:
>> 
>>    ->base_reg = GPIO_REGMAP_ADDR(addr);
>> 
>> I'm open for suggestions.
>> 
> 
> Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
> IS_ERR() returning true?

Unfortunatly, its not a pointer, but only a regular unsigned int (ie
the type the regmap API has for its "reg" property). It could be a
pointer of course but then the user would have to allocate additional
memory.

-michael

> 
>> >
>> >> +#define GPIO_REGMAP_ADDR(_addr) \
>> >> +       ((struct gpio_regmap_addr) { .addr = _addr, .valid = true })
>> >> +
>> >> +/**
>> >> + * struct gpio_regmap - Description of a generic regmap gpio_chip.
>> >> + *
>> >> + * @parent:            The parent device
>> >> + * @regmap:            The regmap use to access the registers
>> >
>> > s/use/used/
>> >
>> >> + *                     given, the name of the device is used
>> >> + * @label:             (Optional) Descriptive name for GPIO
>> >> controller.
>> >> + *                     If not given, the name of the device is used.
>> >> + * @ngpio:             Number of GPIOs
>> >> + * @reg_dat_base:      (Optional) (in) register base address
>> >> + * @reg_set_base:      (Optional) set register base address
>> >> + * @reg_clr_base:      (Optional) clear register base address
>> >> + * @reg_dir_in_base:   (Optional) out setting register base address
>> >> + * @reg_dir_out_base:  (Optional) in setting register base address
>> >> + * @reg_stride:                (Optional) May be set if the registers
>> >> (of the
>> >> + *                     same type, dat, set, etc) are not consecutive.
>> >> + * @ngpio_per_reg:     Number of GPIOs per register
>> >> + * @irq_domain:                (Optional) IRQ domain if the
>> >> controller is
>> >> + *                     interrupt-capable
>> >> + * @reg_mask_xlate:     (Optional) Translates base address and GPIO
>> >> + *                     offset to a register/bitmask pair. If not
>> >> + *                     given the default gpio_regmap_simple_xlate()
>> >> + *                     is used.
>> >> + * @to_irq:            (Optional) Maps GPIO offset to a irq number.
>> >> + *                     By default assumes a linear mapping of the
>> >> + *                     given irq_domain.
>> >> + * @driver_data:       Pointer to the drivers private data. Not used
>> >> by
>> >> + *                     gpio-regmap.
>> >> + *
>> >> + * The reg_mask_xlate translates a given base address and GPIO offset
>> >> to
>> >> + * register and mask pair. The base address is one of the given
>> >> reg_*_base.
>> >> + */
>> >> +struct gpio_regmap {
>> >
>> > I'd prefer to follow a pattern seen in other such APIs of calling this
>> > structure gpio_regmap_config and creating another private structure
>> > called gpio_regmap used in callbacks that would only contain necessary
>> > fields.
>> 
>> something like the following?
>> 
>> struct gpio_regmap *gpio_regmap_register(struct gpio_regmap_config *)
>> 
>> but if that structure is private, how can a callback access individual
>> elements? Or do you mean private in "local to the gpio drivers"?
>> 
> 
> Either making the structure local to drivers/gpio or making it
> entirely opaque and providing accessor functions. Depending on how
> much of the structure one may want to access.
> 
>> Also I was unsure about the naming, eg. some use
>> stuff_register()/stuff_unregister() and some 
>> stuff_add()/stuff_remove().
>> 
> 
> register/unregister is fine with me.
> 
> Bart
