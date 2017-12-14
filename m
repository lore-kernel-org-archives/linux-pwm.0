From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 2/6] dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings
Date: Thu, 14 Dec 2017 10:56:12 +0000
Message-ID: <1513248976-26700-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This patch adds compatible strings specific to r8a774[35], no driver
change is needed as the fallback compatible string will activate the
right code. Also, this patch replaces the example with a DT snippet used
for adding PWM0 support to an r8a7743 based platform.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
Dear All,

the reason for replacing the example with one of a different SoC is that
the new example refers to recent code from a real use case. I hope that's ok.

Thanks,
Fabrizio

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
