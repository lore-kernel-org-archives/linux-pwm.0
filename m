From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv9 2/4] ARM: dts: Add Freescale FTM PWM node for VF610.
Date: Tue, 7 Jan 2014 16:13:57 +0800
Message-ID: <1389082438-2199-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shawn.guo@linaro.org, thierry.reding@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: linux-pwm@vger.kernel.org

This adds devicetree node for VF610, and there are 8 channels
supported.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---

No changes since v7.


 arch/arm/boot/dts/vf610.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index d31ce1b..6cce861 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -152,6 +152,19 @@
 				clock-names = "pit";
 			};
 
+			pwm0: pwm@40038000 {
+				compatible = "fsl,vf610-ftm-pwm";
+				#pwm-cells = <3>;
+				reg = <0x40038000 0x1000>;
+				clock-names = "ftm_sys", "ftm_ext",
+					      "ftm_fix", "ftm_cnt_clk_en";
+				clocks = <&clks VF610_CLK_FTM0>,
+					<&clks VF610_CLK_FTM0_EXT_SEL>,
+					<&clks VF610_CLK_FTM0_FIX_SEL>,
+					<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
+				status = "disabled";
+			};
+
 			wdog@4003e000 {
 				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
-- 
1.8.4
