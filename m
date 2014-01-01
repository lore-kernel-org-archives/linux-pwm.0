From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] pwm: Add CLPS711X PWM support
Date: Wed,  1 Jan 2014 07:43:41 +0400
Message-ID: <1388547821-10029-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:34546 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaAADoI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Dec 2013 22:44:08 -0500
Received: from smtp35.i.mail.ru (smtp35.i.mail.ru [94.100.177.95])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id 3A60BF9AE7B1
	for <linux-pwm@vger.kernel.org>; Wed,  1 Jan 2014 07:44:05 +0400 (MSK)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>

Add a new driver for the PWM controllers on the CLPS711X platform
based on the PWM framework.
---
 .../bindings/pwm/cirrus-clps711x-pwm.txt           |  16 +++
 drivers/pwm/Kconfig                                |   9 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-clps711x.c                         | 158 +++++++++++++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
 create mode 100644 drivers/pwm/pwm-clps711x.c

diff --git a/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
new file mode 100644
index 0000000..4caf819
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
@@ -0,0 +1,16 @@
+* Cirris Logic CLPS711X PWM controller
+
+Required properties:
+- compatible: Should be "cirrus,clps711x-pwm".
+- reg: Physical base address and length of the controller's registers.
+- clocks: Phandle to the PWM source clock.
+- #pwm-cells: Should be 1. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+	pwm: pwm@80000400 {
+		compatible = "cirrus,clps711x-pwm";
+		reg = <0x80000400 0x4>;
+		clocks = <&clks 8>;
+		#pwm-cells = <1>;
+	};
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 22f2f28..d3a2c26 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -71,6 +71,15 @@ config PWM_BFIN
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-bfin.
 
+config PWM_CLPS711X
+	tristate "CLPS711X PWM support"
+	depends on ARCH_CLPS711X || COMPILE_TEST
+	help
+	  Generic PWM framework driver for Cirrus Logic CLPS711X.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-clps711x.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index d8906ec..d676681 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
+obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
new file mode 100644
index 0000000..6c6e180
--- /dev/null
+++ b/drivers/pwm/pwm-clps711x.c
@@ -0,0 +1,158 @@
+/*
+ * Cirrus Logic CLPS711X PWM driver
+ *
+ * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+struct clps711x_chip {
+	struct pwm_chip	chip;
+	struct clk	*clk;
+	void __iomem	*pmpcon;
+	spinlock_t	lock;
+};
+
+static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct clps711x_chip *priv =
+		container_of(chip, struct clps711x_chip, chip);
+	unsigned int period, freq = clk_get_rate(priv->clk);
+
+	if (!freq)
+		return -EINVAL;
+
+	/* Calculate and store constant period value */
+	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
+	pwm_set_period(pwm, period);
+	pwm_set_chip_data(pwm, (void *)(uintptr_t)period);
+
+	return 0;
+}
+
+static int clps711x_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			       int duty_ns, int period_ns)
+{
+	unsigned int period = (uintptr_t)pwm_get_chip_data(pwm);
+	struct clps711x_chip *priv =
+		container_of(chip, struct clps711x_chip, chip);
+	u32 val, duty, shift;
+	unsigned long flags;
+
+	if (period_ns != period)
+		return -EINVAL;
+
+	/* Duty cycle 0..15 max */
+	duty = DIV_ROUND_CLOSEST(duty_ns * 0xf, period);
+	/* PWM0 - bits 4..7, PWM1 - bits 8..11 */
+	shift = (pwm->hwpwm + 1) * 4;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	val = readl(priv->pmpcon);
+	val &= ~(0xf << shift);
+	val |= duty << shift;
+	writel(val, priv->pmpcon);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int clps711x_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	/* Do nothing */
+	return 0;
+}
+
+static void clps711x_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	/* Do nothing */
+}
+
+static const struct pwm_ops clps711x_pwm_ops = {
+	.request	= clps711x_pwm_request,
+	.config		= clps711x_pwm_config,
+	.enable		= clps711x_pwm_enable,
+	.disable	= clps711x_pwm_disable,
+	.owner		= THIS_MODULE,
+};
+
+static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
+					     const struct of_phandle_args *args)
+{
+	if (args->args[0] >= chip->npwm)
+		return ERR_PTR(-EINVAL);
+
+	return pwm_request_from_chip(chip, args->args[0], NULL);
+}
+
+static int clps711x_pwm_probe(struct platform_device *pdev)
+{
+	struct clps711x_chip *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->pmpcon = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->pmpcon))
+		return PTR_ERR(priv->pmpcon);
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->chip.ops = &clps711x_pwm_ops;
+	priv->chip.dev = &pdev->dev;
+	priv->chip.base = -1;
+	priv->chip.npwm = 2;
+	priv->chip.of_xlate = clps711x_pwm_xlate;
+	priv->chip.of_pwm_n_cells = 1;
+
+	spin_lock_init(&priv->lock);
+
+	platform_set_drvdata(pdev, priv);
+
+	return pwmchip_add(&priv->chip);
+}
+
+static int clps711x_pwm_remove(struct platform_device *pdev)
+{
+	struct clps711x_chip *priv = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&priv->chip);
+}
+
+static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {
+	{ .compatible = "cirrus,clps711x-pwm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clps711x_pwm_dt_ids);
+
+static struct platform_driver clps711x_pwm_driver = {
+	.driver	= {
+		.name		= "clps711x-pwm",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(clps711x_pwm_dt_ids),
+	},
+	.probe	= clps711x_pwm_probe,
+	.remove	= clps711x_pwm_remove,
+};
+module_platform_driver(clps711x_pwm_driver);
+
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("Cirrus Logic CLPS711X PWM driver");
+MODULE_LICENSE("GPL");
-- 
1.8.3.2

