From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 1/5] pwm: add the Berlin pwm controller driver
Date: Mon, 10 Aug 2015 21:42:14 +0200
Message-ID: <55C8FE96.8080705@gmail.com>
References: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com> <1438248201-29222-2-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37617 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbbHJTmT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Aug 2015 15:42:19 -0400
In-Reply-To: <1438248201-29222-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>, thierry.reding@gmail.com
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On 30.07.2015 11:23, Antoine Tenart wrote:
> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> controller has 4 channels.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Antoine,

thanks for providing these patches, some comments below.

> ---
>   drivers/pwm/Kconfig      |   9 +++
>   drivers/pwm/Makefile     |   1 +
>   drivers/pwm/pwm-berlin.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 217 insertions(+)
>   create mode 100644 drivers/pwm/pwm-berlin.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f40fd8d..1773da8145b8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -92,6 +92,15 @@ config PWM_BCM2835
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-bcm2835.
>
> +config PWM_BERLIN
> +	tristate "Berlin PWM support"
> +	depends on ARCH_BERLIN
> +	help
> +	  PWM framework driver for Berlin.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-berlin.
> +
>   config PWM_BFIN
>   	tristate "Blackfin PWM support"
>   	depends on BFIN_GPTIMERS
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5b5a8f..670c5fce8bbb 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
>   obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
>   obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
>   obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
> +obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
>   obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
>   obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>   obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> new file mode 100644
> index 000000000000..786990c1c750
> --- /dev/null
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -0,0 +1,207 @@
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
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +
> +#define BERLIN_PWM_EN			0x0
> +#define BERLIN_PWM_CONTROL		0x4
> +#define BERLIN_PWM_DUTY			0x8
> +#define BERLIN_PWM_TCNT			0xc
> +
> +#define BERLIN_PWM_CLK_RATE		100000000
> +#define BERLIN_PWM_PRESCALE_MASK	0x7
> +#define BERLIN_PWM_PRESCALE_MAX		4096

As Jisheng already pointed out: please use a DT provided
input clock to the PWM driver.

> +
> +struct berlin_pwm_chip {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	spinlock_t lock;
> +};
> +
> +#define to_berlin_pwm_chip(chip)	\
> +	container_of((chip), struct berlin_pwm_chip, chip)
> +
> +#define berlin_pwm_readl(chip, channel, offset)		\
> +	readl((chip)->base + (channel) * 0x10 + offset)
> +#define berlin_pwm_writel(val, chip, channel, offset)	\
> +	writel(val, (chip)->base + (channel) * 0x10 + offset)

In contrast to Jisheng's comment about _relaxed() versions of
readl/writel, I don't really care much. Writing the PWM registers
is everything but timing critical, so I'd also accept the non-relaxed
versions here.

