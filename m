From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v3 1/2] pwm: rockchip: document RK3288 SoC compatible
Date: Wed, 23 Jul 2014 14:38:40 +0800
Message-ID: <1406097521-6457-2-git-send-email-caesar.wang@rock-chips.com>
References: <1406097521-6457-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.4]:47216 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbaGWGjT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jul 2014 02:39:19 -0400
In-Reply-To: <1406097521-6457-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: heiko@sntech.de, thierry.reding@gmail.com, b.galvani@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, huangtao@rock-chips.com, hj@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com, Caesar Wang <caesar.wang@rock-chips.com>

Document new compatible for PWM founding on RK3288 SoC

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
index 3182126..2b7c109 100644
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


