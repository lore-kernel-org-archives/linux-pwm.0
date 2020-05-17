From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 14/16] backlight: drop backlight_put()
Date: Sun, 17 May 2020 21:01:37 +0200
Message-ID: <20200517190139.740249-15-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTC0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:26 -0400
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Russell King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>

There are no external users of backlight_put().
Drop it and open code the two users in backlight.c.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c |  7 +++++--
 include/linux/backlight.h           | 10 ----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index e23b09d03a65..7f3eecaf8317 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -679,7 +679,10 @@ static struct backlight_device *of_find_backlight(struct device *dev)
 
 static void devm_backlight_release(void *data)
 {
-	backlight_put(data);
+	struct backlight_device *bd = data;
+
+	if (bd)
+		put_device(&bd->dev);
 }
 
 /**
@@ -707,7 +710,7 @@ struct backlight_device *devm_of_find_backlight(struct device *dev)
 		return bd;
 	ret = devm_add_action(dev, devm_backlight_release, bd);
 	if (ret) {
-		backlight_put(bd);
+		put_device(&bd->dev);
 		return ERR_PTR(ret);
 	}
 	return bd;
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 99e7cdace2be..d92e523650ec 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -415,16 +415,6 @@ static inline int backlight_disable(struct backlight_device *bd)
 	return backlight_update_status(bd);
 }
 
-/**
- * backlight_put - Drop backlight reference
- * @bd: the backlight device to put
- */
-static inline void backlight_put(struct backlight_device *bd)
-{
-	if (bd)
-		put_device(&bd->dev);
-}
-
 /**
  * backlight_is_blank - Return true if display is expected to be blank
  * @bd: the backlight device
-- 
2.25.1
