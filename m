From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 5/7] ARM: at91/dt: define the HLCDC node available on
 sama5d3 SoCs
Date: Mon,  9 Jun 2014 18:04:18 +0200
Message-ID: <1402329860-27520-6-git-send-email-boris.brezillon@free-electrons.com>
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

Define the HLCDC (High LCD Controller) IP available on some sama5d3 SoCs
(i.e. sama5d31, sama5d33, sama5d34 and sama5d36).

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3_lcd.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/sama5d3_lcd.dtsi
index 2186b89..02a7012 100644
--- a/arch/arm/boot/dts/sama5d3_lcd.dtsi
+++ b/arch/arm/boot/dts/sama5d3_lcd.dtsi
@@ -116,6 +116,32 @@
 				};
 			};
 
+			hlcdc: hlcdc@f0030000 {
+				compatible = "atmel,sama5d3-hlcdc";
+				reg = <0xf0030000 0x2000>;
+				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clock-names = "periph_clk","sys_clk", "slow_clk";
+				status = "disabled";
+
+				hlcdc-display-controller {
+					compatible = "atmel,hlcdc-dc";
+					interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+					pinctrl-names = "default", "rgb-444", "rgb-565", "rgb-666", "rgb-888";
+					pinctrl-0 = <&pinctrl_lcd_base>;
+					pinctrl-1 = <&pinctrl_lcd_base &pinctrl_lcd_rgb444>;
+					pinctrl-2 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
+					pinctrl-3 = <&pinctrl_lcd_base &pinctrl_lcd_rgb666>;
+					pinctrl-4 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
+				};
+
+				hlcdc_pwm: hlcdc-pwm {
+					compatible = "atmel,hlcdc-pwm";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_lcd_pwm>;
+					#pwm-cells = <3>;
+				};
+			};
+
 			pmc: pmc@fffffc00 {
 				periphck {
 					lcdc_clk: lcdc_clk {
-- 
1.8.3.2
