From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 1/2] pwm: pca9685: fix period change with same duty cycle
Date: Tue, 13 Dec 2016 16:52:50 +0100
Message-ID: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: linux-pwm@vger.kernel.org

When first implementing support for changing the output frequency, an
optimization was added to continue the PWM after changing the prescaler
without having to reprogram the ON and OFF registers for the duty cycle,
in case the duty cycle stayed the same.
This was flawed, because we compared the absolute value of the duty
cycle in nanoseconds instead of the ratio to the period.

Fix the problem by removing the shortcut.

Fixes: 01ec8472009c9 ("pwm-pca9685: Support changing the output
frequency")
Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 117fccf..01a6a83 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -65,7 +65,6 @@
 #define PCA9685_MAXCHAN		0x10
 
 #define LED_FULL		(1 << 4)
-#define MODE1_RESTART		(1 << 7)
 #define MODE1_SLEEP		(1 << 4)
 #define MODE2_INVRT		(1 << 4)
 #define MODE2_OUTDRV		(1 << 2)
@@ -117,16 +116,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			udelay(500);
 
 			pca->period_ns = period_ns;
-
-			/*
-			 * If the duty cycle did not change, restart PWM with
-			 * the same duty cycle to period ratio and return.
-			 */
-			if (duty_ns == pca->duty_ns) {
-				regmap_update_bits(pca->regmap, PCA9685_MODE1,
-						   MODE1_RESTART, 0x1);
-				return 0;
-			}
 		} else {
 			dev_err(chip->dev,
 				"prescaler not set: period out of bounds!\n");
-- 
2.10.2
