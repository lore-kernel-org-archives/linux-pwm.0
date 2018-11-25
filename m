From: Hao Zhang <hao5781286@gmail.com>
Subject: [PATCH v3 2/6] ARM: dtsi: add pwm node for sun8i R40.
Date: Mon, 26 Nov 2018 00:19:41 +0800
Message-ID: <20181125161941.GA5305@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org, thierry.reding@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com, hao5781286@gmail.com
List-Id: linux-pwm@vger.kernel.org

This patch adds pwm node for sun8i R40.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 6f4c9ca..cc05b2c 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -317,6 +317,7 @@
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+
 		};
 
 		pio: pinctrl@1c20800 {
@@ -373,6 +374,11 @@
 				bias-pull-up;
 			};
 
+			pwm_ch0_pin: pwm-ch0-pin {
+				pins = "PB2";
+				function = "pwm";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
@@ -384,6 +390,17 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		pwm: pwm@1c23400 {
+			compatible = "allwinner,sun8i-r40-pwm";
+			reg = <0x01c23400 0x400>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>, <&ccu CLK_APB1>;
+			clock-names = "mux-0", "mux-1";
+			pwm-channels = <8>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.7.4
