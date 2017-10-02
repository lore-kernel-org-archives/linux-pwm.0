From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 1/2] pwm: img: Add suspend / resume handling
Date: Mon,  2 Oct 2017 10:51:47 +0100
Message-ID: <1506937908-360-2-git-send-email-ed.blake@sondrel.com>
References: <1506937908-360-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:46624
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751313AbdJBJwH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Oct 2017 05:52:07 -0400
In-Reply-To: <1506937908-360-1-git-send-email-ed.blake@sondrel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Ed Blake <ed.blake@sondrel.com>

The power may be disabled during suspend, so implement suspend and
resume callbacks to save and restore register state.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 drivers/pwm/pwm-img.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 2fb30de..a6d7915 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -52,6 +52,8 @@
  */
 #define MIN_TMBASE_STEPS			16
 
+#define IMG_PWM_NPWM				4
+
 struct img_pwm_soc_data {
 	u32 max_timebase;
 };
@@ -66,6 +68,8 @@ struct img_pwm_chip {
 	int		max_period_ns;
 	int		min_period_ns;
 	const struct img_pwm_soc_data   *data;
+	u32		suspend_ctrl_cfg;
+	u32		suspend_ch_cfg[IMG_PWM_NPWM];
 };
 
 static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
@@ -255,7 +259,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &img_pwm_ops;
 	pwm->chip.base = -1;
-	pwm->chip.npwm = 4;
+	pwm->chip.npwm = IMG_PWM_NPWM;
 
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
@@ -291,9 +295,69 @@ static int img_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pwm_chip->chip);
 }
 
+#ifdef CONFIG_PM
+static int img_pwm_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < pwm_chip->chip.npwm; i++)
+		pwm_chip->suspend_ch_cfg[i] = img_pwm_readl(pwm_chip,
+							    PWM_CH_CFG(i));
+
+	pwm_chip->suspend_ctrl_cfg = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
+
+	clk_disable_unprepare(pwm_chip->pwm_clk);
+	clk_disable_unprepare(pwm_chip->sys_clk);
+
+	return 0;
+}
+
+static int img_pwm_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
+	int ret;
+	int i;
+
+	ret = clk_prepare_enable(pwm_chip->sys_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not prepare or enable sys clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pwm_chip->pwm_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not prepare or enable pwm clock\n");
+		clk_disable_unprepare(pwm_chip->sys_clk);
+		return ret;
+	}
+
+	for (i = 0; i < pwm_chip->chip.npwm; i++)
+		img_pwm_writel(pwm_chip, PWM_CH_CFG(i),
+			       pwm_chip->suspend_ch_cfg[i]);
+
+	img_pwm_writel(pwm_chip, PWM_CTRL_CFG, pwm_chip->suspend_ctrl_cfg);
+
+	for (i = 0; i < pwm_chip->chip.npwm; i++)
+		if (pwm_chip->suspend_ctrl_cfg & BIT(i))
+			regmap_update_bits(pwm_chip->periph_regs,
+					   PERIP_PWM_PDM_CONTROL,
+					   PERIP_PWM_PDM_CONTROL_CH_MASK <<
+					   PERIP_PWM_PDM_CONTROL_CH_SHIFT(i),
+					   0);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+SIMPLE_DEV_PM_OPS(img_pwm_pm_ops, img_pwm_suspend, img_pwm_resume);
+
 static struct platform_driver img_pwm_driver = {
 	.driver = {
 		.name = "img-pwm",
+		.pm = &img_pwm_pm_ops,
 		.of_match_table = img_pwm_of_match,
 	},
 	.probe = img_pwm_probe,
-- 
1.9.1
