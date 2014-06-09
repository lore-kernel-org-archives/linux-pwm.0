From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 7/7] ARM: at91/dt: enable the LCD panel on sama5d3xek boards
Date: Mon,  9 Jun 2014 18:04:20 +0200
Message-ID: <1402329860-27520-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1402329860-27520-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1402329860-27520-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-doc@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Enable LCD related nodes and reference panel node in the hlcdc (High
LCD Controller) controller on sama5d3xek boards.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d31ek.dts | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d33ek.dts | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d34ek.dts | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d36ek.dts | 24 ++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d31ek.dts
index 04eec0d..338f4c3 100644
--- a/arch/arm/boot/dts/sama5d31ek.dts
+++ b/arch/arm/boot/dts/sama5d31ek.dts
@@ -33,6 +33,14 @@
 				status = "okay";
 			};
 
+			hlcdc: hlcdc@f0030000 {
+				status = "okay";
+
+				hlcdc-display-controller {
+					atmel,panel = <&panel 3 0>;
+				};
+			};
+
 			macb1: ethernet@f802c000 {
 				status = "okay";
 			};
@@ -46,6 +54,22 @@
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
index cbd6a3f..f2ab41d 100644
--- a/arch/arm/boot/dts/sama5d33ek.dts
+++ b/arch/arm/boot/dts/sama5d33ek.dts
@@ -36,9 +36,33 @@
 			macb0: ethernet@f0028000 {
 				status = "okay";
 			};
+
+			hlcdc: hlcdc@f0030000 {
+				status = "okay";
+
+				hlcdc-display-controller {
+					atmel,panel = <&panel 3 0>;
+				};
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
index 878aa16..0d0049c 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -46,6 +46,14 @@
 			macb0: ethernet@f0028000 {
 				status = "okay";
 			};
+
+			hlcdc: hlcdc@f0030000 {
+				status = "okay";
+
+				hlcdc-display-controller {
+					atmel,panel = <&panel 3 0>;
+				};
+			};
 		};
 	};
 
@@ -56,6 +64,22 @@
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
index 59576c6..8350358 100644
--- a/arch/arm/boot/dts/sama5d36ek.dts
+++ b/arch/arm/boot/dts/sama5d36ek.dts
@@ -41,12 +41,36 @@
 				status = "okay";
 			};
 
+			hlcdc: hlcdc@f0030000 {
+				status = "okay";
+
+				hlcdc-display-controller {
+					atmel,panel = <&panel 3 0>;
+				};
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
1.8.3.2
