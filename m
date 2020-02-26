From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/4] pwm: pca9685: migrate config/enable/disable to apply
Date: Wed, 26 Feb 2020 14:52:29 +0100
Message-ID: <20200226135229.24929-4-matthias.schiffer@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
List-Id: linux-pwm@vger.kernel.org

For consistency with disabled state, initialize all LEDs in FULL_OFF
state during probe.

This also fixes a broken interaction between config with 100% duty cycle
(which would set the LED to FULL_ON) and enable (which would unset
FULL_ON), effectively disabling the LED again when enable was called
after config. This behaviour was observed with the leds-pwm driver when
directly switching from 0 to maximum brightness.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 53 +++++++++++----------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 370691b21107..e266cbbd39bf 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -219,15 +219,16 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 	}
 }
 
-static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			      int duty_ns, int period_ns)
+static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
 	int prescale;
 
-	if (period_ns != pca->period_ns) {
-		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
+	if (state->period != pca->period_ns) {
+		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ *
+					     state->period,
 					     PCA9685_COUNTER_RANGE * 1000) - 1;
 
 		if (prescale >= PCA9685_PRESCALE_MIN &&
@@ -247,7 +248,7 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			/* Wake the chip up */
 			pca9685_set_sleep_mode(pca, false);
 
-			pca->period_ns = period_ns;
+			pca->period_ns = state->period;
 		} else {
 			dev_err(chip->dev,
 				"prescaler not set: period out of bounds!\n");
@@ -255,13 +256,13 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	if (duty_ns < 1) {
+	if (!state->enabled || state->duty_cycle < 1) {
+		/* Set the full OFF bit */
 		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
-
 		return 0;
 	}
 
-	if (duty_ns == period_ns) {
+	if (state->duty_cycle == state->period) {
 		/* Clear both OFF registers */
 		regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
 		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0x0);
@@ -272,8 +273,8 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
-	duty = DIV_ROUND_UP_ULL(duty, period_ns);
+	duty = PCA9685_COUNTER_RANGE * (unsigned long long)state->duty_cycle;
+	duty = DIV_ROUND_UP_ULL(duty, state->period);
 
 	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), (int)duty & 0xff);
 	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm),
@@ -285,29 +286,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pca9685 *pca = to_pca(chip);
-
-	/*
-	 * Clear the full-off bit.
-	 * It has precedence over the others and must be off.
-	 */
-	regmap_update_bits(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL, 0x0);
-
-	return 0;
-}
-
-static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pca9685 *pca = to_pca(chip);
-
-	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
-
-	/* Clear the LED_OFF counter. */
-	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
-}
-
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
@@ -321,14 +299,11 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pca9685_pwm_disable(chip, pwm);
 	pm_runtime_put(chip->dev);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
-	.enable = pca9685_pwm_enable,
-	.disable = pca9685_pwm_disable,
-	.config = pca9685_pwm_config,
+	.apply = pca9685_pwm_apply,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
 	.owner = THIS_MODULE,
@@ -377,9 +352,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	regmap_write(pca->regmap, PCA9685_MODE2, mode2);
 
-	/* clear all "full off" bits */
+	/* Set all LEDs full off */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
-	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
 
 	/*
 	 * The PWM subsystem does not support a pre-delay.
-- 
2.17.1
