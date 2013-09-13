Return-Path: <B47053@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 4/4] Documentation: Add device tree bindings for Freescale FTM PWM.
Date: Fri, 13 Sep 2013 13:58:42 +0800
Message-ID: <1379051922-4930-5-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1379051922-4930-1-git-send-email-Li.Xiubo@freescale.com>
References: <1379051922-4930-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: r65073@freescale.com, thierry.reding@gmail.com
Cc: s.hauer@pengutronix.de, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

This adds the Document for Freescale FTM PWM driver under
Documentation/devicetree/bindings/pwm/.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
new file mode 100644
index 0000000..e736806
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -0,0 +1,36 @@
+Freescale FTM PWM controller
+
+Required properties:
+- compatible: Should be "fsl,vf610-ftm-pwm"
+- reg: Physical base address and length of the controller's registers
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+  the cells format.
+- clock-names : Includes the following module clock source entries:
+    "ftm0" (system clock),
+    "ftm0_fix_sel" (fixed frequency clock),
+    "ftm0_ext_sel" (external clock)
+- clocks : Must contain an entry list for entries in clock-names.
+- fsl,pwm-counter-clk: The FTM PWM counter clock source, should be one of the
+  entries in clock-names.
+- For each channel's pinctrl, the "chN-active" and "chN-idle" states should be
+  implemented at the same time.
+
+Example:
+
+pwm0: pwm@40038000 {
+		compatible = "fsl,vf610-ftm-pwm";
+		reg = <0x40038000 0x1000>;
+		#pwm-cells = <3>;
+		clock-names = "ftm0", "ftm0_fix_sel", "ftm0_ext_sel";
+		clocks = <&clks VF610_CLK_FTM0>,
+			<&clks VF610_CLK_FTM0_FIX_SEL>,
+			<&clks VF610_CLK_FTM0_EXT_SEL>;
+		pinctrl-names = "ch0-active", "ch0-idle", "ch1-active", "ch1-idle",
+		....;
+		pinctrl-0 = <&pinctrl_pwm0_ch0_active>;
+		pinctrl-1 = <&pinctrl_pwm0_ch0_idle>;
+		pinctrl-2 = <&pinctrl_pwm0_ch1_active>;
+		pinctrl-3 = <&pinctrl_pwm0_ch1_idle>;
+		...
+		fsl,pwm-counter-clk = "ftm0_ext_sel";
+};
-- 
1.8.0
