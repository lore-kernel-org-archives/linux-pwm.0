From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/2] pwm: iqs620a: Use 64-bit division
Date: Mon, 15 Jun 2020 16:16:06 +0200
Message-ID: <20200615141606.2814208-3-thierry.reding@gmail.com>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbgFOOQR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2020 10:16:17 -0400
In-Reply-To: <20200615141606.2814208-1-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The PWM framework is going to change the PWM period and duty cycles to
be 64-bit unsigned integers. To avoid build errors on platforms that do
not natively support 64-bit division, use explicity 64-bit division.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-iqs620a.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 674f0e238ba0..b2bb27eff623 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -46,7 +46,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct iqs620_pwm_private *iqs620_pwm;
 	struct iqs62x_core *iqs62x;
-	int duty_scale, ret;
+	u64 duty_scale;
+	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -ENOTSUPP;
@@ -69,7 +70,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
 	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
 	 */
-	duty_scale = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
+	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
 
 	mutex_lock(&iqs620_pwm->lock);
 
@@ -81,7 +82,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (duty_scale) {
-		u8 duty_val = min(duty_scale - 1, 0xFF);
+		u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
 
 		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
 				   duty_val);
-- 
2.24.1
