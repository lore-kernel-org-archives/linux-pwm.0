From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] backlight: add PWM dependencies
Date: Tue,  4 Feb 2014 13:57:14 +0100
Message-ID: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:57029 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbaBDM50 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 4 Feb 2014 07:57:26 -0500
Received: by mail-we0-f176.google.com with SMTP id q58so3987523wes.21
        for <linux-pwm@vger.kernel.org>; Tue, 04 Feb 2014 04:57:25 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

In some compilations the LM3630A and LP855X backlight drivers
fail like this:

drivers/built-in.o: In function `lm3630a_pwm_ctrl':
drivers/video/backlight/lm3630a_bl.c:168: undefined reference to `pwm_config'
drivers/video/backlight/lm3630a_bl.c:172: undefined reference to `pwm_disable'
drivers/video/backlight/lm3630a_bl.c:170: undefined reference to `pwm_enable'
drivers/built-in.o: In function `lp855x_pwm_ctrl':
drivers/video/backlight/lp855x_bl.c:249: undefined reference to `pwm_config'
drivers/video/backlight/lp855x_bl.c:253: undefined reference to `pwm_disable'
drivers/video/backlight/lp855x_bl.c:251: undefined reference to `pwm_enable'

This is because both drivers depend on the PWM framework, so
add this dependency to their Kconfig entries.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/backlight/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 5a3eb2ecb525..0604c3348761 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -371,6 +371,7 @@ config BACKLIGHT_AAT2870
 config BACKLIGHT_LM3630A
 	tristate "Backlight Driver for LM3630A"
 	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on PWM
 	select REGMAP_I2C
 	help
 	  This supports TI LM3630A Backlight Driver
@@ -387,6 +388,7 @@ config BACKLIGHT_LM3639
 config BACKLIGHT_LP855X
 	tristate "Backlight driver for TI LP855X"
 	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on PWM
 	help
 	  This supports TI LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
 	  LP8557 backlight driver.
-- 
1.8.5.3

