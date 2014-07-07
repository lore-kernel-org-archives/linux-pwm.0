From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 10/11] ARM: at91/dt: add LCD panel description to sama5d3xdm.dtsi
Date: Mon,  7 Jul 2014 16:51:10 +0200
Message-ID: <1404744671-1629-11-git-send-email-boris.brezillon@free-electrons.com>
References: <1404744671-1629-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57743 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753455AbaGGOvm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jul 2014 10:51:42 -0400
In-Reply-To: <1404744671-1629-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>

Add LCD panel related nodes (backlight, regulators and panel) to sama5d3
Display Module dtsi.

Reference LCD pin muxing used by sama5d3xek boards.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xdm.dtsi | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
index 035ab72..690055e 100644
--- a/arch/arm/boot/dts/sama5d3xdm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xdm.dtsi
@@ -36,6 +36,49 @@
 					};
 				};
 			};
+
+			hlcdc: hlcdc@f0030000 {
+				hlcdc-display-controller {
+					pinctrl-names = "default", "rgb-444", "rgb-565", "rgb-666", "rgb-888";
+					pinctrl-0 = <&pinctrl_lcd_base>;
+					pinctrl-1 = <&pinctrl_lcd_base &pinctrl_lcd_rgb444>;
+					pinctrl-2 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
+					pinctrl-3 = <&pinctrl_lcd_base &pinctrl_lcd_rgb666_alt>;
+					pinctrl-4 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888_alt>;
+				};
+			};
 		};
 	};
+
+	bl_reg: backlight_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight-power-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		status = "disabled";
+	};
+
+	panel_reg: panel_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "panel-power-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		status = "disabled";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&hlcdc_pwm 0 50000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		power-supply = <&bl_reg>;
+		status = "disabled";
+	};
+
+	panel: panel {
+		compatible = "foxlink,fl500wvr00-a0t", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&panel_reg>;
+		status = "disabled";
+	};
 };
-- 
1.8.3.2

