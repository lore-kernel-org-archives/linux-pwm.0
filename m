From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] pwm: add ZTE ZX PWM device driver
Date: Thu, 29 Jun 2017 10:54:34 +0800
Message-ID: <1498704874-14599-3-git-send-email-shawnguo@kernel.org>
References: <1498704874-14599-1-git-send-email-shawnguo@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498704874-14599-1-git-send-email-shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Baoyou Xie <xie.baoyou-i+zz7BTLltu8dxfXipz/DA@public.gmane.org>, Xin Zhou <zhou.xin8-i+zz7BTLltu8dxfXipz/DA@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

It adds PWM device driver for ZTE ZX family SoCs.  The PWM controller
supports 4 devices with polarity configuration.

The driver has been tested with pwm-regulator support to scale core
voltage via cpufreq.

Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/pwm/Kconfig  |   9 ++
 drivers/pwm/Makefile |   1 +
 drivers/pwm/pwm-zx.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
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
index 000000000000..5c81c2ddc0a9
--- /dev/null
+++ b/drivers/pwm/pwm-zx.c
@@ -0,0 +1,244 @@
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
+#define ZX_PWM_CLKDIV_MASK	GENMASK(11, 2)
+#define ZX_PWM_CLKDIV(x)	(((x) << 8) & ZX_PWM_CLKDIV_MASK)
+#define ZX_PWM_POLAR		BIT(1)
+#define ZX_PWM_EN		BIT(0)
+#define ZX_PWM_PERIOD		0x4
+#define ZX_PWM_DUTY		0x8
+
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
+#define to_zx_pwm_chip(_chip) container_of(_chip, struct zx_pwm_chip, chip)
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
+static int zx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			 int duty_ns, int period_ns)
+{
+	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
+	unsigned int period_cycles;
+	unsigned int duty_cycles;
+	unsigned long long c;
+	unsigned long rate;
+	int div = 1;
+	u32 val;
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
+	if (pwm_is_enabled(pwm)) {
+		val = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
+		val &= ~ZX_PWM_EN;
+		zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_MODE, val);
+	}
+
+	/* Set up registers */
+	val = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
+	val &= ZX_PWM_CLKDIV_MASK;
+	val |= ZX_PWM_CLKDIV(div);
+	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_MODE, val);
+
+	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_PERIOD, period_cycles);
+	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_DUTY, duty_cycles);
+
+	/* Re-enable the pwm if needed */
+	if (pwm_is_enabled(pwm)) {
+		val = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
+		val |= ZX_PWM_EN;
+		zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_MODE, val);
+	}
+
+	return 0;
+}
+
+static int zx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
+	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(zpc->wclk);
+	if (ret)
+		return ret;
+
+	/* Enable the pwm */
+	val = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
+	val |= ZX_PWM_EN;
+	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_MODE, val);
+
+	return 0;
+}
+
+static void zx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
+	u32 val;
+
+	/* Disable the pwm */
+	val = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
+	val &= ~ZX_PWM_EN;
+	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_MODE, val);
+
+	clk_disable_unprepare(zpc->wclk);
+}
+
+static int zx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+			       enum pwm_polarity polarity)
+{
+	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
+	u32 val;
+
+	val = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
+
+	if (polarity == PWM_POLARITY_INVERSED)
+		val &= ~ZX_PWM_POLAR;
+	else
+		val |= ZX_PWM_POLAR;
+
+	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_MODE, val);
+
+	return 0;
+}
+
+static const struct pwm_ops zx_pwm_ops = {
+	.config = zx_pwm_config,
+	.enable = zx_pwm_enable,
+	.disable = zx_pwm_disable,
+	.set_polarity = zx_pwm_set_polarity,
+	.owner = THIS_MODULE,
+};
+
+static int zx_pwm_probe(struct platform_device *pdev)
+{
+	struct zx_pwm_chip *zpc;
+	struct resource *res;
+	int ret;
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
+	zpc->chip.dev = &pdev->dev;
+	zpc->chip.ops = &zx_pwm_ops;
+	zpc->chip.base = -1;
+	zpc->chip.npwm = 4;
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
+	ret = clk_prepare_enable(zpc->pclk);
+	if (ret)
+		goto pwm_remove;
+
+	return 0;
+
+pwm_remove:
+	pwmchip_remove(&zpc->chip);
+	return ret;
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
+MODULE_AUTHOR("Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
+MODULE_DESCRIPTION("ZTE ZX PWM Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
