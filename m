From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH repost2] pwm: renesas-tpu: remove support for sh7372
Date: Fri, 18 Aug 2017 12:09:01 +0200
Message-ID: <20170818100858.GA15521@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35517 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdHRKJG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2017 06:09:06 -0400
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Remove support for the SH7372 (SH-Mobile AP4) from the renesas-tpu driver.

Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
removes this SoC from the kernel in v4.1.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 1 -
 drivers/pwm/pwm-renesas-tpu.c                             | 1 -
 2 files changed, 2 deletions(-)

 Based on linux-pwm/for-next

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
index b067e84a94b5..1aadc804dae4 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
@@ -6,7 +6,6 @@ Required Properties:
     - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PWM controller.
     - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM controller.
     - "renesas,tpu-r8a7790": for R8A7790 (R-Car H2) compatible PWM controller.
-    - "renesas,tpu-sh7372": for SH7372 (SH-Mobile AP4) compatible PWM controller.
     - "renesas,tpu": for generic R-Car TPU PWM controller.
 
   - reg: Base address and length of each memory resource used by the PWM
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 075c1a764ba2..29267d12fb4c 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -455,7 +455,6 @@ static const struct of_device_id tpu_of_table[] = {
 	{ .compatible = "renesas,tpu-r8a73a4", },
 	{ .compatible = "renesas,tpu-r8a7740", },
 	{ .compatible = "renesas,tpu-r8a7790", },
-	{ .compatible = "renesas,tpu-sh7372", },
 	{ .compatible = "renesas,tpu", },
 	{ },
 };
-- 
2.1.4
