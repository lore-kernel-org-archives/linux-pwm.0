From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 1/5] pwm-backlight: enable/disable the PWM before/after LCD enable toggle.
Date: Mon, 17 Jul 2017 23:28:07 +0200
Message-ID: <20170717212811.25374-1-enric.balletbo@collabora.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34928 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdGQV20 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jul 2017 17:28:26 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org

Before this patch the enable signal was set before the PWM signal and
vice-versa on power off. I guess that this sequence is wrong, at least,
it is on the different panels datasheets that I checked, so I inverted
the sequence to follow the specs.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v2:
 - Add this as a separate patch (Thierry Reding)
Changes since v1:
 - None

 drivers/video/backlight/pwm_bl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 002f1ce..909a686 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
+	pwm_enable(pb->pwm);
+
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
 	pb->enabled = true;
 }
 
@@ -66,12 +67,12 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
-
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
+	pwm_config(pb->pwm, 0, pb->period);
+	pwm_disable(pb->pwm);
+
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
 }
-- 
2.9.3
