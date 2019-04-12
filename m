From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson-g12a: Add PWM nodes
Date: Fri, 12 Apr 2019 11:23:37 +0200
Message-ID: <20190412092337.6941-4-narmstrong@baylibre.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412092337.6941-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This adds the EE and AO PWM nodes and the possible pinctrl settings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 179 ++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 501496eb34c6..5b7c9076e2d1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -355,6 +355,94 @@
 						};
 					};
 
+					pwm_a_pins: pwm-a {
+						mux {
+							groups = "pwm_a";
+							function = "pwm_a";
+							bias-disable;
+						};
+					};
+
+					pwm_b_x7_pins: pwm-b-x7 {
+						mux {
+							groups = "pwm_b_x7";
+							function = "pwm_b";
+							bias-disable;
+						};
+					};
+
+					pwm_b_x19_pins: pwm-b-x19 {
+						mux {
+							groups = "pwm_b_x19";
+							function = "pwm_b";
+							bias-disable;
+						};
+					};
+
+					pwm_c_c_pins: pwm-c-c {
+						mux {
+							groups = "pwm_c_c";
+							function = "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_c_x5_pins: pwm-c-x5 {
+						mux {
+							groups = "pwm_c_x5";
+							function = "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_c_x8_pins: pwm-c-x8 {
+						mux {
+							groups = "pwm_c_x8";
+							function = "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_d_x3_pins: pwm-d-x3 {
+						mux {
+							groups = "pwm_d_x3";
+							function = "pwm_d";
+							bias-disable;
+						};
+					};
+
+					pwm_d_x6_pins: pwm-d-x6 {
+						mux {
+							groups = "pwm_d_x6";
+							function = "pwm_d";
+							bias-disable;
+						};
+					};
+
+					pwm_e_pins: pwm-e {
+						mux {
+							groups = "pwm_e";
+							function = "pwm_e";
+							bias-disable;
+						};
+					};
+
+					pwm_f_x_pins: pwm-f-x {
+						mux {
+							groups = "pwm_f_x";
+							function = "pwm_f";
+							bias-disable;
+						};
+					};
+
+					pwm_f_h_pins: pwm-f-h {
+						mux {
+							groups = "pwm_f_h";
+							function = "pwm_f";
+							bias-disable;
+						};
+					};
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -632,6 +720,62 @@
 							bias-disable;
 						};
 					};
+
+					pwm_ao_a_pins: pwm-ao-a {
+						mux {
+							groups = "pwm_ao_a";
+							function = "pwm_ao_a";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_b_pins: pwm-ao-b {
+						mux {
+							groups = "pwm_ao_b";
+							function = "pwm_ao_b";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_c_4_pins: pwm-ao-c-4 {
+						mux {
+							groups = "pwm_ao_c_4";
+							function = "pwm_ao_c";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_c_6_pins: pwm-ao-c-6 {
+						mux {
+							groups = "pwm_ao_c_6";
+							function = "pwm_ao_c";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_5_pins: pwm-ao-d-5 {
+						mux {
+							groups = "pwm_ao_d_5";
+							function = "pwm_ao_d";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_10_pins: pwm-ao-d-10 {
+						mux {
+							groups = "pwm_ao_d_10";
+							function = "pwm_ao_d";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_e_pins: pwm-ao-d-e {
+						mux {
+							groups = "pwm_ao_d_e";
+							function = "pwm_ao_d";
+							bias-disable;
+						};
+					};
 				};
 			};
 
@@ -659,6 +803,13 @@
 				status = "disabled";
 			};
 
+			pwm_AO_cd: pwm@2000 {
+				compatible = "amlogic,meson-g12a-ao-pwm";
+				reg = <0x0 0x2000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
@@ -681,6 +832,13 @@
 				status = "disabled";
 			};
 
+			pwm_AO_ab: pwm@7000 {
+				compatible = "amlogic,meson-g12a-ao-pwm";
+				reg = <0x0 0x7000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			ir: ir@8000 {
 				compatible = "amlogic,meson-gxbb-ir";
 				reg = <0x0 0x8000 0x0 0x20>;
@@ -774,6 +932,27 @@
 				#reset-cells = <1>;
 			};
 
+			pwm_ef: pwm@19000 {
+				compatible = "amlogic,meson-g12a-ee-pwm";
+				reg = <0x0 0x19000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@1a000 {
+				compatible = "amlogic,meson-g12a-ee-pwm";
+				reg = <0x0 0x1a000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ab: pwm@1b000 {
+				compatible = "amlogic,meson-g12a-ee-pwm";
+				reg = <0x0 0x1b000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			clk_msr: clock-measure@18000 {
 				compatible = "amlogic,meson-g12a-clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
-- 
2.21.0
