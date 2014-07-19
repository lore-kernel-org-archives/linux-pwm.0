From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v2 1/2] pwm: add this patch to introduce for rk-pwm and vop-pwm
Date: Sat, 19 Jul 2014 20:55:28 +0800
Message-ID: <1405774529-26027-2-git-send-email-caesar.wang@rock-chips.com>
References: <1405774529-26027-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1405774529-26027-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: heiko@sntech.de, thierry.reding@gmail.com, b.galvani@gmail.com
Cc: cf@rock-chips.com, huangtao@rock-chips.com, addy.ke@rock-chips.com, xjq@rock-chips.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
index 3182126..bb6e7f1 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
@@ -1,11 +1,14 @@
 Rockchip PWM controller
 
 Required properties:
- - compatible: should be "rockchip,rk2928-pwm"
- - reg: physical base address and length of the controller's registers
- - clocks: phandle and clock specifier of the PWM reference clock
- - #pwm-cells: should be 2. See pwm.txt in this directory for a
-   description of the cell format.
+- compatible: should be "rockchip,<name>-pwm"should be one of following:
+    "rockchip,rk2928-pwm" - support the old version PWM for RK29xx,RK3066,RK3188 SoCs.
+    "rockchip,rk3288-pwm" - support the new version PWM for RK3036,RK3288 SoCs.
+    "rockchip,vop-pwm" - support rockchip integrated VOP-PWM for RK32 SoCs.
+- reg: physical base address and length of the controller's registers.
+- clocks: phandle and clock specifier of the PWM reference clock.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a
+  description of the cell format.
 
 Example:
 
-- 
1.9.1


