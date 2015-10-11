From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 3/4] ARM: dts: sunxi: Enable PWM controller on Q8 format tablets
Date: Sun, 11 Oct 2015 11:55:07 +0200
Message-ID: <1444557308-10892-3-git-send-email-hdegoede@redhat.com>
References: <1444557308-10892-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444557308-10892-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Q8 format tablets use channel 0 of the PWM controller for backlight dimming.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
-Enable the pwm controller in sunxi-q8-common.dtsi rather then in
 sun8i-q8-common.dtsi
---
 arch/arm/boot/dts/sunxi-q8-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-q8-common.dtsi b/arch/arm/boot/dts/sunxi-q8-common.dtsi
index 17b26ff..b824146 100644
--- a/arch/arm/boot/dts/sunxi-q8-common.dtsi
+++ b/arch/arm/boot/dts/sunxi-q8-common.dtsi
@@ -75,3 +75,9 @@
 		voltage = <400000>;
 	};
 };
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
