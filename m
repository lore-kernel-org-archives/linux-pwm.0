From: shenwei.wang@nxp.com
Subject: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on i.MX8x
Date: Thu, 24 May 2018 13:08:48 -0500
Message-ID: <20180524180848.61844-1-shenwei.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
List-Id: linux-pwm@vger.kernel.org

On the new i.MX8x SoC family, the following changes were made on the FTM
block:

1. Need to enable the IPG clock before accessing any FTM registers. Because
the IPG clock is not an option for FTM counter clock source, it can't be
used as the ftm_sys clock.

2. An additional PWM enable bit was added for each PWM channel in register
FTM_SC[16:23]. It supports 8 channels. Bit16 is for channel 0, and bit23
for channel 7.

As the IP version information can not be obtained in any of the FTM
registers, a property of "fsl,has-pwmen-bits" is added in the ftm pwm
device node. If it has the property, the driver set the PWM enable bit
when a PWM channel is requested.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 557b4ea..0426458f 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -86,7 +86,9 @@ struct fsl_pwm_chip {
 	struct regmap *regmap;
 
 	int period_ns;
+	bool has_pwmen;
 
+	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
 };
 
@@ -97,16 +99,31 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 
 static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	int ret;
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret = clk_prepare_enable(fpc->ipg_clk);
+
+	if ((!ret) && (fpc->has_pwmen)) {
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
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	if (fpc->has_pwmen) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
+		mutex_unlock(&fpc->lock);
+	}
+	clk_disable_unprepare(fpc->ipg_clk);
 }
 
 static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
@@ -363,7 +380,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 {
 	int ret;
 
-	ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret = clk_prepare_enable(fpc->ipg_clk);
 	if (ret)
 		return ret;
 
@@ -371,7 +388,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
 
 	return 0;
 }
@@ -428,6 +445,10 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
 	}
 
+	fpc->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fpc->ipg_clk))
+		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
+
 	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(fpc->chip.dev, "ftm_fix");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
@@ -446,6 +467,8 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.base = -1;
 	fpc->chip.npwm = 8;
+	fpc->has_pwmen = of_property_read_bool(pdev->dev.of_node,
+						"fsl,ftm-has-pwmen-bits");
 
 	ret = pwmchip_add(&fpc->chip);
 	if (ret < 0) {
@@ -480,7 +503,7 @@ static int fsl_pwm_suspend(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_disable_unprepare(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -503,7 +526,7 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_prepare_enable(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
-- 
2.9.2
