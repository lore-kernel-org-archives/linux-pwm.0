From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/4] backlight: Expose brightness curve type through sysfs
Date: Thu, 13 Jun 2019 12:43:24 -0700
Message-ID: <20190613194326.180889-3-mka@chromium.org>
References: <20190613194326.180889-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613194326.180889-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Backlight brightness curves can have different shapes. The two main
types are linear and non-linear curves. The human eye doesn't
perceive linearly increasing/decreasing brightness as linear (see
also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
linearly to human eye"), hence many backlights use non-linear (often
logarithmic) brightness curves. The type of curve currently is opaque
to userspace, so userspace often relies on more or less reliable
heuristics (like the number of brightness levels) to decide whether
to treat a backlight device as linear or non-linear.

Export the type of the brightness curve via the new sysfs attribute
'scale'. The value of the attribute may be a simple string like
'linear' or 'non-linear', or a composite string similar to
'compatible' strings of the device tree. A composite string consists
of different elements separated by commas, starting with the
most-detailed description and ending with the least-detailed one. An
example for a composite string is "cie-1931,perceptual,non-linear"
This brightness curve was generated with the CIE 1931 algorithm, it
is perceptually linear, but not actually linear in terms of the
emitted light. If userspace doesn't know about 'cie-1931' or
'perceptual' it should at least be able to interpret the 'non-linear'
part.

For devices that don't provide information about the scale of their
brightness curve the value of the 'scale' attribute is 'unknown'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../ABI/testing/sysfs-class-backlight         | 32 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/video/backlight/backlight.c           | 22 +++++++++++++
 include/linux/backlight.h                     | 10 ++++++
 4 files changed, 65 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

diff --git a/Documentation/ABI/testing/sysfs-class-backlight b/Documentation/ABI/testing/sysfs-class-backlight
new file mode 100644
index 000000000000..924fb68940e6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight
@@ -0,0 +1,32 @@
+What:		/sys/class/backlight/<backlight>/scale
+Date:		June 2019
+KernelVersion:	5.4
+Contact:	Daniel Thompson <daniel.thompson@linaro.org>
+Description:
+		Description of the scale of the brightness curve. The
+		description consists of one or more elements separated by
+		commas, from the most detailed to the least detailed
+		description.
+
+		Possible values are:
+
+		unknown
+		  The scale of the brightness curve is unknown.
+
+		linear
+		  The brightness changes linearly in terms of the emitted
+		  light, changes are perceived as non-linear by the human eye.
+
+		non-linear
+		  The brightness changes non-linearly in terms of the emitted
+		  light, changes might be perceived as linear by the human eye.
+
+		perceptual,non-linear
+		  The brightness changes non-linearly in terms of the emitted
+		  light, changes should be perceived as linear by the human eye.
+
+		cie-1931,perceptual,non-linear
+		  The brightness curves was calculated with the CIE 1931
+		  algorithm. Brightness changes non-linearly in terms of the
+		  emitted light, changes should be perceived as linear by the
+		  human eye.
diff --git a/MAINTAINERS b/MAINTAINERS
index d51e74340870..c46812510ba5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2858,6 +2858,7 @@ F:	include/linux/backlight.h
 F:	include/linux/pwm_backlight.h
 F:	Documentation/devicetree/bindings/leds/backlight
 F:	Documentation/ABI/stable/sysfs-class-backlight
+F:	Documentation/ABI/testing/sysfs-class-backlight
 
 BATMAN ADVANCED
 M:	Marek Lindner <mareklindner@neomailbox.ch>
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 1ef8b6fd62ac..c6e6ea6f2688 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -32,6 +32,15 @@ static const char *const backlight_types[] = {
 	[BACKLIGHT_FIRMWARE] = "firmware",
 };
 
+static const char *const backlight_scale_types[] = {
+	[BACKLIGHT_SCALE_UNKNOWN]	= "unknown",
+	[BACKLIGHT_SCALE_CIE1931]	= "cie-1931,perceptual,non-linear",
+	[BACKLIGHT_SCALE_PERCEPTUAL]	= "perceptual,non-linear",
+	[BACKLIGHT_SCALE_LINEAR]	= "linear",
+	[BACKLIGHT_SCALE_NON_LINEAR]	= "non-linear",
+};
+
+
 #if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
 			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
 /* This callback gets called when something important happens inside a
@@ -246,6 +255,18 @@ static ssize_t actual_brightness_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(actual_brightness);
 
+static ssize_t scale_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct backlight_device *bd = to_backlight_device(dev);
+
+	if (WARN_ON(bd->props.scale > BACKLIGHT_SCALE_NON_LINEAR))
+		return sprintf(buf, "unknown\n");
+
+	return sprintf(buf, "%s\n", backlight_scale_types[bd->props.scale]);
+}
+static DEVICE_ATTR_RO(scale);
+
 static struct class *backlight_class;
 
 #ifdef CONFIG_PM_SLEEP
@@ -292,6 +313,7 @@ static struct attribute *bl_device_attrs[] = {
 	&dev_attr_brightness.attr,
 	&dev_attr_actual_brightness.attr,
 	&dev_attr_max_brightness.attr,
+	&dev_attr_scale.attr,
 	&dev_attr_type.attr,
 	NULL,
 };
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 0b5897446dca..62e4ab162f34 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -46,6 +46,14 @@ enum backlight_notification {
 	BACKLIGHT_UNREGISTERED,
 };
 
+enum backlight_scale {
+	BACKLIGHT_SCALE_UNKNOWN,
+	BACKLIGHT_SCALE_CIE1931 = 1,
+	BACKLIGHT_SCALE_PERCEPTUAL,
+	BACKLIGHT_SCALE_LINEAR,
+	BACKLIGHT_SCALE_NON_LINEAR,	/* needed for backwards compatibility */
+};
+
 struct backlight_device;
 struct fb_info;
 
@@ -80,6 +88,8 @@ struct backlight_properties {
 	enum backlight_type type;
 	/* Flags used to signal drivers of state changes */
 	unsigned int state;
+	/* Type of the brightness scale (linear, non-linear, ...) */
+	enum backlight_scale scale;
 
 #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
 #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
