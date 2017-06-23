From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH v2 4/6] pwm: bindings: add MT2712/MT7622 information
Date: Fri, 23 Jun 2017 13:08:23 +0800
Message-ID: <1498194505-30930-5-git-send-email-zhi.mao@mediatek.com>
References: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: zhenbao.liu@mediatek.com, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, sean.wang@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yt.shen@mediatek.com, yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

add MT2712/MT7622 pwm information

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 54c59b0..ef8bd3c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -2,6 +2,8 @@ MediaTek PWM controller
 
 Required properties:
  - compatible: should be "mediatek,<name>-pwm":
+   - "mediatek,mt2712-pwm": found on mt2712 SoC.
+   - "mediatek,mt7622-pwm": found on mt7622 SoC.
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
@@ -10,7 +12,9 @@ Required properties:
  - clock-names: must contain the following:
    - "top": the top clock generator
    - "main": clock used by the PWM core
-   - "pwm1-5": the five per PWM clocks
+   - "pwm1-8": the eight per PWM clocks for mt2712
+   - "pwm1-6": the six per PWM clocks for mt7622
+   - "pwm1-5": the five per PWM clocks for mt7623
  - pinctrl-names: Must contain a "default" entry.
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
-- 
1.7.9.5
