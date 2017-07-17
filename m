From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 4/5] ARM: dts: rockchip: set PWM delay backlight settings for Veyron.
Date: Mon, 17 Jul 2017 23:28:10 +0200
Message-ID: <20170717212811.25374-4-enric.balletbo@collabora.com>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717212811.25374-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

For veyron the binding should provide both PWM timings, the delay between
you enable the PWM and set the enable signal, and the delay between you
disable the PWM signal and clear the enable signal. Update the binding
accordingly, in this case the panels connected to the veyron boards have
a symmetric power sequence, hence the same value is used.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v2:
 - Use new names for proprieties.
Changes since v1:
 - Add this new patch to fix current binding on veyron.

 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index d752a31..4cef71f 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -96,7 +96,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm0 0 1000000 0>;
-		pwm-delay-us = <10000>;
+		post-pwm-on-delay-us = <10000>;
+		pwm-off-delay-us = <10000>;
 	};
 
 	gpio-charger {
-- 
2.9.3
