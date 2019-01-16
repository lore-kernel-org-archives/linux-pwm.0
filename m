From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 2/4] drivers: pwm: pwm-bcm-kona: Switch to using atomic PWM Framework
Date: Thu, 17 Jan 2019 01:45:14 +0530
Message-ID: <1547669716-20070-3-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

Switch to using atomic PWM Framework on broadcom PWM kona driver

Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c | 201 +++++++++++++++++++--------------------------
 1 file changed, 83 insertions(+), 118 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 09a95ae..fe63289 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -108,151 +108,116 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 	ndelay(400);
 }
 
-static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
-{
-	struct kona_pwmc *kp = to_kona_pwmc(chip);
-	u64 val, div, rate;
-	unsigned long prescale = PRESCALE_MIN, pc, dc;
-	unsigned int value, chan = pwm->hwpwm;
-
-	/*
-	 * Find period count, duty count and prescale to suit duty_ns and
-	 * period_ns. This is done according to formulas described below:
-	 *
-	 * period_ns = 10^9 * (PRESCALE + 1) * PC / PWM_CLK_RATE
-	 * duty_ns = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
-	 *
-	 * PC = (PWM_CLK_RATE * period_ns) / (10^9 * (PRESCALE + 1))
-	 * DC = (PWM_CLK_RATE * duty_ns) / (10^9 * (PRESCALE + 1))
-	 */
-
-	rate = clk_get_rate(kp->clk);
-
-	while (1) {
-		div = 1000000000;
-		div *= 1 + prescale;
-		val = rate * period_ns;
-		pc = div64_u64(val, div);
-		val = rate * duty_ns;
-		dc = div64_u64(val, div);
-
-		/* If duty_ns or period_ns are not achievable then return */
-		if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
-			return -EINVAL;
-
-		/* If pc and dc are in bounds, the calculation is done */
-		if (pc <= PERIOD_COUNT_MAX && dc <= DUTY_CYCLE_HIGH_MAX)
-			break;
-
-		/* Otherwise, increase prescale and recalculate pc and dc */
-		if (++prescale > PRESCALE_MAX)
-			return -EINVAL;
-	}
-
-	/*
-	 * Don't apply settings if disabled. The period and duty cycle are
-	 * always calculated above to ensure the new values are
-	 * validated immediately instead of on enable.
-	 */
-	if (pwm_is_enabled(pwm)) {
-		kona_pwmc_prepare_for_settings(kp, chan);
-
-		value = readl(kp->base + PRESCALE_OFFSET);
-		value &= ~PRESCALE_MASK(chan);
-		value |= prescale << PRESCALE_SHIFT(chan);
-		writel(value, kp->base + PRESCALE_OFFSET);
-
-		writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
-
-		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
-
-		kona_pwmc_apply_settings(kp, chan);
-	}
-
-	return 0;
-}
-
-static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				  enum pwm_polarity polarity)
+static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	unsigned int chan = pwm->hwpwm;
 	unsigned int value;
-	int ret;
-
-	ret = clk_prepare_enable(kp->clk);
-	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
-		return ret;
-	}
 
 	kona_pwmc_prepare_for_settings(kp, chan);
 
-	value = readl(kp->base + PWM_CONTROL_OFFSET);
-
-	if (polarity == PWM_POLARITY_NORMAL)
-		value |= 1 << PWM_CONTROL_POLARITY_SHIFT(chan);
-	else
-		value &= ~(1 << PWM_CONTROL_POLARITY_SHIFT(chan));
+	/* Simulate a disable by configuring for zero duty */
+	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
+	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
 
-	writel(value, kp->base + PWM_CONTROL_OFFSET);
+	/* Set prescale to 0 for this channel */
+	value = readl(kp->base + PRESCALE_OFFSET);
+	value &= ~PRESCALE_MASK(chan);
+	writel(value, kp->base + PRESCALE_OFFSET);
 
 	kona_pwmc_apply_settings(kp, chan);
 
 	clk_disable_unprepare(kp->clk);
-
-	return 0;
 }
 
