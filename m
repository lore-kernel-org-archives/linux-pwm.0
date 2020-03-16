From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: pwm: renesas-tpu: Document more R-Car Gen2 support
Date: Mon, 16 Mar 2020 11:14:53 +0100
Message-ID: <20200316101453.27745-1-geert+renesas@glider.be>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:46314 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgCPKO5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:14:57 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

All R-Car Gen2 SoCs have a Renesas Timer Pulse Unit.
Document support for the missing variants.

No driver change is needed due to the fallback compatible string.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on R-Car M2-W.
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 4969a954993cb693..4bf62a3d5bba8e3a 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -19,6 +19,10 @@ properties:
           - renesas,tpu-r8a7744   # RZ/G1N
           - renesas,tpu-r8a7745   # RZ/G1E
           - renesas,tpu-r8a7790   # R-Car H2
+          - renesas,tpu-r8a7791   # R-Car M2-W
+          - renesas,tpu-r8a7792   # R-Car V2H
+          - renesas,tpu-r8a7793   # R-Car M2-N
+          - renesas,tpu-r8a7794   # R-Car E2
           - renesas,tpu-r8a7795   # R-Car H3
           - renesas,tpu-r8a7796   # R-Car M3-W
           - renesas,tpu-r8a77965  # R-Car M3-N
-- 
2.17.1
