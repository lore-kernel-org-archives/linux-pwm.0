From: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/4] mvebu: xp: Add PWM properties to .dtsi files
Date: Fri, 24 Mar 2017 15:18:12 +0100
Message-ID: <20170324141815.7252-3-ralph.sennhauser@gmail.com>
References: <20170324141815.7252-1-ralph.sennhauser@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170324141815.7252-1-ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>

Add properties to the GPIO nodes to allow them to be also used as PWM
lines.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
URL: https://patchwork.ozlabs.org/patch/427294/
[Ralph Sennhauser:
  * Use #pwm-cells = <1>
  * Add missing reg-names / #pwm-cell properties to armada-xp-mv78260.dtsi
    'gpio1' node]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/armada-370.dtsi        | 10 ++++++++--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 10 ++++++++--
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 10 ++++++++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 10 ++++++++--
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index cc011c8..de7295c 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -138,24 +138,30 @@
 
 			gpio0: gpio@18100 {
 				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <1>;
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
+				#pwm-cells = <1>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio@18180 {
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 07c5090..9ae856b 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -203,24 +203,30 @@
 		internal-regs {
 			gpio0: gpio@18100 {
 				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <1>;
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
+				#pwm-cells = <1>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>;
+				clocks = <&coreclk 0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 64e936a..11eb6ff 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -286,24 +286,30 @@
 		internal-regs {
 			gpio0: gpio@18100 {
 				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <1>;
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
+				#pwm-cells = <1>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio@18180 {
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index d1383dd..597b0d6 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -324,24 +324,30 @@
 		internal-regs {
 			gpio0: gpio@18100 {
 				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <1>;
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
+				#pwm-cells = <1>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio@18180 {
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
