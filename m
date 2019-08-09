From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/7] pwm: jz4740: Make PWM start with the active part
Date: Fri,  9 Aug 2019 14:30:30 +0200
Message-ID: <20190809123031.24219-7-paul@crapouillou.net>
References: <20190809123031.24219-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809123031.24219-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The PWM will always start with the inactive part. To counter that,
when PWM is enabled we switch the configured polarity, and use
'period - duty + 1' as the real duty.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 85e2110aae4f..8df898429d47 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -121,6 +121,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		   *parent_clk = clk_get_parent(clk);
 	unsigned long rate, parent_rate, period, duty;
 	unsigned long long tmp;
+	bool polarity_inversed;
 	int ret;
 
 	parent_rate = clk_get_rate(parent_clk);
@@ -183,24 +184,27 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
-	/* Set duty */
-	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
-
 	/* Set period */
 	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
 
+	/*
+	 * The PWM will always start with the inactive part. To counter that,
+	 * when PWM is enabled we switch the configured polarity, and use
+	 * 'period - duty + 1' as the real duty.
+	 */
+
+	/* Set duty */
+	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), period - duty + 1);
+
 	/* Set polarity */
-	switch (state->polarity) {
-	case PWM_POLARITY_NORMAL:
+	polarity_inversed = state->polarity == PWM_POLARITY_INVERSED;
+	if (!polarity_inversed ^ state->enabled)
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
2.21.0.593.g511ec345e18
