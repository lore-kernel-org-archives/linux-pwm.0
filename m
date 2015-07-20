From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH v6 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
Date: Mon, 20 Jul 2015 16:17:15 +0800
Message-ID: <1437380237-28961-2-git-send-email-yh.huang@mediatek.com>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, YH Huang <yh.huang@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

Document the device-tree binding of MediatTek display PWM.
The PWM has one channel to control the backlight brightness for display.
It supports MT8173 and MT6595.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
new file mode 100644
index 0000000..f8f59ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -0,0 +1,42 @@
+MediaTek display PWM controller
+
+Required properties:
+ - compatible: should be "mediatek,<name>-disp-pwm":
+   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
+   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
+ - reg: physical base address and length of the controller's registers.
+ - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
+   the cell format.
+ - clocks: phandle and clock specifier of the PWM reference clock.
+ - clock-names: must contain the following:
+   - "main": clock used to generate PWM signals.
+   - "mm": sync signals from the modules of mmsys.
+ - pinctrl-names: Must contain a "default" entry.
+ - pinctrl-0: One property must exist for each entry in pinctrl-names.
+   See pinctrl/pinctrl-bindings.txt for details of the property values.
+
+Example:
+	pwm0: pwm@1401e000 {
+		compatible = "mediatek,mt8173-disp-pwm",
+			     "mediatek,mt6595-disp-pwm";
+		reg = <0 0x1401e000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys CLK_MM_DISP_PWM026M>,
+			 <&mmsys CLK_MM_DISP_PWM0MM>;
+		clock-names = "main", "mm";
+		pinctrl-names = "default";
+		pinctrl-0 = <&disp_pwm0_pins>;
+	};
+
+	backlight_lcd: backlight_lcd {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 1000000>;
+		brightness-levels = <
+			  0  16  32  48  64  80  96 112
+			128 144 160 176 192 208 224 240
+			255
+		>;
+		default-brightness-level = <9>;
+		power-supply = <&mt6397_vio18_reg>;
+		enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
+	};
-- 
1.8.1.1.dirty
