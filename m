From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v5 2/4] ARM: dts: mvebu: Add PWM properties to .dtsi files
Date: Sun,  9 Apr 2017 20:09:28 +0200
Message-ID: <20170409180931.4884-3-ralph.sennhauser@gmail.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, Ralph Sennhauser <ralph.sennhauser@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

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
