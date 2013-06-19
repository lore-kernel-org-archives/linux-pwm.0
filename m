Return-Path: <axel.lin@ingics.com>
Return-Path: <axel.lin@ingics.com>
Message-ID: <1371662009.5355.0.camel@phoenix>
Subject: [PATCH] pwm: pca9685: Add .owner to struct pwm_ops
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 20 Jun 2013 01:13:29 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-pwm@vger.kernel.org

Add missing .owner of struct pwm_ops. This prevents the module from being
removed from underneath its users.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/pwm-pca9685.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 2afc904..c9f9e65 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -199,6 +199,7 @@ static const struct pwm_ops pca9685_pwm_ops = {
 	.config = pca9685_pwm_config,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
+	.owner = THIS_MODULE,
 };
 
 static struct regmap_config pca9685_regmap_i2c_config = {
-- 
1.8.1.2
