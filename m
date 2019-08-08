From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
Date: Thu,  8 Aug 2019 16:59:38 +0800
Message-ID: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add Spreadtrum PWM controller documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
new file mode 100644
index 0000000..e8e0d5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
@@ -0,0 +1,31 @@
+Spreadtrum PWM controller
+
+Spreadtrum SoCs PWM controller provides 4 PWM channels.
+
+Required porperties:
+- compatible : Should be "sprd,ums512-pwm".
+- reg: Physical base address and length of the controller's registers.
+- clocks: The phandle and specifier referencing the controller's clocks.
+- clock-names: Should contain following entries:
+  "source": for PWM source (parent) clock.
+  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
+  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
+- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+	pwms: pwm@32260000 {
+		compatible = "sprd,ums512-pwm";
+		reg = <0 0x32260000 0 0x10000>;
+		clock-names = "source",
+			"pwm0", "enable0",
+			"pwm1", "enable1",
+			"pwm2", "enable2",
+			"pwm3", "enable3";
+		clocks = <&ext_26m>,
+		       <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
+		       <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
+		       <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
+		       <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
+		#pwm-cells = <2>;
+	};
-- 
1.7.9.5
