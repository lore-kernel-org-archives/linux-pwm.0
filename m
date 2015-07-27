From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH 1/2] pwm: NXP LPC18xx PWM/SCT driver
Date: Mon, 27 Jul 2015 01:45:44 -0300
Message-ID: <1437972345-16444-2-git-send-email-ariel@vanguardiasur.com.ar>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33753 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbG0EqX (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2015 00:46:23 -0400
Received: by qged69 with SMTP id d69so44494919qge.0
        for <linux-pwm@vger.kernel.org>; Sun, 26 Jul 2015 21:46:22 -0700 (PDT)
In-Reply-To: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, manabian@gmail.com, ezequiel@vanguardiasur.com.ar, thierry.reding@gmail.com, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

This commit adds support for NXP LPC18xx PWM/SCT.

NXP LPC SoCs family, which includes LPC18xx/LPC43xx, provides a State
Configurable Timer (SCT) which can be configured as a Pulse Width Modulator.
Other SoCs in that family may share the same hardware.

The PWM supports a total of 16 channels, but only 15 can be simultaneously
requested. There's only one period, global to all the channels, thus PWM driver
will refuse setting different values to it.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 drivers/pwm/Kconfig       |  12 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-lpc18xx.c | 459 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 472 insertions(+)
 create mode 100644 drivers/pwm/pwm-lpc18xx.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index b1541f4..2c7635c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -173,6 +173,18 @@ config PWM_LP3943
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lp3943.
 
+config PWM_LPC18XX
+	tristate "LPC18xx/43xx PWM support"
+	depends on ARCH_LPC18XX
+	help
+	  Generic PWM framework driver for NXP LPC18xx PWM/SCT which
+	  supports 16 channels.
+	  A maximum of 15 channels can be requested simultaneously and
+	  must have the same period.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-lpc18xx.
+
 config PWM_LPC32XX
 	tristate "LPC32XX PWM support"
 	depends on ARCH_LPC32XX
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index ec50eb5..986b286 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
+obj-$(CONFIG_PWM_LPC18XX)	+= pwm-lpc18xx.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
diff --git a/drivers/pwm/pwm-lpc18xx.c b/drivers/pwm/pwm-lpc18xx.c
new file mode 100644
index 0000000..77b5e74
--- /dev/null
+++ b/drivers/pwm/pwm-lpc18xx.c
@@ -0,0 +1,459 @@
+/*
+ * NXP LPC18xx Pulse Width Modulator driver
+ *
+ * Copyright (c) 2015 Ariel D'Alessandro <ariel@vanguardiasur.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * Notes
+ * =====
+ * NXP LPC18xx provides a State Configurable Timer (SCT) which can be configured
+ * as a Pulse Width Modulator.
+ *
+ * SCT supports 16 outputs, 16 events and 16 registers. Each event will be
+ * triggered when its related register matches the SCT counter value, and it
+ * will set or clear a selected output.
+ *
+ * One of the events is preselected to generate the period, thus the maximum
+ * number of simultaneous channels is limited to 15. Notice that period is
+ * global to all the channels, thus PWM driver will refuse setting different
+ * values to it.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+/* LPC18xx SCT registers */
+#define LPC18XX_PWM_CONFIG		0x000
+#define LPC18XX_PWM_CONFIG_UNIFY	BIT(0)
+#define LPC18XX_PWM_CONFIG_NORELOAD	BIT(7)
+
+#define LPC18XX_PWM_CTRL		0x004
+#define LPC18XX_PWM_CTRL_HALT		BIT(2)
+#define LPC18XX_PWM_BIDIR		BIT(4)
+#define LPC18XX_PWM_PRE_SHIFT		5
+#define LPC18XX_PWM_PRE_MASK		(0xff << LPC18XX_PWM_PRE_SHIFT)
+#define LPC18XX_PWM_PRE(x)		(x << LPC18XX_PWM_PRE_SHIFT)
+
+#define LPC18XX_PWM_LIMIT		0x008
+
+#define LPC18XX_PWM_RES_BASE		0x058
+#define LPC18XX_PWM_RES_SHIFT(_ch)	(_ch * 2)
+#define LPC18XX_PWM_RES(_ch, _action)	(_action << LPC18XX_PWM_RES_SHIFT(_ch))
+#define LPC18XX_PWM_RES_MASK(_ch)	(0x3 << LPC18XX_PWM_RES_SHIFT(_ch))
+
+#define LPC18XX_PWM_MATCH_BASE		0x100
+#define LPC18XX_PWM_MATCH(_ch)		(LPC18XX_PWM_MATCH_BASE + _ch * 4)
+
+#define LPC18XX_PWM_MATCHREL_BASE	0x200
+#define LPC18XX_PWM_MATCHREL(_ch)	(LPC18XX_PWM_MATCHREL_BASE + _ch * 4)
+
+#define LPC18XX_PWM_EVSTATEMSK_BASE	0x300
+#define LPC18XX_PWM_EVSTATEMSK(_ch)	(LPC18XX_PWM_EVSTATEMSK_BASE + _ch * 8)
+#define LPC18XX_PWM_EVSTATEMSK_ALL	0xffffffff
+
+#define LPC18XX_PWM_EVCTRL_BASE		0x304
+#define LPC18XX_PWM_EVCTRL(_ch)		(LPC18XX_PWM_EVCTRL_BASE + _ch * 8)
+
+#define LPC18XX_PWM_EVCTRL_MATCH(_ch)	_ch
+
+#define LPC18XX_PWM_EVCTRL_COMB_SHIFT	12
+#define LPC18XX_PWM_EVCTRL_COMB_MATCH	(0x1 << LPC18XX_PWM_EVCTRL_COMB_SHIFT)
+
+#define LPC18XX_PWM_OUTPUTSET_BASE	0x500
+#define LPC18XX_PWM_OUTPUTSET(_ch)	(LPC18XX_PWM_OUTPUTSET_BASE + _ch * 8)
+
+#define LPC18XX_PWM_OUTPUTCL_BASE	0x504
+#define LPC18XX_PWM_OUTPUTCL(_ch)	(LPC18XX_PWM_OUTPUTCL_BASE + _ch * 8)
+
+/* LPC18xx SCT unified counter */
+#define LPC18XX_PWM_TIMER_MAX		0xffffffff
+
+/* LPC18xx SCT events */
+#define LPC18XX_PWM_EVENT_PERIOD	0
+#define LPC18XX_PWM_EVENT_MAX		16
+
+/* SCT conflict resolution */
+enum lpc18xx_pwm_res_action {
+	LPC18XX_PWM_RES_NONE	= 0x0,
+	LPC18XX_PWM_RES_SET	= 0x1,
+	LPC18XX_PWM_RES_CLEAR	= 0x2,
+	LPC18XX_PWM_RES_TOGGLE	= 0x3,
+};
+
+struct lpc18xx_pwm_data {
+	unsigned int		duty_event;
+};
+
+struct lpc18xx_pwm_chip {
+	struct device		*dev;
+	struct pwm_chip		chip;
+	void __iomem		*base;
+	struct clk		*pwm_clk;
+	unsigned long		clk_rate;
+	unsigned int		period_ns;
+	unsigned int		min_period_ns;
+	unsigned int		max_period_ns;
+	unsigned int		period_event;
+	unsigned long		event_map;
+	struct mutex            res_lock;
+	struct mutex            period_lock;
+};
+
+static inline struct lpc18xx_pwm_chip *to_lpc18xx_pwm_chip(
+							struct pwm_chip *chip)
+{
+	return container_of(chip, struct lpc18xx_pwm_chip, chip);
+}
+
+static inline void lpc18xx_pwm_writel(struct lpc18xx_pwm_chip *lpc18xx_pwm,
+				      u32 reg, u32 val)
+{
+	writel(val, lpc18xx_pwm->base + reg);
+}
+
+static inline u32 lpc18xx_pwm_readl(struct lpc18xx_pwm_chip *lpc18xx_pwm,
+				    u32 reg)
+{
+	return readl(lpc18xx_pwm->base + reg);
+}
+
+static void lpc18xx_pwm_set_conflict_res(struct lpc18xx_pwm_chip *lpc18xx_pwm,
+					 struct pwm_device *pwm,
+					 enum lpc18xx_pwm_res_action action)
+{
+	u32 val;
+
+	mutex_lock(&lpc18xx_pwm->res_lock);
+
+	/*
+	 * Simultaneous set and clear may happen on an output, that is the case
+	 * when duty_ns == period_ns. LPC18xx SCT allows to set a conflict
+	 * resolution action to be taken in such a case.
+	 */
+	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_RES_BASE);
+	val &= ~LPC18XX_PWM_RES_MASK(pwm->hwpwm);
+	val |= LPC18XX_PWM_RES(pwm->hwpwm, action);
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_RES_BASE, val);
+
+	mutex_unlock(&lpc18xx_pwm->res_lock);
+}
+
+static void lpc18xx_pwm_config_period(struct pwm_chip *chip, int period_ns)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
+	u64 val;
+
+	val = (u64)period_ns * lpc18xx_pwm->clk_rate;
+	do_div(val, NSEC_PER_SEC);
+
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_MATCH(lpc18xx_pwm->period_event),
+			   (u32)val);
+
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_MATCHREL(lpc18xx_pwm->period_event),
+			   (u32)val);
+}
+
+static void lpc18xx_pwm_config_duty(struct pwm_chip *chip,
+				    struct pwm_device *pwm, int duty_ns)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
+	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	u64 val;
+
+	val = (u64)duty_ns * lpc18xx_pwm->clk_rate;
+	do_div(val, NSEC_PER_SEC);
+
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_MATCH(lpc18xx_data->duty_event),
+			   (u32)val);
+
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_MATCHREL(lpc18xx_data->duty_event),
+			   (u32)val);
+}
+
+static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			      int duty_ns, int period_ns)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
+	int i;
+
+	if (period_ns < lpc18xx_pwm->min_period_ns ||
+	    period_ns > lpc18xx_pwm->max_period_ns) {
+		dev_err(chip->dev, "period %d not in range\n", period_ns);
+		return -ERANGE;
+	}
+
+	mutex_lock(&lpc18xx_pwm->period_lock);
+
+	/*
+	 * The PWM supports only a single period for all PWM channels, therefore
+	 * incompatible changes need to be refused.
+	 */
+	if (lpc18xx_pwm->period_ns && lpc18xx_pwm->period_ns != period_ns) {
+		dev_err(chip->dev, "conflicting period requested for PWM %u\n",
+			pwm->hwpwm);
+		mutex_unlock(&lpc18xx_pwm->period_lock);
+		return -EBUSY;
+	}
+
+	if (!lpc18xx_pwm->period_ns) {
+		lpc18xx_pwm->period_ns = period_ns;
+		for (i = 0; i < chip->npwm; i++) {
+			pwm_set_period(&chip->pwms[i], period_ns);
+		}
+		lpc18xx_pwm_config_period(chip, period_ns);
+	}
+
+	mutex_unlock(&lpc18xx_pwm->period_lock);
+
+	lpc18xx_pwm_config_duty(chip, pwm, duty_ns);
+
+	return 0;
+}
+
+static int lpc18xx_pwm_set_polarity(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    enum pwm_polarity polarity)
+{
+	return 0;
+}
+
+static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
+	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	enum lpc18xx_pwm_res_action res_action;
+	unsigned int set_event, clear_event;
+
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_EVCTRL(lpc18xx_data->duty_event),
+			   LPC18XX_PWM_EVCTRL_MATCH(lpc18xx_data->duty_event) |
+			   LPC18XX_PWM_EVCTRL_COMB_MATCH);
+
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_EVSTATEMSK(lpc18xx_data->duty_event),
+			   LPC18XX_PWM_EVSTATEMSK_ALL);
+
+	if (pwm->polarity == PWM_POLARITY_NORMAL) {
+		set_event = lpc18xx_pwm->period_event;
+		clear_event = lpc18xx_data->duty_event;
+		res_action = LPC18XX_PWM_RES_SET;
+	} else {
+		set_event = lpc18xx_data->duty_event;
+		clear_event = lpc18xx_pwm->period_event;
+		res_action = LPC18XX_PWM_RES_CLEAR;
+	}
+
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_OUTPUTSET(pwm->hwpwm),
+			   BIT(set_event));
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_OUTPUTCL(pwm->hwpwm),
+			   BIT(clear_event));
+	lpc18xx_pwm_set_conflict_res(lpc18xx_pwm, pwm, res_action);
+
+	return 0;
+}
+
+static void lpc18xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
+	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_EVCTRL(lpc18xx_data->duty_event), 0);
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_OUTPUTSET(pwm->hwpwm), 0);
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_OUTPUTCL(pwm->hwpwm), 0);
+}
+
+static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
+	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	unsigned long event;
+
+	event = find_first_zero_bit(&lpc18xx_pwm->event_map,
+				    LPC18XX_PWM_EVENT_MAX);
+
+	if (event >= LPC18XX_PWM_EVENT_MAX) {
+		dev_err(lpc18xx_pwm->dev,
+			"maximum number of simultaneous channels reached\n");
+		return -EBUSY;
+	};
+
+	set_bit(event, &lpc18xx_pwm->event_map);
+	lpc18xx_data->duty_event = event;
+
+	return 0;
+}
+
+static void lpc18xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
+	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+
+	lpc18xx_pwm_disable(chip, pwm);
+	clear_bit(lpc18xx_data->duty_event, &lpc18xx_pwm->event_map);
+}
+
+static const struct pwm_ops lpc18xx_pwm_ops = {
+	.config		= lpc18xx_pwm_config,
+	.set_polarity	= lpc18xx_pwm_set_polarity,
+	.enable		= lpc18xx_pwm_enable,
+	.disable	= lpc18xx_pwm_disable,
+	.request	= lpc18xx_pwm_request,
+	.free		= lpc18xx_pwm_free,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id lpc18xx_pwm_of_match[] = {
+	{ .compatible = "nxp,lpc1850-pwm" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lpc18xx_pwm_of_match);
+
+static int lpc18xx_pwm_probe(struct platform_device *pdev)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm;
+	struct pwm_device *pwm;
+	struct resource *res;
+	int ret, i;
+	u64 val;
+
+	lpc18xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*lpc18xx_pwm),
+				   GFP_KERNEL);
+	if (!lpc18xx_pwm)
+		return -ENOMEM;
+
+	lpc18xx_pwm->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lpc18xx_pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(lpc18xx_pwm->base))
+		return PTR_ERR(lpc18xx_pwm->base);
+
+	lpc18xx_pwm->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
+	if (IS_ERR(lpc18xx_pwm->pwm_clk)) {
+		dev_err(&pdev->dev, "failed to get pwm clock\n");
+		return PTR_ERR(lpc18xx_pwm->pwm_clk);
+	}
+
+	ret = clk_prepare_enable(lpc18xx_pwm->pwm_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not prepare or enable pwm clock\n");
+		return ret;
+	}
+
+	lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
+
+	mutex_init(&lpc18xx_pwm->res_lock);
+	mutex_init(&lpc18xx_pwm->period_lock);
+
+	val = (u64)NSEC_PER_SEC * LPC18XX_PWM_TIMER_MAX;
+	do_div(val, lpc18xx_pwm->clk_rate);
+	lpc18xx_pwm->max_period_ns = val;
+
+	val = (u64)NSEC_PER_SEC;
+	do_div(val, lpc18xx_pwm->clk_rate);
+	lpc18xx_pwm->min_period_ns = val;
+
+	lpc18xx_pwm->chip.dev = &pdev->dev;
+	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
+	lpc18xx_pwm->chip.base = -1;
+	lpc18xx_pwm->chip.npwm = 16;
+	lpc18xx_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	lpc18xx_pwm->chip.of_pwm_n_cells = 3;
+
+	/* SCT counter must be in unify (32 bit) mode */
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
+			   LPC18XX_PWM_CONFIG_UNIFY);
+
+	/*
+	 * Everytime the timer counter reaches the period value, the related
+	 * event will be triggered and the counter reset to 0.
+	 */
+	set_bit(LPC18XX_PWM_EVENT_PERIOD, &lpc18xx_pwm->event_map);
+	lpc18xx_pwm->period_event = LPC18XX_PWM_EVENT_PERIOD;
+
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_EVSTATEMSK(lpc18xx_pwm->period_event),
+			   LPC18XX_PWM_EVSTATEMSK_ALL);
+
+	val = LPC18XX_PWM_EVCTRL_MATCH(lpc18xx_pwm->period_event) |
+	      LPC18XX_PWM_EVCTRL_COMB_MATCH;
+	lpc18xx_pwm_writel(lpc18xx_pwm,
+			   LPC18XX_PWM_EVCTRL(lpc18xx_pwm->period_event), val);
+
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_LIMIT,
+			   BIT(lpc18xx_pwm->period_event));
+
+	ret = pwmchip_add(&lpc18xx_pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
+		goto disable_pwmclk;
+	}
+
+	for (i = 0; i < lpc18xx_pwm->chip.npwm; i++) {
+		pwm = &lpc18xx_pwm->chip.pwms[i];
+		pwm->chip_data = devm_kzalloc(lpc18xx_pwm->dev,
+					      sizeof(struct lpc18xx_pwm_data),
+					      GFP_KERNEL);
+		if (!pwm->chip_data) {
+			ret = -ENOMEM;
+			goto remove_pwmchip;
+		}
+	}
+
+	platform_set_drvdata(pdev, lpc18xx_pwm);
+
+	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
+	val &= ~LPC18XX_PWM_BIDIR;
+	val &= ~LPC18XX_PWM_CTRL_HALT;
+	val &= ~LPC18XX_PWM_PRE_MASK;
+	val |= LPC18XX_PWM_PRE(0);
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
+
+	return 0;
+
+remove_pwmchip:
+	pwmchip_remove(&lpc18xx_pwm->chip);
+disable_pwmclk:
+	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
+	return ret;
+}
+
+static int lpc18xx_pwm_remove(struct platform_device *pdev)
+{
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = platform_get_drvdata(pdev);
+	u32 val;
+
+	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL,
+			   val | LPC18XX_PWM_CTRL_HALT);
+
+	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
+
+	return pwmchip_remove(&lpc18xx_pwm->chip);
+}
+
+static struct platform_driver lpc18xx_pwm_driver = {
+	.driver = {
+		.name = "lpc18xx-pwm",
+		.of_match_table = lpc18xx_pwm_of_match,
+	},
+	.probe = lpc18xx_pwm_probe,
+	.remove = lpc18xx_pwm_remove,
+};
+module_platform_driver(lpc18xx_pwm_driver);
+
+MODULE_AUTHOR("Ariel D'Alessandro <ariel@vanguardiasur.com.ar>");
+MODULE_DESCRIPTION("NXP LPC18xx PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
