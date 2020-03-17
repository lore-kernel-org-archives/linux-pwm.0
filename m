From: Michael Walle <michael@walle.cc>
Subject: [PATCH 15/18] arm64: dts: freescale: sl28: enable sl28cpld
Date: Tue, 17 Mar 2020 21:50:14 +0100
Message-ID: <20200317205017.28280-16-michael@walle.cc>
References: <20200317205017.28280-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317205017.28280-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
List-Id: linux-pwm@vger.kernel.org

Add the board management controller node.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 1648a04ea79f..b74d9ac0c388 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 #include "fsl-ls1028a.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Kontron SMARC-sAL28";
@@ -165,6 +166,92 @@
 		reg = <0x32>;
 	};
 
+	sl28cpld: sl28cpld@4a {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "kontron,sl28cpld";
+		reg = <0x4a>;
+		interrupts-extended = <&gpio2 6 IRQ_TYPE_EDGE_FALLING>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		cpld_gpio0: gpio@0 {
+			compatible = "kontron,sl28cpld-gpio";
+			reg = <0>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"GPIO0_CAM0_PWR_N", "GPIO1_CAM1_PWR_N",
+				"GPIO2_CAM0_RST_N", "GPIO3_CAM1_RST_N",
+				"GPIO4_HDA_RST_N", "GPIO5_PWM_OUT",
+				"GPIO6_TACHIN", "GPIO7";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		cpld_gpio1: gpio@1 {
+			compatible = "kontron,sl28cpld-gpio";
+			reg = <1>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"GPIO8", "GPIO9", "GPIO10", "GPIO11",
+				"", "", "", "";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		cpld_gpo: gpo {
+			compatible = "kontron,sl28cpld-gpo";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"LCD0 voltage enable",
+				"LCD0 backlight enable",
+				"eMMC reset", "LVDS bridge reset",
+				"LVDS bridge power-down",
+				"SDIO power enable",
+				"", "";
+		};
+
+		cpld_gpi: gpi {
+			compatible = "kontron,sl28cpld-gpi";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"Power button", "Force recovery", "Sleep",
+				"Battery low", "Lid state", "Charging",
+				"Charger present", "";
+		};
+
+		hwmon {
+			compatible = "kontron,sl28cpld-fan";
+		};
+
+		pwm0: pwm@0 {
+			#pwm-cells = <2>;
+			compatible = "kontron,sl28cpld-pwm";
+			reg = <0>;
+		};
+
+		pwm1: pwm@1 {
+			#pwm-cells = <2>;
+			compatible = "kontron,sl28cpld-pwm";
+			reg = <1>;
+		};
+
+		watchdog {
+			compatible = "kontron,sl28cpld-wdt";
+		};
+	};
+
 	eeprom@50 {
 		compatible = "atmel,24c32";
 		reg = <0x50>;
-- 
2.20.1
