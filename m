From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v10 2/2] pwm: add DT bindings documentation for atmel-hlcdc-pwm driver
Date: Tue,  7 Oct 2014 15:38:15 +0200
Message-ID: <1412689095-14259-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1412689095-14259-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34095 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753496AbaJGNiU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 09:38:20 -0400
In-Reply-To: <1412689095-14259-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

The HLCDC IP available in some Atmel SoCs (i.e. at91sam9x5, at91sam9n12
or sama5d3 families for instance) provides a PWM device.

The DT bindings used for this PWM device is following the default 3 cells
bindings described in Documentation/devicetree/bindings/pwm/pwm.txt.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
new file mode 100644
index 0000000..cfda0d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
@@ -0,0 +1,29 @@
+Device-Tree bindings for Atmel's HLCDC (High-end LCD Controller) PWM driver
+
+The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
+See ../mfd/atmel-hlcdc.txt for more details.
+
+Required properties:
+ - compatible: value should be one of the following:
+   "atmel,hlcdc-pwm"
+ - pinctr-names: the pin control state names. Should contain "default".
+ - pinctrl-0: should contain the pinctrl states described by pinctrl
+   default.
+ - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
+   bindings defined in pwm.txt in this directory.
+
+Example:
+
+	hlcdc: hlcdc@f0030000 {
+		compatible = "atmel,sama5d3-hlcdc";
+		reg = <0xf0030000 0x2000>;
+		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+		clock-names = "periph_clk","sys_clk", "slow_clk";
+
+		hlcdc_pwm: hlcdc-pwm {
+			compatible = "atmel,hlcdc-pwm";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_lcd_pwm>;
+			#pwm-cells = <3>;
+		};
+	};
-- 
1.9.1