-static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int kona_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
 {
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
+	struct pwm_state cstate;
+	u64 val, div, rate;
+	unsigned long prescale = PRESCALE_MIN, pc, dc;
+	unsigned int value, chan = pwm->hwpwm;
 	int ret;
 
-	ret = clk_prepare_enable(kp->clk);
-	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
-		return ret;
-	}
-
-	ret = kona_pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
-			       pwm_get_period(pwm));
-	if (ret < 0) {
-		clk_disable_unprepare(kp->clk);
-		return ret;
-	}
+	pwm_get_state(pwm, &cstate);
+
+	if (state->enabled) {
+		/*
+		 * Find period count, duty count and prescale to suit duty_ns
+		 * and period_ns. This is done according to formulas described
+		 * below:
+		 *
+		 * period_ns = 10^9 * (PRESCALE + 1) * PC / PWM_CLK_RATE
+		 * duty_ns = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
+		 *
+		 * PC = (PWM_CLK_RATE * period_ns) / (10^9 * (PRESCALE + 1))
+		 * DC = (PWM_CLK_RATE * duty_ns) / (10^9 * (PRESCALE + 1))
+		 */
+		rate = clk_get_rate(kp->clk);
+
+		while (1) {
+			div = 1000000000;
+			div *= 1 + prescale;
+			val = rate * state->period;
+			pc = div64_u64(val, div);
+			val = rate * state->duty_cycle;
+			dc = div64_u64(val, div);
+
+			/* If duty_ns or period_ns are not achievable then
+			 * return
+			 */
+			if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
+				return -EINVAL;
+
+			/* If pc & dc are in bounds, the calculation is done */
+			if (pc <= PERIOD_COUNT_MAX && dc <= DUTY_CYCLE_HIGH_MAX)
+				break;
+
+			/* Otherwise, increase prescale & recalculate pc & dc */
+			if (++prescale > PRESCALE_MAX)
+				return -EINVAL;
+		}
+
+		if (!cstate.enabled) {
+			ret = clk_prepare_enable(kp->clk);
+			if (ret < 0) {
+				dev_err(chip->dev,
+					"failed to enable clock: %d\n", ret);
+				return ret;
+			}
+		}
 
-	return 0;
-}
-
-static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct kona_pwmc *kp = to_kona_pwmc(chip);
-	unsigned int chan = pwm->hwpwm;
-	unsigned int value;
+		kona_pwmc_prepare_for_settings(kp, chan);
 
-	kona_pwmc_prepare_for_settings(kp, chan);
+		value = readl(kp->base + PRESCALE_OFFSET);
+		value &= ~PRESCALE_MASK(chan);
+		value |= prescale << PRESCALE_SHIFT(chan);
+		writel(value, kp->base + PRESCALE_OFFSET);
+		writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
+		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
 
-	/* Simulate a disable by configuring for zero duty */
-	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
-	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
+		if (cstate.polarity != state->polarity) {
+			value = readl(kp->base + PWM_CONTROL_OFFSET);
+			if (state->polarity == PWM_POLARITY_NORMAL)
+				value |= 1 << PWM_CONTROL_POLARITY_SHIFT(chan);
+			else
+				value &= ~(1 <<
+					   PWM_CONTROL_POLARITY_SHIFT(chan));
 
-	/* Set prescale to 0 for this channel */
-	value = readl(kp->base + PRESCALE_OFFSET);
-	value &= ~PRESCALE_MASK(chan);
-	writel(value, kp->base + PRESCALE_OFFSET);
+			writel(value, kp->base + PWM_CONTROL_OFFSET);
+		}
 
-	kona_pwmc_apply_settings(kp, chan);
+		kona_pwmc_apply_settings(kp, chan);
+	} else if (cstate.enabled) {
+		kona_pwmc_disable(chip, pwm);
+	}
 
-	clk_disable_unprepare(kp->clk);
+	return 0;
 }
 
 static const struct pwm_ops kona_pwm_ops = {
-	.config = kona_pwmc_config,
-	.set_polarity = kona_pwmc_set_polarity,
-	.enable = kona_pwmc_enable,
-	.disable = kona_pwmc_disable,
+	.apply = kona_pwmc_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
1.9.1
