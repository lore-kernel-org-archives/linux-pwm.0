From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v3 5/6] pwm: add R-Car H3 device tree bindings
Date: Thu, 31 Mar 2016 13:39:15 +0200
Message-ID: <1459424356-26061-6-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1459424356-26061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35529 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbcCaLkI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Mar 2016 07:40:08 -0400
In-Reply-To: <1459424356-26061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index 0822a08..d6de643 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -7,6 +7,7 @@ Required Properties:
  - "renesas,pwm-r8a7790": for R-Car H2
  - "renesas,pwm-r8a7791": for R-Car M2-W
  - "renesas,pwm-r8a7794": for R-Car E2
+ - "renesas,pwm-r8a7795": for R-Car H3
 - reg: base address and length of the registers block for the PWM.
 - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
   the cells format.
-- 
2.7.4
