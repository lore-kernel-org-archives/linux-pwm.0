From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 2/5] dt-bindings: pwm-backlight: add PWM delay proprieties.
Date: Mon, 17 Jul 2017 23:28:08 +0200
Message-ID: <20170717212811.25374-2-enric.balletbo@collabora.com>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717212811.25374-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hardware needs a delay between setting an initial (non-zero) PWM and
enabling the backlight using GPIO. The post-pwm-on-delay-us specifies
this delay in micro seconds. Hardware also needs a delay between disabing
the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-us
is this delay in micro seconds.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Based on the original Huang Lin <hl@rock-chips.com> work.

Changes since v2:
 - Use separate properties (Rob Herring)
Changes since v1:
 - As suggested by Daniel Thompson
   - Do not assume power-on delay and power-off delay will be the same

 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 764db86..810527c 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -17,6 +17,10 @@ Optional properties:
                "pwms" property (see PWM binding[0])
   - enable-gpios: contains a single GPIO specifier for the GPIO which enables
                   and disables the backlight (see GPIO binding[1])
+  - post-pwm-on-delay-us: Delay in us between setting an initial (non-zero) PWM
+                          and enabling the backlight using GPIO.
+  - pwm-off-delay-us: Delay in us between disabling the backlight using GPIO
+                      and setting PWM value to 0.
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
@@ -32,4 +36,6 @@ Example:
 
 		power-supply = <&vdd_bl_reg>;
 		enable-gpios = <&gpio 58 0>;
+		post-pwm-on-delay-us = <10000>;
+		pwm-off-delay-us = <10000>;
 	};
-- 
2.9.3
