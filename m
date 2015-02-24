From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] pwm: pca9685: Constify struct regmap_config
Date: Tue, 24 Feb 2015 10:40:24 +0100
Message-ID: <1424770824-7281-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pwm@vger.kernel.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/pwm/pwm-pca9685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 3fb775ded0df..34b5c275a92a 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -202,7 +202,7 @@ static const struct pwm_ops pca9685_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
-static struct regmap_config pca9685_regmap_i2c_config = {
+static const struct regmap_config pca9685_regmap_i2c_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = PCA9685_NUMREGS,
-- 
1.9.1
