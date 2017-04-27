From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 7/8] arm64: dts: r8a7795-salvator-x: Enable PWM2
Date: Thu, 27 Apr 2017 16:37:42 +0200
Message-ID: <1493303863-23719-8-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36831 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938488AbdD0OiF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Apr 2017 10:38:05 -0400
In-Reply-To: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: geert@glider.be, horms@verge.net.au
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch enables PWM2 for Salvator-X board on R8A7795 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 8558b27..534b17e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -381,6 +381,11 @@
 		function = "pwm1";
 	};
 
+	pwm2_pins: pwm2 {
+		groups = "pwm2_a";
+		function = "pwm2";
+	};
+
 	sdhi0_pins: sd0 {
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
@@ -463,6 +468,13 @@
 	status = "okay";
 };
 
+&pwm2 {
+	/* PMIC DC/DC switching frequency synchronization */
+	pinctrl-0 = <&pwm2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &scif1 {
 	pinctrl-0 = <&scif1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
