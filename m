From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 1/6] dt: lpc32xx: pwm: correct LPC32xx PWM device node example
Date: Sun,  6 Dec 2015 13:29:12 +0200
Message-ID: <1449401357-22458-2-git-send-email-vz@mleia.com>
References: <1449401357-22458-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:51788 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbbLFL3g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 6 Dec 2015 06:29:36 -0500
In-Reply-To: <1449401357-22458-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Roland Stigge <stigge@antcom.de>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org

The change removes '0x' from a device node address and uses lower case
hex chars.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- new change

 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
index cfe1db3..1ab1abc 100644
--- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
@@ -6,7 +6,7 @@ Required properties:
 
 Examples:
 
-pwm@0x4005C000 {
+pwm@4005c000 {
 	compatible = "nxp,lpc3220-pwm";
-	reg = <0x4005C000 0x8>;
+	reg = <0x4005c000 0x8>;
 };
-- 
2.1.4
