From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Fri, 28 Feb 2014 22:13:34 +0800
Message-ID: <CAGsJ_4wcmTEa0F=ELFCqF-MrRzuabYRTR-uctwCXqUJ7gdWRjw@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
 <lel46f$q2d$1@ger.gmane.org> <CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
 <CAMiSF3CczVV+Ob++_ACcwE+OXvFH8f9v1E=Q1F5x7Zz1BjCCzg@mail.gmail.com>
 <CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
 <CAMiSF3CN33N867TtjatYx1EwaV5qJY=JYsSrVFpQvC+yS1T5rA@mail.gmail.com>
 <CAGsJ_4z_48pZcXJXkwyuujoq=cEF3Oov5_GBRtHHOufMdEpRGA@mail.gmail.com>
 <CAGsJ_4yqznr4BAHdk5Hjm1X8BAsiWhMUSTRnriLvykVJ8-8dKw@mail.gmail.com> <CAMiSF3BFMpp4-LKdKouwmP6ca6nEQvu27LNGU6dAW4BX-dez=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38584 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbaB1ON4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2014 09:13:56 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so801993pab.21
        for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2014 06:13:56 -0800 (PST)
In-Reply-To: <CAMiSF3BFMpp4-LKdKouwmP6ca6nEQvu27LNGU6dAW4BX-dez=g@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2014-02-28 21:36 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
> 2014-02-28 11:33 GMT+01:00 Barry Song <21cnbao@gmail.com>:
>>
>> let's have a draft to look whether this is making anything better:
>>
>> /*
>>  * SIRF serial SoC PWM device core driver
>>  *
>>  * Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group company.
>>  *
>>  * Licensed under GPLv2.
>>  */
>> #include <linux/kernel.h>
>> #include <linux/init.h>
>> #include <linux/module.h>
>> #include <linux/device.h>
>> #include <linux/platform_device.h>
>> #include <linux/clk.h>
>> #include <linux/delay.h>
>> #include <linux/pwm.h>
>> #include <linux/of.h>
>> #include <linux/io.h>
>>
>> #define SIRF_PWM_SELECT_PRECLK            0x0
>> #define SIRF_PWM_OE                0x4
>> #define SIRF_PWM_ENABLE_PRECLOCK        0x8
>> #define SIRF_PWM_ENABLE_POSTCLOCK        0xC
>> #define SIRF_PWM_GET_WAIT_OFFSET(n)        (0x10 + 0x8*n)
>> #define SIRF_PWM_GET_HOLD_OFFSET(n)        (0x14 + 0x8*n)
>>
>> #define SIRF_PWM_TR_STEP(n)            (0x48 + 0x8*n)
>> #define SIRF_PWM_STEP_HOLD(n)            (0x4c + 0x8*n)
>>
> Missing spaces around *
>
>
>> #define SRC_FIELD_SIZE                3
>> #define BYPASS_MODE_BIT                21
>> #define TRANS_MODE_SELECT_BIT            7
>>
>> struct sirf_pwm {
>>     struct pwm_chip    chip;
>>     struct mutex mutex;
>>     void __iomem *base;
>>     struct clk *pwmc_clk;
>>     struct clk *sigsrc0_clk;
>>     struct clk *sigsrc3_clk;
>>     /*
>>      * PWM controller uses OSC(default 26MHz) or RTC(default 32768Hz) clock
>>      * to generate PWM signals instead of the clock of the controller
>>      */
>>     unsigned long sigsrc0_clk_rate;
>>     unsigned long sigsrc3_clk_rate;
>> };
>>
>> static inline struct sirf_pwm *to_sirf_pwm_chip(struct pwm_chip *chip)
>> {
>>     return container_of(chip, struct sirf_pwm, chip);
>> }
>>
>> static u32 sirf_pwm_ns_to_cycles(struct pwm_chip *chip, u32 time_ns)
>> {
>>     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>>     u64 dividend;
>>     u32 cycle;
>>
>>     dividend = (u64)spwm->sigsrc0_clk_rate * time_ns + NSEC_PER_SEC / 2;
>>     do_div(dividend, NSEC_PER_SEC);
>>
>>     cycle = dividend;
>>
>>     return cycle > 1 ? cycle : 1;
>> }
>>
>> static int sirf_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>             int duty_ns, int period_ns)
>> {
>>     u32 period_cycles, high_cycles, low_cycles;
>>     u32 val;
>>     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>>     if (unlikely(period_ns == NSEC_PER_SEC/spwm->sigsrc3_clk_rate)) {
>>         /*
>>          * sigsrc 3 is RTC with typical frequency 32KHz,
>>          * bypass RTC clock to WiFi/Bluetooth module
>>          */
>
> This means that only a single, precise period is recognized as triggering
> this clock rate, and as the clock is precisely specified in Hz, we will not
> have a very definite value: the period will be 30517,578 ns, which gives a
> rounded value of 30518, but a truncated value of 30517. Here, it is the
> truncated value that needs to be used.

well. but i am thinking the client of PWM wants to call the function
by a predefined MACRO "NSEC_PER_SEC / freq" if it thinks it is calling
PWM.
that makes non-accurate value even more readable.

>
>>         mutex_lock(&spwm->mutex);
>>
>>         val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>>         val |= 0x1 << (BYPASS_MODE_BIT + pwm->hwpwm);
>>         val &= ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
>>         val |= 3 << (SRC_FIELD_SIZE * pwm->hwpwm);
>>         writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
>>
>>         mutex_unlock(&spwm->mutex);
>>     } else {
>>         /* use OSC to generate PWM signals */
>>         period_cycles = sirf_pwm_ns_to_cycles(chip, period_ns);
>>         if (period_cycles == 1)
>>             return -EINVAL;
>>
> But if we allow the bypass mode, we could continue here if the error
> rate is good. The conversion function does not give this information,
> so we can't continue.

personally, i am ok. if PWM guys don't object, i support. if I am a
PWM guy, i will not like it too. and if you see the original V3, and
comments from PWM guys, you will find that.
when we think again and carefully, don't you think "bypass" is
something belong to clock subsystem but not PWM subsystem? if we do
care about frequency without duty, it is something in clock subsystem
not PWM subsystem.

i think what we can make everything clear is making the channel clocks
become clock nodes of the whole clock tree, the node can be requested
by a non-PWM device and PWM-channel through clk_get. if someone wants
a clock, get it from clock subsystem, and the PWM channel here can
request the clock as well. but i don't have plan to do that for the
moment.

>
>>         high_cycles = sirf_pwm_ns_to_cycles(chip, duty_ns);
>>         low_cycles = period_cycles - high_cycles;
>>
>>         mutex_lock(&spwm->mutex);
>>
>>         val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>>         val &= ~(0x1 << (BYPASS_MODE_BIT + pwm->hwpwm));
>>         val &= ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
>>         writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
>>
>>         if (high_cycles == period_cycles) {
>>             high_cycles--;
>>             low_cycles = 1;
>>         }
>>
>>         writel(high_cycles - 1,
>>             spwm->base + SIRF_PWM_GET_WAIT_OFFSET(pwm->hwpwm));
>>         writel(low_cycles - 1,
>>             spwm->base + SIRF_PWM_GET_HOLD_OFFSET(pwm->hwpwm));
>>
>>         mutex_unlock(&spwm->mutex);
>>     }
>>
>>     return 0;
>> }
>>
>> static int sirf_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> {
>>     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>>     u32 val;
>>
>>     mutex_lock(&spwm->mutex);
>>
>>     /* disable preclock */
>>     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>>     val &= ~(1 << pwm->hwpwm);
>>     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>>
>>     /* select preclock source must after disable preclk*/
>
>     /* The preclock source must be configured only when disabled */
>
>>     val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>>     val &= ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
>>     writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
>
> Here, we clear the value set in sirf_pwm_config if it is not 0. We are
> losing the information set in sirf_pwm_config!!! Do we even need to
> touch it here, or should this code be in the configuration function?

yes, you are right. sorry for misoperating the register.
it is just a quick draft to show the result of our discussion as i
think we need the source codes to continue.

>
>>     /* wait for some time */
>>     usleep_range(100, 100);
>>
> Checkpatch does not like this.

it does dislike. checkpatch dislikes min=max.

>
>>     /* enable preclock */
>>     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>>     val |= (1 << pwm->hwpwm);
>>     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>>
>>     /* enable post clock*/
>>     val = readl(spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>>     val |= (1 << pwm->hwpwm);
>>     writel(val, spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>>
>>     /* enable output */
>>     val = readl(spwm->base + SIRF_PWM_OE);
>>     val |= 1 << pwm->hwpwm;
>>     val |= 1 << (pwm->hwpwm + TRANS_MODE_SELECT_BIT);
>>
>>     writel(val, spwm->base + SIRF_PWM_OE);
>>
>>     mutex_unlock(&spwm->mutex);
>>
>>     return 0;
>> }
>>
>> static void sirf_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>> {
>>     u32 val;
>>     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>>
>>     mutex_lock(&spwm->mutex);
>>
>>     /* disable output */
>>     val = readl(spwm->base + SIRF_PWM_OE);
>>     val &= ~(1 << pwm->hwpwm);
>>     writel(val, spwm->base + SIRF_PWM_OE);
>>
>>     /* disable postclock */
>>     val = readl(spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>>     val &= ~(1 << pwm->hwpwm);
>>     writel(val, spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>>
>>     /* disable preclock */
>>     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>>     val &= ~(1 << pwm->hwpwm);
>>     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>>
>>     mutex_unlock(&spwm->mutex);
>> }
>>
>> static const struct pwm_ops sirf_pwm_ops = {
>>     .enable = sirf_pwm_enable,
>>     .disable = sirf_pwm_disable,
>>     .config = sirf_pwm_config,
>>     .owner = THIS_MODULE,
>> };
>>
>> static int sirf_pwm_probe(struct platform_device *pdev)
>> {
>>     struct sirf_pwm *spwm;
>>     struct resource *mem_res;
>>     int ret;
>>
>>     spwm = devm_kzalloc(&pdev->dev, sizeof(*spwm),
>>             GFP_KERNEL);
>>     if (!spwm)
>>         return -ENOMEM;
>>
>>     platform_set_drvdata(pdev, spwm);
>>
>>     mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>     spwm->base = devm_ioremap_resource(&pdev->dev, mem_res);
>>     if (!spwm->base)
>>         return -ENOMEM;
>>
>>     /*
>>      * clock for PWM controller
>>      */
>>     spwm->pwmc_clk = devm_clk_get(&pdev->dev, "pwmc");
>>     if (IS_ERR(spwm->pwmc_clk)) {
>>         dev_err(&pdev->dev, "failed to get PWM controller clock\n");
>>         return PTR_ERR(spwm->pwmc_clk);
>>     }
>>
>>     ret = clk_prepare_enable(spwm->pwmc_clk);
>>     if (ret)
>>         return ret;
>>
>>     /*
>>      * clocks to generate PWM signals
>>      */
>>     spwm->sigsrc0_clk = devm_clk_get(&pdev->dev, "sigsrc0");
>>     if (IS_ERR(spwm->sigsrc0_clk)) {
>>         dev_err(&pdev->dev, "failed to get PWM signal source clock0\n");
>>         ret = PTR_ERR(spwm->sigsrc0_clk);
>>         goto err_src0_clk;
>>     }
>>
>>     ret = clk_prepare_enable(spwm->sigsrc0_clk);
>>     if (ret)
>>         goto err_src0_clk;
>>
>>     spwm->sigsrc0_clk_rate = clk_get_rate(spwm->sigsrc0_clk);
>>
>>     spwm->sigsrc3_clk = devm_clk_get(&pdev->dev, "sigsrc3");
>>     if (IS_ERR(spwm->sigsrc3_clk)) {
>>         dev_err(&pdev->dev, "failed to get PWM signal source clock3\n");
>>         ret = PTR_ERR(spwm->sigsrc3_clk);
>>         goto err_src3_clk;
>>     }
>>
>>     ret = clk_prepare_enable(spwm->sigsrc3_clk);
>>     if (ret)
>>         goto err_src3_clk;
>>
>>     spwm->sigsrc3_clk_rate = clk_get_rate(spwm->sigsrc3_clk);
>>
> So in the end, you require both functional clocks 0 & 3 to be specified
> in the device tree. And if any of them is not specified, you refuse to
> load the driver.

yes. i prefer both the bypass mode for 32KHz and PWM mode from 26MHz
as 32KHz should be built-in even though i think bypass mode is not a
thing of PWM. but it is the quickest way for the moment to continue
and not break other things.

-barry
