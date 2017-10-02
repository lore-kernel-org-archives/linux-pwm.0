From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 2/2] pwm: img: Add runtime PM
Date: Mon,  2 Oct 2017 10:51:48 +0100
Message-ID: <1506937908-360-3-git-send-email-ed.blake@sondrel.com>
References: <1506937908-360-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:46624
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751104AbdJBJwJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Oct 2017 05:52:09 -0400
In-Reply-To: <1506937908-360-1-git-send-email-ed.blake@sondrel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Ed Blake <ed.blake@sondrel.com>

Add runtime PM to disable the clocks when the h/w is not in use.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 drivers/pwm/pwm-img.c | 132 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 95 insertions(+), 37 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index a6d7915..a9dce2f 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -39,6 +40,8 @@
 #define PERIP_PWM_PDM_CONTROL_CH_MASK		0x1
 #define PERIP_PWM_PDM_CONTROL_CH_SHIFT(ch)	((ch) * 4)
 
+#define IMG_PWM_PM_TIMEOUT			1000 /* ms */
+
 /*
  * PWM period is specified with a timebase register,
  * in number of step periods. The PWM duty cycle is also
@@ -96,6 +99,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long mul, output_clk_hz, input_clk_hz;
 	struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
 	unsigned int max_timebase = pwm_chip->data->max_timebase;
+	int ret;
 
 	if (period_ns < pwm_chip->min_period_ns ||
 	    period_ns > pwm_chip->max_period_ns) {
@@ -127,6 +131,10 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
+	ret = pm_runtime_get_sync(chip->dev);
+	if (ret < 0)
+		return ret;
+
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val &= ~(PWM_CTRL_CFG_DIV_MASK << PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
 	val |= (div & PWM_CTRL_CFG_DIV_MASK) <<
@@ -137,6 +145,9 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	      (timebase << PWM_CH_CFG_TMBASE_SHIFT);
 	img_pwm_writel(pwm_chip, PWM_CH_CFG(pwm->hwpwm), val);
 
+	pm_runtime_mark_last_busy(chip->dev);
+	pm_runtime_put_autosuspend(chip->dev);
+
 	return 0;
 }
 
@@ -144,6 +155,11 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	u32 val;
 	struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
+	int ret;
+
+	ret = pm_runtime_get_sync(chip->dev);
+	if (ret < 0)
+		return ret;
 
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val |= BIT(pwm->hwpwm);
@@ -164,6 +180,9 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val &= ~BIT(pwm->hwpwm);
 	img_pwm_writel(pwm_chip, PWM_CTRL_CFG, val);
+
+	pm_runtime_mark_last_busy(chip->dev);
+	pm_runtime_put_autosuspend(chip->dev);
 }
 
 static const struct pwm_ops img_pwm_ops = {
@@ -186,6 +205,37 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 };
 MODULE_DEVICE_TABLE(of, img_pwm_of_match);
 
+static int img_pwm_runtime_suspend(struct device *dev)
+{
+	struct img_pwm_chip *pwm_chip = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(pwm_chip->pwm_clk);
+	clk_disable_unprepare(pwm_chip->sys_clk);
+
+	return 0;
+}
+
+static int img_pwm_runtime_resume(struct device *dev)
+{
+	struct img_pwm_chip *pwm_chip = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(pwm_chip->sys_clk);
+	if (ret < 0) {
+		dev_err(dev, "could not prepare or enable sys clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pwm_chip->pwm_clk);
+	if (ret < 0) {
+		dev_err(dev, "could not prepare or enable pwm clock\n");
+		clk_disable_unprepare(pwm_chip->sys_clk);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int img_pwm_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -228,23 +278,20 @@ static int img_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pwm->pwm_clk);
 	}
 
-	ret = clk_prepare_enable(pwm->sys_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not prepare or enable sys clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(pwm->pwm_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not prepare or enable pwm clock\n");
-		goto disable_sysclk;
+	pm_runtime_set_autosuspend_delay(&pdev->dev, IMG_PWM_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = img_pwm_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
 	}
 
 	clk_rate = clk_get_rate(pwm->pwm_clk);
 	if (!clk_rate) {
 		dev_err(&pdev->dev, "pwm clock has no frequency\n");
 		ret = -EINVAL;
-		goto disable_pwmclk;
+		goto err_suspend;
 	}
 
 	/* The maximum input clock divider is 512 */
