Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:48037 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbfJAMDG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Oct 2019 08:03:06 -0400
From: Biju Das <biju.das@bp.renesas.com>
Date: Tue,  1 Oct 2019 13:02:40 +0100
Message-Id: <1569931360-17196-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH] dt-bindings: pwm: rcar: Add r8a774b1 support
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Biju Das <biju.das@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-renesas-soc@vger.kernel.org

Document RZ/G2N (R8A774B1) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch depend on
https://patchwork.kernel.org/patch/11154813/
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 0976cfd..272a4df 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -18,6 +18,7 @@ properties:
           - renesas,pwm-r8a7745   # RZ/G1E
           - renesas,pwm-r8a77470  # RZ/G1C
           - renesas,pwm-r8a774a1  # RZ/G2M
+          - renesas,pwm-r8a774b1  # RZ/G2N
           - renesas,pwm-r8a774c0  # RZ/G2E
           - renesas,pwm-r8a7778   # R-Car M1A
           - renesas,pwm-r8a7779   # R-Car H1
-- 
2.7.4
