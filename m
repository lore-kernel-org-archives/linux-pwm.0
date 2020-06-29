From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 1/2] Add DT bindings YAML schema for PWM fan controller of LGM SoC
Date: Mon, 29 Jun 2020 17:03:46 +0800
Message-ID: <cd0692812e7f1bce365a7594b076ae0ed19d2b37.1593420979.git.rahul.tanwar@linux.intel.com>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, p.zabel@pengutronix.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@intel.com, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
which is only used to control the fan attached to the system. This
PWM controller does not have any other consumer other than fan.
Add DT bindings documentation for this PWM fan controller.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
new file mode 100644
index 000000000000..bc3fbc46ec5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/intel,lgm-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LGM SoC PWM fan controller
+
+maintainers:
+  - Rahul Tanwar <rahul.tanwar@intel.com>
+
+properties:
+  compatible:
+    const: intel,lgm-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  intel,fan-wire:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: Specifies fan mode. Default when unspecified is 2.
+
+  intel,max-rpm:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description:
+      Specifies maximum RPM of fan attached to the system.
+      Default when unspecified is 4000.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: pwm@e0d00000 {
+        compatible = "intel,lgm-pwm";
+        reg = <0xe0d00000 0x30>;
+        #pwm-cells = <2>;
+        clocks = <&cgu0 126>;
+        resets = <&rcu0 0x30 21>;
+    };
-- 
2.11.0
