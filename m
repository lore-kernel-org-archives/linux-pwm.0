From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 4/7] DT: bindings: Extend mvebu gpio documentation with PWM
Date: Sat, 10 Jan 2015 00:34:50 +0100
Message-ID: <1420846493-31647-5-git-send-email-andrew@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49511 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758314AbbAIXhU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 9 Jan 2015 18:37:20 -0500
In-Reply-To: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linus.walleij@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, kaloz@openwrt.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Document the optional parameters needed for PWM operation of gpio
lines.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/gpio/gpio-mvebu.txt        | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
index a6f3bec1da7d..9984e2665568 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -38,6 +38,23 @@ Required properties:
 - #gpio-cells: Should be two. The first cell is the pin number. The
   second cell is reserved for flags, unused at the moment.
 
+Optional properties:
+
+In order to use the gpio lines in PWM mode, some additional optional
+properties are required. Only Armada 370 and XP supports these
+properties.
+
+- reg: an additional register set is needed, for the GPIO Blink
+  Counter on/off registers.
+
+- reg-names: Must contain an entry "pwm" corresponding to the
+  additional register range needed for pwm operation.
+
+- #pwm-cells: Should be two. The first cell is the pin number. The
+  second cell is reserved for flags, unused at the moment.
+
+- clocks: Must be a phandle to the clock for the gpio controller.
+
 Example:
 
 		gpio0: gpio@d0018100 {
@@ -51,3 +68,17 @@ Example:
 			#interrupt-cells = <2>;
 			interrupts = <16>, <17>, <18>, <19>;
 		};
+
+		gpio1: gpio@18140 {
+			compatible = "marvell,orion-gpio";
+			reg = <0x18140 0x40>, <0x181c8 0x08>;
+			reg-names = "gpio", "pwm";
+			ngpios = <17>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			#pwm-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <87>, <88>, <89>;
+			clocks = <&coreclk 0>;
+		};
-- 
2.1.3

