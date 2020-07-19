From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 14/19] backlight: cr_bllcd: introduce gpio-backlight semantics
Date: Sun, 19 Jul 2020 10:07:38 +0200
Message-ID: <20200719080743.8560-15-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:25 -0400
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>

cr_bllcd can turn backlight ON or OFF.
Fix semantitics so they equals what we know from gpio-backlight.
brightness == 0   => backlight off
brightness == 1   => backlight on

Use the backlight_get_brightness() helper to simplify the code.

v2:
  - reworked to introduce gpio-backlight semantics (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/cr_bllcd.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
index 4624b7b7c6a6..a24d42e1ea3c 100644
--- a/drivers/video/backlight/cr_bllcd.c
+++ b/drivers/video/backlight/cr_bllcd.c
@@ -63,22 +63,15 @@ static int cr_backlight_set_intensity(struct backlight_device *bd)
 	u32 addr = gpio_bar + CRVML_PANEL_PORT;
 	u32 cur = inl(addr);
 
-	if (bd->props.power == FB_BLANK_UNBLANK)
-		intensity = FB_BLANK_UNBLANK;
-	if (bd->props.fb_blank == FB_BLANK_UNBLANK)
-		intensity = FB_BLANK_UNBLANK;
-	if (bd->props.power == FB_BLANK_POWERDOWN)
-		intensity = FB_BLANK_POWERDOWN;
-	if (bd->props.fb_blank == FB_BLANK_POWERDOWN)
-		intensity = FB_BLANK_POWERDOWN;
-
-	if (intensity == FB_BLANK_UNBLANK) { /* FULL ON */
-		cur &= ~CRVML_BACKLIGHT_OFF;
-		outl(cur, addr);
-	} else if (intensity == FB_BLANK_POWERDOWN) { /* OFF */
+	if (backlight_get_brightness(bd) == 0) {
+		/* OFF */
 		cur |= CRVML_BACKLIGHT_OFF;
 		outl(cur, addr);
-	} /* anything else, don't bother */
+	} else {
+		/* FULL ON */
+		cur &= ~CRVML_BACKLIGHT_OFF;
+		outl(cur, addr);
+	}
 
 	return 0;
 }
@@ -90,9 +83,9 @@ static int cr_backlight_get_intensity(struct backlight_device *bd)
 	u8 intensity;
 
 	if (cur & CRVML_BACKLIGHT_OFF)
-		intensity = FB_BLANK_POWERDOWN;
+		intensity = 0;
 	else
-		intensity = FB_BLANK_UNBLANK;
+		intensity = 1;
 
 	return intensity;
 }
-- 
2.25.1
