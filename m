From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] dt: pwm: bcm2835: fix typo in clocks property name
Date: Mon,  5 Dec 2016 02:10:25 +0200
Message-ID: <20161205001025.13909-1-vz@mleia.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

According to the examples of BCM2835 PWM device nodes there is a typo in
'clocks' property name, which is a common property name on clock consumer
side to store a phandle to an input clock.

Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
index fb6fb31..cf573e8 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
@@ -3,7 +3,7 @@ BCM2835 PWM controller (Raspberry Pi controller)
 Required properties:
 - compatible: should be "brcm,bcm2835-pwm"
 - reg: physical base address and length of the controller's registers
-- clock: This clock defines the base clock frequency of the PWM hardware
+- clocks: This clock defines the base clock frequency of the PWM hardware
   system, the period and the duty_cycle of the PWM signal is a multiple of
   the base period.
 - #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
