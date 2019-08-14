From: Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v2 9/10] dt-bindings: pwm: update bindings for MT7628 SoC
Date: Wed, 14 Aug 2019 18:43:39 +0800
Message-ID: <1565779497-23621-2-git-send-email-sam.shih@mediatek.com>
References: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, sam shih <sam.shih@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

This updates bindings for MT7628 pwm controller.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-mediatek.txt       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index c7bd5633d1eb..9d2d893a07ff 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -21,6 +21,8 @@ Required properties:
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
  - num-pwms: the number of PWM channels.
+ - clock-frequency: fix clock frequency, this is an optional property, only use in MT7628 SoC
+                    for period calculation. This SoC has no complex clock tree.
 
 Example:
 	pwm0: pwm@11006000 {
@@ -40,3 +42,13 @@ Example:
 		pinctrl-0 = <&pwm0_pins>;
 		num-pwms = <5>;
 	};
+MT7628 Example:
+	pwm: pwm@5000 {
+		compatible = "mediatek,mt7628-pwm";
+		reg = <0x5000 0x1000>;
+		#pwm-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pins>, <&pwm1_pins>;
+		num-pwms = <4>;
+		clock-frequency = <100000>;
+	};
-- 
2.17.1
