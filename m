From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/7] dt-bindings: pwm: allwinner: Add H6 PWM description
Date: Sun,  3 Nov 2019 21:33:28 +0100
Message-ID: <20191103203334.10539-2-peron.clem@gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191103203334.10539-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 PWM block is basically the same as A20 PWM, except that it also has
bus clock and reset line which needs to be handled accordingly.

Expand Allwinner PWM binding with H6 PWM specifics.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 0ac52f83a58c..bf36ea509f31 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -30,13 +30,46 @@ properties:
       - items:
           - const: allwinner,sun50i-h5-pwm
           - const: allwinner,sun5i-a13-pwm
+      - const: allwinner,sun50i-h6-pwm
 
   reg:
     maxItems: 1
 
-  clocks:
+  # Even though it only applies to subschemas under the conditionals,
+  # not listing them here will trigger a warning because of the
+  # additionalsProperties set to false.
+  clocks: true
+  clock-names: true
+  resets:
     maxItems: 1
 
+  if:
+    properties:
+      compatible:
+        contains:
+          const: allwinner,sun50i-h6-pwm
+
+  then:
+    properties:
+      clocks:
+        items:
+          - description: Module Clock
+          - description: Bus Clock
+
+      clock-names:
+        items:
+          - const: mod
+          - const: bus
+
+    required:
+      - clock-names
+      - resets
+
+  else:
+    properties:
+      clocks:
+        maxItems: 1
+
 required:
   - "#pwm-cells"
   - compatible
@@ -54,4 +87,14 @@ examples:
         #pwm-cells = <3>;
     };
 
+  - |
+    pwm@300a000 {
+      compatible = "allwinner,sun50i-h6-pwm";
+      reg = <0x0300a000 0x400>;
+      clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
+      clock-names = "mod", "bus";
+      resets = <&ccu RST_BUS_PWM>;
+      #pwm-cells = <3>;
+    };
+
 ...
-- 
2.20.1
