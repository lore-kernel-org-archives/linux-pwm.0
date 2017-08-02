From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 16/23] dt-bindings: pwm: add description for rv1108 pwm
Date: Wed,  2 Aug 2017 16:47:55 +0800
Message-ID: <1501663675-12591-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add device tree bindings document for pwm on
rockchip rv1108 soc.

Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2: None

 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
index 2350ef9..b49f121 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
@@ -3,7 +3,7 @@ Rockchip PWM controller
 Required properties:
  - compatible: should be "rockchip,<name>-pwm"
    "rockchip,rk2928-pwm": found on RK29XX,RK3066 and RK3188 SoCs
-   "rockchip,rk3288-pwm": found on RK3288 SoC
+   "rockchip,rk3288-pwm": found on RK3288 and RV1108 SoCs
    "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
  - reg: physical base address and length of the controller's registers
  - clocks: See ../clock/clock-bindings.txt
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
