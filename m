From: caesar <caesar.wang@rock-chips.com>
Subject: [PATCH 1/2] pwm: add this series patch to introduce for rk-pwm and vop-pwm.
Date: Thu, 17 Jul 2014 14:08:13 +0800
Message-ID: <1405577294-19336-2-git-send-email-caesar.wang@rock-chips.com>
References: <1405577294-19336-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.4]:55330 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbaGQGPH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jul 2014 02:15:07 -0400
In-Reply-To: <1405577294-19336-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, addy.ke@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, hj@rock-chips.com, caesar <caesar.wang@rock-chips.com>

Signed-off-by: caesar <caesar.wang@rock-chips.com>
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


