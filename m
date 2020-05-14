From: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Date: Thu, 14 May 2020 19:41:10 +0800
Message-ID: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linux-imx-3arQi8VN3Tc@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Convert the mxs pwm binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt  | 17 ---------
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 43 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
deleted file mode 100644
index a1b8a48..0000000
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Freescale MXS PWM controller
-
-Required properties:
-- compatible: should be "fsl,imx23-pwm"
-- reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
-  the cells format.
-- fsl,pwm-number: the number of PWM devices
-
-Example:
-
-pwm: pwm@80064000 {
-	compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
-	reg = <0x80064000 0x2000>;
-	#pwm-cells = <3>;
-	fsl,pwm-number = <8>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
new file mode 100644
index 0000000..da68f4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/mxs-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS PWM controller
+
+maintainers:
+  - Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+  - Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx23-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  fsl,pwm-number:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the number of PWM devices
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - fsl,pwm-number
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@80064000 {
+        compatible = "fsl,imx23-pwm";
+        reg = <0x80064000 0x2000>;
+        #pwm-cells = <3>;
+        fsl,pwm-number = <8>;
+    };
-- 
2.7.4
