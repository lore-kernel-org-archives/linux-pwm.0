From: shenwei.wang@nxp.com
Subject: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock
Date: Fri,  8 Jun 2018 14:22:34 -0500
Message-ID: <20180608192237.11063-1-shenwei.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
List-Id: linux-pwm@vger.kernel.org

The current driver assumes that the ftm_sys clock works as
one of the clock sources for the IP block as well as the IP
interface clock. This assumption does not apply any more on
the latest i.MX8x SoC family. On i.MX8x SoCs, a dedicated IP
interface clock is introduced and it must be enabled before
accessing any FTM registers. Moreover, the clock can not be
used as the source clock for the FTM IP block. This patch
introduces the ipg_clk as the dedicated IP interface clock
and by default it is the same as the ftm_sys clock if not
specified.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 557b4ea..df0a1c0 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -87,6 +87,7 @@ struct fsl_pwm_chip {
 
 	int period_ns;
 
+	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
 };
 
@@ -99,14 +100,14 @@ static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	return clk_prepare_enable(fpc->ipg_clk);
 }
 
 static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
 }
 
 static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
@@ -363,7 +364,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 {
 	int ret;
 
-	ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret = clk_prepare_enable(fpc->ipg_clk);
 	if (ret)
 		return ret;
 
@@ -371,7 +372,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
 
 	return 0;
 }
@@ -441,6 +442,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]);
 
+	/* ipg_clk is the interface clock for the IP.
+	 * If not provided, use the ftm_sys clock as
+	 * the default
+	 */
+	fpc->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fpc->ipg_clk))
+		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
+
+
 	fpc->chip.ops = &fsl_pwm_ops;
 	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
 	fpc->chip.of_pwm_n_cells = 3;
@@ -480,7 +490,7 @@ static int fsl_pwm_suspend(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_disable_unprepare(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -503,7 +513,7 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_prepare_enable(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
-- 
2.9.2
