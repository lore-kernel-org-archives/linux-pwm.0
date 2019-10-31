From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 3/4] dt-bindings: pwm: Convert stm32 pwm bindings to json-schema
Date: Thu, 31 Oct 2019 13:30:39 +0100
Message-ID: <20191031123040.26316-4-benjamin.gaignard@st.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191031123040.26316-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, benjamin.gaignard@st.com
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Convert the STM32 pwm binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ----------------
 .../devicetree/bindings/pwm/st,stm32-pwm.yaml      | 51 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/st,stm32-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
deleted file mode 100644
index a8690bfa5e1f..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-STMicroelectronics STM32 Timers PWM bindings
-
-Must be a sub-node of an STM32 Timers device tree node.
-See ../mfd/stm32-timers.txt for details about the parent node.
-
-Required parameters:
-- compatible:		Must be "st,stm32-pwm".
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
-			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
-- #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
-			bindings defined in pwm.txt.
-
-Optional parameters:
-- st,breakinput:	One or two <index level filter> to describe break input configurations.
-			"index" indicates on which break input (0 or 1) the configuration
-			should be applied.
-			"level" gives the active level (0=low or 1=high) of the input signal
-			for this configuration.
-			"filter" gives the filtering value to be applied.
-
-Example:
-	timers@40010000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "st,stm32-timers";
-		reg = <0x40010000 0x400>;
-		clocks = <&rcc 0 160>;
-		clock-names = "int";
-
-		pwm {
-			compatible = "st,stm32-pwm";
-			#pwm-cells = <3>;
-			pinctrl-0	= <&pwm1_pins>;
-			pinctrl-names	= "default";
-			st,breakinput = <0 1 5>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pwm/st,stm32-pwm.yaml b/Documentation/devicetree/bindings/pwm/st,stm32-pwm.yaml
new file mode 100644
index 000000000000..d3f8180edd88
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/st,stm32-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/st,stm32-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Timers PWM bindings
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+properties:
+  pwn:
+    type: object
+
+    description:
+      must be a sub-node of an STM32 Timer device tree node
+
+    properties:
+      compatible:
+        const: st,stm32-pwm
+
+      "#pwm-cells":
+        const: 3
+      
+      st,breakinput:
+        description: |
+          One or two <index level filter> to describe break input configurations.
+          "index" indicates on which break input (0 or 1) the configuration should be applied.
+          "level" gives the active level (0=low or 1=high) of the input signal for this configuration.
+          "filter" gives the filtering value (up to 15) to be applied.
+   
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+          - minItems: 3
+          - maxItems: 3
+
+    required:
+      - "#pwm-cells"
+      - compatible
+
+examples:
+  - |
+    pwm {
+      compatible = "st,stm32-pwm";
+      #pwm-cells = <3>;
+      st,breakinput = <0 1 5>;
+    };
+
+...
-- 
2.15.0
