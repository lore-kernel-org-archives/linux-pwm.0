From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 2/2] dt-bindings: pwm: Convert imx tpm pwm to json-schema
Date: Thu, 14 May 2020 14:54:19 +0800
Message-ID: <1589439259-28510-2-git-send-email-Anson.Huang@nxp.com>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org

Convert the imx tpm pwm binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ---------
 .../devicetree/bindings/pwm/imx-tpm-pwm.yaml       | 55 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
deleted file mode 100644
index 5bf2095..0000000
--- a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Freescale i.MX TPM PWM controller
-
-Required properties:
-- compatible : Should be "fsl,imx7ulp-pwm".
-- reg: Physical base address and length of the controller's registers.
-- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of the cells format.
-- clocks : The clock provided by the SoC to drive the PWM.
-- interrupts: The interrupt for the PWM controller.
-
-Note: The TPM counter and period counter are shared between multiple channels, so all channels
-should use same period setting.
-
-Example:
-
-tpm4: pwm@40250000 {
-	compatible = "fsl,imx7ulp-pwm";
-	reg = <0x40250000 0x1000>;
-	assigned-clocks = <&pcc2 IMX7ULP_CLK_LPTPM4>;
-	assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
-	clocks = <&pcc2 IMX7ULP_CLK_LPTPM4>;
-	#pwm-cells = <3>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
new file mode 100644
index 0000000..fe9ef42
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/imx-tpm-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX TPM PWM controller
+
+maintainers:
+  - Anson Huang <anson.huang@nxp.com>
+
+description: |
+  The TPM counter and period counter are shared between multiple
+  channels, so all channels should use same period setting.
+
+properties:
+  "#pwm-cells":
+    const: 3
+
+  compatible:
+    enum:
+      - fsl,imx7ulp-pwm
+
+  reg:
+    maxItems: 1
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx7ulp-clock.h>
+
+    pwm@40250000 {
+        compatible = "fsl,imx7ulp-pwm";
+        reg = <0x40250000 0x1000>;
+        assigned-clocks = <&pcc2 IMX7ULP_CLK_LPTPM4>;
+        assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
+        clocks = <&pcc2 IMX7ULP_CLK_LPTPM4>;
+        #pwm-cells = <3>;
+    };
-- 
2.7.4
