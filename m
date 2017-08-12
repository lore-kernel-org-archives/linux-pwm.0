From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 1/2] dt-bindings: pwm-bcm2835: Increase pwm-cells
Date: Sat, 12 Aug 2017 12:19:43 +0200
Message-ID: <1502533184-15765-2-git-send-email-stefan.wahren@i2se.com>
References: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdHLKUd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 12 Aug 2017 06:20:33 -0400
In-Reply-To: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

We need to increase the pwm-cells for the optional flags parameter,
before we can implement support for polarity setting via DT.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
index cf573e8..8cf87d1 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
@@ -6,7 +6,7 @@ Required properties:
 - clocks: This clock defines the base clock frequency of the PWM hardware
   system, the period and the duty_cycle of the PWM signal is a multiple of
   the base period.
-- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
 Examples:
@@ -15,7 +15,7 @@ pwm@2020c000 {
 	compatible = "brcm,bcm2835-pwm";
 	reg = <0x2020c000 0x28>;
 	clocks = <&clk_pwm>;
-	#pwm-cells = <2>;
+	#pwm-cells = <3>;
 };
 
 clocks {
-- 
2.7.4
