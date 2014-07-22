From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [PATCH v4 02/11] mfd: add documentation for atmel-hlcdc DT bindings
Date: Tue, 22 Jul 2014 15:11:26 +0200
Message-ID: <1406034695-15534-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Rob Clark <robdclark@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9x5
family or sama5d3 family) exposes 2 subdevices:
- a display controller (controlled by a DRM driver)
- a PWM chip

This patch adds documentation for atmel-hlcdc DT bindings.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/mfd/atmel-hlcdc.txt        | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
new file mode 100644
index 0000000..e9cc1b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
@@ -0,0 +1,50 @@
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
1.8.3.2
