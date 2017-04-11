From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH v2 1/1] pwm: pca9685: fix gpio-only operation.
Date: Tue, 11 Apr 2017 15:19:05 -0400
Message-ID: <1491938345-16933-2-git-send-email-svenv@arcx.com>
References: <1491938345-16933-1-git-send-email-svenv@arcx.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36542 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752753AbdDKTTM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2017 15:19:12 -0400
In-Reply-To: <1491938345-16933-1-git-send-email-svenv@arcx.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>

gpio-only driver operation never clears the SLEEP bit, which can
cause the gpios to become unusable.

Example:
1. user requests first pwm  ->      driver clears SLEEP bit
2. user frees last pwm      ->      driver sets SLEEP bit
3. user requests gpio
4. user switches gpio on    ->      output does not turn on
                                    because SLEEP bit is set

Prevent this behaviour by letting the runtime_pm framework
control the SLEEP bit. This will put the chip to SLEEP if
no pwms/gpios are exported/in use.

Fixes: bccec89f0a35 ("Allow any of the 16 PWMs to be used as a GPIO")
Reported-by: Sven Van Asbroeck <TheSven73@googlemail.com>
Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pwm/pwm-pca9685.c | 111 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 0cfb357..465eb57 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -30,6 +30,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 /*
  * Because the PCA9685 has only one prescaler per chip, changing the period of
@@ -79,7 +80,6 @@
 struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
-	int active_cnt;
 	int duty_ns;
 	int period_ns;
 #if IS_ENABLED(CONFIG_GPIOLIB)
@@ -111,20 +111,10 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 	pwm_set_chip_data(pwm, (void *)1);
 
 	mutex_unlock(&pca->lock);
+	pm_runtime_get_sync(pca->chip.dev);
 	return 0;
 }
 
-static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
-{
-	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
-
-	mutex_lock(&pca->lock);
-	pwm = &pca->chip.pwms[offset];
-	pwm_set_chip_data(pwm, NULL);
-	mutex_unlock(&pca->lock);
-}
-
 static bool pca9685_pwm_is_gpio(struct pca9685 *pca, struct pwm_device *pwm)
 {
 	bool is_gpio = false;
@@ -177,6 +167,19 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), on);
 }
 
+static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
+{
+	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_device *pwm;
+
+	pca9685_pwm_gpio_set(gpio, offset, 0);
+	pm_runtime_put(pca->chip.dev);
+	mutex_lock(&pca->lock);
+	pwm = &pca->chip.pwms[offset];
+	pwm_set_chip_data(pwm, NULL);
+	mutex_unlock(&pca->lock);
+}
+
 static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
 					  unsigned int offset)
 {
@@ -238,6 +241,16 @@ static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 }
 #endif
 
+static void pca9685_set_sleep_mode(struct pca9685 *pca, int sleep)
+{
+	regmap_update_bits(pca->regmap, PCA9685_MODE1,
+			   MODE1_SLEEP, sleep ? MODE1_SLEEP : 0);
+	if (!sleep) {
+		/* Wait 500us for the oscillator to be back up */
+		udelay(500);
+	}
+}
+
 static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
 {
@@ -252,19 +265,19 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		if (prescale >= PCA9685_PRESCALE_MIN &&
 			prescale <= PCA9685_PRESCALE_MAX) {
+			/* putting the chip briefly into SLEEP mode
+			 * at this point won't interfere with the
+			 * pm_runtime framework, because the pm_runtime
+			 * state is guaranteed active here.
+			 */
 			/* Put chip into sleep mode */
-			regmap_update_bits(pca->regmap, PCA9685_MODE1,
-					   MODE1_SLEEP, MODE1_SLEEP);
+			pca9685_set_sleep_mode(pca, 1);
 
 			/* Change the chip-wide output frequency */
 			regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
 
 			/* Wake the chip up */
-			regmap_update_bits(pca->regmap, PCA9685_MODE1,
-					   MODE1_SLEEP, 0x0);
-
-			/* Wait 500us for the oscillator to be back up */
-			udelay(500);
+			pca9685_set_sleep_mode(pca, 0);
 
 			pca->period_ns = period_ns;
 		} else {
@@ -406,21 +419,15 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	if (pca9685_pwm_is_gpio(pca, pwm))
 		return -EBUSY;
-
-	if (pca->active_cnt++ == 0)
-		return regmap_update_bits(pca->regmap, PCA9685_MODE1,
-					  MODE1_SLEEP, 0x0);
+	pm_runtime_get_sync(chip->dev);
 
 	return 0;
 }
 
 static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct pca9685 *pca = to_pca(chip);
-
-	if (--pca->active_cnt == 0)
-		regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
-				   MODE1_SLEEP);
+	pca9685_pwm_disable(chip, pwm);
+	pm_runtime_put(chip->dev);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
@@ -492,21 +499,53 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 		return ret;
 
 	ret = pca9685_pwm_gpio_probe(pca);
-	if (ret < 0)
+	if (ret < 0) {
 		pwmchip_remove(&pca->chip);
+		return ret;
+	}
 
-	return ret;
+	/* the chip comes out of power-up in the active state */
+	pm_runtime_set_active(&client->dev);
+	/* enable will put the chip into suspend, which is what we
+	 * want as all outputs are disabled at this point
+	 */
+	pm_runtime_enable(&client->dev);
+
+	return 0;
 }
 
 static int pca9685_pwm_remove(struct i2c_client *client)
 {
 	struct pca9685 *pca = i2c_get_clientdata(client);
+	int ret;
+
+	ret = pwmchip_remove(&pca->chip);
+	if (ret)
+		return ret;
+	pm_runtime_suspend(&client->dev);
+	pm_runtime_disable(&client->dev);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int pca9685_pwm_runtime_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pca9685 *pca = i2c_get_clientdata(client);
 
-	regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
-			   MODE1_SLEEP);
+	pca9685_set_sleep_mode(pca, 1);
+	return 0;
+}
 
-	return pwmchip_remove(&pca->chip);
+static int pca9685_pwm_runtime_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pca9685 *pca = i2c_get_clientdata(client);
+
+	pca9685_set_sleep_mode(pca, 0);
+	return 0;
 }
+#endif
 
 static const struct i2c_device_id pca9685_id[] = {
 	{ "pca9685", 0 },
@@ -530,11 +569,17 @@ static int pca9685_pwm_remove(struct i2c_client *client)
 MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
 #endif
 
+static const struct dev_pm_ops pca9685_pwm_pm = {
+	SET_RUNTIME_PM_OPS(pca9685_pwm_runtime_suspend,
+			   pca9685_pwm_runtime_resume, NULL)
+};
+
 static struct i2c_driver pca9685_i2c_driver = {
 	.driver = {
 		.name = "pca9685-pwm",
 		.acpi_match_table = ACPI_PTR(pca9685_acpi_ids),
 		.of_match_table = of_match_ptr(pca9685_dt_ids),
+		.pm = &pca9685_pwm_pm,
 	},
 	.probe = pca9685_pwm_probe,
 	.remove = pca9685_pwm_remove,
-- 
1.9.1
