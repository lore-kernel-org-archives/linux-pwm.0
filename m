From: Steven Jackson <sj@oscode.net>
Subject: [PATCH] backlight: pwm_bl: use gpiod_set_value_cansleep to fix
 warnings
Date: Sat, 14 May 2016 10:59:12 +0100
Message-ID: <5736F6F0.4020800@oscode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33919 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbcENJ7Q (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 14 May 2016 05:59:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so8167700wmn.1
        for <linux-pwm@vger.kernel.org>; Sat, 14 May 2016 02:59:15 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, jingoohan1@gmail.com

This is the same issue and fix as 1581b088fc91cbb974ad2b98431a8ecabb48
(backlight: corgi_lcd: use gpio_set_value_cansleep() to avoid WARN_ON).

PWM backlights which use a SPI/I2C IO expander to control power will see
warnings when disabling and enabling the backlight, we should use
_cansleep variants of gpio set/get whenever the context can sleep.

Other backlight drivers such as corgi_bl.c and gpio_backlight.c are
using _cansleep variants in the same contexts.

Signed-off-by: Steven Jackson <sj@oscode.net>
---
  drivers/video/backlight/pwm_bl.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c 
b/drivers/video/backlight/pwm_bl.c
index 64f9e1b..1df5420 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -55,7 +55,7 @@ static void pwm_backlight_power_on(struct pwm_bl_data 
*pb, int brightness)
  		dev_err(pb->dev, "failed to enable power supply\n");

  	if (pb->enable_gpio)
-		gpiod_set_value(pb->enable_gpio, 1);
+		gpiod_set_value_clansleep(pb->enable_gpio, 1);

  	pwm_enable(pb->pwm);
  	pb->enabled = true;
@@ -70,7 +70,7 @@ static void pwm_backlight_power_off(struct pwm_bl_data 
*pb)
  	pwm_disable(pb->pwm);

  	if (pb->enable_gpio)
-		gpiod_set_value(pb->enable_gpio, 0);
+		gpiod_set_value_cansleep(pb->enable_gpio, 0);

  	regulator_disable(pb->power_supply);
  	pb->enabled = false;
-- 
2.7.4
