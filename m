From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] dt-bindings: pwm: renesas-tpu: Correct SoC part numbers and family names
Date: Tue, 19 Dec 2017 17:02:07 +0100
Message-ID: <1513699327-27357-4-git-send-email-geert+renesas@glider.be>
References: <1513699327-27357-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513699327-27357-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pwm@vger.kernel.org

R8A73A4 (not R8A77A4) is R-Mobile APE6,
R8A7740 is R-Mobile (not R-Car) A1.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
index 641b5b4c648340ee..fb633129d845a893 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
@@ -3,7 +3,7 @@
 Required Properties:
 
   - compatible: should be one of the following.
-    - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PWM controller.
+    - "renesas,tpu-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible PWM controller.
     - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM controller.
     - "renesas,tpu-r8a7790": for R8A7790 (R-Car H2) compatible PWM controller.
     - "renesas,tpu": for generic R-Car TPU PWM controller.
@@ -18,7 +18,7 @@ Required Properties:
 Please refer to pwm.txt in this directory for details of the common PWM bindings
 used by client devices.
 
-Example: R8A7740 (R-Car A1) TPU controller node
+Example: R8A7740 (R-Mobile A1) TPU controller node
 
 	tpu: pwm@e6600000 {
 		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
-- 
2.7.4
