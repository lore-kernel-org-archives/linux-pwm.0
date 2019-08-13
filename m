From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
Date: Tue, 13 Aug 2019 21:46:40 +0800
Message-ID: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: u.kleine-koenig@pengutronix.de, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add Spreadtrum PWM controller documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Use assigned-clock-parents and assigned-clocks to set PWM clock parent.
---
 Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
new file mode 100644
index 0000000..e6cf312
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
@@ -0,0 +1,38 @@
+Spreadtrum PWM controller
+
+Spreadtrum SoCs PWM controller provides 4 PWM channels.
+
+Required porperties:
+- compatible : Should be "sprd,ums512-pwm".
+- reg: Physical base address and length of the controller's registers.
+- clocks: The phandle and specifier referencing the controller's clocks.
+- clock-names: Should contain following entries:
+  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
+  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
+- assigned-clocks: Reference to the PWM clock entroes.
+- assigned-clock-parents: The phandle of the parent clock of PWM clock.
+- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+	pwms: pwm@32260000 {
+		compatible = "sprd,ums512-pwm";
+		reg = <0 0x32260000 0 0x10000>;
+		clock-names = "pwm0", "enable0",
+			"pwm1", "enable1",
+			"pwm2", "enable2",
+			"pwm3", "enable3";
+		clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
+		       <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
+		       <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
+		       <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
+		assigned-clocks = <&aon_clk CLK_PWM0>,
+			<&aon_clk CLK_PWM1>,
+			<&aon_clk CLK_PWM2>,
+			<&aon_clk CLK_PWM3>;
+		assigned-clock-parents = <&ext_26m>,
+			<&ext_26m>,
+			<&ext_26m>,
+			<&ext_26m>;
+		#pwm-cells = <2>;
+	};
-- 
1.7.9.5
