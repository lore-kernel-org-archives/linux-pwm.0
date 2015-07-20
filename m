From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH v6 3/3] arm64: dts: mt8173: add MT8173 display PWM driver support node
Date: Mon, 20 Jul 2015 16:17:17 +0800
Message-ID: <1437380237-28961-4-git-send-email-yh.huang@mediatek.com>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, YH Huang <yh.huang@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

Add display PWM node in mt8173-evb.dts and mt8173.dtsi.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index f433c21..b7c1d9f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -34,6 +34,21 @@
 	chosen { };
 };
 
+&pio {
+	disp_pwm0_pins: disp_pwm0_pins {
+		pins1 {
+			pinmux = <MT8173_PIN_87_DISP_PWM0__FUNC_DISP_PWM0>;
+			bias-pull-up;
+		};
+	};
+};
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm0_pins>;
+	status = "okay";
+};
+
 &pwrap {
 	pmic: mt6397 {
 		compatible = "mediatek,mt6397";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 0696f8f..44cab19 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -393,6 +393,28 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		pwm0: pwm@1401e000 {
+			compatible = "mediatek,mt8173-disp-pwm",
+				     "mediatek,mt6595-disp-pwm";
+			reg = <0 0x1401e000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&mmsys CLK_MM_DISP_PWM026M>,
+				 <&mmsys CLK_MM_DISP_PWM0MM>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
+		pwm1: pwm@1401f000 {
+			compatible = "mediatek,mt8173-disp-pwm",
+				     "mediatek,mt6595-disp-pwm";
+			reg = <0 0x1401f000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&mmsys CLK_MM_DISP_PWM126M>,
+				 <&mmsys CLK_MM_DISP_PWM1MM>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.1.1.dirty
