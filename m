From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v4 1/5] pwm: add the Berlin pwm controller driver
Date: Tue, 18 Aug 2015 13:53:27 +0200
Message-ID: <55D31CB7.9030504@gmail.com>
References: <1439897888-10921-1-git-send-email-antoine.tenart@free-electrons.com> <1439897888-10921-2-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35554 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbbHRLyO (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Aug 2015 07:54:14 -0400
In-Reply-To: <1439897888-10921-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>, thierry.reding@gmail.com
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/18/2015 01:38 PM, Antoine Tenart wrote:
> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> controller has 4 channels.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
[...]
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> new file mode 100644
> index 000000000000..1bb3958b6e4f
> --- /dev/null
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -0,0 +1,218 @@
> +/*
> + * Marvell Berlin PWM driver
> + *
> + * Copyright (C) 2015 Marvell Technology Group Ltd.
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
[...]
> +
> +#define berlin_pwm_readl(chip, channel, offset)		\
> +	readl_relaxed((chip)->base + (channel) * 0x10 + offset)
> +#define berlin_pwm_writel(val, chip, channel, offset)	\
> +	writel_relaxed(val, (chip)->base + (channel) * 0x10 + offset)
> +
> +/* prescaler table: {1, 4, 8, 16, 64, 256, 1024, 4096} */
> +static const u32 prescaler_diff_table[] = {
> +	1, 4, 2, 2, 4, 4, 4, 4,
> +};
> +
> +static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm_dev,
> +			     int duty_ns, int period_ns)
> +{
> +	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
> +	int prescale = 0;
> +	u32 val, duty, period;
> +	u64 cycles;
> +
> +	cycles = clk_get_rate(pwm->clk);
> +	cycles *= period_ns;
> +	do_div(cycles, NSEC_PER_SEC);
> +
> +	while (cycles > BERLIN_PWM_MAX_TCNT)
> +		do_div(cycles, prescaler_diff_table[++prescale]);
> +
> +	if (cycles > BERLIN_PWM_MAX_TCNT)
> +		return -EINVAL;
> +
> +	period = cycles;
> +	cycles *= duty_ns;
> +	do_div(cycles, period_ns);
> +	duty = cycles;
> +
> +	spin_lock(&pwm->lock);
> +
> +	val = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> +	val &= ~BERLIN_PWM_PRESCALE_MASK;
> +	val |= prescale;
> +	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	berlin_pwm_writel(duty, pwm, pwm_dev->hwpwm, BERLIN_PWM_DUTY);
> +	berlin_pwm_writel(period, pwm, pwm_dev->hwpwm, BERLIN_PWM_TCNT);

The reason why I usually tend to _not_ use _relaxed() in low-performance
setup code is that you'll have to think about reordering issues when
using _relaxed ones.

The question here is: Is it _guaranteed_ that above writel_relaxed()
will be issued _before_ actually releasing the spin_lock?

> +	spin_unlock(&pwm->lock);
> +
> +	return 0;
> +}
[...]
> +static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm_dev)
> +{
> +	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
> +
> +	spin_lock(&pwm->lock);
> +	berlin_pwm_writel(BERLIN_PWM_ENABLE, pwm, pwm_dev->hwpwm,
> +			  BERLIN_PWM_EN);

Please use the same read-modify-write sequence as below for disable.

> +	spin_unlock(&pwm->lock);
> +
> +	return 0;
> +}
> +
> +static void berlin_pwm_disable(struct pwm_chip *chip,
> +			       struct pwm_device *pwm_dev)
> +{
> +	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
> +	u32 val;
> +
> +	spin_lock(&pwm->lock);
> +
> +	val = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_EN);
> +	val &= ~BERLIN_PWM_ENABLE;
> +	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_EN);
> +
> +	spin_unlock(&pwm->lock);
> +}
[...]
> +static int berlin_pwm_remove(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(pwm->clk);
> +	return pwmchip_remove(&pwm->chip);

You _have_ to first call pwmchip_remove() and then
clk_disable_unprepare().

Sebastian

> +}
> +
> +static struct platform_driver berlin_pwm_driver = {
> +	.probe	= berlin_pwm_probe,
> +	.remove	= berlin_pwm_remove,
> +	.driver	= {
> +		.name	= "berlin-pwm",
> +		.of_match_table = berlin_pwm_match,
> +	},
> +};
> +module_platform_driver(berlin_pwm_driver);
> +
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
> +MODULE_DESCRIPTION("Marvell Berlin PWM driver");
> +MODULE_LICENSE("GPL v2");
>
