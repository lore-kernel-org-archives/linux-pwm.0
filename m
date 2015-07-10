From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] pwm: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 15:28:10 +0900
Message-ID: <1436509690-12144-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:61649 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbbGJG2N (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jul 2015 02:28:13 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/pwm/pwm-pca9685.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 34b5c275a92a..bd5f0276db04 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -285,7 +285,6 @@ MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
 static struct i2c_driver pca9685_i2c_driver = {
 	.driver = {
 		.name = "pca9685-pwm",
-		.owner = THIS_MODULE,
 		.of_match_table = pca9685_dt_ids,
 	},
 	.probe = pca9685_pwm_probe,
-- 
1.9.1
