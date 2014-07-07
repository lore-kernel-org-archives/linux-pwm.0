From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [RESEND PATCH v3 02/11] mfd: add documentation for atmel-hlcdc DT bindings
Date: Mon,  7 Jul 2014 18:42:55 +0200
Message-ID: <1404751384-5077-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58933 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225AbaGGQnM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jul 2014 12:43:12 -0400
In-Reply-To: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Boris BREZILLON <boris.brezillon@free-electrons.com>

The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9x5
family or sama5d3 family) exposes 2 subdevices:
- a display controller (controlled by a DRM driver)
- a PWM chip

This patch adds documentation for atmel-hlcdc DT bindings.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/mfd/atmel-hlcdc.txt        | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
new file mode 100644
index 0000000..294048a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
@@ -0,0 +1,40 @@
+Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD driver
+
+Required properties:
+ - compatible: value should be one of the following:
+   "atmel,sama5d3-hlcdc"
+ - reg: base address and size of the HLCDC device registers.
+ - clock-names: the name of the 3 clocks requested by the HLCDC device.
+   Should contain "periph_clk", "sys_clk" and "slow_clk".
+ - clocks: should contain the 3 clocks requested by the HLCDC device.
+
+The HLCDC IP exposes two subdevices:
+ - a PWM chip: see Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
+ - a Display Controller: see Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
+
+Example:
+
+	hlcdc: hlcdc@f0030000 {
+		compatible = "atmel,sama5d3-hlcdc";
+		reg = <0xf0030000 0x2000>;
+		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+		clock-names = "periph_clk","sys_clk", "slow_clk";
+
+		hlcdc-display-controller {
+			compatible = "atmel,hlcdc-dc";
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+			pinctrl-names = "default", "rgb-444", "rgb-565", "rgb-666", "rgb-888";
+			pinctrl-0 = <&pinctrl_lcd_base>;
+			pinctrl-1 = <&pinctrl_lcd_base &pinctrl_lcd_rgb444>;
+			pinctrl-2 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
+			pinctrl-3 = <&pinctrl_lcd_base &pinctrl_lcd_rgb666>;
+			pinctrl-4 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
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
1.8.3.2

