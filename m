From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 6/6] hwmon: pwm-fan: Update the duty cycle inorder to control the pwm-fan
Date: Fri, 27 Mar 2015 03:09:15 +1030
Message-ID: <1427387955-5129-7-git-send-email-linux.amoon@gmail.com>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Below changes depend on following patch.
https://patchwork.kernel.org/patch/5944061/

Update the pwm_config with duty then update the pwm_disable
to poweroff the cpu fan.

Tested on OdroidXU3 board.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/hwmon/pwm-fan.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7c83dc4..f25c841 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -44,26 +44,24 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	int ret = 0;
 
 	mutex_lock(&ctx->lock);
+
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
-	if (pwm == 0) {
-		pwm_disable(ctx->pwm);
-		goto exit_set_pwm;
-	}
-
 	duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
 	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
 	if (ret)
 		goto exit_set_pwm_err;
 
+	if (pwm == 0)
+		pwm_disable(ctx->pwm);
+
 	if (ctx->pwm_value == 0) {
 		ret = pwm_enable(ctx->pwm);
 		if (ret)
 			goto exit_set_pwm_err;
 	}
 
-exit_set_pwm:
 	ctx->pwm_value = pwm;
 exit_set_pwm_err:
 	mutex_unlock(&ctx->lock);
-- 
1.9.1
