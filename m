From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v5 1/2] pwm: rockchip: document RK3288 SoC compatible
Date: Fri,  8 Aug 2014 15:28:48 +0800
Message-ID: <1407482929-13050-2-git-send-email-caesar.wang@rock-chips.com>
References: <1407482929-13050-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407482929-13050-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, b.galvani@gmail.com, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dianders@chromium.org
Cc: cf@rock-chips.com, addy.ke@rock-chips.com, cjf@rock-chips.com, xjq@rock-chips.com, hj@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

Document new compatible for PWM founding on RK3288 SoC

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
index 3182126..d47d15a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
@@ -1,7 +1,10 @@
 Rockchip PWM controller
 
 Required properties:
- - compatible: should be "rockchip,rk2928-pwm"
+ - compatible: should be "rockchip,<name>-pwm"
+   "rockchip,rk2928-pwm": found on RK29XX,RK3066 and RK3188 SoCs
+   "rockchip,rk3288-pwm": found on RK3288 SoC
+   "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
  - reg: physical base address and length of the controller's registers
  - clocks: phandle and clock specifier of the PWM reference clock
  - #pwm-cells: should be 2. See pwm.txt in this directory for a
-- 
1.9.1
