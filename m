From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH RESEND 3/3] ARM: dts: NSP: Add PWM Support to DT
Date: Tue, 29 Mar 2016 10:22:30 -0400
Message-ID: <1459261350-23851-4-git-send-email-yendapally.reddy@broadcom.com>
References: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:39941 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304AbcC2OWt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Mar 2016 10:22:49 -0400
In-Reply-To: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Add PWM support to the device tree for the Broadcom Northstar Plus SoC.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index def9e78..f9c8341 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -206,6 +206,14 @@
 			brcm,nand-has-wp;
 		};
 
+		pwm: pwm@31000 {
+			compatible = "brcm,iproc-pwm";
+			reg = <0x31000 0x28>;
+			clocks = <&osc>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		ccbtimer0: timer@34000 {
 			compatible = "arm,sp804";
 			reg = <0x34000 0x1000>;
-- 
2.1.0
