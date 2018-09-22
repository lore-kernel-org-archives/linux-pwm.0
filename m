Return-Path: <sergei.shtylyov@cogentembedded.com>
Return-Path: <sergei.shtylyov@cogentembedded.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] dt-bindings: pwm: renesas: tpu: document R8A779{7|8}0
 bindings
Message-ID: <ea104bc7-ee9a-b638-36da-6c6af1e622be@cogentembedded.com>
Date: Sat, 22 Sep 2018 22:57:29 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org

Document the R-Car V3{M|H} (R8A779{7|8}0) SoC in the Renesas TPU bindings;
the TPU hardware in those is the Renesas standard 4-channel timer pulse
unit.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against Linus' repo plus the bindings fix just reposted...

 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
===================================================================
--- linux.orig/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
+++ linux/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
@@ -8,6 +8,10 @@ Required Properties:
     - "renesas,tpu-r8a7743": for R8A7743 (RZ/G1M) compatible PWM controller.
     - "renesas,tpu-r8a7745": for R8A7745 (RZ/G1E) compatible PWM controller.
     - "renesas,tpu-r8a7790": for R8A7790 (R-Car H2) compatible PWM controller.
+    - "renesas,tpu-r8a77970": for R8A77970 (R-Car V3M) compatible PWM
+			      controller.
+    - "renesas,tpu-r8a77980": for R8A77980 (R-Car V3H) compatible PWM
+			      controller.
     - "renesas,tpu": for the generic TPU PWM controller; this is a fallback for
 		     the entries listed above.
 
