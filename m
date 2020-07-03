From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 20/20] backlight: make of_find_backlight_by_node() static
Date: Fri,  3 Jul 2020 20:45:46 +0200
Message-ID: <20200703184546.144664-21-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>
List-Id: linux-pwm@vger.kernel.org

There are no external users of of_find_backlight_by_node().
Make it static so we keep it that way.

v2:
  - drop EXPORT of of_find_backlight_by_node

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 23 +++++++++--------------
 include/linux/backlight.h           | 10 ----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 06f4da3c58e1..ff84e6607486 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -649,19 +649,9 @@ static int of_parent_match(struct device *dev, const void *data)
 	return dev->parent && dev->parent->of_node == data;
 }
 
-/**
- * of_find_backlight_by_node() - find backlight device by device-tree node
- * @node: device-tree node of the backlight device
- *
- * Returns a pointer to the backlight device corresponding to the given DT
- * node or NULL if no such backlight device exists or if the device hasn't
- * been probed yet.
- *
- * This function obtains a reference on the backlight device and it is the
- * caller's responsibility to drop the reference by calling put_device() on
- * the backlight device's .dev field.
- */
-struct backlight_device *of_find_backlight_by_node(struct device_node *node)
+/* Find backlight device by device-tree node */
+static struct backlight_device *
+of_find_backlight_by_node(struct device_node *node)
 {
 	struct device *dev;
 
@@ -669,7 +659,12 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 
 	return dev ? to_backlight_device(dev) : NULL;
 }
-EXPORT_SYMBOL(of_find_backlight_by_node);
+#else
+static struct backlight_device *
+of_find_backlight_by_node(struct device_node *node)
+{
+	return NULL;
+}
 #endif
 
 static struct backlight_device *of_find_backlight(struct device *dev)
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 8b43fd90d84a..fa443899b4ee 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -466,16 +466,6 @@ static inline void * bl_get_data(struct backlight_device *bl_dev)
 	return dev_get_drvdata(&bl_dev->dev);
 }
 
-#ifdef CONFIG_OF
-struct backlight_device *of_find_backlight_by_node(struct device_node *node);
-#else
-static inline struct backlight_device *
-of_find_backlight_by_node(struct device_node *node)
-{
-	return NULL;
-}
-#endif
-
 #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 struct backlight_device *devm_of_find_backlight(struct device *dev);
 #else
-- 
2.25.1
