From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [PATCH v5 11/11] ARM: at91/dt: enable the LCD panel on sama5d3xek boards
Date: Mon,  8 Sep 2014 10:43:42 +0200
Message-ID: <1410165822-16868-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41704 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753699AbaIHIn7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Sep 2014 04:43:59 -0400
In-Reply-To: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>

Enable LCD related nodes.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d31ek.dts | 20 ++++++++++++++++++++
 arch/arm/boot/dts/sama5d33ek.dts | 20 ++++++++++++++++++++
 arch/arm/boot/dts/sama5d34ek.dts | 20 ++++++++++++++++++++
 arch/arm/boot/dts/sama5d36ek.dts | 20 ++++++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d31ek.dts
index 04eec0d..6e605fe 100644
--- a/arch/arm/boot/dts/sama5d31ek.dts
+++ b/arch/arm/boot/dts/sama5d31ek.dts
@@ -33,6 +33,10 @@
 				status = "okay";
 			};
 
+			hlcdc: hlcdc@f0030000 {
+				status = "okay";
+			};
+
 			macb1: ethernet@f802c000 {
 				status = "okay";
 			};
@@ -46,6 +50,22 @@
 		};
 	};
 
+	bl_reg: backlight_regulator {
+		status = "okay";
+	};
+
+	panel_reg: panel_regulator {
+		status = "okay";
+	};
+
+	backlight: backlight {
+		status = "okay";
+	};
+
+	panel: panel {
+		status = "okay";
+	};
+
 	sound {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sama5d33ek.dts b/arch/arm/boot/dts/sama5d33ek.dts
index cbd6a3f..0400641 100644
--- a/arch/arm/boot/dts/sama5d33ek.dts
+++ b/arch/arm/boot/dts/sama5d33ek.dts
@@ -36,9 +36,29 @@
 			macb0: ethernet@f0028000 {
 				status = "okay";
 			};
+
+			hlcdc: hlcdc@f0030000 {
+				status = "okay";
+			};
 		};
 	};
 
+	bl_reg: backlight_regulator {
+		status = "okay";
+	};
+
+	panel_reg: panel_regulator {
+		status = "okay";
+	};
+
+	backlight: backlight {
+		status = "okay";
+	};
+
+	panel: panel {
+		status = "okay";
+	};
+
 	sound {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index 878aa16..9cf473e 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -46,6 +46,10 @@
 			macb0: ethernet@f0028000 {
 				status = "okay";
 			};
+
+			hlcdc: hlcdc@f0030000 {
+				status = "okay";
+			};
 		};
 	};
 
@@ -56,6 +60,22 @@
 		};
 	};
 
+	bl_reg: backlight_regulator {
+		status = "okay";
+	};
+
+	panel_reg: panel_regulator {
+		status = "okay";
+	};
+
+	backlight: backlight {
+		status = "okay";
+	};
+
+	panel: panel {
+		status = "okay";
+	};
+
 	sound {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/sama5d36ek.dts
index 59576c6..1c65741 100644
--- a/arch/arm/boot/dts/sama5d36ek.dts
+++ b/arch/arm/boot/dts/sama5d36ek.dts
@@ -41,12 +41,32 @@
 				status = "okay";
 			};
 
+			hlcdc: hlcdc@f0030000 {
+				status = "okay";
+			};
+
 			macb1: ethernet@f802c000 {
 				status = "okay";
 			};
 		};
 	};
 
+	bl_reg: backlight_regulator {
+		status = "okay";
+	};
+
+	panel_reg: panel_regulator {
+		status = "okay";
+	};
+
+	backlight: backlight {
+		status = "okay";
+	};
+
+	panel: panel {
+		status = "okay";
+	};
+
 	sound {
 		status = "okay";
 	};
-- 
1.9.1

