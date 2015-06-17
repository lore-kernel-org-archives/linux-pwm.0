From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 2/2] pwm-pca9685: Support changing the output frequency
Date: Thu, 18 Jun 2015 01:15:47 +0200
Message-ID: <1434582947-11211-3-git-send-email-clemens.gruber@pqgruber.com>
References: <1434582947-11211-1-git-send-email-clemens.gruber@pqgruber.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:33426 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbbFQXXF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Jun 2015 19:23:05 -0400
In-Reply-To: <1434582947-11211-1-git-send-email-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, Clemens Gruber <clemens.gruber@pqgruber.com>

Previously, period_ns and duty_ns were only used to determine the
ratio of ON and OFF time, the default frequency of 200 Hz was never
changed.
The PCA9685 however is capable of changing the PWM output frequency.

This patch configures the prescaler accordingly, using the formula
and notes provided in the PCA9685 datasheet.
Bounds checking for the minimum and maximum frequencies, last updated
in revision v.4 of said datasheet, is also added.

The prescaler is only touched if the period changed, because we have to
put the chip into sleep mode to unlock the prescale register.
If it is changed, the PWM output frequency changes for all outputs,
because there is one prescaler per chip. This is documented in the
PCA9685 datasheet and in the comments.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index f4a9c4a..1bcce14 100644
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
@@ -24,6 +25,7 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #define PCA9685_MODE1		0x00
 #define PCA9685_MODE2		0x01
@@ -42,6 +44,13 @@
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
 
@@ -59,6 +68,7 @@ struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
 	int active_cnt;
+	int period_ns;
 };
 
 static inline struct pca9685 *to_pca(struct pwm_chip *chip)
@@ -72,6 +82,37 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
 	unsigned int reg;
+	int prescale;
+
+	if (period_ns != pca->period_ns) {
+		/* Set SLEEP bit to allow writing to the prescale register */
+		regmap_update_bits(pca->regmap, PCA9685_MODE1,
+					MODE1_SLEEP, MODE1_SLEEP);
+
+		/*
+		 * Set prescale register according to the configured period,
+		 * which in turn changes the frequency of all 16 PWM outputs.
+		 */
+		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
+					     PCA9685_COUNTER_RANGE * 1000) - 1;
+		if (prescale >= PCA9685_PRESCALE_MIN &&
+			prescale <= PCA9685_PRESCALE_MAX)
+			regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
+		else {
+			dev_err(chip->dev,
+				"prescaler not set: period out of bounds\n");
+			return -EINVAL;
+		}
+
+		/* Clear SLEEP bit */
+		regmap_update_bits(pca->regmap, PCA9685_MODE1,
+					  MODE1_SLEEP, 0x0);
+
+		/* Wait 500us for the oscillator to be back up */
+		udelay(500);
+
+		pca->period_ns = period_ns;
+	}
 
 	if (duty_ns < 1) {
 		if (pwm->hwpwm >= PCA9685_MAXCHAN)
@@ -111,7 +152,7 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	duty = 4096 * (unsigned long long)duty_ns;
+	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
 	duty = DIV_ROUND_UP_ULL(duty, period_ns);
 
 	if (pwm->hwpwm >= PCA9685_MAXCHAN)
@@ -252,6 +293,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 			ret);
 		return ret;
 	}
+	pca->period_ns = PCA9685_DEFAULT_PERIOD;
 
 	i2c_set_clientdata(client, pca);
 
-- 
2.4.3
