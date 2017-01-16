From: Frode Isaksen <fisaksen@baylibre.com>
Subject: [PATCH] ARM: dts: da850-lcdk: enable pwm nodes
Date: Mon, 16 Jan 2017 18:03:09 +0100
Message-ID: <1484586189-3118-1-git-send-email-fisaksen@baylibre.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35331 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdAPRDc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Jan 2017 12:03:32 -0500
Received: by mail-wm0-f48.google.com with SMTP id r126so167141241wmr.0
        for <linux-pwm@vger.kernel.org>; Mon, 16 Jan 2017 09:03:31 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: nsekhar@ti.com, khilman@baylibre.com, ptitiano@baylibre.com, linux-arm-kernel@lists.infradead.org
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, Frode Isaksen <fisaksen@baylibre.com>

Enable the ecap1 and ecap2 pwm nodes for the
lcdk board.
Note that the other pwm nodes are not enabled,
since the pins are shared with ethernet and spi.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 60e027e..6f4c367 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -322,3 +322,15 @@
 		};
 	};
 };
+
+&ecap1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ecap1_pins>;
+	status = "okay";
+};
+
+&ecap2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ecap2_pins>;
+	status = "okay";
+};
-- 
2.7.4
