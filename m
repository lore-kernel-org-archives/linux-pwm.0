From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Tue, 12 May 2015 14:37:22 +0200
Message-ID: <CABuKBeJz_=Nxcen9QU_KHds6UJwUJL0yNpYDhvT3eFoV_EY5xA@mail.gmail.com>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
	<1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431336382-13167-3-git-send-email-yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi YH,

2015-05-11 11:26 GMT+02:00 YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
> Add display PWM driver support to modify backlight for MT8173/MT6595.
>
> Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/pwm/Kconfig             |   9 ++
>  drivers/pwm/Makefile            |   1 +
>  drivers/pwm/pwm-disp-mediatek.c | 225 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/pwm/pwm-disp-mediatek.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f4..9edbb5a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -111,6 +111,15 @@ config PWM_CLPS711X
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-clps711x.
>
> +config PWM_DISP_MEDIATEK
> +       tristate "MEDIATEK display PWM driver"
> +       depends on OF
> +       help
> +         Generic PWM framework driver for mediatek disp-pwm device.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called pwm-disp-mediatek.
> +
>  config PWM_EP93XX
>         tristate "Cirrus Logic EP93xx PWM support"
>         depends on ARCH_EP93XX
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5..c5ff72a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_BCM_KONA)      += pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)      += pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BFIN)         += pwm-bfin.o
>  obj-$(CONFIG_PWM_CLPS711X)     += pwm-clps711x.o
> +obj-$(CONFIG_PWM_DISP_MEDIATEK)        += pwm-disp-mediatek.o
>  obj-$(CONFIG_PWM_EP93XX)       += pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)      += pwm-fsl-ftm.o
>  obj-$(CONFIG_PWM_IMG)          += pwm-img.o
> diff --git a/drivers/pwm/pwm-disp-mediatek.c b/drivers/pwm/pwm-disp-mediatek.c
> new file mode 100644
> index 0000000..38293af
> --- /dev/null
> +++ b/drivers/pwm/pwm-disp-mediatek.c
> @@ -0,0 +1,225 @@
> +/*
> + * Mediatek display pulse-width-modulation controller driver.
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
> +#define DISP_PWM_EN_OFF                        (0x0)
> +#define PWM_ENABLE_SHIFT               (0x0)
> +#define PWM_ENABLE_MASK                        (0x1 << PWM_ENABLE_SHIFT)

Get rid of the _SHIFT which are actually zero, it will make the code
more readable.

> +
> +#define DISP_PWM_COMMIT_OFF            (0x08)
> +#define PWM_COMMIT_SHIFT               (0x0)
> +#define PWM_COMMIT_MASK                        (0x1 << PWM_COMMIT_SHIFT)
> +
> +#define DISP_PWM_CON_0_OFF             (0x10)
> +#define PWM_CLKDIV_SHIFT               (0x10)
> +#define PWM_CLKDIV_MASK                        (0x3ff << PWM_CLKDIV_SHIFT)
> +#define PWM_CLKDIV_MAX                 (0x000003ff)
> +
> +#define DISP_PWM_CON_1_OFF             (0x14)
> +#define PWM_PERIOD_SHIFT               (0x0)
> +#define PWM_PERIOD_MASK                        (0xfff << PWM_PERIOD_SHIFT)
> +#define PWM_PERIOD_MAX                 (0x00000fff)
> +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> +#define PWM_PERIOD_BIT_SHIFT           12
> +
> +#define PWM_HIGH_WIDTH_SHIFT           (0x10)
> +#define PWM_HIGH_WIDTH_MASK            (0x1fff << PWM_HIGH_WIDTH_SHIFT)
> +
> +#define NUM_PWM 1
> +
> +struct mtk_disp_pwm_chip {
> +       struct pwm_chip chip;
> +       struct device   *dev;
> +       struct clk      *clk_main;
> +       struct clk      *clk_mm;
> +       void __iomem    *mmio_base;
> +};
> +
> +static void mtk_disp_pwm_setting(void __iomem *address, u32 value, u32 mask)
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
> +       struct mtk_disp_pwm_chip *mpc;
> +       u64 div, rate;
> +       u32 clk_div, period, high_width, rem;
> +
> +       /*
> +        * Find period, high_width and clk_div to suit duty_ns and period_ns.
> +        * Calculate proper div value to keep period value in the bound.
> +        *
> +        * period_ns = 10^9 * (clk_div + 1) * (period +1) / PWM_CLK_RATE
> +        * duty_ns = 10^9 * (clk_div + 1) * (high_width + 1) / PWM_CLK_RATE
> +        *
> +        * period = (PWM_CLK_RATE * period_ns) / (10^9 * (clk_div + 1)) - 1
> +        * high_width = (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1)) - 1
> +        */
> +       mpc = container_of(chip, struct mtk_disp_pwm_chip, chip);
> +       rate = clk_get_rate(mpc->clk_main);
> +       clk_div = div_u64_rem(rate * period_ns, NSEC_PER_SEC, &rem) >>
> +                               PWM_PERIOD_BIT_SHIFT;

You never use the remainder, so better use div_u64 to make the code cleaner.

> +       if (clk_div > PWM_CLKDIV_MAX)
> +               return -EINVAL;
> +
> +       div = clk_div + 1;
> +       period = div64_u64(rate * period_ns, NSEC_PER_SEC * div);
> +       if (period > 0)
> +               period--;
> +       high_width = div64_u64(rate * duty_ns, NSEC_PER_SEC * div);
> +       if (high_width > 0)
> +               high_width--;
> +
> +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_CON_0_OFF,
> +                            clk_div << PWM_CLKDIV_SHIFT, PWM_CLKDIV_MASK);
> +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_CON_1_OFF,
> +                            (period << PWM_PERIOD_SHIFT) |
> +                       (high_width << PWM_HIGH_WIDTH_SHIFT),
> +                       PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK);
> +
> +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_COMMIT_OFF,
> +                            1 << PWM_COMMIT_SHIFT, PWM_COMMIT_MASK);
> +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_COMMIT_OFF,
> +                            0 << PWM_COMMIT_SHIFT, PWM_COMMIT_MASK);
> +
> +       return 0;
> +}
> +
> +static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +       struct mtk_disp_pwm_chip *mpc;
> +
> +       mpc = container_of(chip, struct mtk_disp_pwm_chip, chip);
> +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_EN_OFF,
> +                            1 << PWM_ENABLE_SHIFT, PWM_ENABLE_MASK);
> +
> +       return 0;
> +}
> +
> +static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +       struct mtk_disp_pwm_chip *mpc;
> +
> +       mpc = container_of(chip, struct mtk_disp_pwm_chip, chip);
> +       mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_EN_OFF,
> +                            0 << PWM_ENABLE_SHIFT, PWM_ENABLE_MASK);
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
> +       struct mtk_disp_pwm_chip *pwm;
> +       struct resource *r;
> +       int ret;
> +
> +       pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +       if (!pwm)
> +               return -ENOMEM;
> +
> +       pwm->dev = &pdev->dev;
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> +       if (IS_ERR(pwm->mmio_base))
> +               return PTR_ERR(pwm->mmio_base);
> +
> +       pwm->clk_main = devm_clk_get(&pdev->dev, "main");
> +       if (IS_ERR(pwm->clk_main))
> +               return PTR_ERR(pwm->clk_main);

I prefer to have a newline after the if-then-ese block, which makes it
(at least for me) easier to read the code.

Thanks,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
