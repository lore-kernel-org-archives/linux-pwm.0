From: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 2/2] pwm: add ZTE ZX PWM device driver
Date: Thu, 27 Jul 2017 16:23:37 +0800
Message-ID: <1501143817-15843-3-git-send-email-shawnguo@kernel.org>
References: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbdG0IZB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 27 Jul 2017 04:25:01 -0400
In-Reply-To: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

From: Shawn Guo <shawn.guo@linaro.org>

It adds PWM device driver for ZTE ZX family SoCs.  The PWM controller
supports 4 devices with polarity configuration.

The driver has been tested with pwm-regulator support to scale core
voltage via cpufreq.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/Kconfig  |   9 ++
 drivers/pwm/Makefile |   1 +
 drivers/pwm/pwm-zx.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 drivers/pwm/pwm-zx.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 313c10789ca2..e98175331a69 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -500,4 +500,13 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_ZX
+	tristate "ZTE ZX PWM support"
+	depends on ARCH_ZX
+	help
+	  Generic PWM framework driver for ZTE ZX family SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-zx.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 93da1f79a3b8..75ab74094d7b 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -49,3 +49,4 @@ obj-$(CONFIG_PWM_TIPWMSS)	+= pwm-tipwmss.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
+obj-$(CONFIG_PWM_ZX)		+= pwm-zx.o
diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
new file mode 100644
index 000000000000..39d5e6bf0510
--- /dev/null
+++ b/drivers/pwm/pwm-zx.c
@@ -0,0 +1,270 @@
+/*
+ * Copyright (C) 2017 Sanechips Technology Co., Ltd.
+ * Copyright 2017 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#define ZX_PWM_MODE		0x0
+#define ZX_PWM_CLKDIV_SHIFT	2
+#define ZX_PWM_CLKDIV_MASK	GENMASK(11, 2)
+#define ZX_PWM_CLKDIV(x)	(((x) << ZX_PWM_CLKDIV_SHIFT) & \
+					 ZX_PWM_CLKDIV_MASK)
+#define ZX_PWM_POLAR		BIT(1)
+#define ZX_PWM_EN		BIT(0)
+#define ZX_PWM_PERIOD		0x4
+#define ZX_PWM_DUTY		0x8
+
+#define ZX_PWM_NUM		4
+#define ZX_PWM_CLKDIV_MAX	1023
+#define ZX_PWM_PERIOD_MAX	65535
+
+struct zx_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *pclk;
+	struct clk *wclk;
+	void __iomem *base;
+};
+
+static inline struct zx_pwm_chip *to_zx_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct zx_pwm_chip, chip);
+}
+
+static inline u32 zx_pwm_readl(struct zx_pwm_chip *zpc, unsigned int hwpwm,
+			       unsigned int offset)
+{
+	return readl(zpc->base + (hwpwm + 1) * 0x10 + offset);
+}
+
+static inline void zx_pwm_writel(struct zx_pwm_chip *zpc, unsigned int hwpwm,
+				 unsigned int offset, u32 val)
+{
+	writel(val, zpc->base + (hwpwm + 1) * 0x10 + offset);
+}
+
+static void zx_pwm_set_mask(struct zx_pwm_chip *zpc, unsigned int hwpwm,
+			    unsigned int offset, u32 mask, u32 value)
+{
+	u32 data;
+
+	data = zx_pwm_readl(zpc, hwpwm, offset);
+	data &= ~mask;
+	data |= value & mask;
+	zx_pwm_writel(zpc, hwpwm, offset, data);
+}
+
+static void zx_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
+	unsigned long rate;
+	int div;
+	u64 tmp;
+	u32 val;
+
+	val = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
+	state->polarity = (val & ZX_PWM_POLAR) ? PWM_POLARITY_NORMAL :
+						 PWM_POLARITY_INVERSED;
+	state->enabled = (val & ZX_PWM_EN) ? true : false;
+
+	div = (val & ZX_PWM_CLKDIV_MASK) >> ZX_PWM_CLKDIV_SHIFT;
+	rate = clk_get_rate(zpc->wclk);
+
+	tmp = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_PERIOD);
+	tmp *= div * NSEC_PER_SEC;
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	tmp = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_DUTY);
+	tmp *= div * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
+}
+
+static int zx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			 unsigned int duty_ns, unsigned int period_ns)
+{
+	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
+	unsigned int period_cycles;
+	unsigned int duty_cycles;
+	unsigned long long c;
+	unsigned long rate;
+	int div = 1;
+
+	/* Find out the best divider */
+	rate = clk_get_rate(zpc->wclk);
+	while (1) {
+		c = rate / div;
+		c = c * period_ns;
+		do_div(c, NSEC_PER_SEC);
+		if (c < ZX_PWM_PERIOD_MAX)
+			break;
+		div++;
+		if (div > ZX_PWM_CLKDIV_MAX)
+			return -ERANGE;
+	}
+
+	/* Calculate duty cycles */
+	period_cycles = c;
+	c *= duty_ns;
+	do_div(c, period_ns);
+	duty_cycles = c;
+
+	/*
+	 * If the pwm is being enabled, we have to temporarily disable it
+	 * before configuring the registers.
+	 */
+	if (pwm_is_enabled(pwm))
+		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_EN, 0);
+
+	/* Set up registers */
+	zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_CLKDIV_MASK,
+			ZX_PWM_CLKDIV(div));
+	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_PERIOD, period_cycles);
+	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_DUTY, duty_cycles);
+
+	/* Re-enable the pwm if needed */
+	if (pwm_is_enabled(pwm))
+		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,
+				ZX_PWM_EN, ZX_PWM_EN);
+
+	return 0;
+}
+
+static int zx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			struct pwm_state *state)
+{
+	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
+	struct pwm_state cstate;
+	int ret;
+
+	pwm_get_state(pwm, &cstate);
+
+	if (state->polarity != cstate.polarity)
+		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_POLAR,
+				(state->polarity == PWM_POLARITY_INVERSED) ?
+				 0 : ZX_PWM_POLAR);
+
+	if (state->period != cstate.period ||
+	    state->duty_cycle != cstate.duty_cycle) {
+		ret = zx_pwm_config(chip, pwm, state->duty_cycle,
+				    state->period);
+		if (ret)
+			return ret;
+	}
+
+	if (state->enabled != cstate.enabled) {
+		if (state->enabled) {
+			ret = clk_prepare_enable(zpc->wclk);
+			if (ret)
+				return ret;
+			zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,
+					ZX_PWM_EN, ZX_PWM_EN);
+		} else {
+			zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,
+					ZX_PWM_EN, 0);
+			clk_disable_unprepare(zpc->wclk);
+		}
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops zx_pwm_ops = {
+	.apply = zx_pwm_apply,
+	.get_state = zx_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int zx_pwm_probe(struct platform_device *pdev)
+{
+	struct zx_pwm_chip *zpc;
+	struct resource *res;
+	int ret;
+	int i;
+
+	zpc = devm_kzalloc(&pdev->dev, sizeof(*zpc), GFP_KERNEL);
+	if (!zpc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	zpc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(zpc->base))
+		return PTR_ERR(zpc->base);
+
+	zpc->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(zpc->pclk))
+		return PTR_ERR(zpc->pclk);
+
+	zpc->wclk = devm_clk_get(&pdev->dev, "wclk");
+	if (IS_ERR(zpc->wclk))
+		return PTR_ERR(zpc->wclk);
+
+	ret = clk_prepare_enable(zpc->pclk);
+	if (ret)
+		return ret;
+
+	/*
+	 * PWM devices may be enabled by firmware, and let's disable all of
+	 * them initially to save power.
+	 */
+	for (i = 0; i < ZX_PWM_NUM; i++)
+		zx_pwm_set_mask(zpc, i, ZX_PWM_MODE, ZX_PWM_EN, 0);
+
+	zpc->chip.dev = &pdev->dev;
+	zpc->chip.ops = &zx_pwm_ops;
+	zpc->chip.base = -1;
+	zpc->chip.npwm = ZX_PWM_NUM;
+	zpc->chip.of_xlate = of_pwm_xlate_with_flags;
+	zpc->chip.of_pwm_n_cells = 3;
+
+	ret = pwmchip_add(&zpc->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, zpc);
+
+	return 0;
+}
+
+static int zx_pwm_remove(struct platform_device *pdev)
+{
+	struct zx_pwm_chip *zpc = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(zpc->pclk);
+
+	return pwmchip_remove(&zpc->chip);
+}
+
+static const struct of_device_id zx_pwm_dt_ids[] = {
+	{ .compatible = "zte,zx296718-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, zx_pwm_dt_ids);
+
+static struct platform_driver zx_pwm_driver = {
+	.driver = {
+		.name = "zx-pwm",
+		.of_match_table = zx_pwm_dt_ids,
+	},
+	.probe = zx_pwm_probe,
+	.remove = zx_pwm_remove,
+};
+module_platform_driver(zx_pwm_driver);
+
+MODULE_ALIAS("platform:zx-pwm");
+MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
+MODULE_DESCRIPTION("ZTE ZX PWM Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