@@ -264,16 +311,18 @@ static int img_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
-		goto disable_pwmclk;
+		goto err_suspend;
 	}
 
 	platform_set_drvdata(pdev, pwm);
 	return 0;
 
-disable_pwmclk:
-	clk_disable_unprepare(pwm->pwm_clk);
-disable_sysclk:
-	clk_disable_unprepare(pwm->sys_clk);
+err_suspend:
+	if (!pm_runtime_enabled(&pdev->dev))
+		img_pwm_runtime_suspend(&pdev->dev);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	return ret;
 }
 
@@ -282,6 +331,11 @@ static int img_pwm_remove(struct platform_device *pdev)
 	struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
 	u32 val;
 	unsigned int i;
+	int ret;
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++) {
 		val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
@@ -289,8 +343,10 @@ static int img_pwm_remove(struct platform_device *pdev)
 		img_pwm_writel(pwm_chip, PWM_CTRL_CFG, val);
 	}
 
-	clk_disable_unprepare(pwm_chip->pwm_clk);
-	clk_disable_unprepare(pwm_chip->sys_clk);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		img_pwm_runtime_suspend(&pdev->dev);
 
 	return pwmchip_remove(&pwm_chip->chip);
 }
@@ -298,9 +354,14 @@ static int img_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int img_pwm_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
-	int i;
+	struct img_pwm_chip *pwm_chip = dev_get_drvdata(dev);
+	int i, ret;
+
+	if (pm_runtime_status_suspended(dev)) {
+		ret = img_pwm_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++)
 		pwm_chip->suspend_ch_cfg[i] = img_pwm_readl(pwm_chip,
@@ -308,31 +369,20 @@ static int img_pwm_suspend(struct device *dev)
 
 	pwm_chip->suspend_ctrl_cfg = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 
-	clk_disable_unprepare(pwm_chip->pwm_clk);
-	clk_disable_unprepare(pwm_chip->sys_clk);
+	img_pwm_runtime_suspend(dev);
 
 	return 0;
 }
 
 static int img_pwm_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
+	struct img_pwm_chip *pwm_chip = dev_get_drvdata(dev);
 	int ret;
 	int i;
 
-	ret = clk_prepare_enable(pwm_chip->sys_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not prepare or enable sys clock\n");
+	ret = img_pwm_runtime_resume(dev);
+	if (ret)
 		return ret;
-	}
-
-	ret = clk_prepare_enable(pwm_chip->pwm_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not prepare or enable pwm clock\n");
-		clk_disable_unprepare(pwm_chip->sys_clk);
-		return ret;
-	}
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++)
 		img_pwm_writel(pwm_chip, PWM_CH_CFG(i),
@@ -348,11 +398,19 @@ static int img_pwm_resume(struct device *dev)
 					   PERIP_PWM_PDM_CONTROL_CH_SHIFT(i),
 					   0);
 
+	if (pm_runtime_status_suspended(dev))
+		img_pwm_runtime_suspend(dev);
+
 	return 0;
 }
 #endif /* CONFIG_PM */
 
-SIMPLE_DEV_PM_OPS(img_pwm_pm_ops, img_pwm_suspend, img_pwm_resume);
+static const struct dev_pm_ops img_pwm_pm_ops = {
+	SET_RUNTIME_PM_OPS(img_pwm_runtime_suspend,
+			   img_pwm_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(img_pwm_suspend, img_pwm_resume)
+};
 
 static struct platform_driver img_pwm_driver = {
 	.driver = {
-- 
1.9.1
