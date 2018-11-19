Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 19 Nov 2018 20:58:08 +0100
Message-Id: <20181119195808.16436-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20181119195808.16436-1-u.kleine-koenig@pengutronix.de>
References: <20181119195808.16436-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [PATCH 4/4] pwm: imx: split into two drivers
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

The two PWM implementations called v1 (for i.MX1 and i.MX21) and v2 (for
i.MX27 and later) have nothing in common apart from needing a clk named
"per" and being integrated in a SoC that is named i.MX$something.

So split the file containing the two disjunct drivers into two files and
two complete separate drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig                    |  17 ++-
 drivers/pwm/Makefile                   |   3 +-
 drivers/pwm/pwm-imx1.c                 | 162 +++++++++++++++++++++++
 drivers/pwm/{pwm-imx.c => pwm-imx27.c} | 175 +++++--------------------
 4 files changed, 213 insertions(+), 144 deletions(-)
 create mode 100644 drivers/pwm/pwm-imx1.c
 rename drivers/pwm/{pwm-imx.c => pwm-imx27.c} (50%)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 504d252716f2..495403a2c102 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -190,14 +190,23 @@ config PWM_IMG
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-img
 
-config PWM_IMX
-	tristate "i.MX PWM support"
+config PWM_IMX1
+	tristate "i.MX1 PWM support"
 	depends on ARCH_MXC
 	help
