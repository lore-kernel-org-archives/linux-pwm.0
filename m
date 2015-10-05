From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] unicore32: nb0916: Use PWM lookup table
Date: Mon,  5 Oct 2015 08:08:43 +0200
Message-ID: <1444025323-23904-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34203 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbJEGIq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 02:08:46 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

Use a PWM lookup table to provide the PWM to the pwm-backlight device.
The driver has a legacy code path that is required only because boards
still use the legacy method of requesting PWMs by global ID. Replacing
these usages allows that legacy fallback to be removed.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/unicore32/kernel/puv3-nb0916.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 46ebfdccbc31..af3962d90def 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -19,6 +19,7 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
@@ -49,8 +50,12 @@ static struct resource puv3_i2c_resources[] = {
 	}
 };
 
+static struct pwm_lookup nb0916_pwm_lookup[] = {
+	PWM_LOOKUP("PKUnity-v3-PWM", 0, "pwm-backlight", NULL, 0,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data nb0916_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
 	.pwm_period_ns	= 70 * 1024,
@@ -112,6 +117,8 @@ int __init mach_nb0916_init(void)
 	platform_device_register_simple("PKUnity-v3-I2C", -1,
 			puv3_i2c_resources, ARRAY_SIZE(puv3_i2c_resources));
 
+	pwm_add_table(nb0916_pwm_lookup, ARRAY_SIZE(nb0916_pwm_lookup));
+
 	platform_device_register_data(NULL, "pwm-backlight", -1,
 			&nb0916_backlight_data, sizeof(nb0916_backlight_data));
 
-- 
2.5.0
