From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 3/3] hwmon: pwm-fan: remove no longer needed
 suspend/resume code
Date: Mon, 24 Apr 2017 12:01:09 +0200
Message-ID: <1493028069-32003-4-git-send-email-b.zolnierkie@samsung.com>
References: <1493028069-32003-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20170424100139epcas1p4e8e120d2da6ef7eb69ca28f6b3077c59@epcas1p4.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1493028069-32003-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pwm@vger.kernel.org

The suspend/resume is now properly handled by pwm-samsung driver
(pwm-fan is currently only used by ARM Exynos boards) and the old
code only handles ctx->pwm_value != 0 case. Just remove it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index f9af393..9dc40f3 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -302,37 +302,6 @@ static int pwm_fan_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pwm_fan_suspend(struct device *dev)
-{
-	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
-
-	if (ctx->pwm_value)
-		pwm_disable(ctx->pwm);
-	return 0;
-}
-
-static int pwm_fan_resume(struct device *dev)
-{
-	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
-	struct pwm_args pargs;
-	unsigned long duty;
-	int ret;
-
-	if (ctx->pwm_value == 0)
-		return 0;
-
-	pwm_get_args(ctx->pwm, &pargs);
-	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, pargs.period);
-	if (ret)
-		return ret;
-	return pwm_enable(ctx->pwm);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(pwm_fan_pm, pwm_fan_suspend, pwm_fan_resume);
-
 static const struct of_device_id of_pwm_fan_match[] = {
 	{ .compatible = "pwm-fan", },
 	{},
@@ -344,7 +313,6 @@ static int pwm_fan_resume(struct device *dev)
 	.remove		= pwm_fan_remove,
 	.driver	= {
 		.name		= "pwm-fan",
-		.pm		= &pwm_fan_pm,
 		.of_match_table	= of_pwm_fan_match,
 	},
 };
-- 
1.9.1
