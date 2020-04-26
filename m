From: Peter Vasil <peter.vasil@gmail.com>
Subject: [PATCH] pwm: sun4i: direct clock output support for Allwinner A64
Date: Sun, 26 Apr 2020 12:11:22 +0200
Message-ID: <20200426101122.98318-1-peter.vasil@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDZKLu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Apr 2020 06:11:50 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Peter Vasil <peter.vasil@gmail.com>

Allwinner A64 is capable of a direct clock output on PWM (see A64
User Manual chapter 3.10). Add support for this in the sun4i PWM
driver and adjust compatibility in sun50i-a64 base device tree.

Signed-off-by: Peter Vasil <peter.vasil@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++----
 drivers/pwm/pwm-sun4i.c                       | 9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 31143fe64d91..c334fd106854 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1069,8 +1069,7 @@ gic: interrupt-controller@1c81000 {
 		};
 
 		pwm: pwm@1c21400 {
-			compatible = "allwinner,sun50i-a64-pwm",
-				     "allwinner,sun5i-a13-pwm";
+			compatible = "allwinner,sun50i-a64-pwm";
 			reg = <0x01c21400 0x400>;
 			clocks = <&osc24M>;
 			pinctrl-names = "default";
@@ -1252,8 +1251,7 @@ r_ir: ir@1f02000 {
 		};
 
 		r_pwm: pwm@1f03800 {
-			compatible = "allwinner,sun50i-a64-pwm",
-				     "allwinner,sun5i-a13-pwm";
+			compatible = "allwinner,sun50i-a64-pwm";
 			reg = <0x01f03800 0x400>;
 			clocks = <&osc24M>;
 			pinctrl-names = "default";
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5c677c563349..18fbbe3277d0 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -352,6 +352,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
 	.npwm = 1,
 };
 
+static const struct sun4i_pwm_data sun50i_a64_pwm_data = {
+	.has_prescaler_bypass = true,
+	.has_direct_mod_clk_output = true,
+	.npwm = 1,
+};
+
 static const struct sun4i_pwm_data sun50i_h6_pwm_data = {
 	.has_prescaler_bypass = true,
 	.has_direct_mod_clk_output = true,
@@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	}, {
 		.compatible = "allwinner,sun8i-h3-pwm",
 		.data = &sun4i_pwm_single_bypass,
+	}, {
+		.compatible = "allwinner,sun50i-a64-pwm",
+		.data = &sun50i_a64_pwm_data,
 	}, {
 		.compatible = "allwinner,sun50i-h6-pwm",
 		.data = &sun50i_h6_pwm_data,
-- 
2.25.1
