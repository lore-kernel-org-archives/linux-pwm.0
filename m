From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH v2 1/4] pwm: Imagination Technologies PWM DAC driver
Date: Wed, 19 Nov 2014 15:15:54 -0800
Message-ID: <CAL1qeaG=tSN_QUSNLpFejss=VS5qk-BJ6vEr3z52BcioJZm54w@mail.gmail.com>
References: <1415979460-1093-1-git-send-email-naidu.tellapati@imgtec.com>
	<1415979460-1093-2-git-send-email-naidu.tellapati@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:48272 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbaKSXPz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Nov 2014 18:15:55 -0500
Received: by mail-vc0-f180.google.com with SMTP id im6so846372vcb.39
        for <linux-pwm@vger.kernel.org>; Wed, 19 Nov 2014 15:15:55 -0800 (PST)
In-Reply-To: <1415979460-1093-2-git-send-email-naidu.tellapati@imgtec.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Naidu Tellapati <naidu.tellapati@imgtec.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Arul Ramasamy <arul.ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

Naidu,

On Fri, Nov 14, 2014 at 7:37 AM,  <naidu.tellapati@imgtec.com> wrote:
> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>
> The Pistachio SOC from Imagination Technologies includes a Pulse Width
> Modulation DAC which produces 1 to 4 digital bit-outputs which represent
> digital waveforms. These PWM outputs are primarily in charge of controlling
> backlight LED devices.
>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index ef2dd2e..7aff57c 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -110,6 +110,17 @@ config PWM_FSL_FTM
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-fsl-ftm.
>
> +config PWM_IMG
> +       tristate "Imagination Technologies PWM driver"
> +       depends on MFD_SYSCON
> +       depends on HAS_IOMEM

That makes this driver selectable in an awful lot of configurations.
Perhaps add a depends on MIPS || COMPILE_TEST (and METAG if this IP is
present on META SoCs)?

> new file mode 100755
> index 0000000..49dfd07
> --- /dev/null
> +++ b/drivers/pwm/pwm-img.c
> @@ -0,0 +1,307 @@
> +/*
> + * Imagination Technologies Pulse Width Modulator driver
> + *
> + * Copyright (c) 2014, Imagination Technologies
> + *
> + * Based on drivers/pwm/pwm-tegra.c, Copyright (c) 2010, NVIDIA Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *

Extra line here.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +/* PWM registers */
> +#define CR_PWM_CTRL_CFG                                0x0000
> +#define CR_PWM_CTRL_CFG_NO_SUB_DIV             0
> +#define CR_PWM_CTRL_CFG_SUB_DIV0               1
> +#define CR_PWM_CTRL_CFG_SUB_DIV1               2
> +#define CR_PWM_CTRL_CFG_SUB_DIV0_DIV1          3
> +#define CR_PWM_CTRL_CFG_DIV_MASK_SHIFT(ch)     (ch * 2 + 4)

Parenthesize ch.  Also, I don't think the _MASK_ part of the name is necessary.

> +#define CR_PWM_CTRL_CFG_DIV_MASK               0x3
> +
> +#define CR_PWM_CH_CFG(ch)                      (0x4 + (ch) * 4)
> +#define CR_PWM_CH_CFG_TMBASE_SHIFT             0
> +#define CR_PWM_CH_CFG_DUTY_SHIFT               16
> +
> +#define CR_PERIP_PWM_PDM_CONTROL               0x0140
> +#define CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(ch)  (ch * 4)

Parenthesize ch here as well.

> +#define NUM_PWM                                        4

That's a rather generic name.  Maybe IMG_NUM_PWM instead?

