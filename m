From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 4/6] arm64: dts: salvator-x: enable PWM
Date: Wed,  9 Mar 2016 17:56:00 +0100
Message-ID: <1457542562-7880-5-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, magnus.damm@gmail.com, thierry.reding@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Enables PWM1 (brightness control) and PWM2 (PMIC switching frequency
synchronization).

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 507d6a4..5525637 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -189,6 +189,15 @@
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
 
+	pwm1_pins: pwm1 {
+		renesas,groups = "pwm1_a";
+		renesas,function = "pwm1";
+	};
+	pwm2_pins: pwm2 {
+		renesas,groups = "pwm2_a";
+		renesas,function = "pwm2";
+	};
+
 	scif1_pins: scif1 {
 		renesas,groups = "scif1_data_a", "scif1_ctrl";
 		renesas,function = "scif1";
@@ -299,6 +308,20 @@
 	};
 };
 
+&pwm1 {
+	/* brightness control */
+	pinctrl-0 = <&pwm1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm2 {
+	/* PMIC DC/DC switching frequency synchronization */
+	pinctrl-0 = <&pwm2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &rcar_sound {
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
 	pinctrl-names = "default";
-- 
2.6.4
