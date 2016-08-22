From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 3/4] ARM64: dts: meson-gxbb: Add Meson GXBB PWM Controller nodes
Date: Mon, 22 Aug 2016 17:36:32 +0200
Message-ID: <1471880193-21879-4-git-send-email-narmstrong@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471880193-21879-1-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index e502c24..e3f4d36 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -153,6 +153,27 @@
 				status = "disabled";
 			};
 
+			pwm_ab: pwm@8550 {
+				compatible = "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x08550 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@8650 {
+				compatible = "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x08650 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ef: pwm@86c0 {
+				compatible = "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x086c0 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			uart_C: serial@8700 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x8700 0x0 0x14>;
@@ -212,6 +233,13 @@
 				clocks = <&xtal>;
 				status = "disabled";
 			};
+
+			pwm_ab_AO: pwm@550 {
+				compatible = "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x0550 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
 		};
 
 		periphs: periphs@c8834000 {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
