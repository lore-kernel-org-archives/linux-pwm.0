From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 5/7] ARM: sun7i: dt: add pinmux configuration for the PWM
Date: Sat, 12 Apr 2014 23:25:57 +0200
Message-ID: <1397337959-12408-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397337959-12408-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1397337959-12408-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Add the pinctrl descriptions for both PWM channels of the Allwinner A20.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 32efc105df83..c6eb881a3ced 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -540,6 +540,20 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
+			pwm0_pins_a: pwm0@0 {
+				allwinner,pins = "PB2";
+				allwinner,function = "pwm";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			pwm1_pins_a: pwm1@0 {
+				allwinner,pins = "PI3";
+				allwinner,function = "pwm";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			uart0_pins_a: uart0@0 {
 				allwinner,pins = "PB22", "PB23";
 				allwinner,function = "uart0";
-- 
1.8.3.2

