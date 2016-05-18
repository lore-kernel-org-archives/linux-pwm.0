From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH INTERNAL v2 3/3] ARM: dts: NSP: Add PWM Support to DT
Date: Wed, 18 May 2016 02:54:01 -0400
Message-ID: <1463554441-47982-4-git-send-email-yendapally.reddy@broadcom.com>
References: <1463554441-47982-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463554441-47982-1-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

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
