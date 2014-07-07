From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for atmel-hlcdc-dc driver
Date: Mon,  7 Jul 2014 18:42:59 +0200
Message-ID: <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58995 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751364AbaGGQnS (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jul 2014 12:43:18 -0400
In-Reply-To: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Boris BREZILLON <boris.brezillon@free-electrons.com>

The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
controller device.

The HLCDC block provides a single RGB output port, and only supports LCD
panels connection to LCD panels for now.

The atmel,panel property link the HLCDC RGB output with the LCD panel
connected on this port (note that the HLCDC RGB connector implementation
makes use of the DRM panel framework).

Connection to other external devices (DRM bridges) might be added later by
mean of a new atmel,xxx (atmel,bridge) property.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt

diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
new file mode 100644
index 0000000..594bdb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
@@ -0,0 +1,59 @@
+Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
+
+The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
+See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more details.
+
+Required properties:
+ - compatible: value should be one of the following:
+   "atmel,hlcdc-dc"
+ - interrupts: the HLCDC interrupt definition
+ - pinctrl-names: the pin control state names. Should contain "default",
+   "rgb-444", "rgb-565", "rgb-666" and "rgb-888".
+ - pinctrl-[0-4]: should contain the pinctrl states described by pinctrl
+   names.
+ - atmel,panel: Should contain a phandle with 2 parameters.
+   The first cell is a phandle to a DRM panel device
+   The second cell encodes the RGB mode, which can take the following values:
+   * 0: RGB444
+   * 1: RGB565
+   * 2: RGB666
+   * 3: RGB888
+   The third cell encodes specific flags describing LCD signals configuration
+   (see Atmel's datasheet for a full description of these fields):
+   * bit 0: HSPOL: Horizontal Synchronization Pulse Polarity
+   * bit 1: VSPOL: Vertical Synchronization Pulse Polarity
+   * bit 2: VSPDLYS: Vertical Synchronization Pulse Start
+   * bit 3: VSPDLYE: Vertical Synchronization Pulse End
+   * bit 4: DISPPOL: Display Signal Polarity
+   * bit 7: DISPDLY: LCD Controller Display Power Signal Synchronization
+   * bit 12: VSPSU: LCD Controller Vertical synchronization Pulse Setup Configuration
+   * bit 13: VSPHO: LCD Controller Vertical synchronization Pulse Hold Configuration
+   * bit 16-20: GUARDTIME: LCD DISPLAY Guard Time
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

