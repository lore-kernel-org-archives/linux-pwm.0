From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v6 10/11] ARM: at91/dt: add LCD panel description to
 sama5d3xdm.dtsi
Date: Mon, 29 Sep 2014 16:44:23 +0200
Message-ID: <1412001864-3251-11-git-send-email-boris.brezillon@free-electrons.com>
References: <1412001864-3251-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1412001864-3251-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Mark Yao <mark.yao@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Add LCD panel related nodes (backlight, regulators and panel) to sama5d3
Display Module dtsi.

Reference LCD pin muxing used by sama5d3xek boards.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xdm.dtsi | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
index 035ab72..91975eb 100644
--- a/arch/arm/boot/dts/sama5d3xdm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xdm.dtsi
@@ -36,6 +36,64 @@
 					};
 				};
 			};
+
+			hlcdc: hlcdc@f0030000 {
+				hlcdc-display-controller {
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888_alt>;
+
+					port@0 {
+						hlcdc_panel_output: endpoint@0 {
+							reg = <0>;
+							remote-endpoint = <&panel_input>;
+						};
+					};
+				};
+			};
+		};
+	};
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
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hlcdc_panel_output>;
+			};
 		};
 	};
 };
-- 
1.9.1
