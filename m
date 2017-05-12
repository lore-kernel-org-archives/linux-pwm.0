From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v4] dt-bindings: pwm: Add R-Car M3-W device tree bindings
Date: Fri, 12 May 2017 10:09:42 +0200
Message-ID: <1494576582-17881-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47122 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756554AbdELIKC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2017 04:10:02 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Add device tree bindings for the PWM controller found on R-Car M3-W SoCs.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
v4
* Broke out of lager patchset on which it appears to have no dependencies
* Added Reviewed by tags 
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index d6de64335022..7e94b802395d 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -8,6 +8,7 @@ Required Properties:
  - "renesas,pwm-r8a7791": for R-Car M2-W
  - "renesas,pwm-r8a7794": for R-Car E2
  - "renesas,pwm-r8a7795": for R-Car H3
+ - "renesas,pwm-r8a7796": for R-Car M3-W
 - reg: base address and length of the registers block for the PWM.
 - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
   the cells format.
-- 
2.1.4
