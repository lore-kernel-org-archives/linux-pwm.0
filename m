From: shenwei.wang@nxp.com
Subject: [PATCH v2 2/4] pwm: fsl-ftm: Added the support of per-compatible data
Date: Fri,  8 Jun 2018 14:22:35 -0500
Message-ID: <20180608192237.11063-2-shenwei.wang@nxp.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
List-Id: linux-pwm@vger.kernel.org

On the i.MX8x SoC family, an additional PWM enable bit is
added for each PWM channel in the register FTM_SC[23:16].
It supports 8 channels. Bit16 is for channel 0, and bit23
is for channel 7. As the IP version information can not
be obtained via any of the FTM registers, a property of
"has_enable_bits" is added via per-compatible data structure.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index df0a1c0..e4c76da 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -75,6 +76,10 @@ enum fsl_pwm_clk {
 	FSL_PWM_CLK_MAX
 };
 
+struct fsl_ftm_soc {
+	bool has_enable_bits;
+};
+
 struct fsl_pwm_chip {
 	struct pwm_chip chip;
 
@@ -89,6 +94,8 @@ struct fsl_pwm_chip {
 
 	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
+
+	const struct fsl_ftm_soc *soc;
 };
 
 static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
@@ -98,15 +105,31 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 
 static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	int ret;
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	return clk_prepare_enable(fpc->ipg_clk);
+	ret = clk_prepare_enable(fpc->ipg_clk);
+
+	if ((!ret) && (fpc->soc->has_enable_bits)) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC,
+				BIT(pwm->hwpwm + 16), BIT(pwm->hwpwm + 16));
+		mutex_unlock(&fpc->lock);
+	}
+
+	return ret;
 }
 
 static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
+	if (fpc->soc->has_enable_bits) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
+		mutex_unlock(&fpc->lock);
+	}
+
 	clk_disable_unprepare(fpc->ipg_clk);
 }
 
@@ -409,6 +432,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 
 	mutex_init(&fpc->lock);
 
+	fpc->soc = of_device_get_match_data(&pdev->dev);
 	fpc->chip.dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -534,8 +558,12 @@ static const struct dev_pm_ops fsl_pwm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(fsl_pwm_suspend, fsl_pwm_resume)
 };
 
+static const struct fsl_ftm_soc vf610_ftm_pwm = {
+	.has_enable_bits = false,
+};
+
 static const struct of_device_id fsl_pwm_dt_ids[] = {
-	{ .compatible = "fsl,vf610-ftm-pwm", },
+	{ .compatible = "fsl,vf610-ftm-pwm", .data = &vf610_ftm_pwm },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_pwm_dt_ids);
-- 
2.9.2
