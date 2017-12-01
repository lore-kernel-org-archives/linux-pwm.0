From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v5 5/5] ARM: dts: rockchip: set PWM delay backlight settings for Minnie
Date: Fri,  1 Dec 2017 13:06:51 +0100
Message-ID: <20171201120651.29633-5-enric.balletbo@collabora.com>
References: <20171201120651.29633-1-enric.balletbo@collabora.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbdLAMHG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Dec 2017 07:07:06 -0500
In-Reply-To: <20171201120651.29633-1-enric.balletbo@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org

The minnie devices comes with an AUO B101EAN01 panel which is different
from default veyron devices, thus the power on/off timing sequence is
slightly different. The datasheet specifies a pwm delay of 200 ms, so
update the PMW delay proprieties accordingly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Heiko,
 I'm not able to test this patch in a minnie device because I don't have
one, so could you do a quick try, please?

Changes since v4:
 - Rebase on top of mainline.
Changes since v3:
 - Use new -ms names for proprieties.
 - Fix the delay, should be 200ms instead of 20ms (Pavel)
Changes since v2:
 - Use new names for proprieties.
Changes since v1:
 - Add this new patch as minnie has differents timings

 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 544de60..4c5307e6 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -123,6 +123,8 @@
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 	power-supply = <&backlight_regulator>;
+	post-pwm-on-delay-ms = <200>;
+	pwm-off-delay-ms = <200>;
 };
 
 &emmc {
-- 
2.9.3
