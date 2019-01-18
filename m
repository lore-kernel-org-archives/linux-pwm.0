From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 5/5] dt-bindings: pwm: update bindings for MT7629 SoC
Date: Fri, 18 Jan 2019 11:24:45 +0800
Message-ID: <e7a59d288a4e23130e0303fec3aeba1f46ed1c26.1547781007.git.ryder.lee@mediatek.com>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

This updates bindings for MT7629 pwm controller.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Changes since v1: add a Reviewed-by tag.
---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index f9e2d1f..f7e7784 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -6,6 +6,7 @@ Required properties:
    - "mediatek,mt7622-pwm": found on mt7622 SoC.
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
+   - "mediatek,mt7629-pwm", "mediatek,mt7622-pwm": found on mt7629 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
    the cell format.
-- 
1.9.1
