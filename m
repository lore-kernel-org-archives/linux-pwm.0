From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] hwmon: pwm-fan: switch to new atomic PWM API
Date: Mon, 24 Apr 2017 15:13:17 +0200
Message-ID: <1493039598-25881-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170424131342epcas5p4cb2f53f6c780119557ff3da56fb8f0a8@epcas5p4.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pwm@vger.kernel.org

Switch pwm-fan driver to new atomic PWM API.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Depends on "[PATCH v2 0/3] pwm: pwm-samsung: fix suspend/resume support"
patchset (https://www.spinics.net/lists/kernel/msg2495209.html).

 drivers/hwmon/pwm-fan.c | 68 +++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 9dc40f3..4ac7700 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -40,31 +40,22 @@ struct pwm_fan_ctx {
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
-	struct pwm_args pargs;
-	unsigned long duty;
+	unsigned long period;
 	int ret = 0;
-
-	pwm_get_args(ctx->pwm, &pargs);
+	struct pwm_state state = { };
 
 	mutex_lock(&ctx->lock);
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
-	duty = DIV_ROUND_UP(pwm * (pargs.period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, pargs.period);
-	if (ret)
-		goto exit_set_pwm_err;
-
-	if (pwm == 0)
-		pwm_disable(ctx->pwm);
+	pwm_init_state(ctx->pwm, &state);
+	period = ctx->pwm->args.period;
+	state.duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
+	state.enabled = pwm ? true : false;
 
-	if (ctx->pwm_value == 0) {
-		ret = pwm_enable(ctx->pwm);
-		if (ret)
-			goto exit_set_pwm_err;
-	}
-
-	ctx->pwm_value = pwm;
+	ret = pwm_apply_state(ctx->pwm, &state);
+	if (!ret)
+		ctx->pwm_value = pwm;
 exit_set_pwm_err:
 	mutex_unlock(&ctx->lock);
 	return ret;
@@ -218,10 +209,9 @@ static int pwm_fan_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
 	struct pwm_fan_ctx *ctx;
-	struct pwm_args pargs;
 	struct device *hwmon;
-	int duty_cycle;
 	int ret;
+	struct pwm_state state = { };
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -237,28 +227,16 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to the
-	 * atomic PWM API.
-	 */
-	pwm_apply_args(ctx->pwm);
-
-	/* Set duty cycle to maximum allowed */
-	pwm_get_args(ctx->pwm, &pargs);
-
-	duty_cycle = pargs.period - 1;
 	ctx->pwm_value = MAX_PWM;
 
-	ret = pwm_config(ctx->pwm, duty_cycle, pargs.period);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to configure PWM\n");
-		return ret;
-	}
+	/* Set duty cycle to maximum allowed and enable PWM output */
+	pwm_init_state(ctx->pwm, &state);
+	state.duty_cycle = ctx->pwm->args.period - 1;
+	state.enabled = true;
 
-	/* Enbale PWM output */
-	ret = pwm_enable(ctx->pwm);
+	ret = pwm_apply_state(ctx->pwm, &state);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to enable PWM\n");
+		dev_err(&pdev->dev, "Failed to configure PWM\n");
 		return ret;
 	}
 
@@ -266,8 +244,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
 		dev_err(&pdev->dev, "Failed to register hwmon device\n");
-		pwm_disable(ctx->pwm);
-		return PTR_ERR(hwmon);
+		ret = PTR_ERR(hwmon);
+		goto err_pwm_disable;
 	}
 
 	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
@@ -282,14 +260,20 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		if (IS_ERR(cdev)) {
 			dev_err(&pdev->dev,
 				"Failed to register pwm-fan as cooling device");
-			pwm_disable(ctx->pwm);
-			return PTR_ERR(cdev);
+			ret = PTR_ERR(cdev);
+			goto err_pwm_disable;
 		}
 		ctx->cdev = cdev;
 		thermal_cdev_update(cdev);
 	}
 
 	return 0;
+
+err_pwm_disable:
+	state.enabled = false;
+	pwm_apply_state(ctx->pwm, &state);
+
+	return ret;
 }
 
 static int pwm_fan_remove(struct platform_device *pdev)
-- 
1.9.1
