From: John Crispin <john@phrozen.org>
Subject: [PATCH 2/2] pwm: add pwm-mediatek
Date: Mon, 23 Jan 2017 19:34:37 +0100
Message-ID: <1485196477-669-2-git-send-email-john@phrozen.org>
References: <1485196477-669-1-git-send-email-john@phrozen.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:47265 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdAWSec (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 23 Jan 2017 13:34:32 -0500
In-Reply-To: <1485196477-669-1-git-send-email-john@phrozen.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, =?UTF-8?q?Sean=20Wang=20=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?= <sean.wang@mediatek.com>, John Crispin <john@phrozen.org>

This patch adds support for the PWM core found on current ARM base SoCs
made by MediaTek. This IP core supports 5 channels and has 2 operational
modes. There is the old mode, which is a classical PWM and the new mode
which allows the user to define bitmasks that get clocked out on the pins.
As the subsystem currently only supports PWM cores with the "old" mode,
we can safely ignore the "new" mode for now.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/pwm/Kconfig        |    9 ++
 drivers/pwm/Makefile       |    1 +
 drivers/pwm/pwm-mediatek.c |  223 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 drivers/pwm/pwm-mediatek.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index f92dd41..dd09e2f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -291,6 +291,15 @@ config PWM_MTK_DISP
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mtk-disp.
 
+config PWM_MEDIATEK
+	tristate "MediaTek PWM support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  Generic PWM framework driver for Mediatek ARM SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-mxs.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS && OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a48bdb5..f897f086 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
+obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
new file mode 100644
index 0000000..dfb9834
--- /dev/null
+++ b/drivers/pwm/pwm-mediatek.c
@@ -0,0 +1,223 @@
+/*
+ * Mediatek Pulse Width Modulator driver
+ *
+ * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/* the IP supports 5 PWM channels */
+#define MTK_NUM_PWM		5
+
+/* PWM registers and bits definitions */
+#define PWMCON			0x00
+#define PWMHDUR			0x04
+#define PWMLDUR			0x08
+#define PWMGDUR			0x0c
+#define PWMWAVENUM		0x28
+#define PWMDWIDTH		0x2c
+#define PWMTHRES		0x30
+
+enum {
+	MTK_CLK_MAIN = 0,
+	MTK_CLK_TOP,
+	MTK_CLK_PWM1,
+	MTK_CLK_PWM2,
+	MTK_CLK_PWM3,
+	MTK_CLK_PWM4,
+	MTK_CLK_PWM5,
+	MTK_CLK_MAX,
+};
+
+static const char * const mtk_pwm_clk_name[] = {
+	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5"
+};
+
+/**
+ * struct mtk_pwm_chip - struct representing pwm chip
+ *
+ * @mmio_base: base address of pwm chip
+ * @chip: linux pwm chip representation
+ */
+struct mtk_pwm_chip {
+	void __iomem *mmio_base;
+	struct pwm_chip chip;
+	struct clk *clks[MTK_CLK_MAX];
+};
+
+static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mtk_pwm_chip, chip);
+}
+
+static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
+				  unsigned long offset)
+{
+	return ioread32(chip->mmio_base + 0x10 + (num * 0x40) + offset);
+}
+
+static inline void mtk_pwm_writel(struct mtk_pwm_chip *chip,
+				    unsigned int num, unsigned long offset,
+				    unsigned long val)
+{
+	iowrite32(val, chip->mmio_base + 0x10 + (num * 0x40) + offset);
+}
+
+static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    int duty_ns, int period_ns)
+{
+	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	u32 resolution = 100 / 4;
+	u32 clkdiv = 0;
+
+	resolution = 1000000000 /
+		     (clk_get_rate(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]));
+
+	while (period_ns / resolution  > 8191) {
+		clkdiv++;
+		resolution *= 2;
+	}
+
+	if (clkdiv > 7)
+		return -1;
+
+	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
+	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
+	return 0;
+}
+
+static int mtk_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	u32 val;
+	int ret;
+
+	ret = clk_prepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	if (ret < 0)
+		return ret;
+
+	val = ioread32(pc->mmio_base);
+	val |= BIT(pwm->hwpwm);
+	iowrite32(val, pc->mmio_base);
+
+	return 0;
+}
+
+static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	u32 val;
+
+	val = ioread32(pc->mmio_base);
+	val &= ~BIT(pwm->hwpwm);
+	iowrite32(val, pc->mmio_base);
+	clk_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+}
+
+static const struct pwm_ops mtk_pwm_ops = {
+	.config = mtk_pwm_config,
+	.enable = mtk_pwm_enable,
+	.disable = mtk_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int mtk_pwm_probe(struct platform_device *pdev)
+{
+	struct mtk_pwm_chip *pc;
+	struct resource *r;
+	int ret, i;
+
+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pc->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(pc->mmio_base))
+		return PTR_ERR(pc->mmio_base);
+
+	for (i = 0; i < MTK_CLK_MAX; i++) {
+		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
+		if (IS_ERR(pc->clks[i]))
+			return PTR_ERR(pc->clks[i]);
+	}
+
+	ret = clk_prepare(pc->clks[MTK_CLK_TOP]);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare(pc->clks[MTK_CLK_MAIN]);
+	if (ret < 0)
+		goto disable_clk_top;
+
+	platform_set_drvdata(pdev, pc);
+
+	pc->chip.dev = &pdev->dev;
+	pc->chip.ops = &mtk_pwm_ops;
+	pc->chip.base = -1;
+	pc->chip.npwm = MTK_NUM_PWM;
+
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		goto disable_clk_main;
+	}
+
+	return 0;
+
+disable_clk_main:
+	clk_unprepare(pc->clks[MTK_CLK_MAIN]);
+disable_clk_top:
+	clk_unprepare(pc->clks[MTK_CLK_TOP]);
+
+	return ret;
+}
+
+static int mtk_pwm_remove(struct platform_device *pdev)
+{
+	struct mtk_pwm_chip *pc = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < MTK_NUM_PWM; i++)
+		pwm_disable(&pc->chip.pwms[i]);
+
+	return pwmchip_remove(&pc->chip);
+}
+
+static const struct of_device_id mtk_pwm_of_match[] = {
+	{ .compatible = "mediatek,mt7623-pwm" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
+
+static struct platform_driver mtk_pwm_driver = {
+	.driver = {
+		.name = "mtk-pwm",
+		.owner = THIS_MODULE,
+		.of_match_table = mtk_pwm_of_match,
+	},
+	.probe = mtk_pwm_probe,
+	.remove = mtk_pwm_remove,
+};
+
+module_platform_driver(mtk_pwm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_ALIAS("platform:mtk-pwm");
-- 
1.7.10.4
