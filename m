From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Tue, 26 May 2015 08:05:33 +0200
Message-ID: <20150526060533.GW6325@pengutronix.de>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
 <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
 <CAGS+omBX1fMBHa-4GLTjQUq5VPR2JRvhJRJ4qBX8hvDF9ihbLA@mail.gmail.com>
 <1432196551.15653.2.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49329 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbEZGFr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2015 02:05:47 -0400
Content-Disposition: inline
In-Reply-To: <1432196551.15653.2.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 21, 2015 at 04:22:31PM +0800, YH Huang wrote:
> On Mon, 2015-05-18 at 11:42 +0800, Daniel Kurtz wrote:
> > On Mon, May 11, 2015 at 5:26 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > > Add display PWM driver support to modify backlight for MT8173/MT6595.
> > >
> > > Signed-off-by: YH Huang <yh.huang@mediatek.com>
> > > ---
> > >  drivers/pwm/Kconfig             |   9 ++
> > >  drivers/pwm/Makefile            |   1 +
> > >  drivers/pwm/pwm-disp-mediatek.c | 225 ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 235 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-disp-mediatek.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index b1541f4..9edbb5a 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -111,6 +111,15 @@ config PWM_CLPS711X
> > >           To compile this driver as a module, choose M here: the module
> > >           will be called pwm-clps711x.
> > >
> > > +config PWM_DISP_MEDIATEK
> > > +       tristate "MEDIATEK display PWM driver"
> > > +       depends on OF
> > > +       help
> > > +         Generic PWM framework driver for mediatek disp-pwm device.
> > > +
> > > +         To compile this driver as a module, choose M here: the module
> > > +         will be called pwm-disp-mediatek.
> > > +
> > >  config PWM_EP93XX
> > >         tristate "Cirrus Logic EP93xx PWM support"
> > >         depends on ARCH_EP93XX
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index ec50eb5..c5ff72a 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_BCM_KONA)      += pwm-bcm-kona.o
> > >  obj-$(CONFIG_PWM_BCM2835)      += pwm-bcm2835.o
> > >  obj-$(CONFIG_PWM_BFIN)         += pwm-bfin.o
> > >  obj-$(CONFIG_PWM_CLPS711X)     += pwm-clps711x.o
> > > +obj-$(CONFIG_PWM_DISP_MEDIATEK)        += pwm-disp-mediatek.o
> > >  obj-$(CONFIG_PWM_EP93XX)       += pwm-ep93xx.o
> > >  obj-$(CONFIG_PWM_FSL_FTM)      += pwm-fsl-ftm.o
> > >  obj-$(CONFIG_PWM_IMG)          += pwm-img.o
> > > diff --git a/drivers/pwm/pwm-disp-mediatek.c b/drivers/pwm/pwm-disp-mediatek.c
> > > new file mode 100644
> > > index 0000000..38293af
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-disp-mediatek.c
> > > @@ -0,0 +1,225 @@
> > > +/*
> > > + * Mediatek display pulse-width-modulation controller driver.
> > > + * Copyright (c) 2015 MediaTek Inc.
> > > + * Author: YH Huang <yh.huang@mediatek.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#define DISP_PWM_EN_OFF                        (0x0)
> > > +#define PWM_ENABLE_SHIFT               (0x0)
> > > +#define PWM_ENABLE_MASK                        (0x1 << PWM_ENABLE_SHIFT)
> > > +
> > > +#define DISP_PWM_COMMIT_OFF            (0x08)
> > > +#define PWM_COMMIT_SHIFT               (0x0)
> > > +#define PWM_COMMIT_MASK                        (0x1 << PWM_COMMIT_SHIFT)
> > > +
> > > +#define DISP_PWM_CON_0_OFF             (0x10)
> > > +#define PWM_CLKDIV_SHIFT               (0x10)
> > > +#define PWM_CLKDIV_MASK                        (0x3ff << PWM_CLKDIV_SHIFT)
> > > +#define PWM_CLKDIV_MAX                 (0x000003ff)
> > > +
> > > +#define DISP_PWM_CON_1_OFF             (0x14)
> > > +#define PWM_PERIOD_SHIFT               (0x0)
> > > +#define PWM_PERIOD_MASK                        (0xfff << PWM_PERIOD_SHIFT)
> > > +#define PWM_PERIOD_MAX                 (0x00000fff)
> > > +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> > > +#define PWM_PERIOD_BIT_SHIFT           12
> > > +
> > > +#define PWM_HIGH_WIDTH_SHIFT           (0x10)
> > > +#define PWM_HIGH_WIDTH_MASK            (0x1fff << PWM_HIGH_WIDTH_SHIFT)
> > > +
> > > +#define NUM_PWM 1
> > > +
> > > +struct mtk_disp_pwm_chip {
> > > +       struct pwm_chip chip;
> > > +       struct device   *dev;
> > > +       struct clk      *clk_main;
> > > +       struct clk      *clk_mm;
> > > +       void __iomem    *mmio_base;
> > > +};
> > > +
> > > +static void mtk_disp_pwm_setting(void __iomem *address, u32 value, u32 mask)
> > > +{
> > > +       u32 val;
> > > +
> > > +       val = readl(address);
> > > +       val &= ~mask;
> > > +       val |= value;
> > > +       writel(val, address);
> > > +}
> > > +
> > > +static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +                              int duty_ns, int period_ns)
> > > +{
> > > +       struct mtk_disp_pwm_chip *mpc;
> > > +       u64 div, rate;
> > > +       u32 clk_div, period, high_width, rem;
> > > +
> > > +       /*
> > > +        * Find period, high_width and clk_div to suit duty_ns and period_ns.
> > > +        * Calculate proper div value to keep period value in the bound.
> > > +        *
> > > +        * period_ns = 10^9 * (clk_div + 1) * (period +1) / PWM_CLK_RATE
> > > +        * duty_ns = 10^9 * (clk_div + 1) * (high_width + 1) / PWM_CLK_RATE
> > > +        *
> > > +        * period = (PWM_CLK_RATE * period_ns) / (10^9 * (clk_div + 1)) - 1
> > > +        * high_width = (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1)) - 1
> > > +        */
> > > +       mpc = container_of(chip, struct mtk_disp_pwm_chip, chip);
> > > +       rate = clk_get_rate(mpc->clk_main);
> > > +       clk_div = div_u64_rem(rate * period_ns, NSEC_PER_SEC, &rem) >>
> > > +                               PWM_PERIOD_BIT_SHIFT;
> > > +       if (clk_div > PWM_CLKDIV_MAX)
> > > +               return -EINVAL;
> > > +
> > > +       div = clk_div + 1;
> > > +       period = div64_u64(rate * period_ns, NSEC_PER_SEC * div);
> > > +       if (period > 0)
> > > +               period--;
> > > +       high_width = div64_u64(rate * duty_ns, NSEC_PER_SEC * div);
> > > +       if (high_width > 0)
> > > +               high_width--;
> > > +
> > > +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_CON_0_OFF,
> > > +                            clk_div << PWM_CLKDIV_SHIFT, PWM_CLKDIV_MASK);
> > > +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_CON_1_OFF,
> > > +                            (period << PWM_PERIOD_SHIFT) |
> > > +                       (high_width << PWM_HIGH_WIDTH_SHIFT),
> > > +                       PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK);
> > > +
> > > +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_COMMIT_OFF,
> > > +                            1 << PWM_COMMIT_SHIFT, PWM_COMMIT_MASK);
> > > +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_COMMIT_OFF,
> > > +                            0 << PWM_COMMIT_SHIFT, PWM_COMMIT_MASK);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > > +{
> > > +       struct mtk_disp_pwm_chip *mpc;
> > > +
> > > +       mpc = container_of(chip, struct mtk_disp_pwm_chip, chip);
> > > +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_EN_OFF,
> > > +                            1 << PWM_ENABLE_SHIFT, PWM_ENABLE_MASK);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > > +{
> > > +       struct mtk_disp_pwm_chip *mpc;
> > > +
> > > +       mpc = container_of(chip, struct mtk_disp_pwm_chip, chip);
> > > +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_EN_OFF,
> > > +                            0 << PWM_ENABLE_SHIFT, PWM_ENABLE_MASK);
> > > +}
> > > +
> > > +static const struct pwm_ops mtk_disp_pwm_ops = {
> > > +       .config = mtk_disp_pwm_config,
> > > +       .enable = mtk_disp_pwm_enable,
> > > +       .disable = mtk_disp_pwm_disable,
> > > +       .owner = THIS_MODULE,
> > > +};
> > > +
> > > +static int mtk_disp_pwm_probe(struct platform_device *pdev)
> > > +{
> > > +       struct mtk_disp_pwm_chip *pwm;
> > > +       struct resource *r;
> > > +       int ret;
> > > +
> > > +       pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> > > +       if (!pwm)
> > > +               return -ENOMEM;
> > > +
> > > +       pwm->dev = &pdev->dev;
> > > +
> > > +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> > > +       if (IS_ERR(pwm->mmio_base))
> > > +               return PTR_ERR(pwm->mmio_base);
> > > +
> > > +       pwm->clk_main = devm_clk_get(&pdev->dev, "main");
> > > +       if (IS_ERR(pwm->clk_main))
> > > +               return PTR_ERR(pwm->clk_main);
> > > +       pwm->clk_mm = devm_clk_get(&pdev->dev, "mm");
> > > +       if (IS_ERR(pwm->clk_mm))
> > > +               return PTR_ERR(pwm->clk_mm);
> > > +
> > > +       ret = clk_prepare_enable(pwm->clk_main);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       ret = clk_prepare_enable(pwm->clk_mm);
> > > +       if (ret < 0) {
> > > +               clk_disable_unprepare(pwm->clk_main);
> > > +               return ret;
> > > +       }
> > > +
> > > +       platform_set_drvdata(pdev, pwm);
> > > +
> > > +       pwm->chip.dev = &pdev->dev;
> > > +       pwm->chip.ops = &mtk_disp_pwm_ops;
> > > +       pwm->chip.base = -1;
> > > +       pwm->chip.npwm = NUM_PWM;
> > > +
> > > +       ret = pwmchip_add(&pwm->chip);
> > > +       if (ret < 0) {
> > > +               dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mtk_disp_pwm_remove(struct platform_device *pdev)
> > > +{
> > > +       struct mtk_disp_pwm_chip *pc = platform_get_drvdata(pdev);
> > > +
> > > +       if (WARN_ON(!pc))
> > > +               return -ENODEV;
> > > +
> > > +       clk_disable_unprepare(pc->clk_main);
> > > +       clk_disable_unprepare(pc->clk_mm);
> > > +
> > > +       return pwmchip_remove(&pc->chip);
> > > +}
> > > +
> > > +static const struct of_device_id mtk_disp_pwm_of_match[] = {
> > > +       { .compatible = "mediatek,mt6595-disp-pwm" },
> > 
> > Does this driver support the PWM in mt8173?
> > If so, don't you need this, too:
> > 
> >   { .compatible = "mediatek,mt8173-disp-pwm" },
> 
> Yes, it supports mt8173.
> I will add it.

If both yre compatible you don't need to add it since you have a
"mediatek,mt6595-disp-pwm" in the mt8173 device tree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