> +#define MAX_TMBASE_STEPS                       65536
> +
> +struct img_pwm_chip {
> +       struct device   *dev;
> +       struct clk      *clk;
> +       struct clk      *sys_clk;
> +       struct pwm_chip chip;
> +       void __iomem    *base;
> +       struct regmap *periph_regs;

Spacing is inconsistent here.

> +};
> +
> +static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
> +{
> +       return container_of(chip, struct img_pwm_chip, chip);
> +}
> +
> +static inline void img_pwm_writel(struct img_pwm_chip *chip,
> +                               unsigned int reg, unsigned long val)
> +{
> +       writel(val, chip->base + reg);
> +}
> +
> +static inline unsigned int img_pwm_readl(struct img_pwm_chip *chip,
> +                                       unsigned int reg)
> +{
> +       return readl(chip->base + reg);
> +}
> +
> +static int img_pwm_get_div_and_tmbase(struct pwm_chip *chip,
> +               unsigned long in_freq, unsigned long out_freq,
> +               unsigned int *divider, unsigned int *tmbase)
> +{
> +       unsigned long mul;
> +
> +       mul = DIV_ROUND_UP(in_freq, out_freq);
> +       if (mul > MAX_TMBASE_STEPS * 512)
> +               return -EINVAL;
> +
> +       if (mul <= MAX_TMBASE_STEPS) {
> +               *divider = 1;
> +               *tmbase = mul;
> +       } else if (mul <= MAX_TMBASE_STEPS * 8) {
> +               *divider = 8;
> +               *tmbase = mul / 8;
> +               *tmbase += mul % 8;

Hmm... I'm not sure this is right.  Are you sure you don't want tmbase
= DIV_ROUND_UP(mul, 8) or DIV_ROUND_CLOSEST(mul, 8)?

> +       } else if (mul <= MAX_TMBASE_STEPS * 64) {
> +               *divider = 64;
> +               *tmbase = mul / 64;
> +               *tmbase += mul % 64;
> +       } else if (mul <= MAX_TMBASE_STEPS * 512) {
> +               *divider = 512;
> +               *tmbase = mul / 512;
> +               *tmbase += mul % 512;
> +       }
> +
> +       return 0;
> +}
> +
> +static void img_pwm_ch_config(struct img_pwm_chip *chip,
> +               unsigned int ch_num, unsigned int divider,
> +               unsigned int tmbase_steps, unsigned int duty_steps)
> +{
> +       unsigned int div;
> +       unsigned long val;
> +
> +       switch (divider) {
> +       case 1:
> +               div = CR_PWM_CTRL_CFG_NO_SUB_DIV;
> +               break;
> +       case 8:
> +               div = CR_PWM_CTRL_CFG_SUB_DIV0;
> +               break;
> +       case 64:
> +               div = CR_PWM_CTRL_CFG_SUB_DIV1;
> +               break;
> +       case 512:
> +               div = CR_PWM_CTRL_CFG_SUB_DIV0_DIV1;
> +               break;
> +       }
> +
> +       val = img_pwm_readl(chip, CR_PWM_CTRL_CFG);
> +       val &= ~(CR_PWM_CTRL_CFG_DIV_MASK <<
> +                                       CR_PWM_CTRL_CFG_DIV_MASK_SHIFT(ch_num));
> +       val |= (div & CR_PWM_CTRL_CFG_DIV_MASK) <<
> +                                       CR_PWM_CTRL_CFG_DIV_MASK_SHIFT(ch_num);
> +       img_pwm_writel(chip, CR_PWM_CTRL_CFG, val);
> +
> +       val = (duty_steps << CR_PWM_CH_CFG_DUTY_SHIFT) |
> +                               (tmbase_steps << CR_PWM_CH_CFG_TMBASE_SHIFT);
> +       img_pwm_writel(chip, CR_PWM_CH_CFG(ch_num), val);
> +}
> +
> +static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +                       int duty_ns, int period_ns)
> +{
> +       unsigned int divider;
> +       unsigned int duty_steps;
> +       unsigned int tmbase_steps;
> +       unsigned long output_clk_hz;
> +       unsigned long input_clk_hz;
> +       struct img_pwm_chip *pwm_chip;
> +
> +       pwm_chip = to_img_pwm_chip(chip);
> +
> +       input_clk_hz = clk_get_rate(pwm_chip->clk);
> +       output_clk_hz = DIV_ROUND_UP(NSEC_PER_SEC, period_ns);
> +       if (img_pwm_get_div_and_tmbase(chip, input_clk_hz,
> +                               output_clk_hz, &divider, &tmbase_steps) < 0) {
> +               dev_err(chip->dev,
> +                       "failed to configure timebase steps/divider value.\n");
> +               return -EINVAL;
> +       }
> +
> +       duty_steps = (tmbase_steps * duty_ns) / period_ns;
> +       img_pwm_ch_config(pwm_chip, pwm->hwpwm, divider,
> +                       tmbase_steps, duty_steps);

IMO it would be cleaner if img_pwm_get_div_and_tmbase() and
img_pwm_ch_config() were just folded into this function.

> +
> +       return 0;
> +}
> +
> +static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +       unsigned int val;
> +       struct img_pwm_chip *pwm_chip;
> +
> +       pwm_chip = to_img_pwm_chip(chip);
> +
> +       val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +       val |= BIT(pwm->hwpwm);
> +       img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +
> +       regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
> +                       BIT(CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm)),
> +                       0 << CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm));

