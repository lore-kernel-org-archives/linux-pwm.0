From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 07/20] backlight: document enums in backlight.h
Date: Fri,  3 Jul 2020 20:45:33 +0200
Message-ID: <20200703184546.144664-8-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgGCSqT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:19 -0400
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>

Add kernel-doc documentation for the backlight enums

v2:
  - Add intro to each enum member (Daniel)
    Except backlight type as line lenght was too long.
    The generated HTML is the same.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 7d6cb61e10f5..0f425b32e6be 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -14,26 +14,98 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
+/**
+ * enum backlight_update_reason - what method was used to update backlight
+ *
+ * A driver indicates the method (reason) used for updating the backlight
+ * when calling backlight_force_update().
+ */
 enum backlight_update_reason {
+	/**
+	 * @BACKLIGHT_UPDATE_HOTKEY: The backlight was updated using a hot-key.
+	 */
 	BACKLIGHT_UPDATE_HOTKEY,
+
+	/**
+	 * @BACKLIGHT_UPDATE_SYSFS: The backlight was updated using sysfs.
+	 */
 	BACKLIGHT_UPDATE_SYSFS,
 };
 
+/**
+ * enum backlight_type - the type of backlight control
+ *
+ * The type of interface used to control the backlight.
+ */
 enum backlight_type {
+	/**
+	 * @BACKLIGHT_RAW:
+	 *
+	 * The backlight is controlled using hardware registers.
+	 */
 	BACKLIGHT_RAW = 1,
+
+	/**
+	 * @BACKLIGHT_PLATFORM:
+	 *
+	 * The backlight is controlled using a platform-specific interface.
+	 */
 	BACKLIGHT_PLATFORM,
+
+	/**
+	 * @BACKLIGHT_FIRMWARE:
+	 *
+	 * The backlight is controlled using a standard firmware interface.
+	 */
 	BACKLIGHT_FIRMWARE,
+
+	/**
+	 * @BACKLIGHT_TYPE_MAX: Number of entries.
+	 */
 	BACKLIGHT_TYPE_MAX,
 };
 
+/**
+ * enum backlight_notification - the type of notification
+ *
+ * The notifications that is used for notification sent to the receiver
+ * that registered notifications using backlight_register_notifier().
+ */
 enum backlight_notification {
+	/**
+	 * @BACKLIGHT_REGISTERED: The backlight device is registered.
+	 */
 	BACKLIGHT_REGISTERED,
+
+	/**
+	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
+	 */
 	BACKLIGHT_UNREGISTERED,
 };
 
+/** enum backlight_scale - the type of scale used for brightness values
+ *
+ * The type of scale used for brightness values.
+ */
 enum backlight_scale {
+	/**
+	 * @BACKLIGHT_SCALE_UNKNOWN: The scale is unknown.
+	 */
 	BACKLIGHT_SCALE_UNKNOWN = 0,
+
+	/**
+	 * @BACKLIGHT_SCALE_LINEAR: The scale is linear.
+	 *
+	 * The linear scale will increase brightness the same for each step.
+	 */
 	BACKLIGHT_SCALE_LINEAR,
+
+	/**
+	 * @BACKLIGHT_SCALE_NON_LINEAR: The scale is not linear.
+	 *
+	 * This is often used when the brightness values tries to adjust to
+	 * the relative perception of the eye demanding a non-linear scale.
+	 */
 	BACKLIGHT_SCALE_NON_LINEAR,
 };
 
-- 
2.25.1
