From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Fri, 28 Feb 2014 14:36:31 +0100
Message-ID: <CAMiSF3BFMpp4-LKdKouwmP6ca6nEQvu27LNGU6dAW4BX-dez=g@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
	<lel46f$q2d$1@ger.gmane.org>
	<CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
	<CAMiSF3CczVV+Ob++_ACcwE+OXvFH8f9v1E=Q1F5x7Zz1BjCCzg@mail.gmail.com>
	<CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
	<CAMiSF3CN33N867TtjatYx1EwaV5qJY=JYsSrVFpQvC+yS1T5rA@mail.gmail.com>
	<CAGsJ_4z_48pZcXJXkwyuujoq=cEF3Oov5_GBRtHHOufMdEpRGA@mail.gmail.com>
	<CAGsJ_4yqznr4BAHdk5Hjm1X8BAsiWhMUSTRnriLvykVJ8-8dKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34442 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbaB1Ngd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2014 08:36:33 -0500
Received: by mail-wi0-f177.google.com with SMTP id r20so597876wiv.10
        for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2014 05:36:31 -0800 (PST)
In-Reply-To: <CAGsJ_4yqznr4BAHdk5Hjm1X8BAsiWhMUSTRnriLvykVJ8-8dKw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2014-02-28 11:33 GMT+01:00 Barry Song <21cnbao@gmail.com>:
>
> let's have a draft to look whether this is making anything better:
>
> /*
>  * SIRF serial SoC PWM device core driver
>  *
>  * Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group company.
>  *
>  * Licensed under GPLv2.
>  */
> #include <linux/kernel.h>
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/device.h>
> #include <linux/platform_device.h>
> #include <linux/clk.h>
> #include <linux/delay.h>
> #include <linux/pwm.h>
> #include <linux/of.h>
> #include <linux/io.h>
>
> #define SIRF_PWM_SELECT_PRECLK            0x0
> #define SIRF_PWM_OE                0x4
> #define SIRF_PWM_ENABLE_PRECLOCK        0x8
> #define SIRF_PWM_ENABLE_POSTCLOCK        0xC
> #define SIRF_PWM_GET_WAIT_OFFSET(n)        (0x10 + 0x8*n)
> #define SIRF_PWM_GET_HOLD_OFFSET(n)        (0x14 + 0x8*n)
>
> #define SIRF_PWM_TR_STEP(n)            (0x48 + 0x8*n)
> #define SIRF_PWM_STEP_HOLD(n)            (0x4c + 0x8*n)
>
Missing spaces around *


> #define SRC_FIELD_SIZE                3
> #define BYPASS_MODE_BIT                21
> #define TRANS_MODE_SELECT_BIT            7
>
> struct sirf_pwm {
>     struct pwm_chip    chip;
>     struct mutex mutex;
>     void __iomem *base;
>     struct clk *pwmc_clk;
>     struct clk *sigsrc0_clk;
>     struct clk *sigsrc3_clk;
>     /*
>      * PWM controller uses OSC(default 26MHz) or RTC(default 32768Hz) clock
>      * to generate PWM signals instead of the clock of the controller
>      */
>     unsigned long sigsrc0_clk_rate;
>     unsigned long sigsrc3_clk_rate;
> };
>
> static inline struct sirf_pwm *to_sirf_pwm_chip(struct pwm_chip *chip)
> {
>     return container_of(chip, struct sirf_pwm, chip);
> }
>
> static u32 sirf_pwm_ns_to_cycles(struct pwm_chip *chip, u32 time_ns)
> {
>     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>     u64 dividend;
>     u32 cycle;
>
>     dividend = (u64)spwm->sigsrc0_clk_rate * time_ns + NSEC_PER_SEC / 2;
>     do_div(dividend, NSEC_PER_SEC);
>
>     cycle = dividend;
>
>     return cycle > 1 ? cycle : 1;
> }
>
> static int sirf_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>             int duty_ns, int period_ns)
> {
>     u32 period_cycles, high_cycles, low_cycles;
>     u32 val;
>     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>     if (unlikely(period_ns == NSEC_PER_SEC/spwm->sigsrc3_clk_rate)) {
>         /*
>          * sigsrc 3 is RTC with typical frequency 32KHz,
>          * bypass RTC clock to WiFi/Bluetooth module
>          */

This means that only a single, precise period is recognized as triggering
this clock rate, and as the clock is precisely specified in Hz, we will not
have a very definite value: the period will be 30517,578 ns, which gives a
rounded value of 30518, but a truncated value of 30517. Here, it is the
truncated value that needs to be used.

>         mutex_lock(&spwm->mutex);
>
>         val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>         val |= 0x1 << (BYPASS_MODE_BIT + pwm->hwpwm);
>         val &= ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
>         val |= 3 << (SRC_FIELD_SIZE * pwm->hwpwm);
>         writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
>
>         mutex_unlock(&spwm->mutex);
>     } else {
>         /* use OSC to generate PWM signals */
>         period_cycles = sirf_pwm_ns_to_cycles(chip, period_ns);
>         if (period_cycles == 1)
>             return -EINVAL;
>
But if we allow the bypass mode, we could continue here if the error
rate is good. The conversion function does not give this information,
so we can't continue.

>         high_cycles = sirf_pwm_ns_to_cycles(chip, duty_ns);
>         low_cycles = period_cycles - high_cycles;
>
>         mutex_lock(&spwm->mutex);
>
>         val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>         val &= ~(0x1 << (BYPASS_MODE_BIT + pwm->hwpwm));
>         val &= ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
>         writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
>
>         if (high_cycles == period_cycles) {
>             high_cycles--;
>             low_cycles = 1;
>         }
>
>         writel(high_cycles - 1,
>             spwm->base + SIRF_PWM_GET_WAIT_OFFSET(pwm->hwpwm));
>         writel(low_cycles - 1,
>             spwm->base + SIRF_PWM_GET_HOLD_OFFSET(pwm->hwpwm));
>
>         mutex_unlock(&spwm->mutex);
>     }
>
>     return 0;
> }
>
> static int sirf_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> {
>     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>     u32 val;
>
>     mutex_lock(&spwm->mutex);
>
>     /* disable preclock */
>     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>     val &= ~(1 << pwm->hwpwm);
>     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>
>     /* select preclock source must after disable preclk*/

    /* The preclock source must be configured only when disabled */

>     val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>     val &= ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
>     writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);

