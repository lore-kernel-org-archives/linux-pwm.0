From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v6 09/11] ARM: at91/dt: define the HLCDC node available on
 sama5d3 SoCs
Date: Mon, 29 Sep 2014 16:44:22 +0200
Message-ID: <1412001864-3251-10-git-send-email-boris.brezillon@free-electrons.com>
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

Define the HLCDC (HLCD Controller) IP available on some sama5d3 SoCs
(i.e. sama5d31, sama5d33, sama5d34 and sama5d36) in sama5d3 dtsi file.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
---
 arch/arm/boot/dts/sama5d3_lcd.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/sama5d3_lcd.dtsi
index e7581f6..1874cf7 100644
--- a/arch/arm/boot/dts/sama5d3_lcd.dtsi
+++ b/arch/arm/boot/dts/sama5d3_lcd.dtsi
@@ -166,6 +166,34 @@
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
+					compatible = "atmel,hlcdc-display-controller";
+					interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						reg = <0>;
+					};
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
1.9.1
