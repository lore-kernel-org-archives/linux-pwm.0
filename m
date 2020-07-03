From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 13/20] backlight: as3711_bl: simplify update_status
Date: Fri,  3 Jul 2020 20:45:39 +0200
Message-ID: <20200703184546.144664-14-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgGCSqb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:31 -0400
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>

Replaces the open-coded checks of the state, with the
backlight_get_brightness() helper. This increases readability
of the code and align the functionality across the drivers.

Futhermore drop the debug prints in update_status().
If we need debug printing then we can add it to the backlight core.

v2:
  - Use backlight_get_brightness()

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
---
 drivers/video/backlight/as3711_bl.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 33f0f0f2e8b3..3b60019cdc2b 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -104,17 +104,10 @@ static int as3711_bl_update_status(struct backlight_device *bl)
 	struct as3711_bl_data *data = bl_get_data(bl);
 	struct as3711_bl_supply *supply = to_supply(data);
 	struct as3711 *as3711 = supply->as3711;
-	int brightness = bl->props.brightness;
+	int brightness;
 	int ret = 0;
 
-	dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
-		__func__, bl->props.brightness, bl->props.power,
-		bl->props.fb_blank, bl->props.state);
-
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		brightness = 0;
+	brightness = backlight_get_brightness(bl);
 
 	if (data->type == AS3711_BL_SU1) {
 		ret = as3711_set_brightness_v(as3711, brightness,
-- 
2.25.1
