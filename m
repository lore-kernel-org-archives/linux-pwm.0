Return-Path: <B47053@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 2/4] ARM: dts: Add Freescale FTM PWM node for VF610.
Date: Fri, 13 Sep 2013 13:58:40 +0800
Message-ID: <1379051922-4930-3-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1379051922-4930-1-git-send-email-Li.Xiubo@freescale.com>
References: <1379051922-4930-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: r65073@freescale.com, thierry.reding@gmail.com
Cc: s.hauer@pengutronix.de, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

This adds devicetree node for VF610, and there are 8 channels supported
by default.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 83 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 67d929c..9b200ef 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -140,6 +140,17 @@
 				clock-names = "pit";
 			};
 
+			pwm0: pwm@40038000 {
+				compatible = "fsl,vf610-ftm-pwm";
+				#pwm-cells = <3>;
+				reg = <0x40038000 0x1000>;
+				clock-names = "ftm0", "ftm0_fix_sel", "ftm0_ext_sel";
+				clocks = <&clks VF610_CLK_FTM0>,
+					<&clks VF610_CLK_FTM0_FIX_SEL>,
+					<&clks VF610_CLK_FTM0_EXT_SEL>;
+				status = "disabled";
+			};
+
 			wdog@4003e000 {
 				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
@@ -270,16 +281,86 @@
 				};
 
 				pwm0 {
-					pinctrl_pwm0_1: pwm0grp_1 {
+					pinctrl_pwm0_ch0_active: pwm0grp_ch0_active {
 						fsl,pins = <
 						VF610_PAD_PTB0__FTM0_CH0	0x1582
+						>;
+					};
+					pinctrl_pwm0_ch0_idle: pwm0grp_ch0_idle {
+						fsl,pins = <
+						VF610_PAD_PTB0__FTM0_CH0	0x0000
+						>;
+					};
+					pinctrl_pwm0_ch1_active: pwm0grp_ch1_active {
+						fsl,pins = <
 						VF610_PAD_PTB1__FTM0_CH1	0x1582
+						>;
+					};
+					pinctrl_pwm0_ch1_idle: pwm0grp_ch1_idle {
+						fsl,pins = <
+						VF610_PAD_PTB1__FTM0_CH1	0x0000
+						>;
+					};
+					pinctrl_pwm0_ch2_active: pwm0grp_ch2_active {
+						fsl,pins = <
 						VF610_PAD_PTB2__FTM0_CH2	0x1582
+						>;
+					};
+					pinctrl_pwm0_ch2_idle: pwm0grp_ch2_idle {
+						fsl,pins = <
+						VF610_PAD_PTB2__FTM0_CH2	0x0000
+						>;
+					};
+					pinctrl_pwm0_ch3_active: pwm0grp_ch3_active {
+						fsl,pins = <
 						VF610_PAD_PTB3__FTM0_CH3	0x1582
+						>;
+					};
+					pinctrl_pwm0_ch3_idle: pwm0grp_ch3_idle {
+						fsl,pins = <
+						VF610_PAD_PTB3__FTM0_CH3	0x0000
+						>;
+					};
+					pinctrl_pwm0_ch4_active: pwm0grp_ch4_active {
+						fsl,pins = <
+						VF610_PAD_PTB4__FTM0_CH4	0x1582
+						>;
+					};
+					pinctrl_pwm0_ch4_idle: pwm0grp_ch4_idle {
+						fsl,pins = <
+						VF610_PAD_PTB4__FTM0_CH4	0x0000
+						>;
+					};
+					pinctrl_pwm0_ch5_active: pwm0grp_ch5_active {
+						fsl,pins = <
+						VF610_PAD_PTB5__FTM0_CH5	0x1582
+						>;
+					};
+					pinctrl_pwm0_ch5_idle: pwm0grp_ch5_idle {
+						fsl,pins = <
+						VF610_PAD_PTB5__FTM0_CH5	0x0000
+						>;
+					};
+					pinctrl_pwm0_ch6_active: pwm0grp_ch6_active {
+						fsl,pins = <
 						VF610_PAD_PTB6__FTM0_CH6	0x1582
+						>;
+					};
+					pinctrl_pwm0_ch6_idle: pwm0grp_ch6_idle {
+						fsl,pins = <
+						VF610_PAD_PTB6__FTM0_CH6	0x0000
+						>;
+					};
+					pinctrl_pwm0_ch7_active: pwm0grp_ch7_active {
+						fsl,pins = <
 						VF610_PAD_PTB7__FTM0_CH7	0x1582
 						>;
 					};
+					pinctrl_pwm0_ch7_idle: pwm0grp_ch7_idle {
+						fsl,pins = <
+						VF610_PAD_PTB7__FTM0_CH7	0x0000
+						>;
+					};
 				};
 
 				qspi0 {
-- 
1.8.0
