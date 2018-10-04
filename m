Return-Path: <biju.das@bp.renesas.com>
From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH] dt-bindings: pwm: rcar: Add r8a7744 support
Date: Thu,  4 Oct 2018 17:17:19 +0100
Message-Id: <1538669839-33081-1-git-send-email-biju.das@bp.renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Biju Das <biju.das@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-renesas-soc@vger.kernel.org

Document RZ/G1N (R8A7744) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
This patch is tested against next-20181004
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index e1ef6af..ff667e6 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -3,6 +3,7 @@
 Required Properties:
 - compatible: should be "renesas,pwm-rcar" and one of the following.
  - "renesas,pwm-r8a7743": for RZ/G1M
+ - "renesas,pwm-r8a7744": for RZ/G1N
  - "renesas,pwm-r8a7745": for RZ/G1E
  - "renesas,pwm-r8a7778": for R-Car M1A
  - "renesas,pwm-r8a7779": for R-Car H1
-- 
2.7.4
