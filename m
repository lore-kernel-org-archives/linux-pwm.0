From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/4] ARM64: dts: meson-gxbb: Add Meson GXBB PWM Controller nodes
Date: Sun, 10 Jul 2016 11:24:04 +0200
Message-ID: <1468142645-4360-4-git-send-email-narmstrong@baylibre.com>
References: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 806b903..2eacef0 100644
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
2.7.0
