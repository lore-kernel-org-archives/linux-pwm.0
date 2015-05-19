From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 2/2] pwm: Add support for R-Car PWM Timer
Date: Tue, 19 May 2015 19:42:39 +0900
Message-ID: <1432032159-704-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1432032159-704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432032159-704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pwm@vger.kernel.org

This patch adds support for R-Car SoCs PWM Timer.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/Kconfig    |  11 ++
 drivers/pwm/Makefile   |   1 +
 drivers/pwm/pwm-rcar.c | 268 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 drivers/pwm/pwm-rcar.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index b1541f4..3e58a68 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -249,6 +249,17 @@ config PWM_PXA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pxa.
 
+config PWM_RCAR
+	tristate "Renesas R-Car PWM support"
+	depends on ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the PWM Timer controller found in Renesas
+	  R-Car chips through the PWM API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-rcar.
+
 config PWM_RENESAS_TPU
 	tristate "Renesas TPU PWM support"
 	depends on ARCH_SHMOBILE || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index ec50eb5..79d3dc3 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
+obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
new file mode 100644
index 0000000..50f64d6
--- /dev/null
+++ b/drivers/pwm/pwm-rcar.c
@@ -0,0 +1,268 @@
+/*
+ * R-Car PWM Timer driver
+ *
+ * Copyright (C) 2015 Renesas Electronics Corporation
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#define RCAR_PWM_MAX_DIVISION	24
+#define RCAR_PWM_MAX_CYCLE	1023
+
+#define RCAR_PWMCR		0x00
+#define RCAR_PWMCNT		0x04
+#define RCAR_PWM_CH_OFFSET	0x1000
+
+#define RCAR_PWMCR_CC0_MASK	0x000f0000
+#define RCAR_PWMCR_CC0_SHIFT	16
+#define RCAR_PWMCR_CCMD		BIT(15)
+#define RCAR_PWMCR_SYNC		BIT(11)
+#define RCAR_PWMCR_SS0		BIT(4)
+#define RCAR_PWMCR_EN0		BIT(0)
+
+#define RCAR_PWMCNT_CYC0_MASK	0x03ff0000
+#define RCAR_PWMCNT_CYC0_SHIFT	16
+#define RCAR_PWMCNT_PH0_MASK	0x000003ff
+#define RCAR_PWMCNT_PH0_SHIFT	0
+
+struct rcar_pwm_chip {
+	struct pwm_chip chip;
+	void __iomem *base;
+	struct clk *clk;
+};
+
+#define to_rcar_pwm_chip(chip)	container_of(chip, struct rcar_pwm_chip, chip)
+
+static void rcar_pwm_write(struct rcar_pwm_chip *rp, u32 data, u32 reg)
+{
+	iowrite32(data, rp->base + reg);
+}
+
+static u32 rcar_pwm_read(struct rcar_pwm_chip *rp, u32 reg)
+{
+	return ioread32(rp->base + reg);
+}
+
+static void rcar_pwm_bit_modify(struct rcar_pwm_chip *rp,
+				u32 mask, u32 data, u32 reg)
+{
+	u32 val = rcar_pwm_read(rp, reg);
+
+	val &= ~mask;
+	val |= data & mask;
+	rcar_pwm_write(rp, val, reg);
+}
+
+static int rcar_pwn_get_clock_division(struct rcar_pwm_chip *rp,
+				       int period_ns)
+{
+	int div;
+	unsigned long clk_rate = clk_get_rate(rp->clk);
+	unsigned long long max;	/* max cycle / nanoseconds */
+
+	for (div = 0; div <= RCAR_PWM_MAX_DIVISION; div++) {
+		max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
+			(1 << div);
+		do_div(max, clk_rate);
+		if (period_ns < max)
+			break;
+	}
+
+	return div;
+}
+
+static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp, int div)
+{
+	u32 val = rcar_pwm_read(rp, RCAR_PWMCR);
+
+	if (div > RCAR_PWM_MAX_DIVISION)
+		return;
+
+	val &= ~(RCAR_PWMCR_CCMD | RCAR_PWMCR_CC0_MASK);
+	if (div & 1)
+		val |= RCAR_PWMCR_CCMD;
+	div >>= 1;
+	val |= div << RCAR_PWMCR_CC0_SHIFT;
+	rcar_pwm_write(rp, val, RCAR_PWMCR);
+}
+
+static void rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div,
+				 int duty_ns, int period_ns)
+{
+	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
+	unsigned long clk_rate = clk_get_rate(rp->clk);
+	u32 cyc, ph;
+
+	one_cycle = (unsigned long long)NSEC_PER_SEC * 100 * (1 << div);
+	do_div(one_cycle, clk_rate);
+
+	tmp = period_ns * 100;
+	do_div(tmp, one_cycle);
+	cyc = ((u32)tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
+
+	tmp = duty_ns * 100;
+	do_div(tmp, one_cycle);
+	ph = (u32)tmp & RCAR_PWMCNT_PH0_MASK;
+
+	/* Avoid prohibited setting */
+	if (cyc && ph)
+		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
+}
+
+static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+
+	return clk_prepare_enable(rp->clk);
+}
+
+static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+
+	clk_disable_unprepare(rp->clk);
+}
+
+static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			   int duty_ns, int period_ns)
+{
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+	int div;
+
+	div = rcar_pwn_get_clock_division(rp, period_ns);
+
+	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
+	rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
+	rcar_pwm_set_clock_control(rp, div);
+	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
+
+	return 0;
+}
+
+static int rcar_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+	u32 pwmcnt;
+
+	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
+	pwmcnt = rcar_pwm_read(rp, RCAR_PWMCNT);
+	if (!(pwmcnt & RCAR_PWMCNT_CYC0_MASK) ||
+	    !(pwmcnt & RCAR_PWMCNT_PH0_MASK))
+		return -EINVAL;
+
+	rcar_pwm_bit_modify(rp, RCAR_PWMCR_EN0, RCAR_PWMCR_EN0, RCAR_PWMCR);
+
+	return 0;
+}
+
+static void rcar_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+
+	rcar_pwm_bit_modify(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
+}
+
+static const struct pwm_ops rcar_pwm_ops = {
+	.request	= rcar_pwm_request,
+	.free		= rcar_pwm_free,
+	.config		= rcar_pwm_config,
+	.enable		= rcar_pwm_enable,
+	.disable	= rcar_pwm_disable,
+	.owner		= THIS_MODULE,
+};
+
+static int rcar_pwm_probe(struct platform_device *pdev)
+{
+	struct rcar_pwm_chip *rcar_pwm;
+	struct resource *res;
+	int ret;
+
+	rcar_pwm = devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
+	if (rcar_pwm == NULL)
+		return -ENOMEM;
+
+	rcar_pwm->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rcar_pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rcar_pwm->base))
+		return PTR_ERR(rcar_pwm->base);
+
+	rcar_pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(rcar_pwm->clk)) {
+		dev_err(&pdev->dev, "cannot get clock\n");
+		return PTR_ERR(rcar_pwm->clk);
+	}
+
+	platform_set_drvdata(pdev, rcar_pwm);
+
+	rcar_pwm->chip.dev = &pdev->dev;
+	rcar_pwm->chip.ops = &rcar_pwm_ops;
+	rcar_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	rcar_pwm->chip.base = -1;
+	rcar_pwm->chip.npwm = 1;
+
+	ret = pwmchip_add(&rcar_pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register PWM chip\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "R-Car PWM Timer registered\n");
+
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+}
+
+static int rcar_pwm_remove(struct platform_device *pdev)
+{
+	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&rcar_pwm->chip);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id rcar_pwm_of_table[] = {
+	{ .compatible = "renesas,pwm-r8a7778", },
+	{ .compatible = "renesas,pwm-r8a7779", },
+	{ .compatible = "renesas,pwm-r8a7790", },
+	{ .compatible = "renesas,pwm-r8a7791", },
+	{ .compatible = "renesas,pwm-r8a7794", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
+
+static struct platform_driver rcar_pwm_driver = {
+	.probe		= rcar_pwm_probe,
+	.remove		= rcar_pwm_remove,
+	.driver		= {
+		.name	= "pwm-rcar",
+		.of_match_table = of_match_ptr(rcar_pwm_of_table),
+	}
+};
+module_platform_driver(rcar_pwm_driver);
+
+MODULE_AUTHOR("Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>");
+MODULE_DESCRIPTION("Renesas PWM Timer Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:pwm-rcar");
-- 
1.9.1

