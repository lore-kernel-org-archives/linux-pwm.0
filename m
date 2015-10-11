From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/4] ARM: dts: sun5i: Add PWM controller node for A13 / A10s
Date: Sun, 11 Oct 2015 11:55:05 +0200
Message-ID: <1444557308-10892-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40338 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbbJKJzO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 11 Oct 2015 05:55:14 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Add dts nodes for the PWM controller on the A13 / A10s.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-Use a separate compatible string for a10s and a13
---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 0fdabe8..f7dcf4e 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -165,6 +165,14 @@
 			#size-cells = <0>;
 		};
 
+		pwm: pwm@01c20e00 {
+			compatible = "allwinner,sun5i-a10s-pwm";
+			reg = <0x01c20e00 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		uart0: serial@01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index f3631c9..d910d3a 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -150,6 +150,16 @@
 					     "apb1_uart3";
 		};
 	};
+
+	soc@01c00000 {
+		pwm: pwm@01c20e00 {
+			compatible = "allwinner,sun5i-a13-pwm";
+			reg = <0x01c20e00 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+	};
 };
 
 &cpu0 {
-- 
2.5.0
