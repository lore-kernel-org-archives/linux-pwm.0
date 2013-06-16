Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Date: Sun, 16 Jun 2013 19:19:32 +0200
Message-ID: <1395589.x1LsEiFKi9@flatron>
In-Reply-To: <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

Hi Kukjin,

On Wednesday 05 of June 2013 23:18:13 Tomasz Figa wrote:
> This patch introduces new Samsung PWM driver, which uses Samsung
> PWM/timer master driver to control shared parts of the hardware.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-samsung.c | 528
> ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 529
> insertions(+)
>  create mode 100644 drivers/pwm/pwm-samsung.c

I you haven't yet merged this patch, please let me send v2 of this series, 
addressing Heiko's comments and adjustments to my understanding of the PWM 
hardware after getting access to SMDK6410 board, which uses PWM to control 
LCD backlight.

Best regards,
Tomasz

> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 229a599..833c3ac 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
>  obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
>  obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung-legacy.o
> +obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> new file mode 100644
> index 0000000..61bed3d
> --- /dev/null
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -0,0 +1,528 @@
> +/* drivers/pwm/pwm-samsung.c
> + *
> + * Copyright (c) 2007 Ben Dooks
> + * Copyright (c) 2008 Simtec Electronics
> + *     Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
> + * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
> + *
> + * PWM driver for Samsung SoCs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published
> by + * the Free Software Foundation; either version 2 of the License.
> +*/
> +
> +#include <linux/clk.h>
> +#include <linux/export.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/time.h>
> +
> +#include <clocksource/samsung_pwm.h>
> +
> +#define REG_TCFG0			0x00
> +#define REG_TCFG1			0x04
> +#define REG_TCON			0x08
> +
> +#define REG_TCNTB(tmr)			(0x0c + ((tmr) * 0xc))
> +#define REG_TCMPB(tmr)			(0x10 + ((tmr) * 0xc))
> +
> +#define TCFG0_PRESCALER_MASK		0xff
> +#define TCFG0_PRESCALER1_SHIFT		8
> +
> +#define TCFG1_MUX_MASK			0xf
> +#define TCFG1_SHIFT(x)			((x) * 4)
> +
> +#define TCON_START(chan)		(1 << (4 * (chan) + 0))
> +#define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
> +#define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
> +#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
> +
> +struct samsung_pwm_channel {
> +	unsigned long period_ns;
> +	unsigned long duty_ns;
> +	unsigned long tin_ns;
> +};
> +
> +struct samsung_pwm_chip {
> +	struct pwm_chip chip;
> +	struct samsung_pwm_variant variant;
> +	struct samsung_pwm_channel channels[SAMSUNG_PWM_NUM];
> +
> +	void __iomem *base;
> +	struct clk *base_clk;
> +	struct clk *tclk0;
> +	struct clk *tclk1;
> +};
> +#define to_samsung_pwm_chip(chip)	\
> +			container_of(chip, struct samsung_pwm_chip, chip)
> +
> +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> +static DEFINE_SPINLOCK(samsung_pwm_lock);
> +#endif
> +
> +static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
> +					unsigned int channel, u8 divisor)
> +{
> +	u8 shift = TCFG1_SHIFT(channel);
> +	unsigned long flags;
> +	u32 reg;
> +	u8 bits;
> +
> +	bits = (fls(divisor) - 1) - pwm->variant.div_base;
> +
> +	spin_lock_irqsave(&samsung_pwm_lock, flags);
> +
> +	reg = readl(pwm->base + REG_TCFG1);
> +	reg &= ~(TCFG1_MUX_MASK << shift);
> +	reg |= bits << shift;
> +	writel(reg, pwm->base + REG_TCFG1);
> +
> +	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> +}
> +
> +static inline int pwm_samsung_is_tdiv(struct samsung_pwm_chip *chip,
> +							unsigned int chan)
> +{
> +	struct samsung_pwm_variant *variant = &chip->variant;
> +	u32 reg;
> +
> +	reg = readl(chip->base + REG_TCFG1);
> +	reg >>= TCFG1_SHIFT(chan);
> +	reg &= TCFG1_MUX_MASK;
> +
> +	return ((1 << reg) & variant->tclk_mask) == 0;
> +}
> +
> +static unsigned long pwm_samsung_get_tin_rate(struct samsung_pwm_chip
> *chip, +							unsigned 
int chan)
> +{
> +	unsigned long rate;
> +	u32 reg;
> +
> +	rate = clk_get_rate(chip->base_clk);
> +
> +	reg = readl(chip->base + REG_TCFG0);
> +	if (chan >= 2)
> +		reg >>= TCFG0_PRESCALER1_SHIFT;
> +	reg &= TCFG0_PRESCALER_MASK;
> +
> +	return rate / (reg + 1);
> +}
> +
> +static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip
> *chip, +					unsigned int chan, 
unsigned long freq)
> +{
> +	struct samsung_pwm_variant *variant = &chip->variant;
> +	unsigned long rate;
> +	unsigned int div;
> +	struct clk *clk;
> +
> +	if (!pwm_samsung_is_tdiv(chip, chan)) {
> +		clk = (chan < 2) ? chip->tclk0 : chip->tclk1;
> +		if (!IS_ERR(clk)) {
> +			rate = clk_get_rate(clk);
> +			if (rate)
> +				return rate;
> +		}
> +
> +		dev_warn(chip->chip.dev,
> +			"tclk of PWM %d is inoperational, using tdiv\n", 
chan);
> +	}
> +
> +	rate = pwm_samsung_get_tin_rate(chip, chan);
> +	dev_dbg(chip->chip.dev, "tin parent at %lu\n", rate);
> +
> +	/*
> +	 * Compare minimum PWM frequency that can be achieved with 
possible
> +	 * divider settings and choose the lowest divisor that can 
generate
> +	 * frequencies lower than requested.
> +	 */
> +	for (div = variant->div_base; div < 4; ++div)
> +		if ((rate >> (variant->bits + div)) < freq)
> +			break;
> +
> +	pwm_samsung_set_divisor(chip, chan, 1 << div);
> +
> +	return rate >> div;
> +}
> +
> +static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device
> *pwm) +{
> +	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
> +
> +	if (our_chip->variant.output_mask & (1 << pwm->hwpwm))
> +		return 0;
> +
> +	dev_warn(our_chip->chip.dev,
> +			"tried to request PWM channel %d without 
output\n",
> +			pwm->hwpwm);
> +
> +	return -EINVAL;
> +}
> +
> +static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device
> *pwm) +{
> +	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
> +	unsigned int channel = pwm->hwpwm;
> +	unsigned long tcon;
> +	unsigned long flags;
> +
> +	if (channel > 0)
> +		++channel;
> +
> +	spin_lock_irqsave(&samsung_pwm_lock, flags);
> +
> +	tcon = __raw_readl(our_chip->base + REG_TCON);
> +
> +	tcon &= ~TCON_MANUALUPDATE(channel);
> +	tcon |= TCON_START(channel) | TCON_AUTORELOAD(channel);
> +
> +	__raw_writel(tcon, our_chip->base + REG_TCON);
> +
> +	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> +
> +	return 0;
> +}
> +
> +static void pwm_samsung_disable(struct pwm_chip *chip, struct
> pwm_device *pwm) +{
> +	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
> +	unsigned int channel = pwm->hwpwm;
> +	unsigned long tcon;
> +	unsigned long flags;
> +
> +	if (channel > 0)
> +		++channel;
> +
> +	spin_lock_irqsave(&samsung_pwm_lock, flags);
> +
> +	tcon = __raw_readl(our_chip->base + REG_TCON);
> +	tcon &= ~TCON_AUTORELOAD(channel);
> +	__raw_writel(tcon, our_chip->base + REG_TCON);
> +
> +	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> +}
> +
> +static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device
> *pwm, +		int duty_ns, int period_ns)
> +{
> +	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
> +	struct samsung_pwm_channel *chan = &our_chip->channels[pwm-
>hwpwm];
> +	unsigned long tin_ns = chan->tin_ns;
> +	unsigned int tcon_chan = pwm->hwpwm;
> +	unsigned long tin_rate;
> +	unsigned long period;
> +	unsigned long flags;
> +	unsigned long tcnt;
> +	long tcmp;
> +	u32 tcon;
> +
> +	/* We currently avoid using 64bit arithmetic by using the
> +	 * fact that anything faster than 1Hz is easily representable
> +	 * by 32bits. */
> +	if (period_ns > NSEC_PER_SEC || duty_ns > NSEC_PER_SEC)
> +		return -ERANGE;
> +
> +	if (period_ns == chan->period_ns && duty_ns == chan->duty_ns)
> +		return 0;
> +
> +	/* The TCMP and TCNT can be read without a lock, they're not
> +	 * shared between the timers. */
> +	tcmp = readl(our_chip->base + REG_TCMPB(pwm->hwpwm));
> +	tcnt = readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
> +
> +	period = NSEC_PER_SEC / period_ns;
> +
> +	dev_dbg(our_chip->chip.dev, "duty_ns=%d, period_ns=%d (%lu)\n",
> +		duty_ns, period_ns, period);
> +
> +	/* Check to see if we are changing the clock rate of the PWM */
> +	if (chan->period_ns != period_ns) {
> +		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, 
period);
> +
> +		chan->period_ns = period_ns;
> +
> +		dev_dbg(our_chip->chip.dev, "tin_rate=%lu\n", tin_rate);
> +
> +		tin_ns = NSEC_PER_SEC / tin_rate;
> +		tcnt = period_ns / tin_ns;
> +
> +		chan->tin_ns = tin_ns;
> +	}
> +
> +	/* Note, counters count down */
> +	tcmp = duty_ns / tin_ns;
> +	tcmp = tcnt - tcmp;
> +
> +	/* the pwm hw only checks the compare register after a decrement,
> +	   so the pin never toggles if tcmp = tcnt */
> +	if (tcmp == tcnt)
> +		tcmp--;
> +
> +	dev_dbg(our_chip->chip.dev, "tin_ns=%lu, tcmp=%ld/%lu\n",
> +							tin_ns, tcmp, 
tcnt);
> +
> +	if (tcmp < 0)
> +		tcmp = 0;
> +
> +	/* Update the PWM register block. */
> +	if (tcon_chan > 0)
> +		++tcon_chan;
> +
> +	spin_lock_irqsave(&samsung_pwm_lock, flags);
> +
> +	tcon = __raw_readl(our_chip->base + REG_TCON);
> +
> +	tcnt--;
> +
> +	tcon &= ~(TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan));
> +	tcon |= TCON_MANUALUPDATE(tcon_chan);
> +
> +	__raw_writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
> +	__raw_writel(tcmp, our_chip->base + REG_TCMPB(pwm->hwpwm));
> +	__raw_writel(tcon, our_chip->base + REG_TCON);
> +
> +	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int pwm_samsung_set_polarity(struct pwm_chip *chip,
> +			struct pwm_device *pwm, enum pwm_polarity 
polarity)
> +{
> +	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
> +	unsigned int channel = pwm->hwpwm;
> +	unsigned long flags;
> +	u32 tcon;
> +
> +	if (channel > 0)
> +		++channel;
> +
> +	spin_lock_irqsave(&samsung_pwm_lock, flags);
> +
> +	tcon = __raw_readl(our_chip->base + REG_TCON);
> +
> +	/* Invert in hardware means normal polarity of PWM core */
> +	if (polarity == PWM_POLARITY_NORMAL)
> +		tcon |= TCON_INVERT(channel);
> +	else
> +		tcon &= ~TCON_INVERT(channel);
> +
> +	__raw_writel(tcon, our_chip->base + REG_TCON);
> +
> +	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct pwm_ops pwm_samsung_ops = {
> +	.request	= pwm_samsung_request,
> +	.enable		= pwm_samsung_enable,
> +	.disable	= pwm_samsung_disable,
> +	.config		= pwm_samsung_config,
> +	.set_polarity	= pwm_samsung_set_polarity,
> +	.owner		= THIS_MODULE,
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct samsung_pwm_variant s3c24xx_variant = {
> +	.bits		= 16,
> +	.div_base	= 1,
> +	.has_tint_cstat	= false,
> +	.tclk_mask	= (1 << 4),
> +};
> +
> +static const struct samsung_pwm_variant s3c64xx_variant = {
> +	.bits		= 32,
> +	.div_base	= 0,
> +	.has_tint_cstat	= true,
> +	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
> +};
> +
> +static const struct samsung_pwm_variant s5p64x0_variant = {
> +	.bits		= 32,
> +	.div_base	= 0,
> +	.has_tint_cstat	= true,
> +	.tclk_mask	= 0,
> +};
> +
> +static const struct samsung_pwm_variant s5p_variant = {
> +	.bits		= 32,
> +	.div_base	= 0,
> +	.has_tint_cstat	= true,
> +	.tclk_mask	= (1 << 5),
> +};
> +
> +static const struct of_device_id samsung_pwm_matches[] = {
> +	{ .compatible = "samsung,s3c2410-pwm", .data = &s3c24xx_variant },
> +	{ .compatible = "samsung,s3c6400-pwm", .data = &s3c64xx_variant },
> +	{ .compatible = "samsung,s5p6440-pwm", .data = &s5p64x0_variant },
> +	{ .compatible = "samsung,s5pc100-pwm", .data = &s5p_variant },
> +	{ .compatible = "samsung,exynos4210-pwm", .data = &s5p64x0_variant 
},
> +	{},
> +};
> +#endif
> +
> +static int pwm_samsung_parse_dt(struct samsung_pwm_chip *chip)
> +{
> +	struct device_node *np = chip->chip.dev->of_node;
> +	const struct of_device_id *match;
> +	struct property *prop;
> +	const __be32 *cur;
> +	u32 val;
> +
> +	match = of_match_node(samsung_pwm_matches, np);
> +	if (!match)
> +		return -ENODEV;
> +
> +	memcpy(&chip->variant, match->data, sizeof(chip->variant));
> +
> +	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, 
val) {
> +		if (val >= SAMSUNG_PWM_NUM) {
> +			pr_warning("%s: invalid channel index in 
samsung,pwm-outputs
> property\n", +								
__func__);
> +			continue;
> +		}
> +		chip->variant.output_mask |= 1 << val;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pwm_samsung_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct samsung_pwm_chip *chip;
> +	struct resource *res;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (chip == NULL) {
> +		dev_err(dev, "failed to allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->chip.dev = &pdev->dev;
> +	chip->chip.ops = &pwm_samsung_ops;
> +	chip->chip.base = -1;
> +	chip->chip.npwm = SAMSUNG_PWM_NUM;
> +
> +	if (pdev->dev.of_node) {
> +		ret = pwm_samsung_parse_dt(chip);
> +		if (ret)
> +			return ret;
> +
> +		chip->chip.of_xlate = of_pwm_xlate_with_flags;
> +		chip->chip.of_pwm_n_cells = 3;
> +	} else {
> +		if (!pdev->dev.platform_data) {
> +			dev_err(&pdev->dev, "no platform data 
specified\n");
> +			return -EINVAL;
> +		}
> +
> +		memcpy(&chip->variant, pdev->dev.platform_data,
> +							sizeof(chip-
>variant));
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to get mem resource\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!chip->base) {
> +		dev_err(&pdev->dev, "failed to request and map 
registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->base_clk = devm_clk_get(&pdev->dev, "timers");
> +	if (IS_ERR(chip->base_clk)) {
> +		dev_err(dev, "failed to get timer base clk\n");
> +		return PTR_ERR(chip->base_clk);
> +	}
> +	clk_prepare_enable(chip->base_clk);
> +
> +	chip->tclk0 = devm_clk_get(&pdev->dev, "pwm-tclk0");
> +	chip->tclk1 = devm_clk_get(&pdev->dev, "pwm-tclk1");
> +
> +	ret = pwmchip_add(&chip->chip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register pwm\n");
> +		goto err_clk_disable;
> +	}
> +
> +	dev_info(dev, "base_clk at %lu, tclk0 at %lu, tclk1 at %lu\n",
> +		clk_get_rate(chip->base_clk),
> +		!IS_ERR(chip->tclk0) ? clk_get_rate(chip->tclk0) : 0,
> +		!IS_ERR(chip->tclk1) ? clk_get_rate(chip->tclk1) : 0);
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(chip->base_clk);
> +
> +	return ret;
> +}
> +
> +static int pwm_samsung_remove(struct platform_device *pdev)
> +{
> +	struct samsung_pwm_chip *chip = platform_get_drvdata(pdev);
> +	int err;
> +
> +	err = pwmchip_remove(&chip->chip);
> +	if (err < 0)
> +		return err;
> +
> +	clk_disable_unprepare(chip->base_clk);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int pwm_samsung_suspend(struct device *dev)
> +{
> +	struct samsung_pwm_chip *chip = dev_get_drvdata(dev);
> +	int i;
> +
> +	/* No one preserve these values during suspend so reset them
> +	 * Otherwise driver leaves PWM unconfigured if same values
> +	 * passed to pwm_config
> +	 */
> +	for (i = 0; i < SAMSUNG_PWM_NUM; ++i) {
> +		chip->channels[i].period_ns = 0;
> +		chip->channels[i].duty_ns = 0;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static struct dev_pm_ops pwm_samsung_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pwm_samsung_suspend, NULL)
> +};
> +
> +static struct platform_driver pwm_samsung_driver = {
> +	.driver		= {
> +		.name	= "samsung-pwm",
> +		.owner	= THIS_MODULE,
> +		.pm	= &pwm_samsung_pm_ops,
> +		.of_match_table = of_match_ptr(samsung_pwm_matches),
> +	},
> +	.probe		= pwm_samsung_probe,
> +	.remove		= pwm_samsung_remove,
> +};
> +module_platform_driver(pwm_samsung_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Tomasz Figa <tomasz.figa@gmail.com>");
> +MODULE_ALIAS("platform:samsung-pwm");
