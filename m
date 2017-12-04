From: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC
Date: Mon, 4 Dec 2017 14:00:18 +0800
Message-ID: <20171204060018.8856-4-yixun.lan@amlogic.com>
References: <20171204060018.8856-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171204060018.8856-1-yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

From: Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>

Add PWM DT info for the Amlogic's Meson-Axg SoC.

Signed-off-by: Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 120 +++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 92f65eec3e18..f7f228701df1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -177,6 +177,24 @@
 				clock-names = "clk_i2c";
 			};
 
+			pwm_ab: pwm@1b000 {
+				compatible = "amlogic,meson-axg-ee-pwm";
+				reg = <0x0 0x1b000 0x0 0x20>;
+				#pwm-cells = <3>;
+				clocks = <&xtal>, <&xtal>;
+				clock-names = "clkin0", "clkin1";
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@1a000 {
+				compatible = "amlogic,meson-axg-ee-pwm";
+				reg = <0x0 0x1a000 0x0 0x20>;
+				#pwm-cells = <3>;
+				clocks = <&xtal>, <&xtal>;
+				clock-names = "clkin0", "clkin1";
+				status = "disabled";
+			};
+
 			uart_A: serial@24000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x24000 0x0 0x14>;
@@ -368,6 +386,90 @@
 						function = "i2c3";
 					};
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
 
@@ -435,6 +537,24 @@
 				clock-names = "clk_i2c";
 			};
 
+			pwm_AO_ab: pwm@7000 {
+				compatible = "amlogic,meson-axg-ao-pwm";
+				reg = <0x0 0x07000 0x0 0x20>;
+				#pwm-cells = <3>;
+				clocks = <&xtal>, <&xtal>;
+				clock-names = "clkin0", "clkin1";
+				status = "disabled";
+			};
+
+			pwm_AO_cd: pwm@2000 {
+				compatible = "amlogic,axg-ao-pwm";
+				reg = <0x0 0x02000  0x0 0x20>;
+				#pwm-cells = <3>;
+				clocks = <&xtal>, <&xtal>;
+				clock-names = "clkin0", "clkin1";
+				status = "disabled";
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
