From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 4/4] ARM: dts: meson8b: Add Meson8b PWM Controller nodes
Date: Mon, 22 Aug 2016 17:36:33 +0200
Message-ID: <1471880193-21879-5-git-send-email-narmstrong@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index fc4080d..41fd536 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -162,6 +162,27 @@
 			reg = <0xc1108000 0x4>, <0xc1104000 0x460>;
 		};
 
+		pwm_ab: pwm@8550 {
+			compatible = "amlogic,meson8b-pwm";
+			reg = <0xc1108550 0x10>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm_cd: pwm@8650 {
+			compatible = "amlogic,meson8b-pwm";
+			reg = <0xc1108650 0x10>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm_ef: pwm@86c0 {
+			compatible = "amlogic,meson8b-pwm";
+			reg = <0xc11086c0 0x10>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		pinctrl_cbus: pinctrl@c1109880 {
 			compatible = "amlogic,meson8b-cbus-pinctrl";
 			reg = <0xc1109880 0x10>;
-- 
1.9.1
