From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/2] dt-bindings: pwm-bcm2835: Increase pwm-cells
Date: Sat,  8 Jul 2017 12:13:57 +0200
Message-ID: <1499508838-20715-2-git-send-email-stefan.wahren@i2se.com>
References: <1499508838-20715-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:62834 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbdGHKPF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jul 2017 06:15:05 -0400
In-Reply-To: <1499508838-20715-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

We need to increase the pwm-cells for the optional flags parameter,
before we can implement support for polarity setting via DT.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
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
