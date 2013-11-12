Return-Path: <Li.Xiubo@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv6 4/4] Documentation: Add device tree bindings for Freescale FTM PWM.
Date: Tue, 12 Nov 2013 09:36:58 +0800
Message-ID: <1384220218-12716-5-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Li.Xiubo@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: r65073@freescale.com, thierry.reding@gmail.com
Cc: s.hauer@pengutronix.de, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

This adds the Document for Freescale FTM PWM driver under
Documentation/devicetree/bindings/pwm/.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Kumar Gala <galak@codeaurora.org>
---
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
new file mode 100644
index 0000000..5c1cd2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -0,0 +1,29 @@
+Freescale FlexTimer Module(FTM) PWM controller
+
+Required properties:
+- compatible: Should be "fsl,vf610-ftm-pwm"
+- reg: Physical base address and length of the controller's registers
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+  the cells format.
+- clock-names : Should includes the following module clock source entries:
+    "ftm0" (module clock),
+    "ftm0_counter" (counter clock),
+- clocks : Must contain a clock specifier for each entry in clock-names,
+  See clock/clock-bindings.txt for details of the property values.
+- pinctrl-names: must contain a "default" entry.
+- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
+  See pinctrl/pinctrl-bindings.txt for details of the property values.
+
+
+Example:
+
+pwm0: pwm@40038000 {
+		compatible = "fsl,vf610-ftm-pwm";
+		reg = <0x40038000 0x1000>;
+		#pwm-cells = <3>;
+		clock-names = "ftm0", "ftm0_counter;
+		clocks = <&clks VF610_CLK_FTM0>,
+			<&clks VF610_CLK_FTM0_FIX_SEL>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pwm0_1>;
+};
-- 
1.8.4
