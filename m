From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v6 2/4] ARM: dts: mvebu: Add PWM properties to .dtsi files
Date: Fri, 14 Apr 2017 17:40:53 +0200
Message-ID: <20170414154056.32055-3-ralph.sennhauser@gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35409 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbdDNPlM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2017 11:41:12 -0400
In-Reply-To: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Add properties to the GPIO nodes to allow them to be also used as PWM
lines.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427294/
[Ralph Sennhauser: Add new compatible string marvell,armada-370-xp-gpio]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-370.dtsi        | 19 ++++++++++++++-----
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 16 ++++++++++++----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 19 ++++++++++++++-----
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 19 ++++++++++++++-----
 4 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index cc011c8..5e815cc 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -137,29 +137,38 @@
 			};
 
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio@18180 {
-				compatible = "marvell,orion-gpio";
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <2>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 07c5090..f77168c9 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -202,25 +202,33 @@
 
 		internal-regs {
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <17>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>;
+				clocks = <&coreclk 0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 64e936a..0ecfaf4 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -285,29 +285,38 @@
 
 		internal-regs {
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio@18180 {
-				compatible = "marvell,orion-gpio";
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <3>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index d1383dd..670ece4c 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -323,29 +323,38 @@
 
 		internal-regs {
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio@18180 {
-				compatible = "marvell,orion-gpio";
+				compatible = "marvell,armada-370-xp-gpio",
+					     "marvell,orion-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <3>;
 				gpio-controller;
-- 
2.10.2
