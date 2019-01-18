From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 2/5] dt-bindings: pwm: add a property "mediatek,num-pwms"
Date: Fri, 18 Jan 2019 11:24:42 +0800
Message-ID: <7e1de17a43f2cde73aecd2773e2b3a5fdfd294f3.1547781007.git.ryder.lee@mediatek.com>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

This adds a property "mediatek,num-pwms" in example so that we could
set the number of PWM channels via device tree.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Changes since v1: add a Reviewed-by tag.
---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 991728c..f9e2d1f 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -20,6 +20,7 @@ Required properties:
  - pinctrl-names: Must contain a "default" entry.
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
+ - mediatek,num-pwms: the number of PWM channels.
 
 Example:
 	pwm0: pwm@11006000 {
@@ -37,4 +38,5 @@ Example:
 			      "pwm3", "pwm4", "pwm5";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pins>;
+		mediatek,num-pwms = <5>;
 	};
-- 
1.9.1
