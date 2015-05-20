From: Shobhit Kumar <kumar@shobhit.info>
Subject: Re: [Intel-gfx] [PATCH 6/8] pwm: crc: Add Crystalcove (CRC) PWM driver
Date: Wed, 20 May 2015 20:39:01 +0530
Message-ID: <CAAbrOmd61pF8AKVVV7c91mvup1doo0dKV0NXvRRpW+915fOH2Q@mail.gmail.com>
References: <1430316005-16480-7-git-send-email-shobhit.kumar@intel.com>
	<1430818716-27287-1-git-send-email-shobhit.kumar@intel.com>
	<20150506121455.GB9421@ulmo>
	<CAAbrOmcnToTPOaa-w+L=nYHuwkKYsrMm_kXXrucnFocKQ2KGfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAbrOmcnToTPOaa-w+L=nYHuwkKYsrMm_kXXrucnFocKQ2KGfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, May 7, 2015 at 12:49 PM, Shobhit Kumar <kumar@shobhit.info> wrote:
> On Wed, May 6, 2015 at 5:44 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
>> On Tue, May 05, 2015 at 03:08:36PM +0530, Shobhit Kumar wrote:
>>> The Crystalcove PMIC controls PWM signals and this driver exports that
>>
>> You say signal_s_ here, but you only expose a single PWM device. Does
>> the PMIC really control more than one? If it isn't, this should probably
>> become: "controls a PWM output and this driver...".
>
> Actually it does support 3 of them but on the platform only one is
> being used and I exported only that as of now. Probably I should
> expand a little in the commit message indicating this. will re-post
> after fixing based on your other comments.

Updates pending due to personal leave. Can be expected next week.

Regards
Shobhit

