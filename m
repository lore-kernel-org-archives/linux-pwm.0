From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Date: Wed, 26 Feb 2020 14:52:26 +0100
Message-ID: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
List-Id: linux-pwm@vger.kernel.org

duty_cycle was only set, never read.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index b07bdca3d510..19ac97108a64 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -69,7 +69,6 @@
 struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
-	int duty_ns;
 	int period_ns;
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
@@ -272,8 +271,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	pca->duty_ns = duty_ns;
-
 	if (duty_ns < 1) {
 		if (pwm->hwpwm >= PCA9685_MAXCHAN)
 			reg = PCA9685_ALL_LED_OFF_H;
@@ -449,7 +446,6 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 			ret);
 		return ret;
 	}
-	pca->duty_ns = 0;
 	pca->period_ns = PCA9685_DEFAULT_PERIOD;
 
 	i2c_set_clientdata(client, pca);
-- 
2.17.1
