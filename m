From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/5] dt-bindings: pwm: sunxi: add new compatible strings
Date: Wed,  7 Mar 2018 02:07:18 +0000
Message-ID: <20180307020719.6675-5-andre.przywara@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBF4U7XKAKGQE3FKPL4A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180307020719.6675-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The PWM controllers found in the Allwinner A64, H5 and H6 SoCs are fully
compatible to the PWM controllers found in the A13 and H3.
Add new compatible strings for those SoCs to the binding document, so
that they can be safely used, together with a fallback string
(preferably "allwinner,sun5i-a13-pwm").
Add add the optionals "resets" property, needed by the H6.

Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
index 51ff54c8b8ef..b3a127a0e58c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
@@ -7,11 +7,17 @@ Required properties:
     - "allwinner,sun5i-a13-pwm"
     - "allwinner,sun7i-a20-pwm"
     - "allwinner,sun8i-h3-pwm"
+    - "allwinner,sun50i-a64-pwm"
+    - "allwinner,sun50i-h5-pwm"
+    - "allwinner,sun50i-h6-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
     the cells format.
   - clocks: From common clock binding, handle to the parent clock.
 
+Optional properties:
+  - resets: shall be the reset control phandle for the PWM block, if required.
+
 Example:
 
 	pwm: pwm@1c20e00 {
-- 
2.14.1
