From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/4] pwm: pca9685: initialize all LED registers during probe
Date: Wed, 26 Feb 2020 14:52:28 +0100
Message-ID: <20200226135229.24929-3-matthias.schiffer@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
List-Id: linux-pwm@vger.kernel.org

Initialize all ON delays to 0 during probe, rather than doing it in
pca9685_pwm_enable.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 393ab92aa945..370691b21107 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -289,13 +289,6 @@ static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
-	/*
-	 * The PWM subsystem does not support a pre-delay.
-	 * So, set the ON-timeout to 0
-	 */
-	regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
-	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
-
 	/*
 	 * Clear the full-off bit.
 	 * It has precedence over the others and must be off.
@@ -388,6 +381,13 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
 
+	/*
+	 * The PWM subsystem does not support a pre-delay.
+	 * So, set the ON-timeout to 0
+	 */
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
+
 	pca->chip.ops = &pca9685_pwm_ops;
 	pca->chip.npwm = PCA9685_MAXCHAN;
 
-- 
2.17.1
