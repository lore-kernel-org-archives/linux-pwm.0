From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 1/4] pwm: Imagination Technologies PWM DAC driver
Date: Wed, 12 Nov 2014 21:43:49 -0800
Message-ID: <CAL1qeaFuKccak4fJFOK1YSW1uoyLA_a=GFWJ1PTS00Ab9vZB9A@mail.gmail.com>
References: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1415795873-4816-2-git-send-email-Naidu.Tellapati@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:40920 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaKMFnu (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Nov 2014 00:43:50 -0500
Received: by mail-vc0-f182.google.com with SMTP id im17so3078918vcb.41
        for <linux-pwm@vger.kernel.org>; Wed, 12 Nov 2014 21:43:49 -0800 (PST)
In-Reply-To: <1415795873-4816-2-git-send-email-Naidu.Tellapati@imgtec.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, linux-pwm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Nov 12, 2014 at 4:37 AM,  <Naidu.Tellapati@imgtec.com> wrote:
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
> index ef2dd2e..de1c922 100644

> @@ -110,6 +110,16 @@ config PWM_FSL_FTM
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-fsl-ftm.
>
> +config PWM_IMG
> +       tristate "Imagination Technologies PWM driver"
> +       depends on MFD_SYSCON

It also at least depends on HAS_IOMEM.  Is this IP present on non-MIPS
SoCs?  If not, then maybe add depends on MIPS || COMPILE_TEST.

> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> new file mode 100755
> index 0000000..9361dbf

> @@ -0,0 +1,294 @@
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
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.

I don't think this paragraph is necessary.

> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +
> +/* PWM registers */
> +#define CR_PWM_CTRL_CFG                        0x0000 /* Control and config register */
> +#define PWM_CH_DIV_MASK(ch)            (BIT(ch * 2 + 4) | BIT(ch * 2 + 5))

This is a strange way to define a mask.  Like I mentioned in the
watchdog driver, I prefer to use unshifted masks - not sure if Thierry
has a preference though.

Also, be sure to parenthesize macro parameters when they are used in
the expression.

> +#define PWM_CH_DIV_SHIFT(ch)           (ch * 2 + 4)
> +
> +#define CR_PWM_CH_CFG(ch)              (0x4 + (ch) * 4) /* Config register */
> +#define TMBASE_SHIFT                   0
> +#define DUTY_SHIFT                     16

Maybe prefix these tow CR_PWM_CH_CFG to make it clear as to which
register these fields belong?  Same goes for the other field #defines
below.

> +#define CR_PERIP_PWM_PDM_CONTROL       0x0140 /* PWM and PDM ctrl register */
> +#define PWM_PDM_CH_CTRL_SHIFT(ch)      (ch * 4)
> +
> +#define NUM_PWM                                4
> +#define SUB_DIV0                       1
> +#define SUB_DIV1                       2
> +#define NO_SUB_DIV                     0
> +#define SUB_DIV0_DIV1                  3
> +#define MIN_TMBASE_STEPS               1
> +#define MAX_TMBASE_STEPS               65536
> +#define MIN_DUTY_STEPS                 0
> +#define MAX_DUTY_STEPS                 65535

Please place these #defines next to their corresponding register or
register field #define.

> +struct img_pwm_chip {
> +       struct device   *dev;
> +       struct clk      *clk;
> +       struct pwm_chip chip;
> +       void __iomem    *base;
> +       struct regmap *periph_regs;
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
> +               div = NO_SUB_DIV;
> +               break;
> +       case 8:
> +               div = SUB_DIV0;
> +               break;
> +       case 64:
> +               div = SUB_DIV1;
> +               break;
> +       case 512:
> +               div = SUB_DIV0_DIV1;
> +               break;
> +       }
> +
> +       val = img_pwm_readl(chip, CR_PWM_CTRL_CFG);
> +       val &= ~PWM_CH_DIV_MASK(ch_num);
> +       val |= (div << PWM_CH_DIV_SHIFT(ch_num)) & PWM_CH_DIV_MASK(ch_num);
> +       img_pwm_writel(chip, CR_PWM_CTRL_CFG, val);
> +
> +       duty_steps = duty_steps << DUTY_SHIFT;
> +       tmbase_steps = tmbase_steps << TMBASE_SHIFT;
> +       val = (duty_steps | tmbase_steps);

Why not do:

val = (duty_steps << DUTY_SHIFT) | (tmbase_steps << TMBASE_SHIFT):

I don't see any need for the intermediate assignments.

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
> +       duty_steps = (tmbase_steps * duty_ns) / (period_ns);

Unnecessary parenthesis.

> +       img_pwm_ch_config(pwm_chip, pwm->hwpwm, divider,
> +                       tmbase_steps, duty_steps);
> +
> +       return 0;
> +}
> +
> +static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +       unsigned int val = 0;

No need to initialize val (there are other places where this is done as well).

> +       struct img_pwm_chip *pwm_chip;
> +
> +       pwm_chip = to_img_pwm_chip(chip);
> +
> +       val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +       val |= BIT(pwm->hwpwm);
> +       img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +       regmap_read(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL, &val);
> +       val &= ~BIT(PWM_PDM_CH_CTRL_SHIFT(pwm->hwpwm));
> +       regmap_write(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL, val);
> +
> +       return 0;
> +}
> +
> +static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +       unsigned int val = 0;
> +       struct img_pwm_chip *pwm_chip;
> +
> +       pwm_chip = to_img_pwm_chip(chip);
> +
> +       val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +       val &= ~BIT(pwm->hwpwm);
> +       img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +       regmap_read(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL, &val);
> +       val |= BIT(PWM_PDM_CH_CTRL_SHIFT(pwm->hwpwm));
> +       regmap_write(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL, val);

FYI there's regmap_update_bits() which will do the read-modify-write sequence.

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
> +       pwm->clk = devm_clk_get(&pdev->dev, "pwm");
> +       if (IS_ERR(pwm->clk)) {
> +               dev_err(&pdev->dev, "failed to get the clock.\n");
> +               return PTR_ERR(pwm->clk);
> +       }
> +
> +       ret = clk_prepare_enable(pwm->clk);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "could not prepare or enable pwm clock.\n");
> +               return ret;
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
> +               clk_disable_unprepare(pwm->clk);
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, pwm);
> +
> +       return 0;
> +}
> +
> +static int img_pwm_remove(struct platform_device *pdev)
> +{
> +       int i;
> +       unsigned int val = 0;
> +       struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
> +
> +       for (i = 0; i < NUM_PWM; i++) {
> +               val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
> +               val &= ~BIT(i);
> +               img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
> +       }
> +
> +       clk_disable_unprepare(pwm_chip->clk);
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
