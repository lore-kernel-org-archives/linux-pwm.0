From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Thu, 27 Feb 2014 00:01:26 +0800
Message-ID: <CAGsJ_4yNZuW6cZapjAg0YN=o4dE37qMWWyTYQ_bincaPYTWcZA@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com> <20140226141039.GD29779@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:41868 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaBZQBq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 11:01:46 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so1154670pad.3
        for <linux-pwm@vger.kernel.org>; Wed, 26 Feb 2014 08:01:46 -0800 (PST)
In-Reply-To: <20140226141039.GD29779@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Arnd Bergmann <arnd@arndb.de>, Rongjun Ying <Rongjun.ying@csr.com>, Huayi Li <Huayi.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-02-26 22:10 GMT+08:00 Thierry Reding <thierry.reding@gmail.com>:
> On Sat, Feb 08, 2014 at 06:23:22PM +0800, Barry Song wrote:
>> From: Rongjun Ying <Rongjun.ying@csr.com>
>>
>> PWM controller of CSR SiRFSoC can generate 7 independent outputs. Each output
>
> "The PWM controller of the CSR SiRFSoC..." and "Each output's..."
>
>> duty cycle can be adjusted by setting the corresponding wait & hold registers.
>>
>> Supports 7 independent channel output: 6 for external(channel0-5) and 1 for
>> internal(channel6).
>
> This repeats part of the first sentence. Perhaps:
>
>         There are 6 external channels (0 to 5) and 1 internal channel (6).
>
> ?
>
>> Supports wide frequency range: divide by 2 to 65536*2 of source clock.
>
> "Supports a wide frequency range: the source clock divider can be from 2
> up to 65536*2".

well. this was copied from datasheet :-)

>
>>  Documentation/devicetree/bindings/pwm/pwm-sirf.txt |   17 +
>>  arch/arm/boot/dts/atlas6.dtsi                      |    3 +-
>>  arch/arm/boot/dts/prima2.dtsi                      |    3 +-
>>  drivers/pwm/Kconfig                                |    9 +
>>  drivers/pwm/Makefile                               |    1 +
>>  drivers/pwm/pwm-sirf.c                             |  308 ++++++++++++++++++++
>>  6 files changed, 339 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>>  create mode 100644 drivers/pwm/pwm-sirf.c
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sirf.txt b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>> new file mode 100644
>> index 0000000..4b10109
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>> @@ -0,0 +1,17 @@
>> +SiRF prima2 & atlas6 PWM drivers
>> +
>> +Required properties:
>> +- compatible: "sirf,prima2-pwm"
>> +- reg: physical base address and length of the controller's registers
>> +- #pwm-cells: should be 2.  The first cell specifies the per-chip index
>> +  of the PWM to use and the second cell is the period in nanoseconds.
>> +- clocks: from common clock binding: the 1st clock is for PWM controller
>> +  the 2nd clock is the source to generate PWM waves
>> +
>> +Example:
>> +pwm: pwm@b0130000 {
>> +     compatible = "sirf,prima2-pwm";
>> +     #pwm-cells = <2>;
>> +     reg = <0xb0130000 0x10000>;
>> +     clocks = <&clks 21>, <&clks 1>;
>> +};
>
> Please move this into a separate patch and Cc the device tree bindings
> maintainers. There's nothing non-standard in this binding as far as I
> can tell, but I'd still like to give them an opportunity to object.

ok.

>
> Also you should be documenting the clock-names property here as well.

ok.

