From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v2 1/2] pwm-pca9685: Fix several driver bugs
Date: Mon, 20 Jul 2015 10:23:50 +0200
Message-ID: <1437380631-7149-2-git-send-email-clemens.gruber@pqgruber.com>
References: <1437380631-7149-1-git-send-email-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437380631-7149-1-git-send-email-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

Problems:
- When duty_ns == period_ns, the full OFF bit was not cleared and the
  PWM output of the PCA9685 stayed off.
- When duty_ns == period_ns and the catch-all channel was used, the
  ALL_LED_OFF_L register was not cleared.
- The full ON bit was not cleared when setting the OFF time, therefore
  the exact OFF time was ignored when setting a duty_ns < period_ns

Solution: Clear both OFF registers when setting full ON and clear the
full ON bit when changing the OFF registers.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 34b5c27..f4a9c4a 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -85,6 +85,22 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (duty_ns == period_ns) {
+		/* Clear both OFF registers */
+		if (pwm->hwpwm >= PCA9685_MAXCHAN)
+			reg = PCA9685_ALL_LED_OFF_L;
+		else
+			reg = LED_N_OFF_L(pwm->hwpwm);
+
+		regmap_write(pca->regmap, reg, 0x0);
+
+		if (pwm->hwpwm >= PCA9685_MAXCHAN)
+			reg = PCA9685_ALL_LED_OFF_H;
+		else
+			reg = LED_N_OFF_H(pwm->hwpwm);
+
+		regmap_write(pca->regmap, reg, 0x0);
+
+		/* Set the full ON bit */
 		if (pwm->hwpwm >= PCA9685_MAXCHAN)
 			reg = PCA9685_ALL_LED_ON_H;
 		else
@@ -112,6 +128,14 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
 
+	/* Clear the full ON bit, otherwise the set OFF time has no effect */
+	if (pwm->hwpwm >= PCA9685_MAXCHAN)
+		reg = PCA9685_ALL_LED_ON_H;
+	else
+		reg = LED_N_ON_H(pwm->hwpwm);
+
+	regmap_write(pca->regmap, reg, 0);
+
 	return 0;
 }
 
-- 
2.4.6
