From: vineetha.g.jaya.kumaran@intel.com
Subject: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
Date: Sun, 17 May 2020 21:52:40 +0800
Message-ID: <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63618 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgEQN4K (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 17 May 2020 09:56:10 -0400
In-Reply-To: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, robh+dt@kernel.org
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com, vineetha.g.jaya.kumaran@intel.com

From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>

Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.

Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
---
 .../devicetree/bindings/pwm/pwm-keembay.yaml       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-keembay.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
new file mode 100644
index 0000000..00968d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-keembay.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Keem Bay PWM Device Tree Bindings
+
+maintainers:
+  - Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - intel,keembay-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+        phandle to the reference clock.
+
+required:
+ - compatible
+ - reg
+ - clocks
+
+examples:
+  - |
+    pwm@203200a0 {
+      compatible = "intel,keembay-pwm";
+      reg = <0x0 0x203200a0 0x0 0xe8>;
+      clocks = <&scmi_clk KEEM_BAY_A53_GPIO>;
+    };
-- 
1.9.1
