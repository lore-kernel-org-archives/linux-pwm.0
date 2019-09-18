From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/8] dt-bindings: sram: Convert Samsung Exynos SYSRAM bindings to json-schema
Date: Wed, 18 Sep 2019 19:31:36 +0200
Message-ID: <20190918173141.4314-3-krzk@kernel.org>
References: <20190918173141.4314-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190918173141.4314-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Convert Samsung Exynos SYSRAM bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

TODO:
The node naming should be probably fixed (sysram->sram)

Changes since v1:
1. Indent example with four spaces (more readable).
---
 .../devicetree/bindings/sram/samsung-sram.txt | 38 ------------
 .../bindings/sram/samsung-sram.yaml           | 58 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 59 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/samsung-sram.txt
 create mode 100644 Documentation/devicetree/bindings/sram/samsung-sram.yaml

diff --git a/Documentation/devicetree/bindings/sram/samsung-sram.txt b/Documentation/devicetree/bindings/sram/samsung-sram.txt
deleted file mode 100644
index 61a9bbed303d..000000000000
--- a/Documentation/devicetree/bindings/sram/samsung-sram.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Samsung Exynos SYSRAM for SMP bringup:
-------------------------------------
-
-Samsung SMP-capable Exynos SoCs use part of the SYSRAM for the bringup
-of the secondary cores. Once the core gets powered up it executes the
-code that is residing at some specific location of the SYSRAM.
-
-Therefore reserved section sub-nodes have to be added to the mmio-sram
-declaration. These nodes are of two types depending upon secure or
-non-secure execution environment.
-
-Required sub-node properties:
-- compatible : depending upon boot mode, should be
-		"samsung,exynos4210-sysram" : for Secure SYSRAM
-		"samsung,exynos4210-sysram-ns" : for Non-secure SYSRAM
-
-The rest of the properties should follow the generic mmio-sram discription
-found in Documentation/devicetree/bindings/sram/sram.txt
-
-Example:
-
-	sysram@2020000 {
-		compatible = "mmio-sram";
-		reg = <0x02020000 0x54000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x02020000 0x54000>;
-
-		smp-sysram@0 {
-			compatible = "samsung,exynos4210-sysram";
-			reg = <0x0 0x1000>;
-		};
-
-		smp-sysram@53000 {
-			compatible = "samsung,exynos4210-sysram-ns";
-			reg = <0x53000 0x1000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sram/samsung-sram.yaml b/Documentation/devicetree/bindings/sram/samsung-sram.yaml
new file mode 100644
index 000000000000..f49b3b58eb5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/samsung-sram.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sram/samsung-sram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC SYSRAM for SMP bringup
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |+
+  Samsung SMP-capable Exynos SoCs use part of the SYSRAM for the bringup
+  of the secondary cores. Once the core gets powered up it executes the
+  code that is residing at some specific location of the SYSRAM.
+
+  Therefore reserved section sub-nodes have to be added to the mmio-sram
+  declaration. These nodes are of two types depending upon secure or
+  non-secure execution environment.
+
+allOf:
+  - $ref: "sram.yaml#"
+
+properties:
+  $nodename:
+    pattern: "^sysram(@.*)?"
+
+patternProperties:
+  "^([a-z]*-)?sysram@[a-f0-9]$":
+    type: object
+
+    properties:
+      compatible:
+        description:
+          Depending upon boot mode
+        enum:
+          - samsung,exynos4210-sysram                 # for Secure SYSRAM
+          - samsung,exynos4210-sysram-ns              # for Non-secure SYSRAM
+
+examples:
+  - |
+    sysram@2020000 {
+        compatible = "mmio-sram";
+        reg = <0x02020000 0x54000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x02020000 0x54000>;
+
+        smp-sysram@0 {
+            compatible = "samsung,exynos4210-sysram";
+            reg = <0x0 0x1000>;
+        };
+
+        smp-sysram@53000 {
+            compatible = "samsung,exynos4210-sysram-ns";
+            reg = <0x53000 0x1000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9cec4494b9a8..c49d35dce088 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2225,7 +2225,7 @@ F:	drivers/soc/samsung/
 F:	include/linux/soc/samsung/
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
-F:	Documentation/devicetree/bindings/sram/samsung-sram.txt
+F:	Documentation/devicetree/bindings/sram/samsung-sram.yaml
 F:	Documentation/devicetree/bindings/power/pd-samsung.txt
 N:	exynos
 
-- 
2.17.1
