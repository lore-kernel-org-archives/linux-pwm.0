From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v4 2/4] mvebu: xp: Add PWM properties to .dtsi files
Date: Mon, 27 Mar 2017 21:42:58 +0200
Message-ID: <20170327194301.1104-3-ralph.sennhauser@gmail.com>
References: <20170327194301.1104-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170327194301.1104-1-ralph.sennhauser@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

Add properties to the GPIO nodes to allow them to be also used as PWM
lines.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427294/
[Ralph Sennhauser:
  * Use new compatible string marvell,armada-370-xp-gpio
  * Add missing reg-names / #pwm-cell properties to armada-xp-mv78260.dtsi
    'gpio1' node]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-370.dtsi        | 16 +++++++++++-----
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 14 ++++++++++----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 16 +++++++++++-----
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 16 +++++++++++-----
 4 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index cc011c8..e30b076 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -137,29 +137,35 @@
 			};
 
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-xp-gpio";
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
+				compatible = "marvell,armada-370-xp-gpio";
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
+				compatible = "marvell,armada-370-xp-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <2>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 07c5090..429ac10 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -202,25 +202,31 @@
 
 		internal-regs {
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-xp-gpio";
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
+				compatible = "marvell,armada-370-xp-gpio";
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
index 64e936a..333c470 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -285,29 +285,35 @@
 
 		internal-regs {
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-xp-gpio";
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
+				compatible = "marvell,armada-370-xp-gpio";
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
+				compatible = "marvell,armada-370-xp-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <3>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index d1383dd..2ff825d 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -323,29 +323,35 @@
 
 		internal-regs {
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-xp-gpio";
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
+				compatible = "marvell,armada-370-xp-gpio";
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
+				compatible = "marvell,armada-370-xp-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <3>;
 				gpio-controller;
-- 
2.10.2
