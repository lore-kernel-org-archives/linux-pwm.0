Return-Path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
Subject: [PATCH v3 1/4] pwm: Imagination Technologies PWM DAC driver
Date: Thu, 20 Nov 2014 20:23:57 +0530
Message-Id: <1416495240-22821-2-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1416495240-22821-1-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1416495240-22821-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com, Ezequiel.Garcia@imgtec.com
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

The Pistachio SOC from Imagination Technologies includes a Pulse Width
Modulation DAC which produces 1 to 4 digital bit-outputs which represent
digital waveforms. These PWM outputs are primarily in charge of controlling
backlight LED devices.

Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
---
 drivers/pwm/Kconfig   |   12 ++
 drivers/pwm/Makefile  |    1 +
 drivers/pwm/pwm-img.c |  284 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 297 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pwm/pwm-img.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ef2dd2e..6b4581a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -110,6 +110,18 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.
 
+config PWM_IMG
+	tristate "Imagination Technologies PWM driver"
+	depends on MFD_SYSCON
+	depends on HAS_IOMEM
+	depends on MIPS || COMPILE_TEST
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
new file mode 100644
index 0000000..ed71148
--- /dev/null
+++ b/drivers/pwm/pwm-img.c
@@ -0,0 +1,284 @@
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
+ */
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/* PWM registers */
+#define CR_PWM_CTRL_CFG				0x0000
+#define CR_PWM_CTRL_CFG_NO_SUB_DIV		0
+#define CR_PWM_CTRL_CFG_SUB_DIV0		1
+#define CR_PWM_CTRL_CFG_SUB_DIV1		2
+#define CR_PWM_CTRL_CFG_SUB_DIV0_DIV1		3
+#define CR_PWM_CTRL_CFG_DIV_SHIFT(ch)		((ch) * 2 + 4)
+#define CR_PWM_CTRL_CFG_DIV_MASK		0x3
+
+#define CR_PWM_CH_CFG(ch)			(0x4 + (ch) * 4)
+#define CR_PWM_CH_CFG_TMBASE_SHIFT		0
+#define CR_PWM_CH_CFG_DUTY_SHIFT		16
+
+#define CR_PERIP_PWM_PDM_CONTROL		0x0140
+#define CR_PERIP_PWM_PDM_CONTROL_CH_MASK	0x1
+#define CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(ch)	((ch) * 4)
+
+#define IMG_NUM_PWM				4
+#define MAX_TMBASE_STEPS			65536
+
+struct img_pwm_chip {
+	struct device	*dev;
+	struct pwm_chip	chip;
+	struct clk	*pwm_clk;
+	struct clk	*sys_clk;
+	void __iomem	*base;
+	struct regmap	*periph_regs;
+};
+
+static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct img_pwm_chip, chip);
+}
+
+static inline void img_pwm_writel(struct img_pwm_chip *chip,
+				  unsigned int reg, unsigned long val)
+{
+	writel(val, chip->base + reg);
+}
+
+static inline unsigned int img_pwm_readl(struct img_pwm_chip *chip,
+					 unsigned int reg)
+{
+	return readl(chip->base + reg);
+}
+
+static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			  int duty_ns, int period_ns)
+{
+	unsigned int div;
+	unsigned int divider;
+	unsigned int duty_steps;
+	unsigned int tmbase_steps;
+	unsigned long val;
+	unsigned long mul;
+	unsigned long output_clk_hz;
+	unsigned long input_clk_hz;
+
+	struct img_pwm_chip *pwm_chip;
+
+	pwm_chip = to_img_pwm_chip(chip);
+
+	input_clk_hz = clk_get_rate(pwm_chip->pwm_clk);
+	output_clk_hz = DIV_ROUND_UP(NSEC_PER_SEC, period_ns);
+
+	mul = DIV_ROUND_UP(input_clk_hz, output_clk_hz);
+	if (mul > MAX_TMBASE_STEPS * 512) {
+		dev_err(chip->dev,
+			"failed to configure timebase steps/divider value.\n");
+		return -EINVAL;
+	}
+
+	if (mul <= MAX_TMBASE_STEPS)
+		divider = 1;
+	else if (mul <= MAX_TMBASE_STEPS * 8)
+		divider = 8;
+	else if (mul <= MAX_TMBASE_STEPS * 64)
+		divider = 64;
+	else if (mul <= MAX_TMBASE_STEPS * 512)
+		divider = 512;
+
+	tmbase_steps = DIV_ROUND_UP(mul, divider);
+
+	duty_steps = DIV_ROUND_UP(tmbase_steps * duty_ns, period_ns);
+
+	switch (divider) {
+	case 1:
+		div = CR_PWM_CTRL_CFG_NO_SUB_DIV;
+		break;
+	case 8:
+		div = CR_PWM_CTRL_CFG_SUB_DIV0;
+		break;
+	case 64:
+		div = CR_PWM_CTRL_CFG_SUB_DIV1;
+		break;
+	case 512:
+		div = CR_PWM_CTRL_CFG_SUB_DIV0_DIV1;
+		break;
+	}
+
+	val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
+	val &= ~(CR_PWM_CTRL_CFG_DIV_MASK <<
+					CR_PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
+	val |= (div & CR_PWM_CTRL_CFG_DIV_MASK) <<
+					CR_PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm);
+	img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
+
+	val = (duty_steps << CR_PWM_CH_CFG_DUTY_SHIFT) |
+				(tmbase_steps << CR_PWM_CH_CFG_TMBASE_SHIFT);
+	img_pwm_writel(pwm_chip, CR_PWM_CH_CFG(pwm->hwpwm), val);
+
+	return 0;
+}
+
+static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	unsigned int val;
+	struct img_pwm_chip *pwm_chip;
+
+	pwm_chip = to_img_pwm_chip(chip);
+
+	val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
+	val |= BIT(pwm->hwpwm);
+	img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
+
+	regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
+			   CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
+			   CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 0);
+
+	return 0;
+}
+
+static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	unsigned int val;
+	struct img_pwm_chip *pwm_chip;
+
+	pwm_chip = to_img_pwm_chip(chip);
+
+	val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
+	val &= ~BIT(pwm->hwpwm);
+	img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
+
+	regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
+			   CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
+			   CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 1);
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
+	pwm->sys_clk = devm_clk_get(&pdev->dev, "sys");
+	if (IS_ERR(pwm->sys_clk)) {
+		dev_err(&pdev->dev, "failed to get system clock.\n");
+		return PTR_ERR(pwm->sys_clk);
+	}
+
+	pwm->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
+	if (IS_ERR(pwm->pwm_clk)) {
+		dev_err(&pdev->dev, "failed to get pwm clock.\n");
+		return PTR_ERR(pwm->pwm_clk);
+	}
+
+	ret = clk_prepare_enable(pwm->sys_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not prepare or enable sys clock.\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pwm->pwm_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not prepare or enable pwm clock.\n");
+		goto disable_sysclk;
+	}
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &img_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = IMG_NUM_PWM;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
+		goto disable_pwmclk;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+disable_pwmclk:
+	clk_disable_unprepare(pwm->pwm_clk);
+disable_sysclk:
+	clk_disable_unprepare(pwm->sys_clk);
+
+	return 0;
+}
+
+static int img_pwm_remove(struct platform_device *pdev)
+{
+	unsigned int i;
+	unsigned int val;
+
+	struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
+
+	for (i = 0; i < IMG_NUM_PWM; i++) {
+		val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
+		val &= ~BIT(i);
+		img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
+	}
+
+	clk_disable_unprepare(pwm_chip->pwm_clk);
+	clk_disable_unprepare(pwm_chip->sys_clk);
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
