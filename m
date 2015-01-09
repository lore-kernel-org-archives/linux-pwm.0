From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 7/7] mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
Date: Sat, 10 Jan 2015 00:34:53 +0100
Message-ID: <1420846493-31647-8-git-send-email-andrew@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49499 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbbAIXhE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 9 Jan 2015 18:37:04 -0500
In-Reply-To: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linus.walleij@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, kaloz@openwrt.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

The mvebu gpio driver can also perform PWM on some pins. Us the
pwm-fan driver to control the fan of the WRT1900AC, giving us fine
grain control over its speed and hence noise.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-xp-wrt1900ac.dts | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-wrt1900ac.dts b/arch/arm/boot/dts/armada-xp-wrt1900ac.dts
index d53643ca2c0d..14a4d7cd4ff2 100644
--- a/arch/arm/boot/dts/armada-xp-wrt1900ac.dts
+++ b/arch/arm/boot/dts/armada-xp-wrt1900ac.dts
@@ -276,12 +276,10 @@
 		};
 	};
 
-	gpio_fan {
+	pwm_fan {
 		/* SUNON HA4010V4-0000-C99 */
-		compatible = "gpio-fan";
-		gpios = <&gpio0 24 0>;
-		gpio-fan,speed-map = <0	   0
-				      4500 1>;
+		compatible = "pwm-fan";
+		pwms = <&gpio0 24 4000 0>;
 	};
 
 	dsa@0 {
-- 
2.1.3

