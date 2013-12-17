From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] pwm: pca9685: depends on I2C rather than REGMAP_I2C
Date: Tue, 17 Dec 2013 11:51:29 +0800
Message-ID: <1387252289.4816.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43393 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab3LQDve (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2013 22:51:34 -0500
Received: by mail-pa0-f52.google.com with SMTP id ld10so3904871pab.11
        for <linux-pwm@vger.kernel.org>; Mon, 16 Dec 2013 19:51:33 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-pwm@vger.kernel.org

REGMAP_I2C is not a visible config option.
Thus make PWM_PCA9685 depend on I2c and then select REGMAP_I2C.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 77aef3b..7139e1d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -122,7 +122,8 @@ config PWM_MXS
 
 config PWM_PCA9685
 	tristate "NXP PCA9685 PWM driver"
-	depends on OF && REGMAP_I2C
+	depends on OF && I2C
+	select REGMAP_I2C
 	help
 	  Generic PWM framework driver for NXP PCA9685 LED controller.
 
-- 
1.8.1.2



