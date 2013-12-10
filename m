From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [RFCv2 endianess 1/4] pwm: Add Freescale FTM PWM driver support
Date: Tue, 10 Dec 2013 05:10:01 +0000
Message-ID: <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
 <1386309134-1822-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386309134-1822-2-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "matt.porter@linaro.org" <matt.porter@linaro.org>, "Huan.Wang@freescale.com" <Huan.Wang@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi Mark, Therry,

Is this series of patches ok about endianess fix?

Here I add one boolen big-endian property.

--
Thanks,


> The FTM PWM device can be found on Vybrid VF610 Tower and Layerscape LS-1
> SoCs.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-fsl-ftm.c | 422
> ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 433 insertions(+)
>  create mode 100644 drivers/pwm/pwm-fsl-ftm.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> eece329..c77c571 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -71,6 +71,16 @@ config PWM_EP93XX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ep93xx.
> 
> +config PWM_FSL_FTM
> +	tristate "Freescale FlexTimer Module (FTM) PWM support"
> +	depends on OF
> +	help
> +	  Generic FTM PWM framework driver for Freescale VF610 and
> +	  Layerscape LS-1 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-fsl-ftm.
> +
>  config PWM_IMX
>  	tristate "i.MX PWM support"
>  	depends on ARCH_MXC
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> 8b754e4..9029a12 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
>  obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
>  obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
>  obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
> +obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>  obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c new file
> mode 100644 index 0000000..33df2f9
> --- /dev/null
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -0,0 +1,422 @@
> +/*
> + *  Freescale FlexTimer Module (FTM) PWM Driver
> + *
> + *  Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define FTM_SC	0x00
> +#define FTM_SC_CLK_MASK	0x3
> +#define FTM_SC_CLK_SHIFT	3
> +#define FTM_SC_CLK_SYS	(0x1 << FTM_SC_CLK_SHIFT)
> +#define FTM_SC_CLK_FIX	(0x2 << FTM_SC_CLK_SHIFT)
> +#define FTM_SC_CLK_EXT	(0x3 << FTM_SC_CLK_SHIFT)
> +#define FTM_SC_PS_MASK	0x7
> +#define FTM_SC_PS_SHIFT	0
> +
> +#define FTM_CNT		0x04
> +#define FTM_MOD		0x08
> +
> +#define FTM_CSC_BASE	0x0C
> +#define FTM_CSC_MSB	BIT(5)
> +#define FTM_CSC_MSA	BIT(4)
> +#define FTM_CSC_ELSB	BIT(3)
> +#define FTM_CSC_ELSA	BIT(2)
> +#define FTM_CSC(_channel)	(FTM_CSC_BASE + ((_channel) * 8))
> +
> +#define FTM_CV_BASE	0x10
> +#define FTM_CV(_channel)	(FTM_CV_BASE + ((_channel) * 8))
> +
> +#define FTM_CNTIN	0x4C
> +#define FTM_STATUS	0x50
> +
> +#define FTM_MODE	0x54
> +#define FTM_MODE_FTMEN	BIT(0)
> +#define FTM_MODE_INIT	BIT(2)
> +#define FTM_MODE_PWMSYNC	BIT(3)
> +
> +#define FTM_SYNC	0x58
> +#define FTM_OUTINIT	0x5C
> +#define FTM_OUTMASK	0x60
> +#define FTM_COMBINE	0x64
> +#define FTM_DEADTIME	0x68
> +#define FTM_EXTTRIG	0x6C
> +#define FTM_POL		0x70
> +#define FTM_FMS		0x74
> +#define FTM_FILTER	0x78
> +#define FTM_FLTCTRL	0x7C
> +#define FTM_QDCTRL	0x80
> +#define FTM_CONF	0x84
> +#define FTM_FLTPOL	0x88
> +#define FTM_SYNCONF	0x8C
> +#define FTM_INVCTRL	0x90
> +#define FTM_SWOCTRL	0x94
> +#define FTM_PWMLOAD	0x98
> +
> +enum {
> +	FSL_PWM_SYS_CLK,
> +	FSL_PWM_EXT_CLK,
> +	FSL_PWM_FIX_CLK,
> +};
> +
> +struct fsl_pwm_chip {
> +	struct pwm_chip chip;
> +
> +	struct mutex lock;
> +
> +	struct clk *sys_clk;
> +	struct clk *counter_clk;
> +	unsigned int counter_clk_select;
> +	unsigned int counter_clk_enable;
> +	unsigned int clk_ps;
> +
> +	void __iomem *base;
> +
> +	int period_ns;
> +	int big_endian;
> +};
> +
> +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> +		const void __iomem *addr)
> +{
> +	if (likely(fpc->big_endian))
> +		return ioread32be(addr);
> +	else
> +		return readl(addr);
> +}
> +
> +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
> +		u32 val, void __iomem *addr)
> +{
> +	if (likely(fpc->big_endian))
> +		iowrite32be(val, addr);
> +	else
> +		writel(val, addr);
> +}
> +
> +static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip) {
> +	return container_of(chip, struct fsl_pwm_chip, chip); }
> +
> +static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> +
> +	return clk_prepare_enable(fpc->sys_clk); }
> +
> +static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> +
> +	clk_disable_unprepare(fpc->sys_clk);
> +}
> +
> +static unsigned long fsl_rate_to_cycles(struct fsl_pwm_chip *fpc,
> +				       unsigned long time_ns)
> +{
> +	unsigned long long c;
> +	unsigned long ps = 1 << fpc->clk_ps;
> +
> +	c = clk_get_rate(fpc->counter_clk);
> +	c = c * time_ns;
> +	do_div(c, 1000000000UL);
> +	do_div(c, ps);
> +
> +	return (unsigned long)c;
> +}
> +
> +static int fsl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  int duty_ns, int period_ns)
> +{
> +	unsigned long period, duty;
> +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> +
> +	mutex_lock(&fpc->lock);
> +	if (fpc->period_ns && fpc->period_ns != period_ns) {
> +		dev_err(fpc->chip.dev,
> +				"All the PWMs' period value should be "
> +				"the same\n");
> +		mutex_unlock(&fpc->lock);
> +		return -EINVAL;
> +	} else {
> +		period = fsl_rate_to_cycles(fpc, period_ns);
> +		if (period > 0xFFFF) {
> +			mutex_unlock(&fpc->lock);
> +			return -EINVAL;
> +		}
> +
> +		fsl_pwm_writel(fpc, period - 1, fpc->base + FTM_MOD);
> +		fpc->period_ns = period_ns;
> +	}
> +	mutex_unlock(&fpc->lock);
> +
> +	duty = fsl_rate_to_cycles(fpc, duty_ns);
> +	if (duty >= 0xFFFF)
> +		return -EINVAL;
> +
> +	fsl_pwm_writel(fpc, FTM_CSC_MSB | FTM_CSC_ELSB,
> +			fpc->base + FTM_CSC(pwm->hwpwm));
> +	fsl_pwm_writel(fpc, 0, fpc->base + FTM_CNTIN);
> +	fsl_pwm_writel(fpc, duty, fpc->base + FTM_CV(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> +static int fsl_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +				enum pwm_polarity polarity)
> +{
> +	u32 val;
> +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> +
> +	val = fsl_pwm_readl(fpc, fpc->base + FTM_POL);
> +	if (polarity == PWM_POLARITY_INVERSED)
> +		val |= BIT(pwm->hwpwm);
> +	else
> +		val &= ~BIT(pwm->hwpwm);
> +	fsl_pwm_writel(fpc, val, fpc->base + FTM_POL);
> +
> +	return 0;
> +}
> +
> +static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc) {
> +	int ret;
> +	u32 val;
> +
> +	if (fpc->counter_clk_enable++)
> +		return 0;
> +
> +	ret = clk_prepare_enable(fpc->counter_clk);
> +	if (ret) {
> +		fpc->counter_clk_enable--;
> +		return ret;
> +	}
> +
> +	val = fsl_pwm_readl(fpc, fpc->base + FTM_SC);
> +	val &= ~((FTM_SC_CLK_MASK << FTM_SC_CLK_SHIFT) |
> +			(FTM_SC_PS_MASK << FTM_SC_PS_SHIFT));
> +
> +	/* select counter clock source */
> +	switch (fpc->counter_clk_select) {
> +	case FSL_PWM_SYS_CLK:
> +		val |= FTM_SC_CLK_SYS;
> +		break;
> +	case FSL_PWM_FIX_CLK:
> +		val |= FTM_SC_CLK_FIX;
> +		break;
> +	case FSL_PWM_EXT_CLK:
> +		val |= FTM_SC_CLK_EXT;
> +		break;
> +	default:
> +		fpc->counter_clk_enable--;
> +		return -EINVAL;
> +	}
> +
> +	val |= fpc->clk_ps;
> +	fsl_pwm_writel(fpc, val, fpc->base + FTM_SC);
> +
> +	return 0;
> +}
> +
> +static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	int ret;
> +	u32 val;
> +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> +
> +	val = fsl_pwm_readl(fpc, fpc->base + FTM_OUTMASK);
> +	val &= ~BIT(pwm->hwpwm);
> +	fsl_pwm_writel(fpc, val, fpc->base + FTM_OUTMASK);
> +
> +	val = fsl_pwm_readl(fpc, fpc->base + FTM_OUTINIT);
> +	val &= ~BIT(pwm->hwpwm);
> +	fsl_pwm_writel(fpc, val, fpc->base + FTM_OUTINIT);
> +
> +	mutex_lock(&fpc->lock);
> +	ret = fsl_counter_clock_enable(fpc);
> +	mutex_unlock(&fpc->lock);
> +
> +	return ret;
> +}
> +
> +static void fsl_counter_clock_disable(struct fsl_pwm_chip *fpc) {
> +	u32 val;
> +
> +	if (--fpc->counter_clk_enable)
> +		return;
> +
> +	val = fsl_pwm_readl(fpc, fpc->base + FTM_SC);
> +	val &= ~(FTM_SC_CLK_MASK << FTM_SC_CLK_SHIFT);
> +	fsl_pwm_writel(fpc, val, fpc->base + FTM_SC);
> +
> +	clk_disable_unprepare(fpc->counter_clk);
> +}
> +
> +static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	u32 val;
> +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> +
> +	val = fsl_pwm_readl(fpc, fpc->base + FTM_OUTMASK);
> +	val |= BIT(pwm->hwpwm);
> +	fsl_pwm_writel(fpc, val, fpc->base + FTM_OUTMASK);
> +
> +	mutex_lock(&fpc->lock);
> +	fsl_counter_clock_disable(fpc);
> +
> +	val = fsl_pwm_readl(fpc, fpc->base + FTM_OUTMASK);
> +	if ((val & 0xFF) == 0xFF)
> +		fpc->period_ns = 0;
> +	mutex_unlock(&fpc->lock);
> +
> +}
> +
> +static const struct pwm_ops fsl_pwm_ops = {
> +	.request = fsl_pwm_request,
> +	.free = fsl_pwm_free,
> +	.config = fsl_pwm_config,
> +	.set_polarity = fsl_pwm_set_polarity,
> +	.enable = fsl_pwm_enable,
> +	.disable = fsl_pwm_disable,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int fsl_pwm_parse_clk_ps(struct fsl_pwm_chip *fpc) {
> +	struct clk *ext_clk, *fix_clk;
> +	unsigned long long sys_rate, ext_rate, fix_rate, ratio;
> +
> +	fpc->sys_clk = devm_clk_get(fpc->chip.dev, "ftm_sys");
> +	if (IS_ERR(fpc->sys_clk)) {
> +		dev_err(fpc->chip.dev,
> +				"failed to get \"ftm_sys\" clock\n");
> +		return PTR_ERR(fpc->sys_clk);
> +	}
> +
> +	ext_clk = devm_clk_get(fpc->chip.dev, "ftm_ext");
> +	if (IS_ERR(ext_clk))
> +		ext_clk = NULL;
> +
> +	fix_clk = devm_clk_get(fpc->chip.dev, "ftm_fix");
> +	if (IS_ERR(fix_clk))
> +		fix_clk = NULL;
> +
> +	sys_rate = clk_get_rate(fpc->sys_clk);
> +	if (!sys_rate)
> +		return -EINVAL;
> +
> +	ext_rate = clk_get_rate(ext_clk);
> +	fix_rate = clk_get_rate(fix_clk);
> +
> +	if (sys_rate >= ext_rate && sys_rate >= fix_rate) {
> +		fpc->clk_ps = 7;
> +		fpc->counter_clk = fpc->sys_clk;
> +		fpc->counter_clk_select = FSL_PWM_SYS_CLK;
> +	} else if (ext_rate > fix_rate) {
> +		ratio = 4 * ext_rate - 1;
> +		do_div(ratio, sys_rate);
> +		fpc->clk_ps = ratio;
> +		fpc->counter_clk = ext_clk;
> +		fpc->counter_clk_select = FSL_PWM_FIX_CLK;
> +	} else {
> +		ratio = 2 * fix_rate - 1;
> +		do_div(ratio, sys_rate);
> +		fpc->clk_ps = ratio;
> +		fpc->counter_clk = fix_clk;
> +		fpc->counter_clk_select = FSL_PWM_EXT_CLK;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsl_pwm_probe(struct platform_device *pdev) {
> +	int ret;
> +	struct fsl_pwm_chip *fpc;
> +	struct resource *res;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> +	if (!fpc)
> +		return -ENOMEM;
> +
> +	mutex_init(&fpc->lock);
> +
> +	fpc->chip.dev = &pdev->dev;
> +
> +	if (of_get_property(np, "big-endian", NULL))
> +		fpc->big_endian = 1;
> +
> +	ret = fsl_pwm_parse_clk_ps(fpc);
> +	if (ret < 0)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	fpc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(fpc->base))
> +		return PTR_ERR(fpc->base);
> +
> +	fpc->chip.ops = &fsl_pwm_ops;
> +	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
> +	fpc->chip.of_pwm_n_cells = 3;
> +	fpc->chip.base = -1;
> +	fpc->chip.npwm = 8;
> +
> +	ret = pwmchip_add(&fpc->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, fpc);
> +
> +	return 0;
> +}
> +
> +static int fsl_pwm_remove(struct platform_device *pdev) {
> +	struct fsl_pwm_chip *fpc = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&fpc->lock);
> +
> +	return pwmchip_remove(&fpc->chip);
> +}
> +
> +static const struct of_device_id fsl_pwm_dt_ids[] = {
> +	{ .compatible = "fsl,vf610-ftm-pwm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, fsl_pwm_dt_ids);
> +
> +static struct platform_driver fsl_pwm_driver = {
> +	.driver = {
> +		.name = "fsl-ftm-pwm",
> +		.of_match_table = fsl_pwm_dt_ids,
> +	},
> +	.probe = fsl_pwm_probe,
> +	.remove = fsl_pwm_remove,
> +};
> +module_platform_driver(fsl_pwm_driver);
> +
> +MODULE_DESCRIPTION("Freescale FlexTimer Module PWM Driver");
> +MODULE_AUTHOR("Xiubo Li <Li.Xiubo@freescale.com>");
> +MODULE_ALIAS("platform:fsl-ftm-pwm");
> +MODULE_LICENSE("GPL");
> --
> 1.8.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
