From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] dt-bindings: mfd: Convert stm32 low power timers bindings to json-schema
Date: Fri, 15 Nov 2019 13:27:00 +0100
Message-ID: <20191115122700.12688-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: fabrice.gasnier@st.com, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org

Convert the STM32 low power timers binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/counter/stm32-lptimer-cnt.txt         |  29 -----
 .../bindings/iio/timer/stm32-lptimer-trigger.txt   |  23 ----
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  | 117 +++++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-lptimer.txt      |  48 ---------
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  30 ------
 5 files changed, 117 insertions(+), 130 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt

diff --git a/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
deleted file mode 100644
index e90bc47f752a..000000000000
--- a/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-STMicroelectronics STM32 Low-Power Timer quadrature encoder and counter
-
-STM32 Low-Power Timer provides several counter modes. It can be used as:
-- quadrature encoder to detect angular position and direction of rotary
-  elements, from IN1 and IN2 input signals.
-- simple counter from IN1 input signal.
-
-Must be a sub-node of an STM32 Low-Power Timer device tree node.
-See ../mfd/stm32-lptimer.txt for details about the parent node.
-
-Required properties:
-- compatible:		Must be "st,stm32-lptimer-counter".
-- pinctrl-names: 	Set to "default". An additional "sleep" state can be
-			defined to set pins in sleep state.
-- pinctrl-n: 		List of phandles pointing to pin configuration nodes,
-			to set IN1/IN2 pins in mode of operation for Low-Power
-			Timer input on external pin.
-
-Example:
-	timer@40002400 {
-		compatible = "st,stm32-lptimer";
-		...
-		counter {
-			compatible = "st,stm32-lptimer-counter";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&lptim1_in_pins>;
-			pinctrl-1 = <&lptim1_sleep_in_pins>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
deleted file mode 100644
index 85e6806b17d7..000000000000
--- a/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-STMicroelectronics STM32 Low-Power Timer Trigger
-
-STM32 Low-Power Timer provides trigger source (LPTIM output) that can be used
-by STM32 internal ADC and/or DAC.
-
-Must be a sub-node of an STM32 Low-Power Timer device tree node.
-See ../mfd/stm32-lptimer.txt for details about the parent node.
-
-Required properties:
-- compatible:		Must be "st,stm32-lptimer-trigger".
-- reg:			Identify trigger hardware block. Must be 0, 1 or 2
-			respectively for lptimer1, lptimer2 or lptimer3
-			trigger output.
-
-Example:
-	timer@40002400 {
-		compatible = "st,stm32-lptimer";
-		...
-		trigger@0 {
-			compatible = "st,stm32-lptimer-trigger";
-			reg = <0>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
new file mode 100644
index 000000000000..8f42c9a4c6cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/st,stm32-lptimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Low-Power Timers bindings
+
+description: |
+  The STM32 Low-Power Timer (LPTIM) is a 16-bit timer that provides several
+  functions
+   - PWM output (with programmable prescaler, configurable polarity)
+   - Quadrature encoder, counter
+   - Trigger source for STM32 ADC/DAC (LPTIM_OUT)
+
+maintainers:
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+properties:
+  compatible:
+    const: st,stm32-lptimer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mux
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  pwm:
+    type: object
+
+    properties:
+      compatible:
+        const: st,stm32-pwm-lp
+
+      "#pwm-cells":
+        const: 3
+
+    required:
+      - "#pwm-cells"
+      - compatible
+
+patternProperties:
+  "^trigger@[0-9]+$":
+    type: object
+
+    properties:
+      compatible:
+        const: st,stm32-lptimer-trigger
+
+      reg:
+        description: Identify trigger hardware block.
+        items:
+         minimum: 0
+         maximum: 3
+
+    required:
+      - compatible
+      - reg
+
+  counter:
+    type: object
+
+    properties:
+      compatible:
+        const: st,stm32-lptimer-counter
+
+    required:
+      - compatible
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    timer@40002400 {
+      compatible = "st,stm32-lptimer";
+      reg = <0x40002400 0x400>;
+      clocks = <&timer_clk>;
+      clock-names = "mux";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pwm {
+        compatible = "st,stm32-pwm-lp";
+        #pwm-cells = <3>;
+      };
+
+      trigger@0 {
+        compatible = "st,stm32-lptimer-trigger";
+        reg = <0>;
+      };
+
+      counter {
+        compatible = "st,stm32-lptimer-counter";
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
deleted file mode 100644
index fb54e4dad5b3..000000000000
--- a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-STMicroelectronics STM32 Low-Power Timer
-
-The STM32 Low-Power Timer (LPTIM) is a 16-bit timer that provides several
-functions:
-- PWM output (with programmable prescaler, configurable polarity)
-- Quadrature encoder, counter
-- Trigger source for STM32 ADC/DAC (LPTIM_OUT)
-
-Required properties:
-- compatible:		Must be "st,stm32-lptimer".
-- reg:			Offset and length of the device's register set.
-- clocks:		Phandle to the clock used by the LP Timer module.
-- clock-names:		Must be "mux".
-- #address-cells:	Should be '<1>'.
-- #size-cells:		Should be '<0>'.
-
-Optional subnodes:
-- pwm:			See ../pwm/pwm-stm32-lp.txt
-- counter:		See ../counter/stm32-lptimer-cnt.txt
-- trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
-
-Example:
-
-	timer@40002400 {
-		compatible = "st,stm32-lptimer";
-		reg = <0x40002400 0x400>;
-		clocks = <&timer_clk>;
-		clock-names = "mux";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pwm {
-			compatible = "st,stm32-pwm-lp";
-			pinctrl-names = "default";
-			pinctrl-0 = <&lppwm1_pins>;
-		};
-
-		trigger@0 {
-			compatible = "st,stm32-lptimer-trigger";
-			reg = <0>;
-		};
-
-		counter {
-			compatible = "st,stm32-lptimer-counter";
-			pinctrl-names = "default";
-			pinctrl-0 = <&lptim1_in_pins>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
deleted file mode 100644
index 6521bc44a74e..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-STMicroelectronics STM32 Low-Power Timer PWM
-
-STM32 Low-Power Timer provides single channel PWM.
-
-Must be a sub-node of an STM32 Low-Power Timer device tree node.
-See ../mfd/stm32-lptimer.txt for details about the parent node.
-
-Required parameters:
-- compatible:		Must be "st,stm32-pwm-lp".
-- #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
-			bindings defined in pwm.txt.
-
-Optional properties:
-- pinctrl-names: 	Set to "default". An additional "sleep" state can be
-			defined to set pins in sleep state when in low power.
-- pinctrl-n: 		Phandle(s) pointing to pin configuration node for PWM,
-			respectively for "default" and "sleep" states.
-
-Example:
-	timer@40002400 {
-		compatible = "st,stm32-lptimer";
-		...
-		pwm {
-			compatible = "st,stm32-pwm-lp";
-			#pwm-cells = <3>;
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&lppwm1_pins>;
-			pinctrl-1 = <&lppwm1_sleep_pins>;
-		};
-	};
-- 
2.15.0
