From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv9 Resend 2/4] ARM: dts: vf610: Add Freescale FTM PWM node.
Date: Wed, 19 Feb 2014 16:38:55 +0800
Message-ID: <1392799137-17188-3-git-send-email-Li.Xiubo@freescale.com>
References: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: linux-pwm@vger.kernel.org

This adds devicetree node for VF610, and there are 8 channels
supported.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Yuan Yao <yao.yuan@freescale.com>
---
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
