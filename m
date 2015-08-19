From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add Broadcom BCM7038 PWM controller support
Date: Wed, 19 Aug 2015 08:18:29 -0700
Message-ID: <CAGVrzcb8fHuXb-Rtxziqz4Tg0mYHzL20KOeg9fDengRzAdLq=g@mail.gmail.com>
References: <1438908959-1578-1-git-send-email-f.fainelli@gmail.com>
 <1438908959-1578-3-git-send-email-f.fainelli@gmail.com> <20150819095243.GB26627@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35445 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbbHSPTN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2015 11:19:13 -0400
In-Reply-To: <20150819095243.GB26627@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>

2015-08-19 2:52 GMT-07:00 Thierry Reding <thierry.reding@gmail.com>:
> On Thu, Aug 06, 2015 at 05:55:58PM -0700, Florian Fainelli wrote:
>> Add support for the BCM7038-style PWM controller found in all BCM7xxx STB SoCs.
>> This controller has a hardcoded 2 channels per controller, and cascades a
>> variable frequency generator on top of a fixed frequency generator which offers
>> a range of a 148ns period all the way to ~622ms periods.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/pwm/Kconfig       |  10 ++
>>  drivers/pwm/Makefile      |   1 +
>>  drivers/pwm/pwm-brcmstb.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 334 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-brcmstb.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index b1541f40fd8d..28f95cca70ce 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -111,6 +111,16 @@ config PWM_CLPS711X
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-clps711x.
>>
>> +config PWM_BRCMSTB
>> +     tristate "Broadcom STB PWM support"
>> +     depends on ARCH_BRCMSTB
>> +     help
>> +       Generic PWM framework driver for the Broadcom Set-top-Box
>> +       SoCs (BCM7xxx).
>> +
>> +       To compile this driver as a module, choose M Here: the module
>> +       will be called pwm-brcmstb.c.
>
> Perhaps call it pwm-brcm7xxx? stb sounds more like a use-case
> description rather than a hardware model name.

We settled on brcmstb as the common denominator for everything that
touches Broadcom Set Top Box chips (BCM7xxx), so the regexp we have in
MAINTAINERS will match, also 7xxx has a tendency of being caught by
vger.kernel.org thinking this is pr0n (I am not kidding).

>
>>  config PWM_EP93XX
>>       tristate "Cirrus Logic EP93xx PWM support"
>>       depends on ARCH_EP93XX
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index ec50eb5b5a8f..dc7b1b82d47e 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_PWM_ATMEL_TCB)   += pwm-atmel-tcb.o
>>  obj-$(CONFIG_PWM_BCM_KONA)   += pwm-bcm-kona.o
>>  obj-$(CONFIG_PWM_BCM2835)    += pwm-bcm2835.o
>>  obj-$(CONFIG_PWM_BFIN)               += pwm-bfin.o
>> +obj-$(CONFIG_PWM_BRCMSTB)    += pwm-brcmstb.o
>>  obj-$(CONFIG_PWM_CLPS711X)   += pwm-clps711x.o
>>  obj-$(CONFIG_PWM_EP93XX)     += pwm-ep93xx.o
>>  obj-$(CONFIG_PWM_FSL_FTM)    += pwm-fsl-ftm.o
>> diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
>> new file mode 100644
>> index 000000000000..0c5cf5cbcf74
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-brcmstb.c
>> @@ -0,0 +1,323 @@
>> +/*
>> + * Broadcom BCM7038 PWM driver
>> + *
>> + * Copyright (C) 2015 Broadcom Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#define pr_fmt(fmt)  KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/export.h>
>> +#include <linux/clk.h>
>> +#include <linux/pwm.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>
> These should be alphabetically sorted.
>
>> +
>> +/* The block has a hardcoded number of 2 channels per controller */
>> +#define NUM_PWM_CHAN         2
>
> No need for the define here. You only use this value once, so having the
> literal at the place where it's needed prevents people from having to
> look the value up.
>
>> +
>> +/* This block is the "UPG" clock domain which is hardcoded a 27Mhz */
>> +#define PWM_DEFAULT_FREQ     27000000
>
> Do you really need this? Why not simply make the clocks property
> required and get rid of this fallback?

The block is fairly inflexible in the input frequency it uses, and is
always bundled within the same 27Mhz domain on chips, so having a
fallback for platform that do not have yet a proper clock provider is
both useful and desirable.

