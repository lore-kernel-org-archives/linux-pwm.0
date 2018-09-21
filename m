Return-Path: <sergei.shtylyov@cogentembedded.com>
Return-Path: <sergei.shtylyov@cogentembedded.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] dt-bindings: pwm: renesas: tpu: fix "compatible" prop
 description
Message-ID: <2aaa98bd-475c-08dd-ee34-d41fb960952e@cogentembedded.com>
Date: Fri, 21 Sep 2018 23:45:24 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org

The "compatible" property description contradicts even the example given:
it only says that there must be a single value while the example has the
fallback value too -- which makes much more sense. Moreover, the generic
property value is misdocumented as being R-Car (and RZ/G1) specific...

Fixes: 382457e562bb ("pwm: renesas-tpu: Add DT support")
Fixes: 3ba111a01822 ("dt-bindings: pwm: renesas-tpu: Document r8a774[35] support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against Linus' repo -- the 'fixes' branch in Thierry Reding's
repo is very outdated...

 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
===================================================================
--- linux.orig/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
+++ linux/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
@@ -2,13 +2,14 @@
 
 Required Properties:
 
-  - compatible: should be one of the following.
+  - compatible: must contain one or more of the following:
     - "renesas,tpu-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible PWM controller.
     - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM controller.
     - "renesas,tpu-r8a7743": for R8A7743 (RZ/G1M) compatible PWM controller.
     - "renesas,tpu-r8a7745": for R8A7745 (RZ/G1E) compatible PWM controller.
     - "renesas,tpu-r8a7790": for R8A7790 (R-Car H2) compatible PWM controller.
-    - "renesas,tpu": for generic R-Car and RZ/G1 TPU PWM controller.
+    - "renesas,tpu": for the generic TPU PWM controller; this is a fallback for
+		     the above .
 
   - reg: Base address and length of each memory resource used by the PWM
     controller hardware module.