>
> Regards
> Shobhit
>
>>
>>> capability as a PWM chip driver. This is platform device implementtaion
>>
>> "implementation"
>>
>>> of the drivers/mfd cell device for CRC PMIC
>>
>> Sentences should end with a full stop.
>>
>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>> index b1541f4..954da3e 100644
>>> --- a/drivers/pwm/Kconfig
>>> +++ b/drivers/pwm/Kconfig
>>> @@ -183,6 +183,13 @@ config PWM_LPC32XX
>>>         To compile this driver as a module, choose M here: the module
>>>         will be called pwm-lpc32xx.
>>>
>>> +config PWM_CRC
>>> +     bool "Intel Crystalcove (CRC) PWM support"
>>> +     depends on X86 && INTEL_SOC_PMIC
>>> +     help
>>> +       Generic PWM framework driver for Crystalcove (CRC) PMIC based PWM
>>> +       control.
>>> +
>>
>> This is badly sorted. Please keep the list sorted alphabetically.
>>
>>>  config PWM_LPSS
>>>       tristate "Intel LPSS PWM support"
>>>       depends on X86
>>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>>> index ec50eb5..3d38fed 100644
>>> --- a/drivers/pwm/Makefile
>>> +++ b/drivers/pwm/Makefile
>>> @@ -35,3 +35,4 @@ obj-$(CONFIG_PWM_TIPWMSS)   += pwm-tipwmss.o
>>>  obj-$(CONFIG_PWM_TWL)                += pwm-twl.o
>>>  obj-$(CONFIG_PWM_TWL_LED)    += pwm-twl-led.o
>>>  obj-$(CONFIG_PWM_VT8500)     += pwm-vt8500.o
>>> +obj-$(CONFIG_PWM_CRC)                += pwm-crc.o
>>
>> This too.
>>
>>> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
>>> new file mode 100644
>>> index 0000000..987f3b4
>>> --- /dev/null
>>> +++ b/drivers/pwm/pwm-crc.c
>>> @@ -0,0 +1,171 @@
>>> +/*
>>> + * pwm-crc.c - Intel Crystal Cove PWM Driver
>>
>> I think you can safely remove this line. You already know what file it
>> is when you open it in your editor, and the description is in the
>> MODULE_DESCRIPTION string already.
>>
>>> + *
>>> + * Copyright (C) 2015 Intel Corporation. All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License version
>>> + * 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * Author: Shobhit Kumar <shobhit.kumar@intel.com>
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/mfd/intel_soc_pmic.h>
>>> +#include <linux/pwm.h>
>>> +
>>> +#define PWM0_CLK_DIV         0x4B
>>> +#define  PWM_OUTPUT_ENABLE   (1<<7)
>>
>> Should have spaces around <<.
>>
>>> +#define  PWM_DIV_CLK_0               0x00 /* DIVIDECLK = BASECLK */
>>> +#define  PWM_DIV_CLK_100     0x63 /* DIVIDECLK = BASECLK/100 */
>>> +#define  PWM_DIV_CLK_128     0x7F /* DIVIDECLK = BASECLK/128 */
>>> +
>>> +#define PWM0_DUTY_CYCLE              0x4E
>>> +#define BACKLIGHT_EN         0x51
>>> +
>>> +#define PWM_MAX_LEVEL                0xFF
>>> +
>>> +#define PWM_BASE_CLK         6000    /* 6 MHz */
>>
>> This number is actually 6 KHz. I think it'd be better if you stuck with
>> one unit here. Or perhaps there's some other reason why you can't use
>> 6000000 here instead?
>>
>>> +#define PWM_MAX_PERIOD_NS    21333 /* 46.875KHz */
>>> +
>>> +/**
>>> + * struct crystalcove_pwm - Crystal Cove PWM controller
>>> + * @chip: the abstract pwm_chip structure.
>>> + * @regmap: the regmap from the parent device.
>>> + */
>>> +struct crystalcove_pwm {
>>> +     struct pwm_chip chip;
>>> +     struct platform_device *pdev;
>>
>> I think I had at some point requested that you get rid of this and use
>> the chip.dev member instead. There's no kerneldoc for it and it isn't
>> (well, almost, see below) used anywhere else, so perhaps you forgot to
>> remove it here?
>>
>>> +     struct regmap *regmap;
>>> +};
>>> +
>>> +static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *pc)
>>> +{
>>> +     return container_of(pc, struct crystalcove_pwm, chip);
>>> +}
>>> +
>>> +static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
>>> +{
>>> +     struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
>>> +
>>> +     regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
>>> +{
>>> +     struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
>>> +
>>> +     regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
>>> +}
>>> +
>>> +static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
>>> +                               int duty_ns, int period_ns)
>>
>> Please align arguments on subsequent lines with the first argument of
>> the first line.
>>
>>> +{
>>> +     struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
>>> +     struct device *dev = &crc_pwm->pdev->dev;
>>
>> Did you test reconfiguring the PWM? I don't see crc_pwm->pdev getting
>> initialized anywhere, so this should crash trying to dereference a NULL
>> pointer.
>>
>> Of course if you get rid of the pdev field as I suggested you can simply
>> get the struct device * from c->dev.
>>
>>> +     int level, percent;
>>> +
>>> +     if (period_ns > PWM_MAX_PERIOD_NS) {
>>> +             dev_err(dev, "un-supported period_ns\n");
>>> +             return -1;
>>
>> You should return -EINVAL here. Besides being a literal and therefore a
>> bad idea, -1 == -EPERM and doesn't match the error condition.
>>
>>> +     }
>>> +
>>> +     if (pwm->period != period_ns) {
>>> +             int clk_div;
>>> +
>>> +             /* changing the clk divisor, need to disable fisrt */
>>> +             crc_pwm_disable(c, pwm);
>>> +             clk_div = PWM_BASE_CLK * period_ns / 1000000;
>>
>> Similar to the above, this is confusing because you're mixing up
>> different scales here. period_ns is in nanoseconds, so it'd be natural
>> to divide by 1000000000 (though you should really be using NSEC_PER_SEC
>> instead). If you counterweight that by expressing PWM_BASE_CLK in Hz
>> (6000000) you get much nicer symmetry and make the code a lot easier to
>> understand.
>>
>>> +
>>> +             regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
>>> +                                     clk_div | PWM_OUTPUT_ENABLE);
>>> +
>>> +             /* enable back */
>>> +             crc_pwm_enable(c, pwm);
>>> +     }
>>> +
>>> +     if (duty_ns > period_ns) {
>>> +             dev_err(dev, "duty cycle cannot be greater than cycle period\n");
>>> +             return -1;
>>> +     }
>>
>> The PWM core already performs this check, so you'll never get here in
>> case this condition is true.
>>
>>> +
>>> +     /* change the pwm duty cycle */
>>> +     percent = duty_ns * 100 / period_ns;
>>> +     level = percent * PWM_MAX_LEVEL / 100;
>>
>> Why do you need to apply the rule of three twice here? Doesn't
>>
>>         level = duty_ns * PWM_MAX_LEVEL / period_ns;
>>
>> give you what you want?
>>
>>> +     regmap_write(crc_pwm->regmap, PWM0_DUTY_CYCLE, level);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct pwm_ops crc_pwm_ops = {
>>> +     .config = crc_pwm_config,
>>> +     .enable = crc_pwm_enable,
>>> +     .disable = crc_pwm_disable,
>>> +     .owner = THIS_MODULE,
>>> +};
>>> +
>>> +static int crystalcove_pwm_probe(struct platform_device *pdev)
>>> +{
>>> +     struct crystalcove_pwm *pwm;
>>> +     int retval;
>>> +     struct device *dev = pdev->dev.parent;
>>> +     struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
>>> +
>>> +     pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>>> +     if (!pwm)
>>> +             return -ENOMEM;
>>> +
>>> +     pwm->chip.dev = &pdev->dev;
>>> +     pwm->chip.ops = &crc_pwm_ops;
>>> +     pwm->chip.base = -1;
>>> +     pwm->chip.npwm = 1;
>>> +
>>> +     /* get the PMIC regmap */
>>> +     pwm->regmap = pmic->regmap;
>>> +
>>> +     retval = pwmchip_add(&pwm->chip);
>>> +     if (retval < 0)
>>> +             return retval;
>>> +
>>> +     dev_dbg(&pdev->dev, "crc-pwm probe successful\n");
>>
>> Do you really want this? The driver core will complain in any of the
>> above failures, so what use is there to be chatty when probing
>> succeeds?
>>
>>> +static struct platform_driver crystalcove_pwm_driver = {
>>> +     .probe = crystalcove_pwm_probe,
>>> +     .remove = crystalcove_pwm_remove,
>>> +     .driver = {
>>> +             .name = "crystal_cove_pwm",
>>
>> I'd prefer this to be "crystal-cove-pwm" for consistency with other
>> drivers, but since the MFD part already uses underscores in names it'd
>> introduce an inconsistency there. So I'm fine with this one as-is.
>>
>> Thierry
>>
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/intel-gfx
>>
