From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v8 2/2] pwm: add DT bindings documentation for atmel-hlcdc-pwm driver
Date: Mon,  6 Oct 2014 16:07:03 +0200
Message-ID: <1412604423-19329-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1412604423-19329-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56122 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751346AbaJFOHJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Oct 2014 10:07:09 -0400
In-Reply-To: <1412604423-19329-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>

The HLCDC IP available in some Atmel SoCs (i.e. sam9x5i.e. at91sam9n12,
at91sam9x5 family or sama5d3 family) provide a PWM device.

The DT bindings used for this PWM device is following the default 3 cells
bindings described in Documentation/devicetree/bindings/pwm/pwm.txt.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
new file mode 100644
index 0000000..9f4f83a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
@@ -0,0 +1,50 @@
+Device-Tree bindings for Atmel's HLCDC (High LCD Controller) PWM driver
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
+   bindings defined in Documentation/devicetree/bindings/pwm/pwm.txt.
+
+Example:
+
+	hlcdc: hlcdc@f0030000 {
+		compatible = "atmel,sama5d3-hlcdc";
+		reg = <0xf0030000 0x2000>;
+		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+		clock-names = "periph_clk","sys_clk", "slow_clk";
+		status = "disabled";
+
+		hlcdc-display-controller {
+			compatible = "atmel,hlcdc-display-controller";
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+
+				hlcdc_panel_output: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&panel_input>;
+				};
+			};
+		};
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

