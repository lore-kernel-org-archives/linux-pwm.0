From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2 RESEND] pwm: Add CLPS711X PWM support
Date: Wed,  5 Feb 2014 19:22:29 +0400
Message-ID: <1391613749-7896-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.176.58]:47231 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaBEPXA (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Feb 2014 10:23:00 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

Add a new driver for the ARM CLPS711X Pulse Width Modulator (PWM) interface.
This CPU contain two 4-bit PWM outputs with constant period, based on CPU
PLL frequency. PWM polarity is determined by hardware by power on reset.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../bindings/pwm/cirrus-clps711x-pwm.txt           |  15 ++
 drivers/pwm/Kconfig                                |   9 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-clps711x.c                         | 176 +++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
 create mode 100644 drivers/pwm/pwm-clps711x.c

diff --git a/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
new file mode 100644
index 0000000..e252f6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
@@ -0,0 +1,15 @@
+* Cirris Logic CLPS711X PWM controller
+
+Required properties:
+- compatible: Should be "cirrus,clps711x-pwm".
+- reg: Physical base address and length of the controller's registers.
+- clocks: phandle to the PWM reference clock.
+- #pwm-cells: Should be 1. The cell specifies the index of the channel.
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
index 0000000..fafb6a0
--- /dev/null
+++ b/drivers/pwm/pwm-clps711x.c
@@ -0,0 +1,176 @@
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
+	struct pwm_chip chip;
+	void __iomem *pmpcon;
+	struct clk *clk;
+	spinlock_t lock;
+};
+
+static inline struct clps711x_chip *to_clps711x_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct clps711x_chip, chip);
+}
+
+static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
+{
+	/* PWM0 - bits 4..7, PWM1 - bits 8..11 */
+	u32 shift = (n + 1) * 4;
+	unsigned long flags;
+	u32 tmp;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmp = readl(priv->pmpcon);
+	tmp &= ~(0xf << shift);
+	tmp |= v << shift;
+	writel(tmp, priv->pmpcon);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
+{
+	/* Duty cycle 0..15 max */
+	return DIV_ROUND_CLOSEST(v * 0xf, pwm_get_period(pwm));
+}
+
+static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct clps711x_chip *priv = to_clps711x_chip(chip);
+	unsigned int freq = clk_get_rate(priv->clk);
+
+	if (!freq)
+		return -EINVAL;
+
+	/* Store constant period value */
+	pwm_set_period(pwm, DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq));
+
+	return 0;
+}
+
+static int clps711x_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			       int duty_ns, int period_ns)
+{
+	struct clps711x_chip *priv = to_clps711x_chip(chip);
+	unsigned int duty;
+
+	if (period_ns != pwm_get_period(pwm))
+		return -EINVAL;
+
+	duty = clps711x_get_duty(pwm, duty_ns);
+	clps711x_pwm_update_val(priv, pwm->hwpwm, duty);
+
+	return 0;
+}
+
+static int clps711x_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct clps711x_chip *priv = to_clps711x_chip(chip);
+	unsigned int duty;
+
+	duty = clps711x_get_duty(pwm, pwm_get_duty_cycle(pwm));
+	clps711x_pwm_update_val(priv, pwm->hwpwm, duty);
+
+	return 0;
+}
+
+static void clps711x_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct clps711x_chip *priv = to_clps711x_chip(chip);
+
+	clps711x_pwm_update_val(priv, pwm->hwpwm, 0);
+}
+
+static const struct pwm_ops clps711x_pwm_ops = {
+	.request = clps711x_pwm_request,
+	.config = clps711x_pwm_config,
+	.enable = clps711x_pwm_enable,
+	.disable = clps711x_pwm_disable,
+	.owner = THIS_MODULE,
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
+	.driver = {
+		.name = "clps711x-pwm",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(clps711x_pwm_dt_ids),
+	},
+	.probe = clps711x_pwm_probe,
+	.remove = clps711x_pwm_remove,
+};
+module_platform_driver(clps711x_pwm_driver);
+
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("Cirrus Logic CLPS711X PWM driver");
+MODULE_LICENSE("GPL");
-- 
1.8.3.2

