From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 1/5] pwm-backlight: enable/disable the PWM before/after LCD enable toggle.
Date: Fri, 21 Jul 2017 12:48:09 +0200
Message-ID: <20170721104813.5389-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49960 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdGUKsa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jul 2017 06:48:30 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org

Before this patch the enable signal was set before the PWM signal and
vice-versa on power off. This sequence is wrong, at least, it is on
the different panels datasheets that I checked, so I inverted the sequence
to follow the specs.

For reference the following panels have the mentioned sequence:
  - N133HSE-EA1 (Innolux)
  - N116BGE (Innolux)
  - N156BGE-L21 (Innolux)
  - B101EAN0 (Auo)
  - B101AW03 (Auo)
  - LTN101NT05 (Samsung)
  - CLAA101WA01A (Chunghwa)

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v3:
 - List the part numbers for the panel checked (Daniel Thompson)
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
