From: Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH 1/6] dt-bindings: pwm: allwinner: Add H6 PWM description
Date: Fri, 26 Jul 2019 20:40:40 +0200
Message-ID: <20190726184045.14669-2-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726184045.14669-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

H6 PWM block is basically the same as A20 PWM, except that it also has
bus clock and reset line which needs to be handled accordingly.

Expand Allwinner PWM binding with H6 PWM specifics.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pw=
m.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.ya=
ml
index 0ac52f83a58c..deca5d81802f 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -30,13 +30,47 @@ properties:
       - items:
           - const: allwinner,sun50i-h5-pwm
           - const: allwinner,sun5i-a13-pwm
+      - const: allwinner,sun50i-h6-pwm
=20
   reg:
     maxItems: 1
=20
-  clocks:
+  # Even though it only applies to subschemas under the conditionals,
+  # not listing them here will trigger a warning because of the
+  # additionalsProperties set to false.
+  clocks: true
+  clock-names: true
+  resets:
     maxItems: 1
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h6-pwm
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Module Clock
+            - description: Bus Clock
+
+        clock-names:
+          items:
+            - const: pwm
+            - const: bus
+
+      required:
+        - clock-names
+        - resets
+
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+
 required:
   - "#pwm-cells"
   - compatible
--=20
2.22.0
