From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ARM: pxa: Add dummy backlight power supply on Mitac Mio A701
Date: Sat, 01 Feb 2014 18:55:42 +0100
Message-ID: <87k3deiuox.fsf@free.fr>
References: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
	<87zjn9v7xx.fsf@free.fr> <87txd8vka8.fsf@free.fr>
	<87ha8y76rn.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:45019 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933102AbaBAR4S (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Feb 2014 12:56:18 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 48E422DCA6
	for <linux-pwm@vger.kernel.org>; Sat,  1 Feb 2014 18:56:11 +0100 (CET)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> Hi Arnd,
>>
>> I cannot reach Haojian, and my platform is currently screen-broken without
>> Thierry's patch (see [1] and [2]). I'm trying to have it since -rc6, with no luck.
... zip ...

Hi Eric and Russell,

Since more than a month I've been trying to have a fix applied in the PXA tree,
since v3.13-rc6. I cannot reach Haojian, and Arnd seems unresponsive too.

The history mails are in [1], the patch in [2].

Your are the 2 other maintainers of the PXA tree, Could you please help me ?

Cheers.

--
Robert

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/223116.html


[2]
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/221013.html

---8>---

From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] ARM: pxa: Add dummy backlight power supply on Mitac Mio A701
To: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 20 Dec 2013 10:46:52 +0100 (6 weeks, 1 day, 8 hours ago)
Message-Id: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
X-Mailer: git-send-email 1.8.4.2

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
