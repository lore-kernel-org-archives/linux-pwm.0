From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v4 1/4] pwm: add CSR SiRFSoC PWM driver
Date: Tue, 25 Mar 2014 20:30:22 +0800
Message-ID: <CAGsJ_4yN3ng7cjUq0BOETksxBfxR1RqxBCjJz_nm0O5BFJgbNw@mail.gmail.com>
References: <1394013506-6246-1-git-send-email-21cnbao@gmail.com>
 <1394013506-6246-2-git-send-email-21cnbao@gmail.com> <20140318210315.GE5917@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40250 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbaCYMan (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Mar 2014 08:30:43 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so376316pde.29
        for <linux-pwm@vger.kernel.org>; Tue, 25 Mar 2014 05:30:42 -0700 (PDT)
In-Reply-To: <20140318210315.GE5917@mithrandir>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Huayi Li <Huayi.Li@csr.com>, Rongjun Ying <Rongjun.ying@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-03-19 5:03 GMT+08:00 Thierry Reding <thierry.reding@gmail.com>:
> On Wed, Mar 05, 2014 at 05:58:26PM +0800, Barry Song wrote:
>> From: Huayi Li <Huayi.Li@csr.com>
>>
>> PWM controller of CSR SiRFSoC can generate 7 independent outputs. Each output
>> duty cycle can be adjusted by setting the corresponding wait & hold registers.
>> There are 6 external channels (0 to 5) and 1 internal channel (6).
>> Supports a wide frequency range: the source clock divider can be from 2
>> up to 65536*2.
>
> This commit message is too wide. Please always wrap the commit message
> at 72 characters. See this for reference[0].
>
> [0]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> [...]
>> +config PWM_SIRF
>> +     tristate "SiRF PWM support"
>> +     depends on (ARCH_SIRF || COMPILE_TEST) && COMMON_CLK && OF
>
> I'd prefer these to be split into more lines for readability, like so:
>
>         depends on ARCH_SIRF || COMPILE_TEST
>         depends on COMMON_CLK
>         depends on OF

ok

>
>> diff --git a/drivers/pwm/pwm-sirf.c b/drivers/pwm/pwm-sirf.c
> [...]
>> + * Licensed under GPLv2.
>> + */
>> +#include <linux/kernel.h>
>
> Could use a blank line between the above two, visually separating the
> header comment from the list of include files.

ok.

>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/pwm.h>
>> +#include <linux/of.h>
>> +#include <linux/io.h>
>
> Also please keep these sorted alphabetically.
>
>> +struct sirf_pwm {
>> +     struct pwm_chip chip;
>
> There's a tab between pwm_chip and chip here. It should be a space.

ok

>
>> +     struct mutex mutex;
>> +     void __iomem *base;
>> +     struct clk *pwmc_clk;
>> +     /*  select OSC(26MHz) as clock source to generate PWM signals */
>> +     struct clk *sigsrc_clk;
>
> Maybe I'm missing something, but what in this driver is selecting the
> OSC as clock source?

it can select one of rtc(32KHz), osc(26MHz) and 3 plls in several
hundreds Hz. 26MHz is a fixed one which can generate a wide range of
pwm waves.
and the PWM also supports bypass, which can bypass the above five to
clock out directly.

>
>> +     unsigned long sigsrc_clk_rate;
>
> Why do you cache this value? Can't you simply query the clock framework
> for it when you need it?

since the freq is fixed, we cache it now. but we can drop the cache.

>
>> +static u32 sirf_pwm_ns_to_cycles(struct pwm_chip *chip, u32 time_ns)
>> +{
>> +     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>> +     u64 dividend;
>> +     u32 cycle;
>> +
>> +     dividend = (u64)spwm->sigsrc_clk_rate * time_ns + NSEC_PER_SEC / 2;
>> +     do_div(dividend, NSEC_PER_SEC);
>> +
>> +     cycle = dividend;
>> +
>> +     return cycle > 1 ? cycle : 1;
>> +}
>
> I think you can do without the cycle variable here.
right

>
>> +static int sirf_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +                     int duty_ns, int period_ns)
>
> Please always align the first argument on subsequent lines with the
> first argument on the first line.
ok

>
>> +{
>> +     u32 period_cycles, high_cycles, low_cycles;
>> +     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>> +
>> +     /* use OSC to generate PWM signals */
>> +     period_cycles = sirf_pwm_ns_to_cycles(chip, period_ns);
>
> Again, how is this OSC specific?

as above

>
>> +     if (period_cycles == 1)
>> +             return -EINVAL;
>> +
>> +     high_cycles = sirf_pwm_ns_to_cycles(chip, duty_ns);
>> +     low_cycles = period_cycles - high_cycles;
>> +
>> +     mutex_lock(&spwm->mutex);
>> +
>> +     if (high_cycles == period_cycles) {
>> +             high_cycles--;
>> +             low_cycles = 1;
>> +     }
>
> This perhaps could use a comment. Why is it that the hardware can't be
> programmed to high_cycles == period_cycles?

high=period means that is not a wave but a fixed high voltage level.

>
> Also since you're only accessing local variables here you can safely
> move this block out of the lock.
>
>> +static int sirf_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     struct sirf_pwm *spwm = to_sirf_pwm_chip(chip);
>> +     u32 val;
>> +
>> +     mutex_lock(&spwm->mutex);
>> +
>> +     /* disable preclock */
>> +     val = readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>> +     val &= ~(1 << pwm->hwpwm);
>> +     writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
>> +
>> +     /* select preclock source must after disable preclk*/
>
> Missing space between "preclk" and "*/".

will fix.

>
>> +     val = readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
>> +     val &= ~(0x1 << (BYPASS_MODE_BIT + pwm->hwpwm));
>> +     val &= ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
>
> Perhaps the source field is used to configure which clock is used? In
> that case I suggest you reshuffle the comments a bit. For example I
> think it would be clearer if you stated in the file's header comment
> that the driver currently only works if the OSC is used as the signal
> source clock and make a comment here that this selects OSC.

well. that is the plan for the 1st step.

>
> One thing that worries me slightly is that there's no way we can
> determine from a struct clk what clock it actually is. So it's
> impossible to derive from a struct clk that it is indeed the OSC and
> therefore this driver has no means to be extensible in the future.

we might extend, for example, using 32KHz as source, we can get a very
low frequency wave.

>
> But I have no idea how to solve this properly. Perhaps this would
> somehow need to be modeled within the clock framework?

since this pwm can also bypass, bypass is actually a clock out not a
pwm out. so hooking into clock framework might be good to do in the
next step

>
>> +static int sirf_pwm_probe(struct platform_device *pdev)
>> +{
>> +     struct sirf_pwm *spwm;
>> +     struct resource *mem_res;
>> +     int ret;
>> +
>> +     spwm = devm_kzalloc(&pdev->dev, sizeof(*spwm), GFP_KERNEL);
>> +     if (!spwm)
>> +             return -ENOMEM;
>> +
>> +     platform_set_drvdata(pdev, spwm);
>> +
>> +     mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     spwm->base = devm_ioremap_resource(&pdev->dev, mem_res);
>> +     if (!spwm->base)
>> +             return -ENOMEM;
>
> devm_ioremap_resource() returns an ERR_PTR() encoded error on failure,
> so the proper way to check for this is:
>
>         if (IS_ERR(spwm->base))
>                 return PTR_ERR(spwm->base);

real.

>
>> +     /*
>> +      * clock for PWM controller
>> +      */
>> +     spwm->pwmc_clk = devm_clk_get(&pdev->dev, "pwmc");
>
> I think you could drop the pwmc_ prefix, but I don't feel too strongly
> about that.

if there is no other clock as signal source, it is good. now there is
another one, that is why this clock get prefix.

>
>> +     if (IS_ERR(spwm->pwmc_clk)) {
>> +             dev_err(&pdev->dev, "failed to get PWM controller clock\n");
>> +             return PTR_ERR(spwm->pwmc_clk);
>> +     }
>> +
>> +     ret = clk_prepare_enable(spwm->pwmc_clk);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * clocks to generate PWM signals, we use OSC with 26MHz
>> +      */
>
> Only a single clock is requested here, so "clock to generate...". And
> again there's a reference to OSC and 26 MHz here, but the code is
> completely generic and it could in fact be any other clock.

right.

>
>> +     spwm->sigsrc_clk = devm_clk_get(&pdev->dev, "sigsrc0");
>> +     if (IS_ERR(spwm->sigsrc_clk)) {
>> +             dev_err(&pdev->dev, "failed to get PWM signal source clock0\n");
>> +             ret = PTR_ERR(spwm->sigsrc_clk);
>> +             goto err_src_clk;
>> +     }
>
> Why is this called "sigsrc0" if there's only one?

there are five, OSC is the first one in the HW index.

>
>> +     spwm->sigsrc_clk_rate = clk_get_rate(spwm->sigsrc_clk);
>
> I guess this could be no issue at all if sigsrc_clk indeed always is
> OSC, but caching the rate of the source clock is bad because it gives
> you no chance at all to adapt to clock rate changes later on (if that
> even happens). So in order not to set a bad example, I'd rather see this
> not cached, but queried when needed.

ok. understood.

>
>> +     spwm->chip.dev = &pdev->dev;
>> +     spwm->chip.ops = &sirf_pwm_ops;
>> +     spwm->chip.base = 0;
>
> I think you should want to set this to -1.

ok

>
>> +             dev_err(&pdev->dev, "failed to register PWM\n");
>
> "PWM chip", please.
>
ok

>> +static int sirf_pwm_remove(struct platform_device *pdev)
>> +{
>> +     struct sirf_pwm *spwm = platform_get_drvdata(pdev);
>> +
>> +     clk_disable_unprepare(spwm->pwmc_clk);
>> +     clk_disable_unprepare(spwm->sigsrc_clk);
>> +
>> +     return pwmchip_remove(&spwm->chip);
>> +}
>
> Don't you want to remove the chip first, before disabling all the
> clocks? pwmchip_remove() may end up accessing registers that need the
> clock enabled.

i will check this issue. it seems generally we disable hw before
removing SW to avoid SW get more events like interrupts.

>
>> +static int sirf_pwm_suspend(struct device *dev)
>> +{
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct sirf_pwm *spwm = platform_get_drvdata(pdev);
>> +
>> +     clk_disable_unprepare(spwm->pwmc_clk);
>> +
>> +     return 0;
>> +}
>
> Why doesn't this disable (and unprepare) the source clock?

we can have.
>
>> +static void sirf_pwm_config_restore(struct sirf_pwm *spwm)
>> +{
>> +     struct pwm_device *pwm;
>> +     int i;
>> +
>> +     for (i = 0; i < spwm->chip.npwm; i++) {
>> +             pwm = &spwm->chip.pwms[i];
>> +             /*
>> +              * while restoring from hibernation, state of pwm is enabled,
>
> pwm -> PWM, please.

ok

>
>> +static int sirf_pwm_restore(struct device *dev)
>> +{
>> +     struct sirf_pwm *spwm = dev_get_drvdata(dev);
>> +
>> +     /* back from hibernation, clock is already enabled */
>> +     sirf_pwm_config_restore(spwm);
>> +
>> +     return 0;
>> +}
>> +
>> +#else
>
> Gratuitous blank line above this one.

ok

>
>> +static struct platform_driver sirf_pwm_driver = {
>> +     .driver = {
>> +             .name = "sirf-pwm",
>> +             .pm = &sirf_pwm_pm_ops,
>> +             .of_match_table = sirf_pwm_of_match,
>> +     },
>> +     .probe = sirf_pwm_probe,
>> +     .remove = sirf_pwm_remove,
>> +};
>> +
>> +module_platform_driver(sirf_pwm_driver);
>
> Another gratuitous blank line above this one.
>
ok

> Thierry

-barry
