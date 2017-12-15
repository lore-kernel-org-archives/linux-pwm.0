From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH v2] ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC
Date: Fri, 15 Dec 2017 10:47:39 +0800
Message-ID: <20171215024739.106705-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:27736 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754718AbdLOCrY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Dec 2017 21:47:24 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Yixun Lan <yixun.lan@amlogic.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>

From: Jian Hu <jian.hu@amlogic.com>

Add PWM DT info for the Amlogic's Meson-Axg SoC.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
Changes in v2 since [1]
 - drop clock DT info from soc.dtsi

[1]
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005578.html
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 112 +++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a0d7b10da512..1ee5f12115b6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -120,6 +120,20 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
 
+			pwm_ab: pwm@1b000 {
+				compatible = "amlogic,meson-axg-ee-pwm";
+				reg = <0x0 0x1b000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@1a000 {
+				compatible = "amlogic,meson-axg-ee-pwm";
+				reg = <0x0 0x1a000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			uart_A: serial@24000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x24000 0x0 0x14>;
@@ -180,6 +194,90 @@
 					#gpio-cells = <2>;
 					gpio-ranges = <&pinctrl_periphs 0 0 86>;
 				};
+
+				pwm_a_a_pins: pwm_a_a {
+					mux {
+						groups = "pwm_a_a";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_x18_pins: pwm_a_x18 {
+					mux {
+						groups = "pwm_a_x18";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_x20_pins: pwm_a_x20 {
+					mux {
+						groups = "pwm_a_x20";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_z_pins: pwm_a_z {
+					mux {
+						groups = "pwm_a_z";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_b_a_pins: pwm_b_a {
+					mux {
+						groups = "pwm_b_a";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_b_x_pins: pwm_b_x {
+					mux {
+						groups = "pwm_b_x";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_b_z_pins: pwm_b_z {
+					mux {
+						groups = "pwm_b_z";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_c_a_pins: pwm_c_a {
+					mux {
+						groups = "pwm_c_a";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_c_x10_pins: pwm_c_x10 {
+					mux {
+						groups = "pwm_c_x10";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_c_x17_pins: pwm_c_x17 {
+					mux {
+						groups = "pwm_c_x17";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_d_x11_pins: pwm_d_x11 {
+					mux {
+						groups = "pwm_d_x11";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_d_x16_pins: pwm_d_x16 {
+					mux {
+						groups = "pwm_d_x16";
+						function = "pwm_d";
+					};
+				};
 			};
 		};
 
@@ -225,6 +323,20 @@
 				};
 			};
 
+			pwm_AO_ab: pwm@7000 {
+				compatible = "amlogic,meson-axg-ao-pwm";
+				reg = <0x0 0x07000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_AO_cd: pwm@2000 {
+				compatible = "amlogic,axg-ao-pwm";
+				reg = <0x0 0x02000  0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
-- 
2.15.1