>
>> diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
>> index f8674bc..5a09815 100644
>> --- a/arch/arm/boot/dts/atlas6.dtsi
>> +++ b/arch/arm/boot/dts/atlas6.dtsi
>> @@ -614,8 +614,9 @@
>>
>>                       pwm@b0130000 {
>>                               compatible = "sirf,prima2-pwm";
>> +                             #pwm-cells = <2>;
>>                               reg = <0xb0130000 0x10000>;
>> -                             clocks = <&clks 21>;
>> +                             clocks = <&clks 21>, <&clks 1>;
>>                       };
>>
>>                       efusesys@b0140000 {
>> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
>> index 0e21993..3439e48 100644
>> --- a/arch/arm/boot/dts/prima2.dtsi
>> +++ b/arch/arm/boot/dts/prima2.dtsi
>> @@ -642,8 +642,9 @@
>>
>>                       pwm@b0130000 {
>>                               compatible = "sirf,prima2-pwm";
>> +                             #pwm-cells = <2>;
>>                               reg = <0xb0130000 0x10000>;
>> -                             clocks = <&clks 21>;
>> +                             clocks = <&clks 21>, <&clks 1>;
>>                       };
>>
>>                       efusesys@b0140000 {
>
> These changes need to go into separate patches and go in through the
> arm-soc tree.

ok. i will include this in my tree with your ack after you give and
send pull-request including this one, hoping before the 3.15 merge
window.

>
>> diff --git a/drivers/pwm/pwm-sirf.c b/drivers/pwm/pwm-sirf.c
>> new file mode 100644
>> index 0000000..b717de0
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-sirf.c
>> @@ -0,0 +1,308 @@
>> +/*
>> + * SIRF serial SoC PWM device core driver
>> + *
>> + * Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
> [...]
>> +#define SIRF_PWM_CHL_NUM                     7
>
> This is only used in a single location with a well-known meaning, so no
> need to use a symbolic name.

ok. so you prefer: "spwm->chip.npwm = 7;" ?

>
>> +#define SIRF_PWM_BLS_GRP_NUM                 16
>
> This isn't used as far as I can tell.
>

real.

>> +struct sirf_pwm {
>> +     void __iomem            *base;
>> +     struct clk              *clk;
>> +     struct pwm_chip         chip;
>> +     unsigned long           src_clk_rate;
>> +};
>
> Please drop the alignment of the structure field. Also perhaps move the
> chip field to be the first, so that the upcasting below can be turned
> into a noop.
>

this and all other indentation, whitespace, inline and u32  etc. are ok to me.

>> +#define to_sirf_chip(chip)   container_of(chip, struct sirf_pwm, chip)
>
> Please make this a static inline function.


>
>> +
>> +static unsigned int sirf_pwm_ns_to_cycles(struct pwm_chip *chip, unsigned int time_ns)
>
> Please wrap this to go on a single line.
>
>> +{
>> +     struct sirf_pwm *spwm = to_sirf_chip(chip);
>> +     u64 dividend;
>> +     unsigned int cycle;
>> +
>> +     dividend = spwm->src_clk_rate * time_ns + NSEC_PER_SEC / 2;
>> +     do_div(dividend, NSEC_PER_SEC);
>> +
>> +     cycle = dividend & 0xFFFFFFFFUL;
>
> I don't think you need the mask, since you're casting to a 32-bit
> unsigned integer anyway.
>
>> +
>> +     return cycle > 1 ? cycle : 1;
>> +}
>> +
>> +static int sirf_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +             int duty_ns, int period_ns)
>
> Please align arguments on subsequent lines with those of the first.
>
>> +{
>> +     unsigned int period_cycles, high_cycles, low_cycles;
>> +     unsigned int val;
>
> u32 please.
>
>> +     struct sirf_pwm *spwm = to_sirf_chip(chip);
>> +
>> +     period_cycles = sirf_pwm_ns_to_cycles(chip, period_ns);
>> +
>> +     high_cycles = sirf_pwm_ns_to_cycles(chip, duty_ns);
>
> No need for the blank line above, since there's no blank line below
> either.
>
>> +     low_cycles = period_cycles - high_cycles;
>
>> +
>> +     if (period_cycles == 1) {
>> +             /* bypass mode */
>> +             val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>> +             val |= 0x1 << (BYPASS_MODE_BIT + pwm->hwpwm);
>> +             writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
>> +             dev_warn(chip->dev, "period is too short!\n");
>
> What does the bypass mode do? Would it perhaps be better to make this an
> outright error rather than only warning about it?

it means the clock can not serve the pwm (freq,duty) requirement, so
move to a "workaround" frequency.
but this can be dropped and return error code.

>
>> +     } else {
>> +             /* divider mode */
>> +             val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>> +             val &= ~(0x1 << (BYPASS_MODE_BIT + pwm->hwpwm));
>> +             writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
>> +
>> +             if (high_cycles == period_cycles) {
>> +                     high_cycles--;
>> +                     low_cycles = 1;
>> +             }
>> +
>> +             writel(high_cycles, spwm->base + SIRF_PWM_GET_WAIT_OFFSET(pwm->hwpwm));
>> +             writel(low_cycles, spwm->base + SIRF_PWM_GET_HOLD_OFFSET(pwm->hwpwm));
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int sirf_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     struct sirf_pwm *spwm = to_sirf_chip(chip);
>> +     unsigned int val;
>
> The type used by readl() and writel() is u32.
>
>> +     /* disable preclock */
>> +     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>> +     val &= ~(1 << pwm->hwpwm);
>> +     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>> +
>> +     /* select preclock source must after disable preclk*/
>> +     val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>> +     val &= ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
>> +     writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
>> +     /* wait for some time */
>> +     udelay(100);
>
> usleep_range() perhaps?
>
>> +static void sirf_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     unsigned int val;
>
> u32 again.
>
>> +     struct sirf_pwm *spwm = to_sirf_chip(chip);
>> +     /* disable output */
>
> Blank line between the above two, please.
>
>> +     val = readl(spwm->base + SIRF_PWM_OE);
>> +     val &= ~(1 << pwm->hwpwm);
>> +     writel(val, spwm->base + SIRF_PWM_OE);
>> +
>> +     /* disable postclock */
>> +     val = readl(spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>> +     val &= ~(1 << pwm->hwpwm);
>> +     writel(val, spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
>> +
>> +     /* disable preclock */
>> +     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>> +     val &= ~(1 << pwm->hwpwm);
>> +     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>
> I think you need a lock to synchronize accesses to these registers.
>
>> +}
>> +
>> +static struct pwm_ops sirf_pwm_ops = {
>
> static const please.
>
>> +     .enable = sirf_pwm_enable,
>> +     .disable = sirf_pwm_disable,
>> +     .config = sirf_pwm_config,
>> +     .owner = THIS_MODULE,
>> +};
>> +
>> +static int sirf_pwm_probe(struct platform_device *pdev)
>> +{
>> +     struct sirf_pwm *spwm;
>> +     struct resource *mem_res;
>> +     struct clk *clk_pwm_src;
>> +     int ret;
>> +
>> +     spwm = devm_kzalloc(&pdev->dev, sizeof(struct sirf_pwm),
>> +                     GFP_KERNEL);
>
> "sizeof(*spwm)", please. And the above fits on a single line, no need to
> wrap them.
>
>> +     if (!spwm)
>> +             return -ENOMEM;
>> +
>> +     platform_set_drvdata(pdev, spwm);
>> +
>> +     mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     spwm->base = devm_ioremap_resource(&pdev->dev, mem_res);
>> +     if (!spwm->base)
>> +             return -ENOMEM;
>> +
>> +     /*
>> +      * the 1st clock is for PWM controller
>> +      */
>> +     spwm->clk = of_clk_get(pdev->dev.of_node, 0);
>
> Use a clock-names property and devm_clk_get() here, please.
>
>> +     if (IS_ERR(spwm->clk)) {
>> +             dev_err(&pdev->dev, "Get PWM controller clock failed.\n");
>
> "failed to get PWM controller clock"?
>
>> +             return PTR_ERR(spwm->clk);
>> +     }
>> +     clk_prepare_enable(spwm->clk);
>
> Space between the above two. Also you need to check the return value of
> clk_prepare_enable().
>
>> +
>> +     /*
>> +      * the 2nd clock is the source to generate PWM waves
>
> I'd prefer "signals" over "waves".
>
>> +      * it is the OSC on SiRFSoC
>
> The clock is configurable via DT, so this isn't necessarily true. Even
> if all hardware in existence currently works that way, it isn't a given
> to remain like that forever.

the current consideration is that it is something SoC specific, the
clock source is an OSC with fixed frequency 26MHz. but if we look pwm
as a IP module, it is better to look this clock as a normal clock as
you said.

>
>> +      */
>> +     clk_pwm_src = of_clk_get(pdev->dev.of_node, 1);
>> +     if (IS_ERR(clk_pwm_src)) {
>> +             dev_err(&pdev->dev, "Get PWM source clock failed.\n");
>
> "failed to get PWM source clock"?
>
>> +             return PTR_ERR(clk_pwm_src);
>> +     }
>> +     spwm->src_clk_rate = clk_get_rate(clk_pwm_src);
>
> Space between the above two please.
>
>> +     clk_put(clk_pwm_src);
>
> Why drop the reference to it here? Shouldn't you keep it around and even
> call clk_prepare_enable() on it to make sure it's actually on?

same with above.

>
>> +
>> +     spwm->chip.dev = &pdev->dev;
>> +     spwm->chip.ops = &sirf_pwm_ops;
>> +     spwm->chip.base = 0;
>> +     spwm->chip.npwm = SIRF_PWM_CHL_NUM;
>> +
>> +     ret = pwmchip_add(&spwm->chip);
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "failed to register pwm\n");
>
> "PWM" please.
>
>> +             clk_disable_unprepare(spwm->clk);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int sirf_pwm_remove(struct platform_device *pdev)
>> +{
>> +     struct sirf_pwm *spwm = platform_get_drvdata(pdev);
>> +     clk_disable_unprepare(spwm->clk);
>
> I'd prefer a blank line between the two above.
>
>> +     clk_put(spwm->clk);
>> +
>> +     pwmchip_remove(&spwm->chip);
>> +     return 0;
>
> This should be "return pwmchip_remove(...);".
>
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int sirf_pwm_suspend(struct device *dev)
>> +{
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct sirf_pwm *spwm = platform_get_drvdata(pdev);
>> +
>> +     clk_disable_unprepare(spwm->clk);
>> +
>> +     return 0;
>> +}
>> +
>> +static void sirf_pwm_config_restore(struct sirf_pwm *spwm)
>> +{
>> +     struct pwm_device *pwm;
>> +     int i;
>> +
>> +     for (i = 0; i < spwm->chip.npwm; i++) {
>> +             pwm = &spwm->chip.pwms[i];
>> +             /*
>> +              * while restoring from hibernation, state of pwm is enabled,
>> +              * but PWM hardware is not re-enabled
>> +              */
>> +             if (test_bit(PWMF_REQUESTED, &pwm->flags) &&
>> +                  test_bit(PWMF_ENABLED, &pwm->flags))
>
> Indentation is off by one space here.
>
>> +                     sirf_pwm_enable(&spwm->chip, pwm);
>> +     }
>> +}
>> +
>> +static int sirf_pwm_resume(struct device *dev)
>> +{
>> +     struct sirf_pwm *spwm = dev_get_drvdata(dev);
>> +
>> +     clk_prepare_enable(spwm->clk);
>> +
>> +     sirf_pwm_config_restore(spwm);
>> +
>> +     return 0;
>> +}
>> +
>> +static int sirf_pwm_restore(struct device *dev)
>> +{
>> +     struct sirf_pwm *spwm = dev_get_drvdata(dev);
>> +
>> +     /* back from hibernation, clock is already enabled */
>> +     sirf_pwm_config_restore(spwm);
>
> Why is the clock already enabled? Shouldn't it be off until this driver
> enables it?

this issue is special. the PWM is not disabled during hibernation. it
is not like a normal device because user-experiences want to keep the
LCD light during the produre of hibernation and before the final
shutdown. it is something similar with commit 1dea1fd0:

https://git.kernel.org/cgit/linux/kernel/git/baohua/linux.git/commit/?id=1dea1fd09246ada581a99d0669108eea94b7bfee

>
>> +
>> +     return 0;
>> +}
>> +
>> +#else
>> +#define sirf_pwm_resume NULL
>> +#define sirf_pwm_suspend NULL
>> +#define sirf_pwm_restore NULL
>> +#endif
>> +
>> +static const struct dev_pm_ops sirf_pwm_pm_ops = {
>> +     .suspend = sirf_pwm_suspend,
>> +     .resume = sirf_pwm_resume,
>> +     .restore = sirf_pwm_restore,
>> +};
>
> Because if you can unify _resume and _restore, this could all be
> simplified using SIMPLE_DEV_PM_OPS().

it seems not real. suspend to ram, lcd light is off, during suspend to
disk, lcd is on before the final shutdown.

>
>> +
>> +static const struct of_device_id sirf_pwm_of_match[] = {
>> +     { .compatible = "sirf,prima2-pwm", },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, sirf_pwm_of_match);
>> +
>> +static struct platform_driver sirf_pwm_driver = {
>> +     .driver = {
>> +             .name = "prima2-pwm",
>
> "sirf-pwm"?
>
>> +             .owner = THIS_MODULE,
>
> This is no longer necessary.
>
>> +             .pm = &sirf_pwm_pm_ops,
>> +             .of_match_table = sirf_pwm_of_match,
>> +     },
>> +     .probe = sirf_pwm_probe,
>> +     .remove = sirf_pwm_remove,
>> +};
>> +
>> +module_platform_driver(sirf_pwm_driver);
>> +
>> +MODULE_DESCRIPTION("SIRF serial SoC PWM device core driver");
>> +MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>, "
>> +     "Huayi Li <huayi.li@csr.com>");
>
> These could simply be two separate MODULE_AUTHOR() entries.

ok.

>
>> +MODULE_LICENSE("GPL v2");
>
> The file header says GPL v2 or later, which would be "GPL". "GPL v2" is
> GPL v2 only.
>
-barry
