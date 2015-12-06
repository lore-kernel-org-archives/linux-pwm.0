From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 2/6] dt: lpc32xx: pwm: update documentation of LPC32xx PWM device
Date: Sun,  6 Dec 2015 13:29:13 +0200
Message-ID: <1449401357-22458-3-git-send-email-vz@mleia.com>
References: <1449401357-22458-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:51797 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772AbbLFL3g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 6 Dec 2015 06:29:36 -0500
In-Reply-To: <1449401357-22458-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Roland Stigge <stigge@antcom.de>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org

NXP LPC32xx SoC has two separate PWM controller devices, update device
tree binding documentation to reflect this fact.

The change makes previous PWM device node description incompatible
with the new version.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- removed '0x' from a device node address and use lower case hex chars.

 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
index 1ab1abc..74b5bc5 100644
--- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
@@ -8,5 +8,10 @@ Examples:
 
 pwm@4005c000 {
 	compatible = "nxp,lpc3220-pwm";
-	reg = <0x4005c000 0x8>;
+	reg = <0x4005c000 0x4>;
+};
+
+pwm@4005c004 {
+	compatible = "nxp,lpc3220-pwm";
+	reg = <0x4005c004 0x4>;
 };
-- 
2.1.4
