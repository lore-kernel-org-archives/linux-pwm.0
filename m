From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ARM: pxa: Add dummy backlight power supply on Mitac Mio A701
Date: Mon, 13 Jan 2014 00:43:11 +0100
Message-ID: <87txd8vka8.fsf@free.fr>
References: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
	<87zjn9v7xx.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:43046 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaALXnt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Jan 2014 18:43:49 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 55BF42CC26
	for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2014 00:43:39 +0100 (CET)
In-Reply-To: <87zjn9v7xx.fsf@free.fr> (Robert Jarzmik's message of "Mon, 06
	Jan 2014 09:19:22 +0100")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org

Hi Arnd,

I cannot reach Haojian, and my platform is currently screen-broken without
Thierry's patch (see [1] and [2]). I'm trying to have it since -rc6, with no luck.

Could you handle it in arm-soc fixes for -rc9 (if it happens) please ?

Cheers.

--
Robert

[1] http://www.spinics.net/lists/arm-kernel/msg298187.html
[2] Patch :

From 7ca9a136dc67ac4c302b15a333e8cfa1c3fc051b Mon Sep 17 00:00:00 2001
From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 20 Dec 2013 10:46:52 +0100
Subject: [PATCH] ARM: pxa: Add dummy backlight power supply on Mitac Mio A701

Recent changes to the pwm-backlight driver have made the power supply
mandatory. There is code in the regulator core to deal with situations
where no regulator is specified and provide a dummy, but that works on
DT-based boards only.

The situation can be remedied by adding a dummy regulator during board
initialization.

Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/mioa701.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index c2d8625..a8fdcb7 100644
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
@@ -723,6 +724,10 @@ static struct gpio global_gpios[] = {
 	{ GPIO56_MT9M111_nOE, GPIOF_OUT_INIT_LOW, "Camera nOE" },
 };
 
+static struct regulator_consumer_supply fixed_5v0_consumers[] = {
+	REGULATOR_SUPPLY("power", "pwm-backlight"),
+};
+
 static void __init mioa701_machine_init(void)
 {
 	int rc;
@@ -762,6 +767,10 @@ static void __init mioa701_machine_init(void)
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
1.7.10.4

