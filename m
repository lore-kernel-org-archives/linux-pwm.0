From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v4 2/2] pwm-pca9685: Support changing the output frequency
Date: Thu, 23 Jul 2015 17:19:02 +0200
Message-ID: <1437664742-23121-3-git-send-email-clemens.gruber@pqgruber.com>
References: <1437664742-23121-1-git-send-email-clemens.gruber@pqgruber.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:42834 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbbGWPUg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2015 11:20:36 -0400
In-Reply-To: <1437664742-23121-1-git-send-email-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>, Thierry Reding <thierry.reding@gmail.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>

Previously, period_ns and duty_ns were only used to determine the
ratio of ON and OFF time, the default frequency of 200 Hz was never
changed.
The PCA9685 however is capable of changing the PWM output frequency,
which is expected when changing the period.

This patch configures the prescaler accordingly, using the formula
and notes provided in the PCA9685 datasheet.
Bounds checking for the minimum and maximum frequencies, last updated
in revision v.4 of said datasheet, is also added.

The prescaler is only touched if the period changed, because we have to
put the chip into sleep mode to unlock the prescale register.
If it is changed, the PWM output frequency changes for all outputs,
because there is one prescaler per chip. This is documented in the
PCA9685 datasheet and in the comments.

If the duty cycle is not changed at the same time as the period, then
we restart the PWM output using the duty cycle to period ratio from
before the period change.
When using LEDs for example, previously set brightness levels stay the
same when the frequency changes.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index f4a9c4a..895fa16 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -2,6 +2,7 @@
  * Driver for PCA9685 16-channel 12-bit PWM LED controller
  *
  * Copyright (C) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ * Copyright (C) 2015 Clemens Gruber <clemens.gruber@pqgruber.com>
  *
  * based on the pwm-twl-led.c driver
  *
@@ -24,6 +25,15 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
+
+/*
+ * Because the PCA9685 has only one prescaler per chip, changing the period of
+ * one channel affects the period of all 16 PWM outputs!
+ * However, the ratio between each configured duty cycle and the chip-wide
+ * period remains constant, because the OFF time is set in proportion to the
+ * counter range.
+ */
 
 #define PCA9685_MODE1		0x00
 #define PCA9685_MODE2		0x01
@@ -42,10 +52,18 @@
 #define PCA9685_ALL_LED_OFF_H	0xFD
 #define PCA9685_PRESCALE	0xFE
 
+#define PCA9685_PRESCALE_MIN	0x03	/* => max. frequency of 1526 Hz */
+#define PCA9685_PRESCALE_MAX	0xFF	/* => min. frequency of 24 Hz */
+
+#define PCA9685_COUNTER_RANGE	4096
+#define PCA9685_DEFAULT_PERIOD	5000000	/* Default period_ns = 1/200 Hz */
+#define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 MHz */
+
 #define PCA9685_NUMREGS		0xFF
 #define PCA9685_MAXCHAN		0x10
 
 #define LED_FULL		(1 << 4)
+#define MODE1_RESTART		(1 << 7)
 #define MODE1_SLEEP		(1 << 4)
 #define MODE2_INVRT		(1 << 4)
 #define MODE2_OUTDRV		(1 << 2)
@@ -59,6 +77,8 @@ struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
 	int active_cnt;
+	int duty_ns;
+	int period_ns;
 };
 
 static inline struct pca9685 *to_pca(struct pwm_chip *chip)
@@ -72,6 +92,47 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
 	unsigned int reg;
+	int prescale;
+
+	if (period_ns != pca->period_ns) {
+		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
+					     PCA9685_COUNTER_RANGE * 1000) - 1;
+
+		if (prescale >= PCA9685_PRESCALE_MIN &&
+			prescale <= PCA9685_PRESCALE_MAX) {
+			/* Put chip into sleep mode */
+			regmap_update_bits(pca->regmap, PCA9685_MODE1,
+					   MODE1_SLEEP, MODE1_SLEEP);
+
+			/* Change the chip-wide output frequency */
+			regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
+
+			/* Wake the chip up */
+			regmap_update_bits(pca->regmap, PCA9685_MODE1,
+					   MODE1_SLEEP, 0x0);
+
+			/* Wait 500us for the oscillator to be back up */
+			udelay(500);
+
+			pca->period_ns = period_ns;
+
+			/*
+			 * If the duty cycle did not change, restart PWM with
+			 * the same duty cycle to period ratio and return.
+			 */
+			if (duty_ns == pca->duty_ns) {
+				regmap_update_bits(pca->regmap, PCA9685_MODE1,
+						   MODE1_RESTART, 0x1);
+				return 0;
+			}
+		} else {
+			dev_err(chip->dev,
+				"prescaler not set: period out of bounds!\n");
+			return -EINVAL;
+		}
+	}
+
+	pca->duty_ns = duty_ns;
 
 	if (duty_ns < 1) {
 		if (pwm->hwpwm >= PCA9685_MAXCHAN)
@@ -111,7 +172,7 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	duty = 4096 * (unsigned long long)duty_ns;
+	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
 	duty = DIV_ROUND_UP_ULL(duty, period_ns);
 
 	if (pwm->hwpwm >= PCA9685_MAXCHAN)
@@ -252,6 +313,8 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 			ret);
 		return ret;
 	}
+	pca->duty_ns = 0;
+	pca->period_ns = PCA9685_DEFAULT_PERIOD;
 
 	i2c_set_clientdata(client, pca);
 
-- 
2.4.6
