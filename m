From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 5/7] mvebu: xp: Add pwm properties to .dtsi files
Date: Sat, 10 Jan 2015 00:34:51 +0100
Message-ID: <1420846493-31647-6-git-send-email-andrew@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, kaloz@openwrt.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-pwm@vger.kernel.org

Add properties to the gpio nodes to allow them to be also used
as pwm lines.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-370.dtsi        | 10 ++++++++--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 10 ++++++++--
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |  8 ++++++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 10 ++++++++--
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fdb3c12a6139..1a38d15adb88 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -123,24 +123,30 @@
 
 			gpio0: gpio@18100 {
 				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
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
 				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
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
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 281ccd24295c..a37a73dd9252 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -169,24 +169,30 @@
 		internal-regs {
 			gpio0: gpio@18100 {
 				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
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
 				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
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
index d7a8d0b0f385..a4b9fbd3a44d 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -253,24 +253,28 @@
 		internal-regs {
 			gpio0: gpio@18100 {
 				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
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
 				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio@18180 {
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 9c40c130d11a..77ae071134a0 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -291,24 +291,30 @@
 		internal-regs {
 			gpio0: gpio@18100 {
 				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
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
 				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
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
-- 
2.1.3

