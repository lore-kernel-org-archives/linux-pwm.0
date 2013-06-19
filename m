Return-Path: <axel.lin@ingics.com>
Return-Path: <axel.lin@ingics.com>
Message-ID: <1371662847.5355.2.camel@phoenix>
Subject: [PATCH] pwm: pca9685: Fix wrong argument to set MODE1_SLEEP bit
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 20 Jun 2013 01:27:27 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-pwm@vger.kernel.org

Current code actually does not set MODE1_SLEEP bit because the new value for
bitmask (0x1) is wrong. To set MODE1_SLEEP bit, we should pass MODE1_SLEEP
as the new value for bitmask.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Steffen,
I don't have this hardware, can you test if this patch works?
Thanks,
Axel

 drivers/pwm/pwm-pca9685.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index c9f9e65..3fb775d 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -190,7 +190,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	if (--pca->active_cnt == 0)
 		regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
-				   0x1);
+				   MODE1_SLEEP);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
@@ -264,7 +264,8 @@ static int pca9685_pwm_remove(struct i2c_client *client)
 {
 	struct pca9685 *pca = i2c_get_clientdata(client);
 
-	regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP, 0x1);
+	regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
+			   MODE1_SLEEP);
 
 	return pwmchip_remove(&pca->chip);
 }
-- 
1.8.1.2
