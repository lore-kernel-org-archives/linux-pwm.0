From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH v3 4/5] dt-bindings: pwm: renesas-tpu: Document r8a774[35] support
Date: Tue, 19 Dec 2017 13:34:59 +0000
Message-ID: <1513690500-12165-5-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Document r8a774[35] specific compatible strings. No driver change is
needed as the fallback compatible string "renesas,tpu" activates the
right code in the driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
* No change

 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
index 1aadc80..16e5748 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
@@ -5,8 +5,10 @@ Required Properties:
   - compatible: should be one of the following.
     - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PWM controller.
     - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM controller.
+    - "renesas,tpu-r8a7743": for R8A7743 (RZ/G1M) compatible PWM controller.
+    - "renesas,tpu-r8a7745": for R8A7745 (RZ/G1E) compatible PWM controller.
     - "renesas,tpu-r8a7790": for R8A7790 (R-Car H2) compatible PWM controller.
-    - "renesas,tpu": for generic R-Car TPU PWM controller.
+    - "renesas,tpu": for generic R-Car and RZ/G1 TPU PWM controller.
 
   - reg: Base address and length of each memory resource used by the PWM
     controller hardware module.
-- 
2.7.4
