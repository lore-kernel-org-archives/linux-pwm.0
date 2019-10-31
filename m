From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 4/4] dt-bindings: mfd: Convert stm32 timers bindings to json-schema
Date: Thu, 31 Oct 2019 13:30:40 +0100
Message-ID: <20191031123040.26316-5-benjamin.gaignard@st.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191031123040.26316-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, benjamin.gaignard@st.com
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Convert the STM32 timers binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 91 ++++++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-timers.txt       | 73 -----------------
 2 files changed, 91 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
new file mode 100644
index 000000000000..3f0a65fb2bc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/st,stm32-timers.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Timers bindings
+
+description: |
+  This hardware block provides 3 types of timer along with PWM functionality: \
+    - advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable \
+      prescaler, break input feature, PWM outputs and complementary PWM ouputs channels. \
+    - general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a \
+      programmable prescaler and PWM outputs.\
+    - basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+allOf:
+  - $ref: "../pwm/st,stm32-pwm.yaml#"
+  - $ref: "../iio/timer/st,stm32-timer-trigger.yaml#"
+  - $ref: "../counter/st,stm32-timer-cnt.yaml#"
+
+properties:
+  compatible:
+    const: st,stm32-timers
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: int
+
+  reset:
+    maxItems: 1
+
+  dmas: true
+
+  dma-names: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    timers2: timer@40000000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "st,stm32-timers";
+      reg = <0x40000000 0x400>;
+      clocks = <&rcc TIM2_K>;
+      clock-names = "int";
+      dmas = <&dmamux1 18 0x400 0x1>,
+             <&dmamux1 19 0x400 0x1>,
+             <&dmamux1 20 0x400 0x1>,
+             <&dmamux1 21 0x400 0x1>,
+             <&dmamux1 22 0x400 0x1>;
+      dma-names = "ch1", "ch2", "ch3", "ch4", "up";
+      pwm {
+        compatible = "st,stm32-pwm";
+        #pwm-cells = <3>;
+        st,breakinput = <0 1 5>;
+      };
+      timer@0 {
+        compatible = "st,stm32-timer-trigger";
+        reg = <0>;
+      };
+      counter {
+        compatible = "st,stm32-timer-counter";
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
deleted file mode 100644
index 15c3b87f51d9..000000000000
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-STM32 Timers driver bindings
-
-This IP provides 3 types of timer along with PWM functionality:
-- advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
-  prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
-- general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
-  programmable prescaler and PWM outputs.
-- basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
-
-Required parameters:
-- compatible: must be "st,stm32-timers"
-
-- reg:			Physical base address and length of the controller's
-			registers.
-- clock-names:		Set to "int".
-- clocks: 		Phandle to the clock used by the timer module.
-			For Clk properties, please refer to ../clock/clock-bindings.txt
-
-Optional parameters:
-- resets:		Phandle to the parent reset controller.
-			See ../reset/st,stm32-rcc.txt
-- dmas:			List of phandle to dma channels that can be used for
-			this timer instance. There may be up to 7 dma channels.
-- dma-names:		List of dma names. Must match 'dmas' property. Valid
-			names are: "ch1", "ch2", "ch3", "ch4", "up", "trig",
-			"com".
-
-Optional subnodes:
-- pwm:			See ../pwm/pwm-stm32.txt
-- timer:		See ../iio/timer/stm32-timer-trigger.txt
-- counter:		See ../counter/stm32-timer-cnt.txt
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
-			pinctrl-0	= <&pwm1_pins>;
-			pinctrl-names	= "default";
-		};
-
-		timer@0 {
-			compatible = "st,stm32-timer-trigger";
-			reg = <0>;
-		};
-
-		counter {
-			compatible = "st,stm32-timer-counter";
-			pinctrl-names = "default";
-			pinctrl-0 = <&tim1_in_pins>;
-		};
-	};
-
-Example with all dmas:
-	timer@40010000 {
-		...
-		dmas = <&dmamux1 11 0x400 0x0>,
-		       <&dmamux1 12 0x400 0x0>,
-		       <&dmamux1 13 0x400 0x0>,
-		       <&dmamux1 14 0x400 0x0>,
-		       <&dmamux1 15 0x400 0x0>,
-		       <&dmamux1 16 0x400 0x0>,
-		       <&dmamux1 17 0x400 0x0>;
-		dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig", "com";
-		...
-		child nodes...
-	};
-- 
2.15.0
