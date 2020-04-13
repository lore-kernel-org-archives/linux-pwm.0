From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] pwm: jz4740: Make PWM start with the active part
Date: Mon, 13 Apr 2020 14:14:44 +0200
Message-ID: <20200413121445.72996-2-paul@crapouillou.net>
References: <20200413121445.72996-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:52970 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgDMMPh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Apr 2020 08:15:37 -0400
In-Reply-To: <20200413121445.72996-1-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>

The PWM would previously always start with the inactive part.
To counter that, the common trick is to use an inverted duty as the
real duty (as in, 'period - duty'), and invert the polarity when the
PWM is enabled.

However, for some reason the driver was already configuring the hardware
for an inverted duty, so inverting it again means we do configure the
hardware with the actual duty value.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3cd5c054ad9a..f566f9d248d6 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -6,7 +6,6 @@
  * Limitations:
  * - The .apply callback doesn't complete the currently running period before
  *   reconfiguring the hardware.
- * - Each period starts with the inactive part.
  */
 
 #include <linux/clk.h>
@@ -163,7 +162,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Calculate duty value */
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
-	duty = period - tmp;
+	duty = (unsigned long)tmp;
 
 	if (duty >= period)
 		duty = period - 1;
@@ -190,17 +189,13 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
 	/* Set polarity */
-	switch (state->polarity) {
-	case PWM_POLARITY_NORMAL:
+	if ((state->polarity != PWM_POLARITY_INVERSED) ^ state->enabled)
 		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH, 0);
-		break;
-	case PWM_POLARITY_INVERSED:
+	else
 		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH,
 				   TCU_TCSR_PWM_INITL_HIGH);
-		break;
-	}
 
 	if (state->enabled)
 		jz4740_pwm_enable(chip, pwm);
-- 
2.25.1