>
>> +
>> +#define PWM_CTRL             0x00
>> +#define  CTRL_START          BIT(0)
>> +#define  CTRL_OEB            BIT(1)
>> +#define  CTRL_FORCE_HIGH     BIT(2)
>> +#define  CTRL_OPENDRAIN              BIT(3)
>> +#define  CTRL_CHAN_OFFS              4
>> +
>> +#define PWM_CTRL2            0x04
>> +#define  CTRL2_OUT_SELECT    BIT(0)
>> +
>> +#define PWM_CWORD_MSB                0x08
>> +#define PWM_CWORD_LSB                0x0C
>> +
>> +#define PWM_CH_SIZE          0x8
>> +
>> +/* Number of bits for the CWORD value */
>> +#define CWORD_BIT_SIZE               16
>> +
>> +/* Maximum control word value allowed when variable-frequency PWM is used as a
>> + * clock for the constant-frequency PMW.
>> + */
>
> Proper block-comment style is:
>
>         /*
>          * ....
>          * ....
>          */
>
>> +#define CONST_VAR_F_MAX              32768
>> +#define CONST_VAR_F_MIN              1
>> +
>> +#define PWM_ON                       0x18
>> +#define  PWM_ON_MIN          1
>> +#define PWM_PERIOD           0x1C
>> +#define  PWM_PERIOD_MIN              0
>
> Have you considered parameterizing these for ease of use, like so:
>
>         #define PWM_ON(ch)      (0x18 + ((ch) * PWM_CH_SIZE))
>
> ?
>
>> +
>> +#define PWM_ON_PERIOD_MAX    0xff
>> +
>> +struct brcmstb_pwm_dev {
>> +     struct platform_device *pdev;
>
> This seems to be unused.
>
>> +     void __iomem *base;
>> +     struct clk *clk;
>> +     unsigned long rate;
>> +     struct pwm_chip chip;
>> +};
>> +
>> +static inline u32 pwm_readl(struct brcmstb_pwm_dev *p, u32 off)
>> +{
>> +     if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>
> The driver depends on ARCH_BRCMSTB which in turn depends on ARM, so this
> condition is always going to be false. and therefore the line below is
> dead code and should be removed.

I will update the Kconfig dependencies to include its MIPS counterpart
(arch/mips/bmips), thanks for catching that.

>
>> +             return __raw_readl(p->base + off);
>> +     else
>> +             return readl_relaxed(p->base + off);
>> +}
>> +
>> +static inline void pwm_writel(struct brcmstb_pwm_dev *p, u32 val, u32 off)
>> +{
>> +     if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>> +             __raw_writel(val, p->base + off);
>
> Same here.
>
>> +     else
>> +             writel_relaxed(val, p->base + off);
>> +}
>> +
>> +static inline struct brcmstb_pwm_dev *to_brcmstb_pwm(struct pwm_chip *ch)
>> +{
>> +     return container_of(ch, struct brcmstb_pwm_dev, chip);
>> +}
>> +
>> +/* Fv is derived from the variable frequency output. The variable frequency
>> + * output is configured using this formula:
>> + *
>> + * W = cword, if cword < 2 ^ 15 else 16-bit 2's complement of cword
>> + *
>> + * Fv = W x 2 ^ -16 x 27Mhz (reference clock)
>> + *
>> + * The period is: (period + 1) / Fv and "on" time is on / (period + 1)
>> + *
>> + * The PWM core framework specifies that the "duty_ns" parameter is in fact the
>> + * "on" time, so this translates directly into our HW programming here.
>> + */
>
> Again, should use proper block-comment style. There's more like that
> throughout the remainder of the code, please fix those too.

Fine...

