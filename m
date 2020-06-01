From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] pwm: img: call pm_runtime_put in pm_runtime_get_sync failed case
Date: Mon,  1 Jun 2020 02:11:16 -0500
Message-ID: <20200601071116.69508-1-navid.emamdoost@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHLw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 03:11:52 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>

Even in failed case of pm_runtime_get_sync, the usage_count
is incremented. In order to keep the usage_count with correct
value call appropriate put.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/pwm/pwm-img.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index c9e57bd109fb..599a0f66a384 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -129,8 +129,10 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
 	ret = pm_runtime_get_sync(chip->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(chip->dev);
 		return ret;
+	}
 
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val &= ~(PWM_CTRL_CFG_DIV_MASK << PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
@@ -331,8 +333,10 @@ static int img_pwm_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(&pdev->dev);
 		return ret;
+	}
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++) {
 		val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
-- 
2.17.1