Just use 0 for this argument.

> +
> +       return 0;
> +}
> +
> +static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +       unsigned int val = 0;

No need to initialize val.

> +       struct img_pwm_chip *pwm_chip;
> +
> +       pwm_chip = to_img_pwm_chip(chip);
> +
> +       val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +       val &= ~BIT(pwm->hwpwm);
> +       img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +
> +       regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
> +                       BIT(CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm)),
> +                       1 << (CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm)));

BIT(CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(...))?

> +}
> +
> +static const struct pwm_ops img_pwm_ops = {
> +       .config = img_pwm_config,
> +       .enable = img_pwm_enable,
> +       .disable = img_pwm_disable,
> +       .owner = THIS_MODULE,
> +};
> +
> +static int img_pwm_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct resource *res;
> +       struct img_pwm_chip *pwm;
> +
> +       pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +       if (!pwm)
> +               return -ENOMEM;
> +
> +       pwm->dev = &pdev->dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       pwm->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(pwm->base))
> +               return PTR_ERR(pwm->base);
> +
> +       pwm->periph_regs = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +                                                       "img,cr-periph");
> +       if (IS_ERR(pwm->periph_regs))
> +               return PTR_ERR(pwm->periph_regs);
> +
> +       pwm->sys_clk = devm_clk_get(&pdev->dev, "sys");
> +       if (IS_ERR(pwm->sys_clk)) {
> +               dev_err(&pdev->dev, "failed to get the system clock.\n");
> +               return PTR_ERR(pwm->sys_clk);
> +       }
> +
> +       pwm->clk = devm_clk_get(&pdev->dev, "pwm");
> +       if (IS_ERR(pwm->clk)) {
> +               dev_err(&pdev->dev, "failed to get the clock.\n");
> +               return PTR_ERR(pwm->clk);
> +       }
> +
> +       ret = clk_prepare_enable(pwm->sys_clk);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "could not prepare or enable pwm clock.\n");
> +               return ret;
> +       }
> +
> +       ret = clk_prepare_enable(pwm->clk);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "could not prepare or enable pwm clock.\n");
> +               goto disable_sysclk;
> +       }
> +
> +       pwm->chip.dev = &pdev->dev;
> +       pwm->chip.ops = &img_pwm_ops;
> +       pwm->chip.base = -1;
> +       pwm->chip.npwm = NUM_PWM;
> +
> +       ret = pwmchip_add(&pwm->chip);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
> +               goto disable_pwmclk;
> +       }
> +
> +       platform_set_drvdata(pdev, pwm);
> +
> +disable_pwmclk:
> +       clk_disable_unprepare(pwm->clk);
> +disable_sysclk:
> +       clk_disable_unprepare(pwm->sys_clk);
> +
> +       return 0;
> +}
> +
> +static int img_pwm_remove(struct platform_device *pdev)
> +{
> +       int i;

unsigned

> +       unsigned int val = 0;

No need to initialize val.

> +       struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
> +
> +       for (i = 0; i < NUM_PWM; i++) {
> +               val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +               val &= ~BIT(i);
> +               img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +       }
> +
> +       clk_disable_unprepare(pwm_chip->clk);
> +       clk_disable_unprepare(pwm_chip->sys_clk);
> +
> +       return pwmchip_remove(&pwm_chip->chip);
> +}
> +
> +static const struct of_device_id img_pwm_of_match[] = {
> +       { .compatible = "img,pistachio-pwm", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, img_pwm_of_match);
> +
> +static struct platform_driver img_pwm_driver = {
> +       .driver = {
> +               .name = "img-pwm",
> +               .of_match_table = of_match_ptr(img_pwm_of_match),
> +       },
> +       .probe = img_pwm_probe,
> +       .remove = img_pwm_remove,
> +};
> +module_platform_driver(img_pwm_driver);
> +
> +MODULE_AUTHOR("Sai Masarapu <Sai.Masarapu@imgtec.com>");
> +MODULE_DESCRIPTION("Imagination Technologies PWM DAC driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.0.4
>