>
>> +static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +                           int duty_ns, int period_ns)
>> +{
>> +     struct brcmstb_pwm_dev *b = to_brcmstb_pwm(chip);
>> +     unsigned long pc, dc, cword = CONST_VAR_F_MAX;
>> +     unsigned int ch = pwm->hwpwm;
>> +     bool done = false;
>> +     u64 val, rate, div;
>> +     u32 reg;
>> +
>> +     /* If asking for a duty_ns equal to period_ns, we need to substract
>> +      * the period value by 1 to make it shorter than the "on" time and
>> +      * produce a flat 100% duty cycle signal, and max out the "on" time
>> +      */
>> +     if (duty_ns == period_ns) {
>> +             dc = PWM_ON_PERIOD_MAX;
>> +             pc = PWM_ON_PERIOD_MAX - 1;
>> +             done = true;
>> +     }
>> +
>> +     while (!done) {
>
> This seems to be the same as the more intuitive:
>
>         if (duty_ns == period_ns) {
>                 ...
>         } else {
>                 ...
>         }
>
>> +             /* Calculate the base rate from base frequency and current
>> +              * cword
>> +              */
>> +             div = NSEC_PER_SEC;
>
> I don't think you need this. You can simply pass NSEC_PER_SEC directly
> where needed.
>
>> +             rate = (b->rate * (u64)cword);
>> +             rate = div64_u64(rate, 1 << CWORD_BIT_SIZE);
>> +
>> +             val = period_ns * rate;
>> +             pc = div64_u64(val, div);
>> +
>> +             val = (duty_ns + 1) * rate;
>> +             dc = div64_u64(val, div);
>
> In none of the above cases the divisor needs to be u64, so perhaps using
> div_u64() is better here? Or perhaps even do_div()?

True, but what's wrong with the current code, are you afraid this is
just going to take more cycles to perform the division?

>
>> +
>> +             /* We can be called with separate duty and period updates,
>> +              * so do not reject dc == 0 right away
>> +              */
>> +             if (pc == PWM_PERIOD_MIN ||
>> +                (dc < PWM_ON_MIN && duty_ns))
>> +                     return -EINVAL;
>> +
>> +             /* We converged on a calculation */
>> +             if (pc <= PWM_ON_PERIOD_MAX && dc <= PWM_ON_PERIOD_MAX)
>> +                     break;
>> +
>> +             /* The cword needs to be a power of 2 for the variable
>> +              * frequency generator to output a 50% duty cycle variable
>> +              * frequency which is used as input clock to the fixed
>> +              * frequency generator.
>> +              */
>> +             cword >>= 1;
>> +
>> +             /* Desired periods are too large, we do not have a divider
>> +              * for them
>> +              */
>> +             if (cword < CONST_VAR_F_MIN)
>> +                     return -EINVAL;
>> +     }
>> +
>> +     /* Configure the defined "cword" value to have the variable frequency
>> +      * generator output a base frequency for the constant frequency
>> +      * generator to derive from.
>> +      */
>> +     pwm_writel(b, cword >> 8, PWM_CWORD_MSB + ch * PWM_CH_SIZE);
>> +     pwm_writel(b, cword & 0xff, PWM_CWORD_LSB + ch * PWM_CH_SIZE);
>> +
>> +     /* Select constant frequency signal output */
>> +     reg = pwm_readl(b, PWM_CTRL2);
>> +     reg |= (CTRL2_OUT_SELECT << (ch * CTRL_CHAN_OFFS));
>> +     pwm_writel(b, reg, PWM_CTRL2);
>> +
>> +     /* Configure on and period value */
>> +     pwm_writel(b, pc, PWM_PERIOD + ch * PWM_CH_SIZE);
>> +     pwm_writel(b, dc, PWM_ON + ch * PWM_CH_SIZE);
>> +
>> +     return 0;
>> +}
>> +
>> +static inline void brcmstb_pwm_enable_set(struct brcmstb_pwm_dev *b,
>> +                                       unsigned int ch, bool enable)
>> +{
>> +     unsigned int ofs = ch * CTRL_CHAN_OFFS;
>> +     u32 reg;
>> +
>> +     reg = pwm_readl(b, PWM_CTRL);
>> +     if (enable) {
>> +             reg &= ~(CTRL_OEB << ofs);
>> +             reg |= ((CTRL_START | CTRL_OPENDRAIN) << ofs);
>> +     } else {
>> +             reg &= ~((CTRL_START | CTRL_OPENDRAIN) << ofs);
>> +             reg |= (CTRL_OEB << ofs);
>> +     }
>> +     pwm_writel(b, reg, PWM_CTRL);
>> +}
>> +
>> +static int brcmstb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     struct brcmstb_pwm_dev *b = to_brcmstb_pwm(chip);
>> +
>> +     brcmstb_pwm_enable_set(b, pwm->hwpwm, true);
>> +
>> +     return 0;
>> +}
>> +
>> +static void brcmstb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     struct brcmstb_pwm_dev *b = to_brcmstb_pwm(chip);
>> +
>> +     brcmstb_pwm_enable_set(b, pwm->hwpwm, false);
>> +}
>> +
>> +static const struct pwm_ops brcmstb_pwm_ops = {
>> +     .config         = brcmstb_pwm_config,
>> +     .enable         = brcmstb_pwm_enable,
>> +     .disable        = brcmstb_pwm_disable,
>> +     .owner          = THIS_MODULE,
>> +};
>
> No need for the artificial padding.
>
>> +
>> +static const struct of_device_id brcmstb_pwm_of_match[] = {
>> +     { .compatible = "brcm,bcm7038-pwm", .data = (void *)PWM_DEFAULT_FREQ },
>> +     { .compatible = "brcm,brcmstb-pwm", .data = (void *)PWM_DEFAULT_FREQ },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static int brcmstb_pwm_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *dn = pdev->dev.of_node;
>> +     const struct of_device_id *of_id;
>> +     struct brcmstb_pwm_dev *p;
>> +     struct resource *r;
>> +     int ret;
>> +
>> +     p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
>> +     if (!p)
>> +             return -ENOMEM;
>> +
>> +     of_id = of_match_node(brcmstb_pwm_of_match, dn);
>
> You use dn exactly once here, so I don't think the temporary variable
> gains you anything.

Ok, I will remove this.

>
>> +
>> +     /* Try to grab the clock and its rate, if not available, default
>> +      * to the base 27Mhz clock domain this block comes from.
>> +      */
>> +     p->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(p->clk)) {
>> +             p->clk = NULL;
>> +             p->rate = (unsigned long)of_id->data;
>> +     } else {
>> +             clk_prepare_enable(p->clk);
>> +             p->rate = clk_get_rate(p->clk);
>> +     }
>
> Like I said before, I think it'd be better to keep things simply and
> make the clock required so that you don't have to worry about hard-
> coding for the case where it isn't there.
>
>> +
>> +     platform_set_drvdata(pdev, p);
>> +
>> +     p->pdev = pdev;
>> +     p->chip.dev = &pdev->dev;
>> +     p->chip.ops = &brcmstb_pwm_ops;
>> +     /* Dynamically assign a PWM base */
>> +     p->chip.base = -1;
>> +     /* Static number of PWM channels for this controller */
>> +     p->chip.npwm = NUM_PWM_CHAN;
>> +     p->chip.of_xlate = of_pwm_xlate_with_flags;
>> +     p->chip.of_pwm_n_cells = 2;
>
> You don't strictly need these because the core will set these by
> default.
>
>> +     p->chip.can_sleep = true;
>> +
>> +     r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     p->base = devm_request_and_ioremap(&pdev->dev, r);
>> +     if (!p->base)
>
> What version of the kernel are you testing on? devm_ioremap_resource()
> was removed in v3.17. You should use devm_ioremap_resource().
>
>> +             return -ENOMEM;
>> +
>> +     ret = pwmchip_add(&p->chip);
>> +     if (ret)
>> +             dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
>> +     else
>> +             dev_info(&pdev->dev, "PWM driver %d channels\n", p->chip.npwm);
>
> No need to brag about successful probe. In general, only output messages
> in unexpected situations. Success to probe a device is expected, hence
> doesn't warrant a message in the kernel log.



