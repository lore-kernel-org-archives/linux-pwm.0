From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v1 1/2] Add YAML schema for a new PWM driver
Date: Fri, 22 May 2020 15:41:58 +0800
Message-ID: <53333e2a30f123065a68a3a24042ead982393164.1590132733.git.rahul.tanwar@linux.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:12119 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgEVHmJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 22 May 2020 03:42:09 -0400
In-Reply-To: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@intel.com, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>

Add DT bindings YAML schema for PWM controller driver of
Lightning Mountain(LGM) SoC.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/pwm/pwm-intel-lgm.yaml     | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml b/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
new file mode 100644
index 000000000000..adb33265aa5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-intel-lgm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LGM SoC PWM controller
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
+  "#pwm-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - resets
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
