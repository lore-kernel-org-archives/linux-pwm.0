From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] pwm: pca9685: Constify struct regmap_config
Date: Mon, 05 Jan 2015 10:03:44 +0100
Message-ID: <1420448624-9567-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39707 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbbAEJDw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jan 2015 04:03:52 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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

