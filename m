From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 11/27] pwm: jz4740: Apply configuration atomically
Date: Thu, 28 Mar 2019 00:16:15 +0100
Message-ID: <20190327231631.15708-12-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

This is cleaner, more future-proof, and incidentally it also fixes the
PWM resetting its config when stopped/started several times.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pwm/pwm-jz4740.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index a7b134af5e04..b2f910413f81 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -83,17 +83,16 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	jz4740_timer_disable(pwm->hwpwm);
 }
 
-static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
+static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	unsigned long long tmp;
 	unsigned long period, duty;
 	unsigned int prescaler = 0;
 	uint16_t ctrl;
-	bool is_enabled;
 
-	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
+	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
 	do_div(tmp, 1000000000);
 	period = tmp;
 
@@ -105,16 +104,14 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (prescaler == 6)
 		return -EINVAL;
 
-	tmp = (unsigned long long)period * duty_ns;
-	do_div(tmp, period_ns);
+	tmp = (unsigned long long)period * state->duty_cycle;
+	do_div(tmp, state->period);
 	duty = period - tmp;
 
 	if (duty >= period)
 		duty = period - 1;
 
-	is_enabled = jz4740_timer_is_enabled(pwm->hwpwm);
-	if (is_enabled)
-		jz4740_pwm_disable(chip, pwm);
+	jz4740_pwm_disable(chip, pwm);
 
 	jz4740_timer_set_count(pwm->hwpwm, 0);
 	jz4740_timer_set_duty(pwm->hwpwm, duty);
@@ -125,18 +122,7 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
 
-	if (is_enabled)
-		jz4740_pwm_enable(chip, pwm);
-
-	return 0;
-}
-
-static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
-		struct pwm_device *pwm, enum pwm_polarity polarity)
-{
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
-
-	switch (polarity) {
+	switch (state->polarity) {
 	case PWM_POLARITY_NORMAL:
 		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
 		break;
@@ -146,16 +132,17 @@ static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
 	}
 
 	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+
+	if (state->enabled)
+		jz4740_pwm_enable(chip, pwm);
+
 	return 0;
 }
 
 static const struct pwm_ops jz4740_pwm_ops = {
 	.request = jz4740_pwm_request,
 	.free = jz4740_pwm_free,
-	.config = jz4740_pwm_config,
-	.set_polarity = jz4740_pwm_set_polarity,
-	.enable = jz4740_pwm_enable,
-	.disable = jz4740_pwm_disable,
+	.apply = jz4740_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.11.0
