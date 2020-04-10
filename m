From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] dt-bindings: pwm: rcar: add r8a77961 support
Date: Fri, 10 Apr 2020 18:14:17 +0900
Message-ID: <1586510057-31562-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add support for r8a77961 (R-Car M3-W+).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 945c14e..620a2ff 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -27,6 +27,7 @@ properties:
           - renesas,pwm-r8a7794   # R-Car E2
           - renesas,pwm-r8a7795   # R-Car H3
           - renesas,pwm-r8a7796   # R-Car M3-W
+          - renesas,pwm-r8a77961  # R-Car M3-W+
           - renesas,pwm-r8a77965  # R-Car M3-N
           - renesas,pwm-r8a77970  # R-Car V3M
           - renesas,pwm-r8a77980  # R-Car V3H
-- 
2.7.4
