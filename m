From: hao_zhang <hao5781286@gmail.com>
Subject: [PATCH v4 3/4] ARM: dts: add pwm node for r40.
Date: Wed, 13 Dec 2017 22:46:28 +0800
Message-ID: <20171213144628.GA18246@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46084 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdLMOqk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Dec 2017 09:46:40 -0500
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, hao5781286@gmail.com

This patch add pwm node for r40.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts |  6 ++++++
 arch/arm/boot/dts/sun8i-r40.dtsi                  | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 8c5efe2..6cf6273 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -196,6 +196,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 173dcc1..6628b17 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -295,6 +295,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pins: pwm0-pin {
+				pins = "PB2", "PB3";
+				function = "pwm";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
@@ -306,6 +311,14 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		pwm: pwm@1c23400 {
+			     compatible = "allwinner,sun8i-r40-pwm";
+			     reg = <0x01c23400 0x154>;
+			     clocks = <&osc24M>;
+			     #pwm-cells = <3>;
+			     status = "disabled";
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.7.4
