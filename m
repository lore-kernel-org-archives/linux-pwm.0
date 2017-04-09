From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH 1/1] pwm: pca9685: fix gpio-only operation.
Date: Sun,  9 Apr 2017 12:11:24 -0400
Message-ID: <1491754284-3870-2-git-send-email-svenv@arcx.com>
References: <1491754284-3870-1-git-send-email-svenv@arcx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491754284-3870-1-git-send-email-svenv@arcx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

gpio-only driver operation never clears the SLEEP bit, which can
cause the gpios to become unusable.

Example:
1. user requests first pwm  ->      driver clears SLEEP bit
2. user frees last pwm      ->      driver sets SLEEP bit
3. user requests gpio
4. user switches gpio on    ->      output does not turn on
                                    because SLEEP bit is set

Prevent this behaviour by keeping the SLEEP bit cleared
for the lifetime of the driver instance.

Fixes: bccec89f0a35 ("Allow any of the 16 PWMs to be used as a GPIO")
Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/pwm/pwm-pca9685.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 0cfb357..4b6adaf 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -79,7 +79,6 @@
 struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
-	int active_cnt;
 	int duty_ns;
 	int period_ns;
 #if IS_ENABLED(CONFIG_GPIOLIB)
@@ -407,28 +406,14 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pca9685_pwm_is_gpio(pca, pwm))
 		return -EBUSY;
 
-	if (pca->active_cnt++ == 0)
-		return regmap_update_bits(pca->regmap, PCA9685_MODE1,
-					  MODE1_SLEEP, 0x0);
-
 	return 0;
 }
 
-static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pca9685 *pca = to_pca(chip);
-
-	if (--pca->active_cnt == 0)
-		regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
-				   MODE1_SLEEP);
-}
-
 static const struct pwm_ops pca9685_pwm_ops = {
 	.enable = pca9685_pwm_enable,
 	.disable = pca9685_pwm_disable,
 	.config = pca9685_pwm_config,
 	.request = pca9685_pwm_request,
-	.free = pca9685_pwm_free,
 	.owner = THIS_MODULE,
 };
 
@@ -479,6 +464,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	/* clear all "full off" bits */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
+	/* clear the "sleep" bit */
+	regmap_update_bits(pca->regmap, PCA9685_MODE1,
+					  MODE1_SLEEP, 0x0);
 
 	pca->chip.ops = &pca9685_pwm_ops;
 	/* add an extra channel for ALL_LED */
-- 
1.9.1