Here, we clear the value set in sirf_pwm_config if it is not 0. We are
losing the information set in sirf_pwm_config!!! Do we even need to
touch it here, or should this code be in the configuration function?

>     /* wait for some time */
>     usleep_range(100, 100);
>
Checkpatch does not like this.

>     /* enable preclock */
>     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>     val |= (1 << pwm->hwpwm);
>     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>
>     /* enable post clock*/
>     val = readl(spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>     val |= (1 << pwm->hwpwm);
>     writel(val, spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>
>     /* enable output */
>     val = readl(spwm->base + SIRF_PWM_OE);
>     val |= 1 << pwm->hwpwm;
>     val |= 1 << (pwm->hwpwm + TRANS_MODE_SELECT_BIT);
>
>     writel(val, spwm->base + SIRF_PWM_OE);
>
>     mutex_unlock(&spwm->mutex);
>
>     return 0;
> }
>
> static void sirf_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> {
>     u32 val;
>     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>
>     mutex_lock(&spwm->mutex);
>
>     /* disable output */
>     val = readl(spwm->base + SIRF_PWM_OE);
>     val &= ~(1 << pwm->hwpwm);
>     writel(val, spwm->base + SIRF_PWM_OE);
>
>     /* disable postclock */
>     val = readl(spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>     val &= ~(1 << pwm->hwpwm);
>     writel(val, spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>
>     /* disable preclock */
>     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>     val &= ~(1 << pwm->hwpwm);
>     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>
>     mutex_unlock(&spwm->mutex);
> }
>
> static const struct pwm_ops sirf_pwm_ops = {
>     .enable = sirf_pwm_enable,
>     .disable = sirf_pwm_disable,
>     .config = sirf_pwm_config,
>     .owner = THIS_MODULE,
> };
>
> static int sirf_pwm_probe(struct platform_device *pdev)
> {
>     struct sirf_pwm *spwm;
>     struct resource *mem_res;
>     int ret;
>
>     spwm = devm_kzalloc(&pdev->dev, sizeof(*spwm),
>             GFP_KERNEL);
>     if (!spwm)
>         return -ENOMEM;
>
>     platform_set_drvdata(pdev, spwm);
>
>     mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>     spwm->base = devm_ioremap_resource(&pdev->dev, mem_res);
>     if (!spwm->base)
>         return -ENOMEM;
>
>     /*
>      * clock for PWM controller
>      */
>     spwm->pwmc_clk = devm_clk_get(&pdev->dev, "pwmc");
>     if (IS_ERR(spwm->pwmc_clk)) {
>         dev_err(&pdev->dev, "failed to get PWM controller clock\n");
>         return PTR_ERR(spwm->pwmc_clk);
>     }
>
>     ret = clk_prepare_enable(spwm->pwmc_clk);
>     if (ret)
>         return ret;
>
>     /*
>      * clocks to generate PWM signals
>      */
>     spwm->sigsrc0_clk = devm_clk_get(&pdev->dev, "sigsrc0");
>     if (IS_ERR(spwm->sigsrc0_clk)) {
>         dev_err(&pdev->dev, "failed to get PWM signal source clock0\n");
>         ret = PTR_ERR(spwm->sigsrc0_clk);
>         goto err_src0_clk;
>     }
>
>     ret = clk_prepare_enable(spwm->sigsrc0_clk);
>     if (ret)
>         goto err_src0_clk;
>
>     spwm->sigsrc0_clk_rate = clk_get_rate(spwm->sigsrc0_clk);
>
>     spwm->sigsrc3_clk = devm_clk_get(&pdev->dev, "sigsrc3");
>     if (IS_ERR(spwm->sigsrc3_clk)) {
>         dev_err(&pdev->dev, "failed to get PWM signal source clock3\n");
>         ret = PTR_ERR(spwm->sigsrc3_clk);
>         goto err_src3_clk;
>     }
>
>     ret = clk_prepare_enable(spwm->sigsrc3_clk);
>     if (ret)
>         goto err_src3_clk;
>
>     spwm->sigsrc3_clk_rate = clk_get_rate(spwm->sigsrc3_clk);
>
So in the end, you require both functional clocks 0 & 3 to be specified
in the device tree. And if any of them is not specified, you refuse to
load the driver.

>     spwm->chip.dev = &pdev->dev;
>     spwm->chip.ops = &sirf_pwm_ops;
>     spwm->chip.base = 0;
>     spwm->chip.npwm = 7;
>
>     mutex_init(&spwm->mutex);
>
>     ret = pwmchip_add(&spwm->chip);
>     if (ret < 0) {
>         dev_err(&pdev->dev, "failed to register PWM\n");
>         goto err_pwmadd;
>     }
>
>     return 0;
>
> err_pwmadd:
>     clk_disable_unprepare(spwm->sigsrc3_clk);
> err_src3_clk:
>     clk_disable_unprepare(spwm->sigsrc0_clk);
> err_src0_clk:
>     clk_disable_unprepare(spwm->pwmc_clk);
>
>     return ret;
> }
>
> static int sirf_pwm_remove(struct platform_device *pdev)
> {
>     struct sirf_pwm *spwm = platform_get_drvdata(pdev);
>
>     clk_disable_unprepare(spwm->pwmc_clk);
>     clk_disable_unprepare(spwm->sigsrc0_clk);
>     clk_disable_unprepare(spwm->sigsrc3_clk);
>
>     return pwmchip_remove(&spwm->chip);
> }
>
> #ifdef CONFIG_PM_SLEEP
> static int sirf_pwm_suspend(struct device *dev)
> {
>     struct platform_device *pdev = to_platform_device(dev);
>     struct sirf_pwm *spwm = platform_get_drvdata(pdev);
>
>     clk_disable_unprepare(spwm->pwmc_clk);
>
>     return 0;
> }
>
> static void sirf_pwm_config_restore(struct sirf_pwm *spwm)
> {
>     struct pwm_device *pwm;
>     int i;
>
>     for (i = 0; i < spwm->chip.npwm; i++) {
>         pwm = &spwm->chip.pwms[i];
>         /*
>          * while restoring from hibernation, state of pwm is enabled,
>          * but PWM hardware is not re-enabled
>          */
>         if (test_bit(PWMF_REQUESTED, &pwm->flags) &&
>             test_bit(PWMF_ENABLED, &pwm->flags))
>             sirf_pwm_enable(&spwm->chip, pwm);
>     }
> }
>
> static int sirf_pwm_resume(struct device *dev)
> {
>     struct sirf_pwm *spwm = dev_get_drvdata(dev);
>
>     clk_prepare_enable(spwm->pwmc_clk);
>
>     sirf_pwm_config_restore(spwm);
>
>     return 0;
> }
>
> static int sirf_pwm_restore(struct device *dev)
> {
>     struct sirf_pwm *spwm = dev_get_drvdata(dev);
>
>     /* back from hibernation, clock is already enabled */
>     sirf_pwm_config_restore(spwm);
>
>     return 0;
> }
>
> #else
> #define sirf_pwm_resume NULL
> #define sirf_pwm_suspend NULL
> #define sirf_pwm_restore NULL
> #endif
>
> static const struct dev_pm_ops sirf_pwm_pm_ops = {
>     .suspend = sirf_pwm_suspend,
>     .resume = sirf_pwm_resume,
>     .restore = sirf_pwm_restore,
> };
>
> static const struct of_device_id sirf_pwm_of_match[] = {
>     { .compatible = "sirf,prima2-pwm", },
>     {}
> };
> MODULE_DEVICE_TABLE(of, sirf_pwm_of_match);
>
> static struct platform_driver sirf_pwm_driver = {
>     .driver = {
>         .name = "sirf-pwm",
>         .pm = &sirf_pwm_pm_ops,
>         .of_match_table = sirf_pwm_of_match,
>     },
>     .probe = sirf_pwm_probe,
>     .remove = sirf_pwm_remove,
> };
>
> module_platform_driver(sirf_pwm_driver);
>
> MODULE_DESCRIPTION("SIRF serial SoC PWM device core driver");
> MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
> MODULE_AUTHOR("Huayi Li <huayi.li@csr.com>");
> MODULE_LICENSE("GPL v2");
