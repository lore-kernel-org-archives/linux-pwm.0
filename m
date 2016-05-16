Return-Path: <mtk07307@mhfsdccf11>
From: Weiqing Kong <weiqing.kong@mediatek.com>
Subject: [PATCH 3/3] dts: Add disp bls dsti and dts config for MT2701
Date: Mon, 16 May 2016 16:14:24 +0800
Message-ID: <1463386464-15707-4-git-send-email-weiqing.kong@mediatek.com>
In-Reply-To: <1463386464-15707-1-git-send-email-weiqing.kong@mediatek.com>
References: <1463386464-15707-1-git-send-email-weiqing.kong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: mtk07307@mhfsdccf11
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, weiqing.kong@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, erin.lo@mediatek.com, yingjoe.chen@mediatek.com, yh.huang@mediatek.com, yt.shen@mediatek.com

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts | 29 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    |  9 +++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index 082ca88..6d572f4 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -22,6 +22,35 @@
 	memory {
 		reg = <0 0x80000000 0 0x40000000>;
 	};
+
+	backlight_lcd: backlight_lcd {
+		compatible = "pwm-backlight";
+		pwms = <&disp_bls 0 100000>;
+		brightness-levels = <
+			  0  16  32  48  64  80  96 112
+			128 144 160 176 192 208 224 240
+			255
+		>;
+		default-brightness-level = <9>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm_bls_gpio>;
+	};
+};
+
+&disp_bls {
+	status = "okay";
+};
+
+&mmsys {
+	status = "okay";
+};
+
+&pio {
+	pwm_bls_gpio: pwm_bls_gpio {
+		pins_cmd_dat {
+			pinmux = <MT2701_PIN_208_AUD_EXT_CK1__FUNC_DISP_PWM>;
+		};
+	};
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 42d5a37..dae55d6 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -234,6 +234,15 @@
 		status = "disabled";
 	};
 
+	disp_bls: dispsys@1400a000 {
+		compatible = "mediatek,mt2701-disp-bls";
+		reg = <0 0x1400a000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys CLK_MM_MDP_BLS_26M>, <&mmsys CLK_MM_DISP_BLS>;
+		clock-names = "main", "mm";
+		status = "disabled";
+	};
+
 	imgsys: syscon@15000000 {
 		compatible = "mediatek,mt2701-imgsys", "syscon";
 		reg = <0 0x15000000 0 0x1000>;
-- 
1.9.1
