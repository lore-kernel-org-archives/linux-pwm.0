From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] pwm: ftm: add Power Management support for FTM pwm.
Date: Fri, 10 Oct 2014 18:57:20 +0800
Message-ID: <1412938640-17393-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2on0106.outbound.protection.outlook.com ([207.46.100.106]:44064
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752898AbaJJLNX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 10 Oct 2014 07:13:23 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

Add PM support for FTM pwm driver using callback function suspend
and resume in .driver.pm of platform_driver.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 103 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 0f2cc7e..c504eb1 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -66,6 +67,8 @@
 #define FTM_SWOCTRL	0x94
 #define FTM_PWMLOAD	0x98
 
+#define FTM_NPWM	8
+
 enum fsl_pwm_clk {
 	FSL_PWM_CLK_SYS,
 	FSL_PWM_CLK_FIX,
@@ -74,9 +77,22 @@ enum fsl_pwm_clk {
 	FSL_PWM_CLK_MAX
 };
 
+struct fsl_pwm_ctx {
+	u32 cntin;
+	u32 outinit;
+	u32 outmask;
+	u32 pol;
+	u32 sc;
+	u32 mod;
+	u32 csc[FTM_NPWM];
+	u32 cv[FTM_NPWM];
+};
+
 struct fsl_pwm_chip {
 	struct pwm_chip chip;
 
+	struct fsl_pwm_ctx ctx;
+
 	struct mutex lock;
 
 	unsigned int use_count;
@@ -327,6 +343,9 @@ static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	int ret;
 
 	mutex_lock(&fpc->lock);
+	if (!fpc->use_count)
+		pm_runtime_get_sync(chip->dev);
+
 	regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm), 0);
 
 	ret = fsl_counter_clock_enable(fpc);
@@ -369,7 +388,10 @@ static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if ((val & 0xFF) == 0xFF)
 		fpc->period_ns = 0;
 
+	if (!fpc->use_count)
+		pm_runtime_put_sync(chip->dev);
 	mutex_unlock(&fpc->lock);
+
 }
 
 static const struct pwm_ops fsl_pwm_ops = {
@@ -390,9 +412,11 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	if (ret)
 		return ret;
 
+	pm_runtime_get_sync(fpc->chip.dev);
 	regmap_write(fpc->regmap, FTM_CNTIN, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
+	pm_runtime_put_sync(fpc->chip.dev);
 
 	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
 
@@ -457,7 +481,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
 	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.base = -1;
-	fpc->chip.npwm = 8;
+	fpc->chip.npwm = FTM_NPWM;
 	fpc->chip.can_sleep = true;
 
 	ret = pwmchip_add(&fpc->chip);
@@ -466,6 +490,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(&pdev->dev);
 	platform_set_drvdata(pdev, fpc);
 
 	return fsl_pwm_init(fpc);
@@ -475,9 +500,84 @@ static int fsl_pwm_remove(struct platform_device *pdev)
 {
 	struct fsl_pwm_chip *fpc = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
 	return pwmchip_remove(&fpc->chip);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static void fsl_pwm_save_ctx(struct fsl_pwm_chip *fpc)
+{
+	int i;
+
+	regmap_read(fpc->regmap, FTM_CNTIN, &fpc->ctx.cntin);
+	regmap_read(fpc->regmap, FTM_OUTINIT, &fpc->ctx.outinit);
+	regmap_read(fpc->regmap, FTM_OUTMASK, &fpc->ctx.outmask);
+	regmap_read(fpc->regmap, FTM_POL, &fpc->ctx.pol);
+	regmap_read(fpc->regmap, FTM_SC, &fpc->ctx.sc);
+	regmap_read(fpc->regmap, FTM_MOD, &fpc->ctx.mod);
+	for (i = 0; i < FTM_NPWM; i++) {
+		regmap_read(fpc->regmap, FTM_CSC(i), &fpc->ctx.csc[i]);
+		regmap_read(fpc->regmap, FTM_CV(i), &fpc->ctx.cv[i]);
+	}
+}
+
+static void fsl_pwm_restore_ctx(struct fsl_pwm_chip *fpc)
+{
+	int i;
+
+	regmap_write(fpc->regmap, FTM_CNTIN, fpc->ctx.cntin);
+	regmap_write(fpc->regmap, FTM_OUTINIT, fpc->ctx.outinit);
+	regmap_write(fpc->regmap, FTM_OUTMASK, fpc->ctx.outmask);
+	regmap_write(fpc->regmap, FTM_POL, fpc->ctx.pol);
+	regmap_write(fpc->regmap, FTM_SC, fpc->ctx.sc);
+	regmap_write(fpc->regmap, FTM_MOD, fpc->ctx.mod);
+	for (i = 0; i < FTM_NPWM; i++) {
+		regmap_write(fpc->regmap, FTM_CSC(i), fpc->ctx.csc[i]);
+		regmap_write(fpc->regmap, FTM_CV(i), fpc->ctx.cv[i]);
+	}
+}
+
+static int fsl_pwm_suspend(struct device *dev)
+{
+	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
+
+	/* Disable explicitly if PWM is running */
+	if (fpc->use_count) {
+		fsl_pwm_save_ctx(fpc);
+
+		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
+		clk_disable_unprepare(fpc->clk[fpc->cnt_select]);
+		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+		pm_runtime_put_sync(dev);
+	}
+
+	return 0;
+}
+
+static int fsl_pwm_resume(struct device *dev)
+{
+	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
+
+	/* Enable explicitly if PWM was running */
+	if (fpc->use_count) {
+		pm_runtime_get_sync(dev);
+		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_prepare_enable(fpc->clk[fpc->cnt_select]);
+		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
+
+		fsl_pwm_restore_ctx(fpc);
+	} else {
+		fsl_pwm_init(fpc);
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops fsl_pwm_pm_ops = {
+		SET_SYSTEM_SLEEP_PM_OPS(fsl_pwm_suspend, fsl_pwm_resume)
+};
+
 static const struct of_device_id fsl_pwm_dt_ids[] = {
 	{ .compatible = "fsl,vf610-ftm-pwm", },
 	{ /* sentinel */ }
@@ -488,6 +588,7 @@ static struct platform_driver fsl_pwm_driver = {
 	.driver = {
 		.name = "fsl-ftm-pwm",
 		.of_match_table = fsl_pwm_dt_ids,
+		.pm = &fsl_pwm_pm_ops,
 	},
 	.probe = fsl_pwm_probe,
 	.remove = fsl_pwm_remove,
-- 
2.1.0.27.g96db324

