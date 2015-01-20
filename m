From: Robby Cai <r63905@freescale.com>
Subject: [PATCH] ARM: dts: imx6qdl: Adjust the brightness setting for LVDS panel
Date: Tue, 20 Jan 2015 18:22:35 +0800
Message-ID: <1421749355-23050-1-git-send-email-r63905@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2on0115.outbound.protection.outlook.com ([207.46.100.115]:30784
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753757AbbATLz5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 20 Jan 2015 06:55:57 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: jg1.han@samsung.com, lee.jones@linaro.org, shawn.guo@linaro.org, thierry.reding@gmail.com

Hannstar XGA panel is used by default on i.MX6QDL Sabre Auto/Lite/SD
or derived board.

According to its data sheet [1],
a) the dimming duty cycle is 20% - 100%.
This patch changes the brightness-level from 20 to 100 with step 10 to
make it straight-forward.
b) the typical dimming frequency is 20KHz.
The previous setting is 200Hz. This patch corrects it.

[1]
http://boundarydevices.com/wp-content/uploads/2013/06/HSD100PXN1-A00-C11-1.0.pdf

Signed-off-by: Robby Cai <r63905@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi     | 6 +++---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi     | 6 +++---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi     | 6 +++---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 6 +++---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  | 6 +++---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 6 +++---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi    | 6 +++---
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index b5756c2..33484d8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -29,9 +29,9 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
+		pwms = <&pwm4 0 50000>;
+		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 86f03c1..0d01751 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -30,9 +30,9 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
+		pwms = <&pwm4 0 50000>;
+		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 4a8d97f..8973bf2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -30,9 +30,9 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
+		pwms = <&pwm4 0 50000>;
+		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 0821812..5453cf0 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -124,9 +124,9 @@
 
 	backlight_lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
+		pwms = <&pwm4 0 50000>;
+		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;
 		power-supply = <&reg_3p3v>;
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..2bfcf5a 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -38,9 +38,9 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
+		pwms = <&pwm3 0 50000>;
+		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 0b28a9d..d1409c0 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -123,9 +123,9 @@
 
 	backlight_lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
+		pwms = <&pwm4 0 50000>;
+		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;
 		power-supply = <&reg_3p3v>;
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index f1cd214..3efc363 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -115,9 +115,9 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
+		pwms = <&pwm1 0 50000>;
+		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;
 		status = "okay";
 	};
 
-- 
1.9.1