-	  Generic PWM framework driver for i.MX.
+	  Generic PWM framework driver for i.MX1 and i.MX21
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-imx.
+	  will be called pwm-imx1.
+
+config PWM_IMX27
+	tristate "i.MX27 PWM support"
+	depends on ARCH_MXC
+	help
+	  Generic PWM framework driver for i.MX27 and later i.MX SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-imx27.
 
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9c676a0dadf5..448825e892bc 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -17,7 +17,8 @@ obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
-obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
+obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
+obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
new file mode 100644
index 000000000000..57ce49e66f27
--- /dev/null
+++ b/drivers/pwm/pwm-imx1.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * simple driver for PWM (Pulse Width Modulator) controller for i.MX1 and
+ * i.MX21.
+ *
+ * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/pwm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#define MX1_PWMC			0x00   /* PWM Control Register */
+#define MX1_PWMS			0x04   /* PWM Sample Register */
+#define MX1_PWMP			0x08   /* PWM Period Register */
+
+#define MX1_PWMC_EN			(1 << 4)
+
+struct pwm_imx1_chip {
+	struct clk *clk_per;
+
+	void __iomem *mmio_base;
+
+	struct pwm_chip chip;
+};
+
+#define to_imx_chip(chip)	container_of(chip, struct pwm_imx1_chip, chip)
+
+static int pwm_imx1_config(struct pwm_chip *chip,
+			   struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	struct pwm_imx1_chip *imx = to_imx_chip(chip);
+
+	/*
+	 * The PWM subsystem allows for exact frequencies. However,
+	 * I cannot connect a scope on my device to the PWM line and
+	 * thus cannot provide the program the PWM controller
+	 * exactly. Instead, I'm relying on the fact that the
+	 * Bootloader (u-boot or WinCE+haret) has programmed the PWM
+	 * function group already. So I'll just modify the PWM sample
+	 * register to follow the ratio of duty_ns vs. period_ns
+	 * accordingly.
+	 *
+	 * This is good enough for programming the brightness of
+	 * the LCD backlight.
+	 *
+	 * The real implementation would divide PERCLK[0] first by
+	 * both the prescaler (/1 .. /128) and then by CLKSEL
+	 * (/2 .. /16).
+	 */
+	u32 max = readl(imx->mmio_base + MX1_PWMP);
+	u32 p = max * duty_ns / period_ns;
+	writel(max - p, imx->mmio_base + MX1_PWMS);
+
+	return 0;
+}
+
+static int pwm_imx1_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_imx1_chip *imx = to_imx_chip(chip);
+	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(imx->clk_per);
+	if (ret < 0)
+		return ret;
+
+	val = readl(imx->mmio_base + MX1_PWMC);
+	val |= MX1_PWMC_EN;
+	writel(val, imx->mmio_base + MX1_PWMC);
+
+	return 0;
+}
+
+static void pwm_imx1_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_imx1_chip *imx = to_imx_chip(chip);
+	u32 val;
+
+	val = readl(imx->mmio_base + MX1_PWMC);
+	val &= ~MX1_PWMC_EN;
+	writel(val, imx->mmio_base + MX1_PWMC);
+
+	clk_disable_unprepare(imx->clk_per);
+}
+
+static const struct pwm_ops pwm_imx1_ops = {
+	.enable = pwm_imx1_enable,
+	.disable = pwm_imx1_disable,
+	.config = pwm_imx1_config,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id pwm_imx1_dt_ids[] = {
+	{ .compatible = "fsl,imx1-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
+
+static int pwm_imx1_probe(struct platform_device *pdev)
+{
+	struct pwm_imx1_chip *imx;
+	struct resource *r;
+
+	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
+	if (imx == NULL)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, imx);
+
+	imx->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(imx->clk_per)) {
+		int ret = PTR_ERR(imx->clk_per);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "getting per clock failed (%d)\n",
+				ret);
+		return ret;
+	}
+
+	imx->chip.ops = &pwm_imx1_ops;
+	imx->chip.dev = &pdev->dev;
+	imx->chip.base = -1;
+	imx->chip.npwm = 1;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(imx->mmio_base))
+		return PTR_ERR(imx->mmio_base);
+
+	return pwmchip_add(&imx->chip);
+}
+
+static int pwm_imx1_remove(struct platform_device *pdev)
+{
+	struct pwm_imx1_chip *imx;
+
+	imx = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&imx->chip);
+}
+
+static struct platform_driver pwm_imx1_driver = {
+	.driver = {
+		.name = "pwm-imx1",
+		.of_match_table = pwm_imx1_dt_ids,
+	},
+	.probe = pwm_imx1_probe,
+	.remove = pwm_imx1_remove,
+};
+module_platform_driver(pwm_imx1_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx27.c
similarity index 50%
rename from drivers/pwm/pwm-imx.c
rename to drivers/pwm/pwm-imx27.c
index 3fa47ba86f87..276e6aacb810 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * simple driver for PWM (Pulse Width Modulator) controller
+ * simple driver for PWM (Pulse Width Modulator) controller for i.MX27 and
+ * later.
  *
  * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
  */
@@ -17,16 +18,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-/* i.MX1 and i.MX21 share the same PWM function block: */
-
-#define MX1_PWMC			0x00   /* PWM Control Register */
-#define MX1_PWMS			0x04   /* PWM Sample Register */
-#define MX1_PWMP			0x08   /* PWM Period Register */
-
-#define MX1_PWMC_EN			(1 << 4)
-
-/* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
-
 #define MX3_PWMCR			0x00    /* PWM Control Register */
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
@@ -38,7 +29,6 @@
 #define MX3_PWMCR_DBGEN			(1 << 22)
 #define MX3_PWMCR_POUTC			(1 << 18)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
-#define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
 #define MX3_PWMCR_SWR			(1 << 3)
 #define MX3_PWMCR_EN			(1 << 0)
 #define MX3_PWMSR_FIFOAV_4WORDS		0x4
@@ -46,77 +36,19 @@
 
 #define MX3_PWM_SWR_LOOP		5
 
-struct imx_chip {
-	struct clk	*clk_per;
+struct pwm_imx27_chip {
+	struct clk *clk_per;
 
-	void __iomem	*mmio_base;
+	void __iomem *mmio_base;
 
-	struct pwm_chip	chip;
+	struct pwm_chip chip;
 };
 
-#define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
-
-static int imx_pwm_config_v1(struct pwm_chip *chip,
-		struct pwm_device *pwm, int duty_ns, int period_ns)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-
-	/*
-	 * The PWM subsystem allows for exact frequencies. However,
-	 * I cannot connect a scope on my device to the PWM line and
-	 * thus cannot provide the program the PWM controller
-	 * exactly. Instead, I'm relying on the fact that the
-	 * Bootloader (u-boot or WinCE+haret) has programmed the PWM
-	 * function group already. So I'll just modify the PWM sample
-	 * register to follow the ratio of duty_ns vs. period_ns
-	 * accordingly.
-	 *
-	 * This is good enough for programming the brightness of
-	 * the LCD backlight.
-	 *
-	 * The real implementation would divide PERCLK[0] first by
-	 * both the prescaler (/1 .. /128) and then by CLKSEL
-	 * (/2 .. /16).
-	 */
-	u32 max = readl(imx->mmio_base + MX1_PWMP);
-	u32 p = max * duty_ns / period_ns;
-	writel(max - p, imx->mmio_base + MX1_PWMS);
+#define to_imx_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
 
-	return 0;
-}
-
-static int imx_pwm_enable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
+static void pwm_imx27_sw_reset(struct pwm_chip *chip)
 {
-	struct imx_chip *imx = to_imx_chip(chip);
-	u32 val;
-	int ret;
-
-	ret = clk_prepare_enable(imx->clk_per);
-	if (ret < 0)
-		return ret;
-
-	val = readl(imx->mmio_base + MX1_PWMC);
-	val |= MX1_PWMC_EN;
-	writel(val, imx->mmio_base + MX1_PWMC);
-
-	return 0;
-}
-
-static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-	u32 val;
-
-	val = readl(imx->mmio_base + MX1_PWMC);
-	val &= ~MX1_PWMC_EN;
-	writel(val, imx->mmio_base + MX1_PWMC);
-
-	clk_disable_unprepare(imx->clk_per);
-}
-
-static void imx_pwm_sw_reset(struct pwm_chip *chip)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
+	struct pwm_imx27_chip *imx = to_imx_chip(chip);
 	struct device *dev = chip->dev;
 	int wait_count = 0;
 	u32 cr;
