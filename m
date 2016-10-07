From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v3 6/6] arm: dts: imx7-colibri: Use enable-gpios for BL_ON
Date: Fri, 7 Oct 2016 20:41:29 +0530
Message-ID: <20161007151129.6043-7-bhuvanchandra.dv@toradex.com>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawnguo@kernel.org, thierry.reding@gmail.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Use pwm-backlight driver 'enable-gpios' property for backlight on/off control.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 2af5e3e..ce5edb5 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -43,7 +43,10 @@
 / {
 	bl: backlight {
 		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_bl_on>;
 		pwms = <&pwm1 0 5000000 0>;
+		enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_module_3v3: regulator-module-3v3 {
@@ -356,7 +359,6 @@
 		fsl,pins = <
 			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x14 /* SODIMM 65 */
 			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x14 /* SODIMM 69 */
-			MX7D_PAD_SD1_WP__GPIO5_IO1		0x14 /* SODIMM 71 */
 			MX7D_PAD_I2C4_SDA__GPIO4_IO15		0x14 /* SODIMM 75 */
 			MX7D_PAD_ECSPI1_MISO__GPIO4_IO18	0x14 /* SODIMM 79 */
 			MX7D_PAD_I2C3_SCL__GPIO4_IO12		0x14 /* SODIMM 81 */
@@ -388,6 +390,12 @@
 		>;
 	};
 
+		pinctrl_gpio_bl_on: gpio-bl-on {
+			fsl,pins = <
+				MX7D_PAD_SD1_WP__GPIO5_IO1		0x14
+			>;
+		};
+
 	pinctrl_i2c1_int: i2c1-int-grp { /* PMIC / TOUCH */
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x79
-- 
2.10.0
