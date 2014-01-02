From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv8 4/4] Documentation: Add device tree bindings for Freescale FTM PWM.
Date: Thu, 2 Jan 2014 17:57:04 +0800
Message-ID: <1388656624-26570-5-git-send-email-Li.Xiubo@freescale.com>
References: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: thierry.reding@gmail.com, shawn.guo@linaro.org, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: linux-pwm@vger.kernel.org

This adds the binding documentation for Freescale FlexTimer Module
(FTM) PWM driver under Documentation/devicetree/bindings/pwm/.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Kumar Gala <galak@codeaurora.org>
---
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
new file mode 100644
index 0000000..6ae6377
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -0,0 +1,38 @@
+Freescale FlexTimer Module (FTM) PWM controller
+
+Required properties:
+- compatible: Should be "fsl,vf610-ftm-pwm".
+- reg: Physical base address and length of the controller's registers
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+  the cells format.
+- clock-names : Should include the following module clock source entries:
+    "ftm_sys" (module clock, also can be used as counter clock),
+    "ftm_ext" (external counter clock),
+    "ftm_fix" (fixed counter clock),
+    "ftm_cnt_clk_en" (external and fixed counter clock enable/disable).
+- clocks : Must contain a clock specifier for each entry in clock-names,
+  See clock/clock-bindings.txt for details of the property values.
+- pinctrl-names: Must contain a "default" entry.
+- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
+  See pinctrl/pinctrl-bindings.txt for details of the property values.
+- big-endian: If this property is absent, the little endian mode will be in
+  use as default, or the big endian mode will be in use for all the device
+  registers.
+
+
+Example:
+
+pwm0: pwm@40038000 {
+		compatible = "fsl,vf610-ftm-pwm";
+		reg = <0x40038000 0x1000>;
+		#pwm-cells = <3>;
+		clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+		clocks = <&clks VF610_CLK_FTM0>,
+			<&clks VF610_CLK_FTM0_EXT_SEL>,
+			<&clks VF610_CLK_FTM0_FIX_SEL>,
+			<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pwm0_1>;
+		big-endian;
+};
-- 
1.8.4


