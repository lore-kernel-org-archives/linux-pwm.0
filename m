From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v5 4/5] ARM: dts: rockchip: set PWM delay backlight settings for Veyron.
Date: Fri,  1 Dec 2017 13:06:50 +0100
Message-ID: <20171201120651.29633-4-enric.balletbo@collabora.com>
References: <20171201120651.29633-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171201120651.29633-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

For veyron the binding should provide both PWM timings, the delay between
you enable the PWM and set the enable signal, and the delay between you
disable the PWM signal and clear the enable signal. Update the binding
accordingly, in this case the panels connected to the veyron boards have
a symmetric power sequence, hence the same value is used.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v4:
 - Rebased on top of mainline.
Changes since v3:
 - Use new -ms names for proprieties.
Changes since v2:
 - Use new names for proprieties.
Changes since v1:
 - Add this new patch to fix current binding on veyron.

 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index d752a31..5a8c7f3 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -96,7 +96,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm0 0 1000000 0>;
-		pwm-delay-us = <10000>;
+		post-pwm-on-delay-ms = <10>;
+		pwm-off-delay-ms = <10>;
 	};
 
 	gpio-charger {
-- 
2.9.3
