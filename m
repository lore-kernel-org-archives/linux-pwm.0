From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 01/13] backlight: refactor fb_notifier_callback()
Date: Mon,  1 Jun 2020 08:51:55 +0200
Message-ID: <20200601065207.492614-2-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAGwT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:19 -0400
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>

Increase readability of fb_notifier_callback() by removing
a few indent levels.
No functional change.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 43 +++++++++++++++--------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index cac3e35d7630..17f04cff50ab 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -58,28 +58,29 @@ static int fb_notifier_callback(struct notifier_block *self,
 
 	bd = container_of(self, struct backlight_device, fb_notif);
 	mutex_lock(&bd->ops_lock);
-	if (bd->ops)
-		if (!bd->ops->check_fb ||
-		    bd->ops->check_fb(bd, evdata->info)) {
-			fb_blank = *(int *)evdata->data;
-			if (fb_blank == FB_BLANK_UNBLANK &&
-			    !bd->fb_bl_on[node]) {
-				bd->fb_bl_on[node] = true;
-				if (!bd->use_count++) {
-					bd->props.state &= ~BL_CORE_FBBLANK;
-					bd->props.fb_blank = FB_BLANK_UNBLANK;
-					backlight_update_status(bd);
-				}
-			} else if (fb_blank != FB_BLANK_UNBLANK &&
-				   bd->fb_bl_on[node]) {
-				bd->fb_bl_on[node] = false;
-				if (!(--bd->use_count)) {
-					bd->props.state |= BL_CORE_FBBLANK;
-					bd->props.fb_blank = fb_blank;
-					backlight_update_status(bd);
-				}
-			}
+
+	if (!bd->ops)
+		goto out;
+	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
+		goto out;
+
+	fb_blank = *(int *)evdata->data;
+	if (fb_blank == FB_BLANK_UNBLANK && !bd->fb_bl_on[node]) {
+		bd->fb_bl_on[node] = true;
+		if (!bd->use_count++) {
+			bd->props.state &= ~BL_CORE_FBBLANK;
+			bd->props.fb_blank = FB_BLANK_UNBLANK;
+			backlight_update_status(bd);
+		}
+	} else if (fb_blank != FB_BLANK_UNBLANK && bd->fb_bl_on[node]) {
+		bd->fb_bl_on[node] = false;
+		if (!(--bd->use_count)) {
+			bd->props.state |= BL_CORE_FBBLANK;
+			bd->props.fb_blank = fb_blank;
+			backlight_update_status(bd);
 		}
+	}
+out:
 	mutex_unlock(&bd->ops_lock);
 	return 0;
 }
-- 
2.25.1
