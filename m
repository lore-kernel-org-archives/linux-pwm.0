From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 5/8] arm64: dts: r8a7796-salvator-x: Add PWM device support
Date: Thu, 27 Apr 2017 16:37:40 +0200
Message-ID: <1493303863-23719-6-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36458 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938475AbdD0OiB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Apr 2017 10:38:01 -0400
In-Reply-To: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: geert@glider.be, horms@verge.net.au
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, Ryo Kodama <ryo.kodama.vz@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

This patch adds support of PWM2 device for Salvator-X board on
R8A7796 SoC.

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index abda84c..1516959 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -138,6 +138,11 @@
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
@@ -257,6 +262,14 @@
 	status = "okay";
 };
 
+&pwm2 {
+	/* PMIC DC/DC switching frequency synchronization */
+	pinctrl-0 = <&pwm2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &scif1 {
 	pinctrl-0 = <&scif1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
