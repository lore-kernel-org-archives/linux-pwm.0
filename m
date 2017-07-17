From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 5/5] ARM: dts: rockchip: set PWM delay backlight settings for Minnie
Date: Mon, 17 Jul 2017 23:28:11 +0200
Message-ID: <20170717212811.25374-5-enric.balletbo@collabora.com>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717212811.25374-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The minnie devices comes with an AUO B101EAN01 panel which is different
from default veyron devices, thus the power on/off timing sequence is
slightly different. The datasheet specifies a pwm delay of 200 ms, so
update the PMW delay proprieties accordingly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Heiko,
 I'm not able to test this patch in a minnie device because I don't have
one, so could you do a quick try, please?

Changes since v2:
 - Use new names for proprieties.
Changes since v1:
 - Add this new patch as minnie has differents timings

 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 544de60..a5b7387 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -123,6 +123,8 @@
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 	power-supply = <&backlight_regulator>;
+	post-pwm-on-delay-us = <20000>;
+	pwm-off-delay-us = <20000>;
 };
 
 &emmc {
-- 
2.9.3
