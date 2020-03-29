From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH RFC 4/6] arm64: dts: armada-cp11x: add pwm support to GPIO
 blocks
Date: Sun, 29 Mar 2020 11:48:20 +0100
Message-ID: <E1jIVUK-0005hJ-33@rmk-PC.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200329104549.GX25745@shell.armlinux.org.uk>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

Add PWM support to the GPIO blocks.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 024073edfc1c..dfd251acc194 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -311,6 +311,7 @@
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				gpio-ranges = <&CP11X_LABEL(pinctrl) 0 0 32>;
 				interrupt-controller;
 				interrupts = <86 IRQ_TYPE_LEVEL_HIGH>,
@@ -319,6 +320,8 @@
 					<83 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <2>;
 				status = "disabled";
+				clock-names = "core";
+				clocks = <&CP11X_LABEL(clk) 1 21>;
 			};
 
 			CP11X_LABEL(gpio2): gpio@140 {
@@ -327,6 +330,7 @@
 				ngpios = <31>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				gpio-ranges = <&CP11X_LABEL(pinctrl) 0 32 31>;
 				interrupt-controller;
 				interrupts = <82 IRQ_TYPE_LEVEL_HIGH>,
@@ -335,6 +339,8 @@
 					<79 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <2>;
 				status = "disabled";
+				clock-names = "core";
+				clocks = <&CP11X_LABEL(clk) 1 21>;
 			};
 		};
 
-- 
2.20.1
