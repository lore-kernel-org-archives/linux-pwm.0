From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH 1/3] dt-bindings: add compatible for the PWM
 controller on Allwinner A64
Date: Sat, 25 Feb 2017 15:42:14 +0800
Message-ID: <20170225074216.64868-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBB57KYTCQKGQEKL7HC7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Allwinner A64 have a PWM controller like other Allwinner SoCs.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
index f1cbeefb3087..2f8315aafe22 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
@@ -7,6 +7,7 @@ Required properties:
     - "allwinner,sun5i-a13-pwm"
     - "allwinner,sun7i-a20-pwm"
     - "allwinner,sun8i-h3-pwm"
+    - "allwinner,sun50i-a64-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
     the cells format.
-- 
2.11.1
