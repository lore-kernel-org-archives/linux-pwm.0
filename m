From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v8 2/2] mfd: add documentation for atmel-hlcdc DT bindings
Date: Mon,  6 Oct 2014 15:48:44 +0200
Message-ID: <1412603324-18789-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9x5
family or sama5d3 family) exposes 2 subdevices:
- a display controller (controlled by a DRM driver)
- a PWM chip

This patch adds documentation for atmel-hlcdc DT bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 .../devicetree/bindings/mfd/atmel-hlcdc.txt        | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
new file mode 100644
index 0000000..f64de95a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
@@ -0,0 +1,51 @@
+Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD driver
+
+Required properties:
+ - compatible: value should be one of the following:
+   "atmel,sama5d3-hlcdc"
+ - reg: base address and size of the HLCDC device registers.
+ - clock-names: the name of the 3 clocks requested by the HLCDC device.
+   Should contain "periph_clk", "sys_clk" and "slow_clk".
+ - clocks: should contain the 3 clocks requested by the HLCDC device.
+ - interrupts: should contain the description of the HLCDC interrupt line
+
+The HLCDC IP exposes two subdevices:
+ - a PWM chip: see ../pwm/atmel-hlcdc-pwm.txt
+ - a Display Controller: see ../drm/atmel-hlcdc-dc.txt
+
+Example:
+
+	hlcdc: hlcdc@f0030000 {
+		compatible = "atmel,sama5d3-hlcdc";
+		reg = <0xf0030000 0x2000>;
+		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+		clock-names = "periph_clk","sys_clk", "slow_clk";
+		interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+		status = "disabled";
+
+		hlcdc-display-controller {
+			compatible = "atmel,hlcdc-display-controller";
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
