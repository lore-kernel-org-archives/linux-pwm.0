From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] dt-bindings: pwm: rcar: Add r8a774a1 support
Date: Tue, 21 Aug 2018 17:03:46 +0100
Message-ID: <1534867426-25533-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index 35a3b97..fa19c26 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -4,6 +4,7 @@ Required Properties:
 - compatible: should be "renesas,pwm-rcar" and one of the following.
  - "renesas,pwm-r8a7743": for RZ/G1M
  - "renesas,pwm-r8a7745": for RZ/G1E
+ - "renesas,pwm-r8a774a1": for RZ/G2M
  - "renesas,pwm-r8a7778": for R-Car M1A
  - "renesas,pwm-r8a7779": for R-Car H1
  - "renesas,pwm-r8a7790": for R-Car H2
-- 
2.7.4
