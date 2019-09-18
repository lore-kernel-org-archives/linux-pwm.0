From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/8] dt-bindings: rng: exynos4-rng: Convert Exynos PRNG bindings to json-schema
Date: Wed, 18 Sep 2019 19:31:34 +0200
Message-ID: <20190918173141.4314-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Convert Samsung Exynos Pseudo Random Number Generator bindings to DT
schema format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Indent example with four spaces (more readable).
---
 .../bindings/rng/samsung,exynos4-rng.txt      | 19 ---------
 .../bindings/rng/samsung,exynos4-rng.yaml     | 41 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 42 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml

diff --git a/Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt b/Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
deleted file mode 100644
index a13fbdb4bd88..000000000000
--- a/Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Exynos Pseudo Random Number Generator
-
-Required properties:
-
-- compatible  : One of:
-                - "samsung,exynos4-rng" for Exynos4210 and Exynos4412
-                - "samsung,exynos5250-prng" for Exynos5250+
-- reg         : Specifies base physical address and size of the registers map.
-- clocks      : Phandle to clock-controller plus clock-specifier pair.
-- clock-names : "secss" as a clock name.
-
-Example:
-
-	rng@10830400 {
-		compatible = "samsung,exynos4-rng";
-		reg = <0x10830400 0x200>;
-		clocks = <&clock CLK_SSS>;
-		clock-names = "secss";
-	};
diff --git a/Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml b/Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml
new file mode 100644
index 000000000000..2d075d6c87b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/samsung,exynos4-rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Pseudo Random Number Generator
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4-rng                   # for Exynos4210 and Exynos4412
+      - samsung,exynos5250-prng               # for Exynos5250+
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: secss
+
+required:
+  - compatible
+  - reg
+  - clock-names
+  - clocks
+
+examples:
+  - |
+    rng@10830400 {
+        compatible = "samsung,exynos4-rng";
+        reg = <0x10830400 0x200>;
+        clocks = <&clock 255>; // CLK_SSS
+        clock-names = "secss";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 00969a90f94c..9cec4494b9a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14181,7 +14181,7 @@ L:	linux-crypto@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/exynos-rng.c
-F:	Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
+F:	Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml
 
 SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
 M:	Łukasz Stelmach <l.stelmach@samsung.com>
-- 
2.17.1
