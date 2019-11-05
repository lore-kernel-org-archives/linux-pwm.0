From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock directly
Date: Tue,  5 Nov 2019 14:14:53 +0100
Message-ID: <20191105131456.32400-5-peron.clem@gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105131456.32400-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

PWM core has an option to bypass whole logic and output unchanged source
clock as PWM output. This is achieved by enabling bypass bit.

Note that when bypass is enabled, no other setting has any meaning, not
even enable bit.

This mode of operation is needed to achieve high enough frequency to
serve as clock source for AC200 chip which is integrated into same
package as H6 SoC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 54e19fa56a4e..810abf47c261 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -3,6 +3,10 @@
  * Driver for Allwinner sun4i Pulse Width Modulation Controller
  *
  * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ *
+ * Limitations:
+ * - When outputing the source clock directly, the PWM logic will be bypassed
+ *   and the currently running period is not guaranteed to be completed
  */
 
 #include <linux/bitops.h>
@@ -73,6 +77,7 @@ static const u32 prescaler_table[] = {
 
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
+	bool has_direct_mod_clk_output;
 	unsigned int npwm;
 };
 
@@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
+	/*
+	 * PWM chapter in H6 manual has a diagram which explains that if bypass
+	 * bit is set, no other setting has any meaning. Even more, experiment
+	 * proved that also enable bit is ignored in this case.
+	 */
+	if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
+	    sun4i_pwm->data->has_direct_mod_clk_output) {
+		state->period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate);
+		state->duty_cycle = state->period / 2;
+		state->polarity = PWM_POLARITY_NORMAL;
+		state->enabled = true;
+		return;
+	}
+
 	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
 	    sun4i_pwm->data->has_prescaler_bypass)
 		prescaler = 1;
@@ -203,7 +222,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
-	u32 ctrl;
+	u32 ctrl, clk_rate;
+	bool bypass;
 	int ret;
 	unsigned int delay_us;
 	unsigned long now;
@@ -218,6 +238,15 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
+	/*
+	 * Although it would make much more sense to check for bypass in
+	 * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled".
+	 */
+	clk_rate = clk_get_rate(sun4i_pwm->clk);
+	bypass = state->enabled &&
+		 (state->period * clk_rate >= NSEC_PER_SEC) &&
+		 (state->duty_cycle * 2 == state->period);
+
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
@@ -265,6 +294,13 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	}
 
+	if (sun4i_pwm->data->has_direct_mod_clk_output) {
+		if (bypass)
+			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
+		else
+			ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
+	}
+
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
 	spin_unlock(&sun4i_pwm->ctrl_lock);
-- 
2.20.1
