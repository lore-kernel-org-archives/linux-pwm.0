From: John Crispin <john@phrozen.org>
Subject: [PATCH 1/2] dt-bindings: pwm: Add MediaTek PWM bindings
Date: Mon, 23 Jan 2017 19:34:36 +0100
Message-ID: <1485196477-669-1-git-send-email-john@phrozen.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:47264 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdAWSec (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 23 Jan 2017 13:34:32 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, =?UTF-8?q?Sean=20Wang=20=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?= <sean.wang@mediatek.com>, John Crispin <john@phrozen.org>

Document the device-tree binding of MediaTek PWM. The PWM has 5 channels.
This has been tested on MT7623 only but should work on all the other MTK
SoCs that contain this core.

Signed-off-by: John Crispin <john@phrozen.org>
---
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
new file mode 100644
index 0000000..54c59b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -0,0 +1,34 @@
+MediaTek PWM controller
+
+Required properties:
+ - compatible: should be "mediatek,<name>-pwm":
+   - "mediatek,mt7623-pwm": found on mt7623 SoC.
+ - reg: physical base address and length of the controller's registers.
+ - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
+   the cell format.
+ - clocks: phandle and clock specifier of the PWM reference clock.
+ - clock-names: must contain the following:
+   - "top": the top clock generator
+   - "main": clock used by the PWM core
+   - "pwm1-5": the five per PWM clocks
+ - pinctrl-names: Must contain a "default" entry.
+ - pinctrl-0: One property must exist for each entry in pinctrl-names.
+   See pinctrl/pinctrl-bindings.txt for details of the property values.
+
+Example:
+	pwm0: pwm@11006000 {
+		compatible = "mediatek,mt7623-pwm";
+		reg = <0 0x11006000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&topckgen CLK_TOP_PWM_SEL>,
+			 <&pericfg CLK_PERI_PWM>,
+			 <&pericfg CLK_PERI_PWM1>,
+			 <&pericfg CLK_PERI_PWM2>,
+			 <&pericfg CLK_PERI_PWM3>,
+			 <&pericfg CLK_PERI_PWM4>,
+			 <&pericfg CLK_PERI_PWM5>;
+		clock-names = "top", "main", "pwm1", "pwm2",
+			      "pwm3", "pwm4", "pwm5";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pins>;
+	};
-- 
1.7.10.4
