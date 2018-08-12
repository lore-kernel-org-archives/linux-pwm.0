From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 4/7] dt-bindings: add bindings for Atmel LCDC pwm
Date: Sun, 12 Aug 2018 20:46:26 +0200
Message-ID: <20180812184629.3808-4-sam@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180812184152.GA22343@ravnborg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The LCDC IP used by some Atmel SOC's have a
multifunction device that include two sub-devices:
- pwm
- display controller

This binding describe the pwm binding and refer back to
the mfd device that this must be a child node of.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/pwm/atmel-lcdc-pwm.txt     | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-lcdc-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel-lcdc-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-lcdc-pwm.txt
new file mode 100644
index 000000000000..a7f11ac6972a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel-lcdc-pwm.txt
@@ -0,0 +1,30 @@
+Device-Tree bindings for Atmel's LCDC (LCD Controller) PWM driver
+
+The Atmel LCDC PWM is subdevice of the LCDC MFD device.
+See ../mfd/atmel-lcdc.txt for more details.
+
+Required properties:
+ - compatible: value should be one of the following:
+   "atmel,lcdc-pwm"
+ - pinctr-names: the pin control state names. Should contain "default".
+ - pinctrl-0: should contain the pinctrl states described by pinctrl
+   default.
+ - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
+   bindings defined in pwm.txt in this directory.
+
+Example:
+	lcdc0: lcdc@700000 {
+		compatible = "atmel,at91sam9263-lcdc-mfd";
+		reg = <0x700000 0x1000>;
+		interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
+		clocks = <&lcd_clk>, <&lcd_clk>;
+		clock-names = "lcdc_clk", "hclk";
+
+		lcdc_pwm: lcdc-pwm {
+			compatible = "atmel,lcdc-pwm";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_lcdc_pwm>;
+			#pwm-cells = <3>;
+		};
+
+	};
-- 
2.12.0
