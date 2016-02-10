From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] ARM: nomadik: add STMPE PWM to the NHK15 device tree
Date: Wed, 10 Feb 2016 09:54:28 +0100
Message-ID: <1455094468-25521-4-git-send-email-linus.walleij@linaro.org>
References: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36015 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbcBJIyw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2016 03:54:52 -0500
Received: by mail-lf0-f48.google.com with SMTP id 78so7336495lfy.3
        for <linux-pwm@vger.kernel.org>; Wed, 10 Feb 2016 00:54:52 -0800 (PST)
In-Reply-To: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

This adds the STMPE PWM to the NHK15 device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I will take this patch into ARM SoC if the other patches get
merged.
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 4a21c6492dbb..cfdcef2c7e49 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -129,6 +129,10 @@
 						0x03020067 // Up
 						0x0303006c>; // Down
 			};
+			stmpe0_pwm: stmpe_pwm {
+				compatible = "st,stmpe-pwm";
+				#pwm-cells = <2>;
+			};
 		};
 		stmpe1: stmpe2401@44 {
 			compatible = "st,stmpe2401";
@@ -172,4 +176,24 @@
 			wp-gpios = <&stmpe_gpio44 18 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&stmpe0_pwm 0 500000>;
+		pwm-names = "backlight";
+		brightness-levels = <
+			0  1  2  3  4  5  6  7  8  9
+			10 11 12 13 14 15 16 17 18 19
+			20 21 22 23 24 25 26 27 28 29
+			30 31 32 33 34 35 36 37 38 39
+			40 41 42 43 44 45 46 47 48 49
+			50 51 52 53 54 55 56 57 58 59
+			60 61 62 63 64 65 66 67 68 69
+			70 71 72 73 74 75 76 77 78 79
+			80 81 82 83 84 85 86 87 88 89
+			90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level = <100>;
+	};
 };
-- 
2.4.3
