From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH 5/5] ARM: dts: sun6i: add pwm backlight for
 reference design tablet
Date: Tue, 11 Oct 2016 14:34:49 +0800
Message-ID: <20161011063449.54775-5-icenowy@aosc.xyz>
References: <20161011063449.54775-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBZ4Q6K7QKGQE6FVQNEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161011063449.54775-1-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The reference tablet design of sun6i uses pwm0 to control the backlight.

As we have PWM support for sun6i now, enable the backlight control.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
 .../boot/dts/sun6i-reference-design-tablet.dtsi    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
index c3fcf16..aa96acf 100644
--- a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	aliases {
@@ -54,6 +55,16 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en_pin>;
+		pwms = <&pwm0 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 0 25 GPIO_ACTIVE_HIGH>; /* PA25 */
+	};
 };
 
 &cpu0 {
@@ -76,6 +87,13 @@
 };
 
 &pio {
+	bl_en_pin: bl_en_pin@0 {
+		allwinner,pins = "PA25";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	mmc0_cd_pin_e708_q1: mmc0_cd_pin@0 {
 		allwinner,pins = "PA8";
 		allwinner,function = "gpio_in";
@@ -91,6 +109,12 @@
 	};
 };
 
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
+
 &p2wi {
 	status = "okay";
 
-- 
2.10.1
