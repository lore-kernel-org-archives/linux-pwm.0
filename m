From: Tim Kryger <tim.kryger@linaro.org>
Subject: [PATCH v6 RESEND 4/5] ARM: dts: Enable the PWM for bcm28155 AP board
Date: Fri, 25 Apr 2014 11:31:14 -0700
Message-ID: <1398450675-19609-5-git-send-email-tim.kryger@linaro.org>
References: <1398450675-19609-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:64366 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbaDYSbW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Apr 2014 14:31:22 -0400
In-Reply-To: <1398450675-19609-1-git-send-email-tim.kryger@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Matt Porter <mporter@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Christian Daudt <bcm@fixthebug.org>, Grant Likely <grant.likely@linaro.org>
Cc: Tim Kryger <tim.kryger@linaro.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, Linux Doc List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Mark the PWM as enabled on the bcm28155 AP board.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index af3da55..9ce91dd 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -69,6 +69,10 @@
 		status = "okay";
 	};
 
+	pwm: pwm@3e01a000 {
+		status = "okay";
+	};
+
 	usbotg: usb@3f120000 {
 		vusb_d-supply = <&usbldo_reg>;
 		vusb_a-supply = <&iosr1_reg>;
-- 
1.7.9.5

