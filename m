From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH] dt-bindings: pwm: Convert Allwinner PWM to a schema
Date: Thu, 16 May 2019 14:08:48 +0200
Message-ID: <20190516120848.25007-1-maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, linux-pwm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The Allwinner SoCs have a PWM controller supported in Linux, with a
matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 57 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-sun4i.txt     | 24 --------
 2 files changed, 57 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
new file mode 100644
index 000000000000..0ac52f83a58c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/allwinner,sun4i-a10-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 PWM Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#pwm-cells":
+    const: 3
+
+  compatible:
+    oneOf:
+      - const: allwinner,sun4i-a10-pwm
+      - const: allwinner,sun5i-a10s-pwm
+      - const: allwinner,sun5i-a13-pwm
+      - const: allwinner,sun7i-a20-pwm
+      - const: allwinner,sun8i-h3-pwm
+      - items:
+          - const: allwinner,sun8i-a83t-pwm
+          - const: allwinner,sun8i-h3-pwm
+      - items:
+          - const: allwinner,sun50i-a64-pwm
+          - const: allwinner,sun5i-a13-pwm
+      - items:
+          - const: allwinner,sun50i-h5-pwm
+          - const: allwinner,sun5i-a13-pwm
+
+  reg:
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
+    pwm: pwm@1c20e00 {
+        compatible = "allwinner,sun7i-a20-pwm";
+        reg = <0x01c20e00 0xc>;
+        clocks = <&osc24M>;
+        #pwm-cells = <3>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
deleted file mode 100644
index 2a1affbff45e..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Allwinner sun4i and sun7i SoC PWM controller
-
-Required properties:
-  - compatible: should be one of:
-    - "allwinner,sun4i-a10-pwm"
-    - "allwinner,sun5i-a10s-pwm"
-    - "allwinner,sun5i-a13-pwm"
-    - "allwinner,sun7i-a20-pwm"
-    - "allwinner,sun8i-h3-pwm"
-    - "allwinner,sun50i-a64-pwm", "allwinner,sun5i-a13-pwm"
-    - "allwinner,sun50i-h5-pwm", "allwinner,sun5i-a13-pwm"
-  - reg: physical base address and length of the controller's registers
-  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
-    the cells format.
-  - clocks: From common clock binding, handle to the parent clock.
-
-Example:
-
-	pwm: pwm@1c20e00 {
-		compatible = "allwinner,sun7i-a20-pwm";
-		reg = <0x01c20e00 0xc>;
-		clocks = <&osc24M>;
-		#pwm-cells = <3>;
-	};
-- 
2.21.0
