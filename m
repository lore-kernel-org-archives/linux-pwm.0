From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v4 5/5] ARM: berlin: add a PWM node on the BG2CD
Date: Tue, 18 Aug 2015 13:38:08 +0200
Message-ID: <1439897888-10921-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1439897888-10921-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33589 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295AbbHRLiN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Aug 2015 07:38:13 -0400
In-Reply-To: <1439897888-10921-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds a PWM node in the Berlin BG2CD device tree, using the
newly added Berlin PWM driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 900213d78a32..5d984f58dde7 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -368,6 +368,13 @@
 			status = "disabled";
 		};
 
+		pwm: pwm@f20000 {
+			compatible = "marvell,berlin-pwm";
+			reg = <0xf20000 0x40>;
+			clocks = <&chip_clk CLKID_CFG>;
+			#pwm-cells = <3>;
+		};
+
 		apb@fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.5.0