>
>> +static int brcmstb_pwm_remove(struct platform_device *pdev)
>> +{
>> +     struct brcmstb_pwm_dev *p = platform_get_drvdata(pdev);
>> +
>> +     clk_disable_unprepare(p->clk);
>> +
>> +     return pwmchip_remove(&p->chip);
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int brcmstb_pwm_suspend(struct device *d)
>> +{
>> +     return 0;
>> +}
>> +
>> +static int brcmstb_pwm_resume(struct device *d)
>> +{
>> +     return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops,
>> +                      brcmstb_pwm_suspend, brcmstb_pwm_resume);
>
> Since these don't do anything, just remove them.
>
>> +static struct platform_driver brcmstb_pwm_driver = {
>> +     .probe  = brcmstb_pwm_probe,
>> +     .remove = brcmstb_pwm_remove,
>> +     .driver = {
>> +             .name   = "pwm-brcmstb",
>> +             .owner  = THIS_MODULE,
>
> No need to set this.
>
>> +             .of_match_table = brcmstb_pwm_of_match,
>> +             .pm     = &brcmstb_pwm_pm_ops,
>> +     },
>> +};
>
> And again, no need for the artificial padding.
>
>> +module_platform_driver(brcmstb_pwm_driver);
>> +
>> +MODULE_AUTHOR("Broadcom Corporation");
>
> I'm not a huge fan of this. This doesn't give me a point of contact that
> I can reach out to if I have any questions. If you must leave this in,
> please add a second MODULE_AUTHOR with your name and preferably email
> address.

Ok.
-- 
Florian
