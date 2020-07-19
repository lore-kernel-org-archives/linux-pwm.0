From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 05/19] backlight: improve backlight_device documentation
Date: Sun, 19 Jul 2020 10:07:29 +0200
Message-ID: <20200719080743.8560-6-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>
List-Id: linux-pwm@vger.kernel.org

Improve the documentation for backlight_device and
adapt it to kernel-doc style.

The updated documentation is more strict on how locking is used.
With the update neither update_lock nor ops_lock may be used
outside the backlight core.
This restriction was introduced to keep the locking simple
by keeping it in the core.
It was verified that this documents the current state by renaming
update_lock => bl_update_lock and ops_lock => bl_ops_lock.
The rename did not reveal any uses outside the backlight core.
The rename is NOT part of this patch.

v3:
  - Update changelog to explain locking details (Daniel)

v2:
  - Add short intro to all fields (Daniel)
  - Updated description of update_lock (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 72 ++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 10518b00b059..7654fe5f1589 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -14,21 +14,6 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
-/* Notes on locking:
- *
- * backlight_device->ops_lock is an internal backlight lock protecting the
- * ops pointer and no code outside the core should need to touch it.
- *
- * Access to update_status() is serialised by the update_lock mutex since
- * most drivers seem to need this and historically get it wrong.
- *
- * Most drivers don't need locking on their get_brightness() method.
- * If yours does, you need to implement it in the driver. You can use the
- * update_lock mutex if appropriate.
- *
- * Any other use of the locks below is probably wrong.
- */
-
 enum backlight_update_reason {
 	BACKLIGHT_UPDATE_HOTKEY,
 	BACKLIGHT_UPDATE_SYSFS,
@@ -215,30 +200,71 @@ struct backlight_properties {
 	enum backlight_scale scale;
 };
 
+/**
+ * struct backlight_device - backlight device data
+ *
+ * This structure holds all data required by a backlight device.
+ */
 struct backlight_device {
-	/* Backlight properties */
+	/**
+	 * @props: Backlight properties
+	 */
 	struct backlight_properties props;
 
-	/* Serialise access to update_status method */
+	/**
+	 * @update_lock: The lock used when calling the update_status() operation.
+	 *
+	 * update_lock is an internal backlight lock that serialise access
+	 * to the update_status() operation. The backlight core holds the update_lock
+	 * when calling the update_status() operation. The update_lock shall not
+	 * be used by backlight drivers.
+	 */
 	struct mutex update_lock;
 
-	/* This protects the 'ops' field. If 'ops' is NULL, the driver that
-	   registered this device has been unloaded, and if class_get_devdata()
-	   points to something in the body of that driver, it is also invalid. */
+	/**
+	 * @ops_lock: The lock used around everything related to backlight_ops.
+	 *
+	 * ops_lock is an internal backlight lock that protects the ops pointer
+	 * and is used around all accesses to ops and when the operations are
+	 * invoked. The ops_lock shall not be used by backlight drivers.
+	 */
 	struct mutex ops_lock;
+
+	/**
+	 * @ops: Pointer to the backlight operations.
+	 *
+	 * If ops is NULL, the driver that registered this device has been unloaded,
+	 * and if class_get_devdata() points to something in the body of that driver,
+	 * it is also invalid.
+	 */
 	const struct backlight_ops *ops;
 
-	/* The framebuffer notifier block */
+	/**
+	 * @fb_notif: The framebuffer notifier block
+	 */
 	struct notifier_block fb_notif;
 
-	/* list entry of all registered backlight devices */
+	/**
+	 * @entry: List entry of all registered backlight devices
+	 */
 	struct list_head entry;
 
+	/**
+	 * @dev: Parent device.
+	 */
 	struct device dev;
 
-	/* Multiple framebuffers may share one backlight device */
+	/**
+	 * @fb_bl_on: The state of individual fbdev's.
+	 *
+	 * Multiple fbdev's may share one backlight device. The fb_bl_on
+	 * records the state of the individual fbdev.
+	 */
 	bool fb_bl_on[FB_MAX];
 
+	/**
+	 * @use_count: The number of uses of fb_bl_on.
+	 */
 	int use_count;
 };
 
-- 
2.25.1
