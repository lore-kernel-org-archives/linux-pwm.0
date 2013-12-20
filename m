From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] ARM: pxa: Add dummy backlight power supply on Mitac Mio A701
Date: Fri, 20 Dec 2013 10:46:52 +0100
Message-ID: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:41667 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab3LTJsZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Dec 2013 04:48:25 -0500
Received: by mail-bk0-f54.google.com with SMTP id v16so1094578bkz.41
        for <linux-pwm@vger.kernel.org>; Fri, 20 Dec 2013 01:48:24 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

Recent changes to the pwm-backlight driver have made the power supply
mandatory. There is code in the regulator core to deal with situations
where no regulator is specified and provide a dummy, but that works on
DT-based boards only.

The situation can be remedied by adding a dummy regulator during board
initialization.

Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/mioa701.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index f70583fee59f..29997bde277d 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -38,6 +38,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/reboot.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/max1586.h>
 #include <linux/slab.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -714,6 +715,10 @@ static struct gpio global_gpios[] = {
 	{ GPIO56_MT9M111_nOE, GPIOF_OUT_INIT_LOW, "Camera nOE" },
 };
 
+static struct regulator_consumer_supply fixed_5v0_consumers[] = {
+	REGULATOR_SUPPLY("power", "pwm-backlight"),
+};
+
 static void __init mioa701_machine_init(void)
 {
 	int rc;
@@ -753,6 +758,10 @@ static void __init mioa701_machine_init(void)
 	pxa_set_i2c_info(&i2c_pdata);
 	pxa27x_set_i2c_power_info(NULL);
 	pxa_set_camera_info(&mioa701_pxacamera_platform_data);
+
+	regulator_register_always_on(0, "fixed-5.0V", fixed_5v0_consumers,
+				     ARRAY_SIZE(fixed_5v0_consumers),
+				     5000000);
 }
 
 static void mioa701_machine_exit(void)
-- 
1.8.4.2

