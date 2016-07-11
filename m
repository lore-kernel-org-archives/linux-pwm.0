From: Weiqing Kong <weiqing.kong@mediatek.com>
Subject: [PATCH V2 1/3] dt-bindings: pwm: Add MediaTek display PWM bindings
Date: Mon, 11 Jul 2016 16:18:07 +0800
Message-ID: <1468225089-28576-2-git-send-email-weiqing.kong@mediatek.com>
References: <1468225089-28576-1-git-send-email-weiqing.kong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468225089-28576-1-git-send-email-weiqing.kong@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, weiqing.kong@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, erin.lo@mediatek.com, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, yh.huang@mediatek.com, yt.shen@mediatek.com
List-Id: linux-pwm@vger.kernel.org

Add MT2701 compatible string.

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
index f8f59ba..6f8af2b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -2,8 +2,9 @@ MediaTek display PWM controller
 
 Required properties:
  - compatible: should be "mediatek,<name>-disp-pwm":
-   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
+   - "mediatek,mt2701-disp-pwm": found on mt2701 SoC.
    - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
+   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
    the cell format.
-- 
1.8.1.1.dirty