> +static const u32 prescaler_table[] = {
> +	1,
> +	4,
> +	8,
> +	16,
> +	64,
> +	256,
> +	1024,
> +	4096,
> +};
> +
> +static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     int duty_ns, int period_ns)
> +{
> +	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
> +	int prescale;
> +	u32 val, duty, period;
> +	u64 tmp;
> +
> +	for (prescale = 0; prescale < ARRAY_SIZE(prescaler_table); prescale++) {
> +		tmp = BERLIN_PWM_CLK_RATE;
> +		do_div(tmp, prescaler_table[prescale]);
> +		tmp *= period_ns;
> +		do_div(tmp, NSEC_PER_SEC);
> +
> +		if (tmp - 1 <= BERLIN_PWM_PRESCALE_MAX)
> +			break;
> +	}
> +
> +	if (tmp - 1 > BERLIN_PWM_PRESCALE_MAX)
> +		return -EINVAL;

Something about the </> BERLIN_PWM_PRESCALE_MAX above looks odd to me.
As soon as you multiply with period_ns you cannot compare against
BERLIN_PWM_PRESCALE_MAX anymore as you ignore that there also is a
TCNT register.

How about you calculate _absolute_ (i.e. w/ prescaler and tcnt) min
and max frequencies on probe or here in _config and bail out early
if requested rate is beyond that range. Then you can find the best
prescaler/tcnt combination with (open-coded):

static const u32 prescaler_diff_table[] = {
/*	1, 4, 8, 16, 64, 256, 1024, 4096 */
	1, 4, 2,  2,  4,   4,    4,    4,
};


u64 cycles;

// assume period_ns = 2500000 (2.5ms for 400Hz)
cycles = clk_get_rate(clk);   // cycles = 100000000 (100MHz)
cycles *= ns_period;          // cycles = 100000000 * 2500000
                               //        = 250 * 10^12
do_div(cycles, NSEC_PER_SEC)  // cycles = 250000

prescale = 0;
while (cycles > BERLIN_PWM_MAX_TCNT)
	do_div(cycles, prescaler_diff_table[++prescale]);

And so on...

Also, it would be nice to have the PWM output frequency
function written down in a comment, e.g.

/*
  * fOUT = fREF / PRESCALE / (TCNT+1)
  * or
  * TCNT = (fOUT * PRESCALE / fREF) - 1
  * and
  * DUTY = duty * TCNT
  */

or something more appropriate.

> +	period = tmp;
> +	tmp *= duty_ns;
> +	do_div(tmp, period_ns);
> +	duty = tmp;
> +
> +	spin_lock(&berlin_chip->lock);

AFAIKS, Jisheng is right about the spin_lock - if the pwm registers
are separate for the different channels you shouldn't need any spinlock
at all - BUT from Documentation/pwm.txt, I read:

"""
Currently the PWM core does not enforce any locking to pwm_enable(),
pwm_disable() and pwm_config(), so the calling context is currently
driver specific. This is an issue derived from the former barebone API
and should be fixed soon.
"""

So, as long as this is not fixed, I suggest to keep the spinlocks - or
wait for Thierry to rule about it.

> +	val = berlin_pwm_readl(berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
> +	val &= ~BERLIN_PWM_PRESCALE_MASK;
> +	val |= prescale;
> +	berlin_pwm_writel(val, berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	berlin_pwm_writel(duty, berlin_chip, pwm->hwpwm, BERLIN_PWM_DUTY);
> +	berlin_pwm_writel(period, berlin_chip, pwm->hwpwm, BERLIN_PWM_TCNT);

For the above calculations to make sense, you'll need the max allowed
TCNT/DUTY values. If you cannot derive them from any DS/BSP, you can try
to writel((u32)-1, TCNT) and read-back the result. Usually that should
give you the max allowed value for that register.

> +	spin_unlock(&berlin_chip->lock);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_set_polarity(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   enum pwm_polarity polarity)
> +{
> +	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
> +	u32 val;
> +
> +	spin_lock(&berlin_chip->lock);
> +
> +	val = berlin_pwm_readl(berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	if (polarity == PWM_POLARITY_NORMAL)
> +		val &= ~BIT(3);
> +	else
> +		val |= BIT(3);

Please use some meaningful name for BIT(3).

> +
> +	berlin_pwm_writel(val, berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	spin_unlock(&berlin_chip->lock);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
> +
> +	spin_lock(&berlin_chip->lock);
> +	berlin_pwm_writel(0x1, berlin_chip, pwm->hwpwm, BERLIN_PWM_EN);

ditto for 0x1 or BIT(0)

> +	spin_unlock(&berlin_chip->lock);
> +
> +	return 0;
> +}
> +
> +static void berlin_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
> +
> +	spin_lock(&berlin_chip->lock);
> +	berlin_pwm_writel(0x0, berlin_chip, pwm->hwpwm, BERLIN_PWM_EN);

ditto.

The rest looks fine to me.

Sebastian

> +	spin_unlock(&berlin_chip->lock);
> +}
> +
> +static const struct pwm_ops berlin_pwm_ops = {
> +	.config = berlin_pwm_config,
> +	.set_polarity = berlin_pwm_set_polarity,
> +	.enable = berlin_pwm_enable,
> +	.disable = berlin_pwm_disable,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct of_device_id berlin_pwm_match[] = {
> +	{ .compatible = "marvell,berlin-pwm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, berlin_pwm_match);
> +
> +static int berlin_pwm_probe(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm;
> +	struct resource *res;
> +	int ret;
> +
> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pwm->base))
> +		return PTR_ERR(pwm->base);
> +
> +	pwm->chip.dev = &pdev->dev;
> +	pwm->chip.ops = &berlin_pwm_ops;
> +	pwm->chip.base = -1;
> +	pwm->chip.npwm = 4;
> +	pwm->chip.can_sleep = true;
> +	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> +	pwm->chip.of_pwm_n_cells = 3;
> +
> +	spin_lock_init(&pwm->lock);
> +
> +	ret = pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_remove(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm = platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&pwm->chip);
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
