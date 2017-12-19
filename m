From: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Subject: [PATCH v3 2/5] dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings
Date: Tue, 19 Dec 2017 13:34:57 +0000
Message-ID: <1513690500-12165-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513690500-12165-1-git-send-email-fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

This patch adds compatible strings specific to r8a774[35], no driver
change is needed as the fallback compatible string will activate the
right code. Also, this patch replaces the example with a DT snippet used
for adding PWM0 support to an r8a7743 based platform.

Signed-off-by: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Reviewed-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2->v3:
* No change

 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index 74c1180..f3bba59 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -2,6 +2,8 @@
 
 Required Properties:
 - compatible: should be "renesas,pwm-rcar" and one of the following.
+ - "renesas,pwm-r8a7743": for RZ/G1M
+ - "renesas,pwm-r8a7745": for RZ/G1E
  - "renesas,pwm-r8a7778": for R-Car M1A
  - "renesas,pwm-r8a7779": for R-Car H1
  - "renesas,pwm-r8a7790": for R-Car H2
@@ -17,13 +19,15 @@ Required Properties:
 - pinctrl-0: phandle, referring to a default pin configuration node.
 - pinctrl-names: Set to "default".
 
-Example: R8A7790 (R-Car H2) PWM Timer node
+Example: R8A7743 (RZ/G1M) PWM Timer node
 
 	pwm0: pwm@e6e30000 {
-		compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+		compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
 		reg = <0 0xe6e30000 0 0x8>;
+		clocks = <&cpg CPG_MOD 523>;
+		power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+		resets = <&cpg 523>;
 		#pwm-cells = <2>;
-		clocks = <&mstp5_clks R8A7790_CLK_PWM>;
 		pinctrl-0 = <&pwm0_pins>;
 		pinctrl-names = "default";
 	};
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
