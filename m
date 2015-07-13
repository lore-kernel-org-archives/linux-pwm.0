From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v5 2/3] pwm: add MediaTek display PWM driver support
Date: Mon, 13 Jul 2015 18:19:45 +0800
Message-ID: <CAGS+omCx4mDAN+F315x+8FeCABcKDoMn1gm_nHzF6VXnF_xm8Q@mail.gmail.com>
References: <1436778294-47635-1-git-send-email-yh.huang@mediatek.com> <1436778294-47635-3-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35852 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbGMKUH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2015 06:20:07 -0400
Received: by ykay190 with SMTP id y190so34817731yka.3
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jul 2015 03:20:06 -0700 (PDT)
In-Reply-To: <1436778294-47635-3-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>

On Mon, Jul 13, 2015 at 5:04 PM, YH Huang <yh.huang@mediatek.com> wrote:
> Add display PWM driver support to modify backlight for MT8173 and MT6595.
> The PWM has one channel to control the brightness of the display.
> When the (high_width / period) is closer to 1, the screen is brighter;
> otherwise, it is darker.
>
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-mtk-disp.c | 256 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 267 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f4..f5b03a4 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -211,6 +211,16 @@ config PWM_LPSS_PLATFORM
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-lpss-platform.
>
> +config PWM_MTK_DISP
> +       tristate "MediaTek display PWM driver"
> +       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       help
> +         Generic PWM framework driver for MediaTek disp-pwm device.
> +         The PWM is used to control the backlight brightness for display.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called pwm-mtk-disp.
> +
>  config PWM_MXS
>         tristate "Freescale MXS PWM support"
>         depends on ARCH_MXS && OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5..99c9e75 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_LPC32XX)     += pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)         += pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)     += pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)        += pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MTK_DISP)     += pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)          += pwm-mxs.o
>  obj-$(CONFIG_PWM_PCA9685)      += pwm-pca9685.o
>  obj-$(CONFIG_PWM_PUV3)         += pwm-puv3.o
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> new file mode 100644
> index 0000000..1f17cee
> --- /dev/null
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -0,0 +1,256 @@
> +/*
> + * MediaTek display pulse-width-modulation controller driver.
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: YH Huang <yh.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DISP_PWM_EN            0

The "DISP_PWM_*" are register offsets, so use a hex value, like this:

#define DISP_PWM_EN                      0x00

Use BIT() for register *fields*, that is, the individual bits of a register.

> +#define PWM_ENABLE_MASK                BIT(0)
> +
> +#define DISP_PWM_COMMIT                BIT(3)

#define DISP_PWM_COMMIT            0x08

> +#define PWM_COMMIT_MASK                BIT(0)
> +
> +#define DISP_PWM_CON_0         BIT(4)

#define DISP_PWM_COMMIT            0x10

> +#define PWM_CLKDIV_SHIFT       16
> +#define PWM_CLKDIV_MAX         0x3ff
> +#define PWM_CLKDIV_MASK                (PWM_CLKDIV_MAX << PWM_CLKDIV_SHIFT)
> +
> +#define DISP_PWM_CON_1         0x14
> +#define PWM_PERIOD_MASK                0xfff
> +/* Shift log2(PWM_PERIOD_MASK + 1) as divisor */
> +#define PWM_PERIOD_BIT_SHIFT   12
> +
> +#define PWM_HIGH_WIDTH_SHIFT   16
> +#define PWM_HIGH_WIDTH_MASK    (0x1fff << PWM_HIGH_WIDTH_SHIFT)
> +
> +struct mtk_disp_pwm {
> +       struct pwm_chip chip;
> +       struct device *dev;

I don't think "dev" is actually used.  And, if needed, it can be
extracted from "chip".

> +       struct clk *clk_main;
> +       struct clk *clk_mm;
> +       void __iomem *base;
> +};
> +
> +static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
> +{
> +       return container_of(chip, struct mtk_disp_pwm, chip);
> +}
> +
> +static void mtk_disp_pwm_update_bits(void __iomem *address, u32 mask, u32 value)

Take "struct mtk_disp_pwm *mdp" as a param and extract mdp->base,
rather than pass the raw iomem address.

