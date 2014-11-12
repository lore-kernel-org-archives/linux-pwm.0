Return-Path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
Subject: [PATCH 1/4] pwm: Imagination Technologies PWM DAC driver
Date: Wed, 12 Nov 2014 18:07:50 +0530
Message-Id: <1415795873-4816-2-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, James.Hartley@imgtec.com, abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

The Pistachio SOC from Imagination Technologies includes a Pulse Width
Modulation DAC which produces 1 to 4 digital bit-outputs which represent
digital waveforms. These PWM outputs are primarily in charge of controlling
backlight LED devices.

Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
---
 drivers/pwm/Kconfig   |   10 ++
 drivers/pwm/Makefile  |    1 +
 drivers/pwm/pwm-img.c |  294 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+), 0 deletions(-)
 create mode 100755 drivers/pwm/pwm-img.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ef2dd2e..de1c922 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -110,6 +110,16 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.
 
+config PWM_IMG
+	tristate "Imagination Technologies PWM driver"
+	depends on MFD_SYSCON 
+	help
+	  Generic PWM framework driver for Imagination Technologies
+	  PWM block which supports 4 channels.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-img.
+
 config PWM_IMX
 	tristate "i.MX PWM support"
 	depends on ARCH_MXC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c458606..29655fd 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
+obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
new file mode 100755
index 0000000..9361dbf
--- /dev/null
+++ b/drivers/pwm/pwm-img.c
@@ -0,0 +1,294 @@
+/*
+ * Imagination Technologies Pulse Width Modulator driver
+ *
+ * Copyright (c) 2014, Imagination Technologies
+ *
+ * Based on drivers/pwm/pwm-tegra.c, Copyright (c) 2010, NVIDIA Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+
+/* PWM registers */
+#define CR_PWM_CTRL_CFG			0x0000 /* Control and config register */
+#define PWM_CH_DIV_MASK(ch)		(BIT(ch * 2 + 4) | BIT(ch * 2 + 5))
+#define PWM_CH_DIV_SHIFT(ch)		(ch * 2 + 4)
+
+#define CR_PWM_CH_CFG(ch)		(0x4 + (ch) * 4) /* Config register */
+#define TMBASE_SHIFT			0
+#define DUTY_SHIFT			16
+
+#define CR_PERIP_PWM_PDM_CONTROL	0x0140 /* PWM and PDM ctrl register */
+#define PWM_PDM_CH_CTRL_SHIFT(ch)	(ch * 4)
+
+#define NUM_PWM				4
+#define SUB_DIV0			1
+#define SUB_DIV1			2
+#define NO_SUB_DIV			0
+#define SUB_DIV0_DIV1			3
+#define MIN_TMBASE_STEPS		1
+#define MAX_TMBASE_STEPS		65536
+#define MIN_DUTY_STEPS			0
+#define MAX_DUTY_STEPS			65535
+
+struct img_pwm_chip {
+	struct device   *dev;
+	struct clk      *clk;
+	struct pwm_chip chip;
+	void __iomem    *base;
+	struct regmap *periph_regs;
+};
+
+static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct img_pwm_chip, chip);
+}
+
+static inline void img_pwm_writel(struct img_pwm_chip *chip,
+				unsigned int reg, unsigned long val)
+{
+	writel(val, chip->base + reg);
+}
+
+static inline unsigned int img_pwm_readl(struct img_pwm_chip *chip,
+					unsigned int reg)
+{
+	return readl(chip->base + reg);
+}
+
+static int img_pwm_get_div_and_tmbase(struct pwm_chip *chip,
+		unsigned long in_freq, unsigned long out_freq,
+		unsigned int *divider, unsigned int *tmbase)
+{
+	unsigned long mul;
+
+	mul = DIV_ROUND_UP(in_freq, out_freq);
+	if (mul > MAX_TMBASE_STEPS * 512)
+		return -EINVAL;
+
+	if (mul <= MAX_TMBASE_STEPS) {
+		*divider = 1;
+		*tmbase = mul;
+	} else if (mul <= MAX_TMBASE_STEPS * 8) {
+		*divider = 8;
+		*tmbase = mul / 8;
+		*tmbase += mul % 8;
+	} else if (mul <= MAX_TMBASE_STEPS * 64) {
+		*divider = 64;
+		*tmbase = mul / 64;
+		*tmbase += mul % 64;
+	} else if (mul <= MAX_TMBASE_STEPS * 512) {
+		*divider = 512;
+		*tmbase = mul / 512;
+		*tmbase += mul % 512;
+	}
+
+	return 0;
+}
+
+static void img_pwm_ch_config(struct img_pwm_chip *chip,
+		unsigned int ch_num, unsigned int divider,
+		unsigned int tmbase_steps, unsigned int duty_steps)
+{
+	unsigned int div;
+	unsigned long val;
+
+	switch (divider) {
+	case 1:
+		div = NO_SUB_DIV;
+		break;
+	case 8:
+		div = SUB_DIV0;
+		break;
+	case 64:
+		div = SUB_DIV1;
+		break;
+	case 512:
+		div = SUB_DIV0_DIV1;
+		break;
+	}
+
+	val = img_pwm_readl(chip, CR_PWM_CTRL_CFG);
+	val &= ~PWM_CH_DIV_MASK(ch_num);
+	val |= (div << PWM_CH_DIV_SHIFT(ch_num)) & PWM_CH_DIV_MASK(ch_num);
+	img_pwm_writel(chip, CR_PWM_CTRL_CFG, val);
+
+	duty_steps = duty_steps << DUTY_SHIFT;
+	tmbase_steps = tmbase_steps << TMBASE_SHIFT;
+	val = (duty_steps | tmbase_steps);
+	img_pwm_writel(chip, CR_PWM_CH_CFG(ch_num), val);
+}
+
+static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			int duty_ns, int period_ns)
+{
+	unsigned int divider;
+	unsigned int duty_steps;
+	unsigned int tmbase_steps;
+	unsigned long output_clk_hz;
+	unsigned long input_clk_hz;
+	struct img_pwm_chip *pwm_chip;
+
+	pwm_chip = to_img_pwm_chip(chip);
+
+	input_clk_hz = clk_get_rate(pwm_chip->clk);
+	output_clk_hz = DIV_ROUND_UP(NSEC_PER_SEC, period_ns);
+	if (img_pwm_get_div_and_tmbase(chip, input_clk_hz,
+				output_clk_hz, &divider, &tmbase_steps) < 0) {
+		dev_err(chip->dev,
+			"failed to configure timebase steps/divider value.\n");
+		return -EINVAL;
+	}
+
+	duty_steps = (tmbase_steps * duty_ns) / (period_ns);
+	img_pwm_ch_config(pwm_chip, pwm->hwpwm, divider,
+			tmbase_steps, duty_steps);
+
+	return 0;
+}
+
+static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	unsigned int val = 0;
+	struct img_pwm_chip *pwm_chip;
+
+	pwm_chip = to_img_pwm_chip(chip);
+
+	val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
+	val |= BIT(pwm->hwpwm);
+	img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
+	regmap_read(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL, &val);
+	val &= ~BIT(PWM_PDM_CH_CTRL_SHIFT(pwm->hwpwm));
+	regmap_write(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL, val);
+
+	return 0;
+}
+
+static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	unsigned int val = 0;
+	struct img_pwm_chip *pwm_chip;
+
+	pwm_chip = to_img_pwm_chip(chip);
+
+	val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
+	val &= ~BIT(pwm->hwpwm);
+	img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
+	regmap_read(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL, &val);
+	val |= BIT(PWM_PDM_CH_CTRL_SHIFT(pwm->hwpwm));
+	regmap_write(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL, val);
+}
+
+static const struct pwm_ops img_pwm_ops = {
+	.config = img_pwm_config,
+	.enable = img_pwm_enable,
+	.disable = img_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int img_pwm_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *res;
+	struct img_pwm_chip *pwm;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pwm->base))
+		return PTR_ERR(pwm->base);
+
+	pwm->periph_regs = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							"img,cr-periph");
+	if (IS_ERR(pwm->periph_regs))
+		return PTR_ERR(pwm->periph_regs);
+
+	pwm->clk = devm_clk_get(&pdev->dev, "pwm");
+	if (IS_ERR(pwm->clk)) {
+		dev_err(&pdev->dev, "failed to get the clock.\n");
+		return PTR_ERR(pwm->clk);
+	}
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not prepare or enable pwm clock.\n");
+		return ret;
+	}
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &img_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = NUM_PWM;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
+		clk_disable_unprepare(pwm->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+}
+
+static int img_pwm_remove(struct platform_device *pdev)
+{
+	int i;
+	unsigned int val = 0;
+	struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
+
+	for (i = 0; i < NUM_PWM; i++) {
+		val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
+		val &= ~BIT(i);
+		img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
+	}
+
+	clk_disable_unprepare(pwm_chip->clk);
+
+	return pwmchip_remove(&pwm_chip->chip);
+}
+
+static const struct of_device_id img_pwm_of_match[] = {
+	{ .compatible = "img,pistachio-pwm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, img_pwm_of_match);
+
+static struct platform_driver img_pwm_driver = {
+	.driver = {
+		.name = "img-pwm",
+		.of_match_table = of_match_ptr(img_pwm_of_match),
+	},
+	.probe = img_pwm_probe,
+	.remove = img_pwm_remove,
+};
+module_platform_driver(img_pwm_driver);
+
+MODULE_AUTHOR("Sai Masarapu <Sai.Masarapu@imgtec.com>");
+MODULE_DESCRIPTION("Imagination Technologies PWM DAC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4
