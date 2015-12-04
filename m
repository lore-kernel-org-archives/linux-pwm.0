From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] dt: lpc32xx: pwm: update documentation of LPC32xx PWM device
Date: Fri,  4 Dec 2015 07:22:33 +0200
Message-ID: <1449206553-26133-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:47845 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbbLDFWj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 4 Dec 2015 00:22:39 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

LPC32xx SoC has two independent PWM controllers, they have different
clock parents, clock gates and slightly different controls, each of
these two PWM controllers has one output channel.

The change updates device tree binding documentation to reflect two PWM
devices.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
index cfe1db3..ab0907d 100644
--- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
@@ -8,5 +8,10 @@ Examples:
 
 pwm@0x4005C000 {
 	compatible = "nxp,lpc3220-pwm";
-	reg = <0x4005C000 0x8>;
+	reg = <0x4005C000 0x4>;
+};
+
+pwm@0x4005C004 {
+	compatible = "nxp,lpc3220-pwm";
+	reg = <0x4005C004 0x4>;
 };
-- 
2.1.4
