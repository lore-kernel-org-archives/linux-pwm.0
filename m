From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date: Wed, 26 Feb 2020 14:52:27 +0100
Message-ID: <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
List-Id: linux-pwm@vger.kernel.org

The interaction of the ALL_LED PWM channel with the other channels was
not well-defined. As the ALL_LED feature does not seem very useful and
it was making the code significantly more complex, simply remove it.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
 1 file changed, 17 insertions(+), 98 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 19ac97108a64..393ab92aa945 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -105,27 +105,12 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 
 static bool pca9685_pwm_is_gpio(struct pca9685 *pca, struct pwm_device *pwm)
 {
-	bool is_gpio = false;
+	bool is_gpio;
 
 	mutex_lock(&pca->lock);
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
-		unsigned int i;
-
-		/*
-		 * Check if any of the GPIOs are requested and in that case
-		 * prevent using the "all LEDs" channel.
-		 */
-		for (i = 0; i < pca->gpio.ngpio; i++)
-			if (gpiochip_is_requested(&pca->gpio, i)) {
-				is_gpio = true;
-				break;
-			}
-	} else if (pwm_get_chip_data(pwm)) {
-		is_gpio = true;
-	}
-
+	is_gpio = !!pwm_get_chip_data(pwm);
 	mutex_unlock(&pca->lock);
+
 	return is_gpio;
 }
 
@@ -239,7 +224,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
-	unsigned int reg;
 	int prescale;
 
 	if (period_ns != pca->period_ns) {
@@ -272,39 +256,18 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (duty_ns < 1) {
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_H;
-		else
-			reg = LED_N_OFF_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, LED_FULL);
+		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
 
 		return 0;
 	}
 
 	if (duty_ns == period_ns) {
 		/* Clear both OFF registers */
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_L;
-		else
-			reg = LED_N_OFF_L(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, 0x0);
-
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_H;
-		else
-			reg = LED_N_OFF_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, 0x0);
+		regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
+		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0x0);
 
 		/* Set the full ON bit */
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_ON_H;
-		else
-			reg = LED_N_ON_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, LED_FULL);
+		regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), LED_FULL);
 
 		return 0;
 	}
@@ -312,27 +275,12 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
 	duty = DIV_ROUND_UP_ULL(duty, period_ns);
 
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_L;
-	else
-		reg = LED_N_OFF_L(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, (int)duty & 0xff);
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_H;
-	else
-		reg = LED_N_OFF_H(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
+	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), (int)duty & 0xff);
+	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm),
+		     ((int)duty >> 8) & 0xf);
 
 	/* Clear the full ON bit, otherwise the set OFF time has no effect */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_ON_H;
-	else
-		reg = LED_N_ON_H(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0);
+	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
 
 	return 0;
 }
@@ -340,36 +288,19 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
-	unsigned int reg;
 
 	/*
 	 * The PWM subsystem does not support a pre-delay.
 	 * So, set the ON-timeout to 0
 	 */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_ON_L;
-	else
-		reg = LED_N_ON_L(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0);
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_ON_H;
-	else
-		reg = LED_N_ON_H(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0);
+	regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
+	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
 
 	/*
 	 * Clear the full-off bit.
 	 * It has precedence over the others and must be off.
 	 */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_H;
-	else
-		reg = LED_N_OFF_H(pwm->hwpwm);
-
-	regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
+	regmap_update_bits(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL, 0x0);
 
 	return 0;
 }
@@ -377,22 +308,11 @@ static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
-	unsigned int reg;
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_H;
-	else
-		reg = LED_N_OFF_H(pwm->hwpwm);
 
-	regmap_write(pca->regmap, reg, LED_FULL);
+	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
 
 	/* Clear the LED_OFF counter. */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_L;
-	else
-		reg = LED_N_OFF_L(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0x0);
+	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
 }
 
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -469,8 +389,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
 
 	pca->chip.ops = &pca9685_pwm_ops;
-	/* add an extra channel for ALL_LED */
-	pca->chip.npwm = PCA9685_MAXCHAN + 1;
+	pca->chip.npwm = PCA9685_MAXCHAN;
 
 	pca->chip.dev = &client->dev;
 	pca->chip.base = -1;
-- 
2.17.1