> +{
> +       u32 val;
> +
> +       val = readl(address);
> +       val &= ~mask;
> +       val |= value;
> +       writel(val, address);
> +}
> +
> +static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +                              int duty_ns, int period_ns)
> +{
> +       struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
> +       u64 div, rate;
> +       u32 clk_div, period, high_width, value;
> +
> +       /*
> +        * Find period, high_width and clk_div to suit duty_ns and period_ns.
> +        * Calculate proper div value to keep period value in the bound.
> +        *
> +        * period_ns = 10^9 * (clk_div + 1) * (period + 1) / PWM_CLK_RATE
> +        * duty_ns = 10^9 * (clk_div + 1) * high_width / PWM_CLK_RATE
> +        *
> +        * period = (PWM_CLK_RATE * period_ns) / (10^9 * (clk_div + 1)) - 1
> +        * high_width = (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1))
> +        */
> +       rate = clk_get_rate(mdp->clk_main);
> +       clk_div = div_u64(rate * period_ns, NSEC_PER_SEC) >>
> +                         PWM_PERIOD_BIT_SHIFT;
> +       if (clk_div > PWM_CLKDIV_MAX)
> +               return -EINVAL;
> +
> +       div = NSEC_PER_SEC * (clk_div + 1);
> +       period = div64_u64(rate * period_ns, div);
> +       if (period > 0)
> +               period--;
> +
> +       high_width = div64_u64(rate * duty_ns, div);
> +
> +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_CON_0,
> +                                PWM_CLKDIV_MASK, clk_div << PWM_CLKDIV_SHIFT);
> +
> +       value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
> +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_CON_1,
> +                                PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK, value);
> +
> +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_COMMIT,
> +                                PWM_COMMIT_MASK, 1);
> +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_COMMIT,
> +                                PWM_COMMIT_MASK, 0);
> +
> +       return 0;
> +}
> +
> +static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +       struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
> +
> +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_EN,
> +                                PWM_ENABLE_MASK, 1);
> +
> +       return 0;
> +}
> +
> +static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +       struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
> +
> +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_EN,
> +                                PWM_ENABLE_MASK, 0);
> +}
> +
> +static const struct pwm_ops mtk_disp_pwm_ops = {
> +       .config = mtk_disp_pwm_config,
> +       .enable = mtk_disp_pwm_enable,
> +       .disable = mtk_disp_pwm_disable,
> +       .owner = THIS_MODULE,
> +};
> +
> +static int mtk_disp_pwm_probe(struct platform_device *pdev)
> +{
> +       struct mtk_disp_pwm *mdp;
> +       struct resource *r;
> +       int ret;
> +
> +       mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
> +       if (!mdp)
> +               return -ENOMEM;
> +
> +       mdp->dev = &pdev->dev;
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       mdp->base = devm_ioremap_resource(&pdev->dev, r);
> +       if (IS_ERR(mdp->base))
> +               return PTR_ERR(mdp->base);
> +
> +       mdp->clk_main = devm_clk_get(&pdev->dev, "main");
> +       if (IS_ERR(mdp->clk_main))
> +               return PTR_ERR(mdp->clk_main);
> +
> +       mdp->clk_mm = devm_clk_get(&pdev->dev, "mm");
> +       if (IS_ERR(mdp->clk_mm))
> +               return PTR_ERR(mdp->clk_mm);
> +
> +       ret = clk_prepare_enable(mdp->clk_main);

Delay turning on the PWM clock until it is actually needed (pwm_enable)...
Just be careful to ensure that the "main" clock is enabled when
writing registers during mtk_disp_pwm_config.
By the way, is the pwm in a power domain that must also be enabled
when enabling the pwm?

> +       if (ret < 0)
> +               return ret;
> +
> +       ret = clk_prepare_enable(mdp->clk_mm);
> +       if (ret < 0)
> +               goto disable_clk_main;
> +
> +       platform_set_drvdata(pdev, mdp);

Set this only after pwmchip_add() succeeds.

> +
> +       mdp->chip.dev = &pdev->dev;
> +       mdp->chip.ops = &mtk_disp_pwm_ops;
> +       mdp->chip.base = -1;
> +       mdp->chip.npwm = 1;
> +
> +       ret = pwmchip_add(&mdp->chip);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +               goto disable_clk_mm;
> +       }
> +
> +       return 0;
> +
> +disable_clk_mm:
> +       clk_disable_unprepare(mdp->clk_mm);
> +disable_clk_main:
> +       clk_disable_unprepare(mdp->clk_main);
> +       return ret;
> +}
> +
> +static int mtk_disp_pwm_remove(struct platform_device *pdev)
> +{
> +       struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
> +       int ret = pwmchip_remove(&mdp->chip);
> +
> +       clk_disable_unprepare(mdp->clk_main);
> +       clk_disable_unprepare(mdp->clk_mm);

Nit: it is more traditional to disable clocks in the opposite order to
which they are enabled, so:

       clk_disable_unprepare(mdp->clk_mm);
       clk_disable_unprepare(mdp->clk_main);

> +
> +       return ret;
> +}
> +
> +static const struct of_device_id mtk_disp_pwm_of_match[] = {
> +       { .compatible = "mediatek,mt8173-disp-pwm" },
> +       { .compatible = "mediatek,mt6595-disp-pwm" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_disp_pwm_suspend(struct device *dev)
> +{
> +       struct mtk_disp_pwm *mdp = dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(mdp->clk_main);
> +       clk_disable_unprepare(mdp->clk_mm);
> +
> +       return 0;
> +}
> +
> +static int mtk_disp_pwm_resume(struct device *dev)
> +{
> +       struct mtk_disp_pwm *mdp = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_prepare_enable(mdp->clk_main);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = clk_prepare_enable(mdp->clk_mm);
> +       if (ret < 0) {
> +               clk_disable_unprepare(mdp->clk_main);
> +               return ret;
> +       }
> +

Don't you also have to restore the PWM rate and frequency?

Is it possible to save power at runtime by leaving mdp->clk_mm enabled
(to generate the PWM signal), but disable mdp->clk_main (clock
required to access PWM registers)?


> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(mtk_disp_pwm_pm_ops, mtk_disp_pwm_suspend,
> +                        mtk_disp_pwm_resume);
> +
> +static struct platform_driver mtk_disp_pwm_driver = {
> +       .driver = {
> +               .name = "mediatek-disp-pwm",
> +               .pm = &mtk_disp_pwm_pm_ops,
> +               .of_match_table = mtk_disp_pwm_of_match,
> +       },
> +       .probe = mtk_disp_pwm_probe,
> +       .remove = mtk_disp_pwm_remove,
> +};
> +module_platform_driver(mtk_disp_pwm_driver);
> +
> +MODULE_AUTHOR("YH Huang <yh.huang@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek SoC display PWM driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.8.1.1.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
