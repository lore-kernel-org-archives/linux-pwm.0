Return-Path: <mtk07307@mhfsdccf11>
From: Weiqing Kong <weiqing.kong@mediatek.com>
Subject: [PATCH 1/3] dt-bindings: pwm: Add MediaTek display PWM bindings
Date: Mon, 16 May 2016 16:14:22 +0800
Message-ID: <1463386464-15707-2-git-send-email-weiqing.kong@mediatek.com>
In-Reply-To: <1463386464-15707-1-git-send-email-weiqing.kong@mediatek.com>
References: <1463386464-15707-1-git-send-email-weiqing.kong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: mtk07307@mhfsdccf11
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, weiqing.kong@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, erin.lo@mediatek.com, yingjoe.chen@mediatek.com, yh.huang@mediatek.com, yt.shen@mediatek.com

Add MT2701 compatible string.

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
index f8f59ba..f2f2fa9 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -1,9 +1,10 @@
 MediaTek display PWM controller
 
 Required properties:
- - compatible: should be "mediatek,<name>-disp-pwm":
-   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
+ - compatible: should be like these:
+   - "mediatek,mt2701-disp-bls": found on mt2701 SoC.
    - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
+   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
    the cell format.
-- 
1.9.1
