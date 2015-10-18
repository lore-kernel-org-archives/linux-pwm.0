From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH RESEND] pwm: ftm: fix clock enable/disable when using PM
Date: Sat, 17 Oct 2015 21:29:12 -0700
Message-ID: <1445142552-3530-1-git-send-email-stefan@agner.ch>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:53309 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbbJRE2w (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Oct 2015 00:28:52 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>

The driver has multiple issues when enabling/disabling clocks. A given
instance enables/disables three clocks: the bus clock, the counter
clock and the PWM clock. The bus clock gets enabled on pwm_request,
whereas the counter and PWM clocks will be enabled upon pwm_enable.

When entering suspend, the current behavior relies on the FTM_OUTMASK
register: If a PWM output is unmasked, the driver assumes the clocks
are enabled. However, some PWM instances, e.g. Vybrid's FTM1, only
have 2 channels connected. In that case, the FTM_OUTMASK reads only
0x3, even when it was initialized with 0xff. Hence for those PWM
instances, the current approach does not work at all.

A second issue is that the three clocks are not treated differently
regarding PWM's enabled/requested state. This can lead to clocks
getting disabled which have not been enabled in the first place (a PWM
channel which only has been requested).

A third issue applies to the bus clock only, which can get enabled
multiple times (once for each PWM channel of a PWM chip). This is
fine, however when entering suspend mode, the clock only gets disabled
once.

To fix the issues this change introduces a different approach by
relying on the enable/prepared counters of the clock framework. Clocks
get disabled during suspend and back enabled on resume regarding to
the PWM channels individual state. However, since we do not count the
clocks locally, this change no longer clears the Status and Control
registers Clock Source Selection (FTM_SC[CLKS]). There have not
observed issues with that approach so far.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pwm/pwm-fsl-ftm.c | 58 ++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index f9dfc8b..5e1dd96 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -80,7 +80,6 @@ struct fsl_pwm_chip {
 
 	struct mutex lock;
 
-	unsigned int use_count;
 	unsigned int cnt_select;
 	unsigned int clk_ps;
 
@@ -300,9 +299,6 @@ static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
 {
 	int ret;
 
-	if (fpc->use_count++ != 0)
-		return 0;
-
 	/* select counter clock source */
 	regmap_update_bits(fpc->regmap, FTM_SC, FTM_SC_CLK_MASK,
 			   FTM_SC_CLK(fpc->cnt_select));
@@ -334,25 +330,6 @@ static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	return ret;
 }
 
-static void fsl_counter_clock_disable(struct fsl_pwm_chip *fpc)
-{
-	/*
-	 * already disabled, do nothing
-	 */
-	if (fpc->use_count == 0)
-		return;
-
-	/* there are still users, so can't disable yet */
-	if (--fpc->use_count > 0)
-		return;
-
-	/* no users left, disable PWM counter clock */
-	regmap_update_bits(fpc->regmap, FTM_SC, FTM_SC_CLK_MASK, 0);
-
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
-	clk_disable_unprepare(fpc->clk[fpc->cnt_select]);
-}
-
 static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
@@ -362,7 +339,8 @@ static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm),
 			   BIT(pwm->hwpwm));
 
-	fsl_counter_clock_disable(fpc);
+	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
+	clk_disable_unprepare(fpc->clk[fpc->cnt_select]);
 
 	regmap_read(fpc->regmap, FTM_OUTMASK, &val);
 	if ((val & 0xFF) == 0xFF)
@@ -492,17 +470,24 @@ static int fsl_pwm_remove(struct platform_device *pdev)
 static int fsl_pwm_suspend(struct device *dev)
 {
 	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
-	u32 val;
+	int i;
 
 	regcache_cache_only(fpc->regmap, true);
 	regcache_mark_dirty(fpc->regmap);
 
-	/* read from cache */
-	regmap_read(fpc->regmap, FTM_OUTMASK, &val);
-	if ((val & 0xFF) != 0xFF) {
+	for (i = 0; i < fpc->chip.npwm; i++) {
+		struct pwm_device *pwm = &fpc->chip.pwms[i];
+
+		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
+			continue;
+
+		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+
+		if (!test_bit(PWMF_ENABLED, &pwm->flags))
+			continue;
+
 		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
 		clk_disable_unprepare(fpc->clk[fpc->cnt_select]);
-		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
 	}
 
 	return 0;
@@ -511,12 +496,19 @@ static int fsl_pwm_suspend(struct device *dev)
 static int fsl_pwm_resume(struct device *dev)
 {
 	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
-	u32 val;
+	int i;
+
+	for (i = 0; i < fpc->chip.npwm; i++) {
+		struct pwm_device *pwm = &fpc->chip.pwms[i];
+
+		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
+			continue;
 
-	/* read from cache */
-	regmap_read(fpc->regmap, FTM_OUTMASK, &val);
-	if ((val & 0xFF) != 0xFF) {
 		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+
+		if (!test_bit(PWMF_ENABLED, &pwm->flags))
+			continue;
+
 		clk_prepare_enable(fpc->clk[fpc->cnt_select]);
 		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
 	}
-- 
2.4.2
