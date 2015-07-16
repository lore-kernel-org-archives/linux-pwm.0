From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 2/3] pwm: add MediaTek display PWM driver support
Date: Thu, 16 Jul 2015 15:17:59 +0800
Message-ID: <1437031079.8107.13.camel@mtksdaap41>
References: <1436778294-47635-1-git-send-email-yh.huang@mediatek.com>
	 <1436778294-47635-3-git-send-email-yh.huang@mediatek.com>
	 <CAGS+omCx4mDAN+F315x+8FeCABcKDoMn1gm_nHzF6VXnF_xm8Q@mail.gmail.com>
	 <1436975995.15774.27.camel@mtksdaap41>
	 <1437025108.18175.13.camel@mtksdaap41>
	 <CAGS+omB1FCX12-KvU7ODywseFKgsAbzNtqNyYZ+PqvO5ZeEn-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omB1FCX12-KvU7ODywseFKgsAbzNtqNyYZ+PqvO5ZeEn-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.mll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 2015-07-16 at 14:54 +0800, Daniel Kurtz wrote:
> On Thu, Jul 16, 2015 at 1:38 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > On Wed, 2015-07-15 at 23:59 +0800, YH Huang wrote:
> >> On Mon, 2015-07-13 at 18:19 +0800, Daniel Kurtz wrote:
> >> > On Mon, Jul 13, 2015 at 5:04 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >> > > Add display PWM driver support to modify backlight for MT8173 and MT6595.
> >> > > The PWM has one channel to control the brightness of the display.
> >> > > When the (high_width / period) is closer to 1, the screen is brighter;
> >> > > otherwise, it is darker.
> >> > >
> >> > > Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >> > > ---
> >> > >  drivers/pwm/Kconfig        |  10 ++
> >> > >  drivers/pwm/Makefile       |   1 +
> >> > >  drivers/pwm/pwm-mtk-disp.c | 256 +++++++++++++++++++++++++++++++++++++++++++++
> >> > >  3 files changed, 267 insertions(+)
> >> > >  create mode 100644 drivers/pwm/pwm-mtk-disp.c
> >> > >
> >> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> > > index b1541f4..f5b03a4 100644
> >> > > --- a/drivers/pwm/Kconfig
> >> > > +++ b/drivers/pwm/Kconfig
> >> > > @@ -211,6 +211,16 @@ config PWM_LPSS_PLATFORM
> >> > >           To compile this driver as a module, choose M here: the module
> >> > >           will be called pwm-lpss-platform.
> >> > >
> >> > > +config PWM_MTK_DISP
> >> > > +       tristate "MediaTek display PWM driver"
> >> > > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> >> > > +       help
> >> > > +         Generic PWM framework driver for MediaTek disp-pwm device.
> >> > > +         The PWM is used to control the backlight brightness for display.
> >> > > +
> >> > > +         To compile this driver as a module, choose M here: the module
> >> > > +         will be called pwm-mtk-disp.
> >> > > +
> >> > >  config PWM_MXS
> >> > >         tristate "Freescale MXS PWM support"
> >> > >         depends on ARCH_MXS && OF
> >> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >> > > index ec50eb5..99c9e75 100644
> >> > > --- a/drivers/pwm/Makefile
> >> > > +++ b/drivers/pwm/Makefile
> >> > > @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_LPC32XX)     += pwm-lpc32xx.o
> >> > >  obj-$(CONFIG_PWM_LPSS)         += pwm-lpss.o
> >> > >  obj-$(CONFIG_PWM_LPSS_PCI)     += pwm-lpss-pci.o
> >> > >  obj-$(CONFIG_PWM_LPSS_PLATFORM)        += pwm-lpss-platform.o
> >> > > +obj-$(CONFIG_PWM_MTK_DISP)     += pwm-mtk-disp.o
> >> > >  obj-$(CONFIG_PWM_MXS)          += pwm-mxs.o
> >> > >  obj-$(CONFIG_PWM_PCA9685)      += pwm-pca9685.o
> >> > >  obj-$(CONFIG_PWM_PUV3)         += pwm-puv3.o
> >> > > diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> >> > > new file mode 100644
> >> > > index 0000000..1f17cee
> >> > > --- /dev/null
> >> > > +++ b/drivers/pwm/pwm-mtk-disp.c
> >> > > @@ -0,0 +1,256 @@
> >> > > +/*
> >> > > + * MediaTek display pulse-width-modulation controller driver.
> >> > > + * Copyright (c) 2015 MediaTek Inc.
> >> > > + * Author: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >> > > + *
> >> > > + * This program is free software; you can redistribute it and/or modify
> >> > > + * it under the terms of the GNU General Public License version 2 as
> >> > > + * published by the Free Software Foundation.
> >> > > + *
> >> > > + * This program is distributed in the hope that it will be useful,
> >> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> > > + * GNU General Public License for more details.
> >> > > + */
> >> > > +
> >> > > +#include <linux/clk.h>
> >> > > +#include <linux/err.h>
> >> > > +#include <linux/io.h>
> >> > > +#include <linux/module.h>
> >> > > +#include <linux/of.h>
> >> > > +#include <linux/pwm.h>
> >> > > +#include <linux/platform_device.h>
> >> > > +#include <linux/slab.h>
> >> > > +
> >> > > +#define DISP_PWM_EN            0
> >> >
> >> > The "DISP_PWM_*" are register offsets, so use a hex value, like this:
> >> >
> >> > #define DISP_PWM_EN                      0x00
> >> >
> >> > Use BIT() for register *fields*, that is, the individual bits of a register.
> >> >
> >>
> >> Got it!
> >>
> >> > > +#define PWM_ENABLE_MASK                BIT(0)
> >> > > +
> >> > > +#define DISP_PWM_COMMIT                BIT(3)
> >> >
> >> > #define DISP_PWM_COMMIT            0x08
> >> >
> >> > > +#define PWM_COMMIT_MASK                BIT(0)
> >> > > +
> >> > > +#define DISP_PWM_CON_0         BIT(4)
> >> >
> >> > #define DISP_PWM_COMMIT            0x10
> >> >
> >> > > +#define PWM_CLKDIV_SHIFT       16
> >> > > +#define PWM_CLKDIV_MAX         0x3ff
> >> > > +#define PWM_CLKDIV_MASK                (PWM_CLKDIV_MAX << PWM_CLKDIV_SHIFT)
> >> > > +
> >> > > +#define DISP_PWM_CON_1         0x14
> >> > > +#define PWM_PERIOD_MASK                0xfff
> >> > > +/* Shift log2(PWM_PERIOD_MASK + 1) as divisor */
> >> > > +#define PWM_PERIOD_BIT_SHIFT   12
> >> > > +
> >> > > +#define PWM_HIGH_WIDTH_SHIFT   16
> >> > > +#define PWM_HIGH_WIDTH_MASK    (0x1fff << PWM_HIGH_WIDTH_SHIFT)
> >> > > +
> >> > > +struct mtk_disp_pwm {
> >> > > +       struct pwm_chip chip;
> >> > > +       struct device *dev;
> >> >
> >> > I don't think "dev" is actually used.  And, if needed, it can be
> >> > extracted from "chip".
> >> >
> >>
> >> I will drop it.
> >>
> >> > > +       struct clk *clk_main;
> >> > > +       struct clk *clk_mm;
> >> > > +       void __iomem *base;
> >> > > +};
> >> > > +
> >> > > +static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
> >> > > +{
> >> > > +       return container_of(chip, struct mtk_disp_pwm, chip);
> >> > > +}
> >> > > +
> >> > > +static void mtk_disp_pwm_update_bits(void __iomem *address, u32 mask, u32 value)
> >> >
> >> > Take "struct mtk_disp_pwm *mdp" as a param and extract mdp->base,
> >> > rather than pass the raw iomem address.
> >> >
> >>
> >> I will revise it like this.
> >>
> >> static void mtk_disp_pwm_update_bits(struct mtk_disp_pwm *mdp,
> >>                              u32 reg, u32 mask, u32 value)
> >> {
> >>       void __iomem *address;
> >>       u32 val;
> >>
> >>       address = mdp->base + reg;
> >>       val = readl(address);
> >>       val &= ~mask;
> >>       val |= value;
> >>       writel(val, address);
> >> }
> >>
> >> > > +{
> >> > > +       u32 val;
> >> > > +
> >> > > +       val = readl(address);
> >> > > +       val &= ~mask;
> >> > > +       val |= value;
> >> > > +       writel(val, address);
> >> > > +}
> >> > > +
> >> > > +static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >> > > +                              int duty_ns, int period_ns)
> >> > > +{
> >> > > +       struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
> >> > > +       u64 div, rate;
> >> > > +       u32 clk_div, period, high_width, value;
> >> > > +
> >> > > +       /*
> >> > > +        * Find period, high_width and clk_div to suit duty_ns and period_ns.
> >> > > +        * Calculate proper div value to keep period value in the bound.
> >> > > +        *
> >> > > +        * period_ns = 10^9 * (clk_div + 1) * (period + 1) / PWM_CLK_RATE
> >> > > +        * duty_ns = 10^9 * (clk_div + 1) * high_width / PWM_CLK_RATE
> >> > > +        *
> >> > > +        * period = (PWM_CLK_RATE * period_ns) / (10^9 * (clk_div + 1)) - 1
> >> > > +        * high_width = (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1))
> >> > > +        */
> >> > > +       rate = clk_get_rate(mdp->clk_main);
> >> > > +       clk_div = div_u64(rate * period_ns, NSEC_PER_SEC) >>
> >> > > +                         PWM_PERIOD_BIT_SHIFT;
> >> > > +       if (clk_div > PWM_CLKDIV_MAX)
> >> > > +               return -EINVAL;
> >> > > +
> >> > > +       div = NSEC_PER_SEC * (clk_div + 1);
> >> > > +       period = div64_u64(rate * period_ns, div);
> >> > > +       if (period > 0)
> >> > > +               period--;
> >> > > +
> >> > > +       high_width = div64_u64(rate * duty_ns, div);
> >> > > +
> >> > > +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_CON_0,
> >> > > +                                PWM_CLKDIV_MASK, clk_div << PWM_CLKDIV_SHIFT);
> >> > > +
> >> > > +       value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
> >> > > +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_CON_1,
> >> > > +                                PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK, value);
> >> > > +
> >> > > +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_COMMIT,
> >> > > +                                PWM_COMMIT_MASK, 1);
> >> > > +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_COMMIT,
> >> > > +                                PWM_COMMIT_MASK, 0);
> >> > > +
> >> > > +       return 0;
> >> > > +}
> >> > > +
> >> > > +static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >> > > +{
> >> > > +       struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
> >> > > +
> >> > > +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_EN,
> >> > > +                                PWM_ENABLE_MASK, 1);
> >> > > +
> >> > > +       return 0;
> >> > > +}
> >> > > +
> >> > > +static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >> > > +{
> >> > > +       struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
> >> > > +
> >> > > +       mtk_disp_pwm_update_bits(mdp->base + DISP_PWM_EN,
> >> > > +                                PWM_ENABLE_MASK, 0);
> >> > > +}
> >> > > +
> >> > > +static const struct pwm_ops mtk_disp_pwm_ops = {
> >> > > +       .config = mtk_disp_pwm_config,
> >> > > +       .enable = mtk_disp_pwm_enable,
> >> > > +       .disable = mtk_disp_pwm_disable,
> >> > > +       .owner = THIS_MODULE,
> >> > > +};
> >> > > +
> >> > > +static int mtk_disp_pwm_probe(struct platform_device *pdev)
> >> > > +{
> >> > > +       struct mtk_disp_pwm *mdp;
> >> > > +       struct resource *r;
> >> > > +       int ret;
> >> > > +
> >> > > +       mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
> >> > > +       if (!mdp)
> >> > > +               return -ENOMEM;
> >> > > +
> >> > > +       mdp->dev = &pdev->dev;
> >> > > +
> >> > > +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> > > +       mdp->base = devm_ioremap_resource(&pdev->dev, r);
> >> > > +       if (IS_ERR(mdp->base))
> >> > > +               return PTR_ERR(mdp->base);
> >> > > +
> >> > > +       mdp->clk_main = devm_clk_get(&pdev->dev, "main");
> >> > > +       if (IS_ERR(mdp->clk_main))
> >> > > +               return PTR_ERR(mdp->clk_main);
> >> > > +
> >> > > +       mdp->clk_mm = devm_clk_get(&pdev->dev, "mm");
> >> > > +       if (IS_ERR(mdp->clk_mm))
> >> > > +               return PTR_ERR(mdp->clk_mm);
> >> > > +
> >> > > +       ret = clk_prepare_enable(mdp->clk_main);
> >> >
> >> > Delay turning on the PWM clock until it is actually needed (pwm_enable)...
> >> > Just be careful to ensure that the "main" clock is enabled when
> >> > writing registers during mtk_disp_pwm_config.
> >
> > Since pwm-backlight driver configures PWM before enable PWM, I enable
> > clocks at the probe function.
> > Turning on the PWM clock in pwm_enable will lose the first configuration
> > of PWM. It won't affect a lot since the system configures PWM many times
> > at boot time.
> > So should I delay or keep the original way?
> 
> Why does turning on the PWM clock in pwm_enable lose the first configuration?
> Would this be solved by turning enabling/disabling clocks during
> mtk_disp_pwm_config()?
> 

If I don't enable clocks at probe function, I enable clocks at
mtk_disp_pwm_enable() and disable clocks at mtk_disp_pwm_disable().
And this causes missing first configuration.

Enabling clocks in mtk_disp_pwm_config() will fix this.
The backlight doesn't work well(no immediate update or losing backlight)
if I disable anyone of the two clocks in mtk_disp_pwm_config().

Regards,
YH Huang

> >
> >> > By the way, is the pwm in a power domain that must also be enabled
> >> > when enabling the pwm?
> >>
> >> It is in the display power domain which must also be enabled.
> >>
> >> >
> >> > > +       if (ret < 0)
> >> > > +               return ret;
> >> > > +
> >> > > +       ret = clk_prepare_enable(mdp->clk_mm);
> >> > > +       if (ret < 0)
> >> > > +               goto disable_clk_main;
> >> > > +
> >> > > +       platform_set_drvdata(pdev, mdp);
> >> >
> >> > Set this only after pwmchip_add() succeeds.
> >>
> >> OK.
> >>
> >> >
> >> > > +
> >> > > +       mdp->chip.dev = &pdev->dev;
> >> > > +       mdp->chip.ops = &mtk_disp_pwm_ops;
> >> > > +       mdp->chip.base = -1;
> >> > > +       mdp->chip.npwm = 1;
> >> > > +
> >> > > +       ret = pwmchip_add(&mdp->chip);
> >> > > +       if (ret < 0) {
> >> > > +               dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> >> > > +               goto disable_clk_mm;
> >> > > +       }
> >> > > +
> >> > > +       return 0;
> >> > > +
> >> > > +disable_clk_mm:
> >> > > +       clk_disable_unprepare(mdp->clk_mm);
> >> > > +disable_clk_main:
> >> > > +       clk_disable_unprepare(mdp->clk_main);
> >> > > +       return ret;
> >> > > +}
> >> > > +
> >> > > +static int mtk_disp_pwm_remove(struct platform_device *pdev)
> >> > > +{
> >> > > +       struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
> >> > > +       int ret = pwmchip_remove(&mdp->chip);
> >> > > +
> >> > > +       clk_disable_unprepare(mdp->clk_main);
> >> > > +       clk_disable_unprepare(mdp->clk_mm);
> >> >
> >> > Nit: it is more traditional to disable clocks in the opposite order to
> >> > which they are enabled, so:
> >> >
> >> >        clk_disable_unprepare(mdp->clk_mm);
> >> >        clk_disable_unprepare(mdp->clk_main);
> >> >
> >>
> >> OK.
> >>
> >> > > +
> >> > > +       return ret;
> >> > > +}
> >> > > +
> >> > > +static const struct of_device_id mtk_disp_pwm_of_match[] = {
> >> > > +       { .compatible = "mediatek,mt8173-disp-pwm" },
> >> > > +       { .compatible = "mediatek,mt6595-disp-pwm" },
> >> > > +       { }
> >> > > +};
> >> > > +MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);
> >> > > +
> >> > > +#ifdef CONFIG_PM_SLEEP
> >> > > +static int mtk_disp_pwm_suspend(struct device *dev)
> >> > > +{
> >> > > +       struct mtk_disp_pwm *mdp = dev_get_drvdata(dev);
> >> > > +
> >> > > +       clk_disable_unprepare(mdp->clk_main);
> >> > > +       clk_disable_unprepare(mdp->clk_mm);
> >> > > +
> >> > > +       return 0;
> >> > > +}
> >> > > +
> >> > > +static int mtk_disp_pwm_resume(struct device *dev)
> >> > > +{
> >> > > +       struct mtk_disp_pwm *mdp = dev_get_drvdata(dev);
> >> > > +       int ret;
> >> > > +
> >> > > +       ret = clk_prepare_enable(mdp->clk_main);
> >> > > +       if (ret < 0)
> >> > > +               return ret;
> >> > > +
> >> > > +       ret = clk_prepare_enable(mdp->clk_mm);
> >> > > +       if (ret < 0) {
> >> > > +               clk_disable_unprepare(mdp->clk_main);
> >> > > +               return ret;
> >> > > +       }
> >> > > +
> >> >
> >> > Don't you also have to restore the PWM rate and frequency?
> >> >
> >> > Is it possible to save power at runtime by leaving mdp->clk_mm enabled
> >> > (to generate the PWM signal), but disable mdp->clk_main (clock
> >> > required to access PWM registers)?
> >>
> >> The pwm-backlight driver will restore the data.
> >>
> >> After I try to disable anyone of the two clocks at runtime, the
> >> backlight doesn't work well(no immediate update or losing backlight).
> >> So we need to keep both clock enabled.
> >>
> >> Regards,
> >> YH Huang
> >>
> >
> >


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