@@ -132,10 +64,10 @@ static void imx_pwm_sw_reset(struct pwm_chip *chip)
 		dev_warn(dev, "software reset timeout\n");
 }
 
-static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
-				   struct pwm_device *pwm)
+static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
+				     struct pwm_device *pwm)
 {
-	struct imx_chip *imx = to_imx_chip(chip);
+	struct pwm_imx27_chip *imx = to_imx_chip(chip);
 	struct device *dev = chip->dev;
 	unsigned int period_ms;
 	int fifoav;
@@ -154,11 +86,11 @@ static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
 	}
 }
 
-static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
-			    struct pwm_state *state)
+static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
 {
 	unsigned long period_cycles, duty_cycles, prescale;
-	struct imx_chip *imx = to_imx_chip(chip);
+	struct pwm_imx27_chip *imx = to_imx_chip(chip);
 	struct pwm_state cstate;
 	unsigned long long c;
 	int ret;
@@ -195,13 +127,13 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * enabled.
 		 */
 		if (cstate.enabled) {
-			imx_pwm_wait_fifo_slot(chip, pwm);
+			pwm_imx27_wait_fifo_slot(chip, pwm);
 		} else {
 			ret = clk_prepare_enable(imx->clk_per);
 			if (ret)
 				return ret;
 
-			imx_pwm_sw_reset(chip);
+			pwm_imx27_sw_reset(chip);
 		}
 
 		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
@@ -225,52 +157,22 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static const struct pwm_ops imx_pwm_ops_v1 = {
-	.enable = imx_pwm_enable_v1,
-	.disable = imx_pwm_disable_v1,
-	.config = imx_pwm_config_v1,
+static const struct pwm_ops pwm_imx27_ops = {
+	.apply = pwm_imx27_apply,
 	.owner = THIS_MODULE,
 };
 
-static const struct pwm_ops imx_pwm_ops_v2 = {
-	.apply = imx_pwm_apply_v2,
-	.owner = THIS_MODULE,
-};
-
-struct imx_pwm_data {
-	bool polarity_supported;
-	const struct pwm_ops *ops;
-};
-
-static struct imx_pwm_data imx_pwm_data_v1 = {
-	.ops = &imx_pwm_ops_v1,
-};
-
-static struct imx_pwm_data imx_pwm_data_v2 = {
-	.polarity_supported = true,
-	.ops = &imx_pwm_ops_v2,
-};
-
-static const struct of_device_id imx_pwm_dt_ids[] = {
-	{ .compatible = "fsl,imx1-pwm", .data = &imx_pwm_data_v1, },
-	{ .compatible = "fsl,imx27-pwm", .data = &imx_pwm_data_v2, },
+static const struct of_device_id pwm_imx27_dt_ids[] = {
+	{ .compatible = "fsl,imx27-pwm", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
+MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
-static int imx_pwm_probe(struct platform_device *pdev)
+static int pwm_imx27_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(imx_pwm_dt_ids, &pdev->dev);
-	const struct imx_pwm_data *data;
-	struct imx_chip *imx;
+	struct pwm_imx27_chip *imx;
 	struct resource *r;
 
-	if (!of_id)
-		return -ENODEV;
-
-	data = of_id->data;
-
 	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx == NULL)
 		return -ENOMEM;
@@ -287,16 +189,12 @@ static int imx_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	imx->chip.ops = data->ops;
+	imx->chip.ops = &pwm_imx27_ops;
 	imx->chip.dev = &pdev->dev;
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
-
-	if (data->polarity_supported) {
-		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
-		imx->chip.of_xlate = of_pwm_xlate_with_flags;
-		imx->chip.of_pwm_n_cells = 3;
-	}
+	imx->chip.of_xlate = of_pwm_xlate_with_flags;
+	imx->chip.of_pwm_n_cells = 3;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
@@ -306,25 +204,24 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	return pwmchip_add(&imx->chip);
 }
 
-static int imx_pwm_remove(struct platform_device *pdev)
+static int pwm_imx27_remove(struct platform_device *pdev)
 {
-	struct imx_chip *imx;
+	struct pwm_imx27_chip *imx;
 
 	imx = platform_get_drvdata(pdev);
 
 	return pwmchip_remove(&imx->chip);
 }
 
-static struct platform_driver imx_pwm_driver = {
-	.driver		= {
-		.name	= "imx-pwm",
-		.of_match_table = imx_pwm_dt_ids,
+static struct platform_driver pwm_imx27_driver = {
+	.driver = {
+		.name = "pwm-imx27",
+		.of_match_table = pwm_imx27_dt_ids,
 	},
-	.probe		= imx_pwm_probe,
-	.remove		= imx_pwm_remove,
+	.probe = pwm_imx27_probe,
+	.remove = pwm_imx27_remove,
 };
-
-module_platform_driver(imx_pwm_driver);
+module_platform_driver(pwm_imx27_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
2.19.1
