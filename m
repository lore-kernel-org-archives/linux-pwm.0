From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 15/15] drm/i915: panel: Use atomic PWM API for devs with an external PWM controller
Date: Sat, 20 Jun 2020 14:17:58 +0200
Message-ID: <20200620121758.14836-16-hdegoede@redhat.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200620121758.14836-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Now that the PWM drivers which we use have been converted to the atomic
PWM API, we can move the i915 panel code over to using the atomic PWM API.

The removes a long standing FIXME and this removes a flicker where
the backlight brightness would jump to 100% when i915 loads even if
using the fastset path.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../drm/i915/display/intel_display_types.h    |  3 +-
 drivers/gpu/drm/i915/display/intel_panel.c    | 73 +++++++++----------
 2 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index de32f9efb120..4bd9981e70a1 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -28,6 +28,7 @@
 
 #include <linux/async.h>
 #include <linux/i2c.h>
+#include <linux/pwm.h>
 #include <linux/sched/clock.h>
 
 #include <drm/drm_atomic.h>
@@ -223,7 +224,7 @@ struct intel_panel {
 		bool util_pin_active_low;	/* bxt+ */
 		u8 controller;		/* bxt+ only */
 		struct pwm_device *pwm;
-		int pwm_period_ns;
+		struct pwm_state pwm_state;
 
 		/* DPCD backlight */
 		u8 pwmgen_bit_count;
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index cb28b9908ca4..a0f76343f381 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -592,10 +592,11 @@ static u32 bxt_get_backlight(struct intel_connector *connector)
 static u32 pwm_get_backlight(struct intel_connector *connector)
 {
 	struct intel_panel *panel = &connector->panel;
-	int duty_ns;
+	int duty_ns, period_ns;
 
 	duty_ns = pwm_get_duty_cycle(panel->backlight.pwm);
-	return DIV_ROUND_UP(duty_ns * 100, panel->backlight.pwm_period_ns);
+	period_ns = pwm_get_period(panel->backlight.pwm);
+	return DIV_ROUND_UP(duty_ns * 100, period_ns);
 }
 
 static void lpt_set_backlight(const struct drm_connector_state *conn_state, u32 level)
@@ -669,10 +670,10 @@ static void bxt_set_backlight(const struct drm_connector_state *conn_state, u32
 static void pwm_set_backlight(const struct drm_connector_state *conn_state, u32 level)
 {
 	struct intel_panel *panel = &to_intel_connector(conn_state->connector)->panel;
-	int duty_ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
 
-	pwm_config(panel->backlight.pwm, duty_ns,
-		   panel->backlight.pwm_period_ns);
+	panel->backlight.pwm_state.duty_cycle =
+		DIV_ROUND_UP(level * panel->backlight.pwm_state.period, 100);
+	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
 }
 
 static void
@@ -841,10 +842,8 @@ static void pwm_disable_backlight(const struct drm_connector_state *old_conn_sta
 	struct intel_connector *connector = to_intel_connector(old_conn_state->connector);
 	struct intel_panel *panel = &connector->panel;
 
-	/* Disable the backlight */
-	intel_panel_actually_set_backlight(old_conn_state, 0);
-	usleep_range(2000, 3000);
-	pwm_disable(panel->backlight.pwm);
+	panel->backlight.pwm_state.enabled = false;
+	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
 }
 
 void intel_panel_disable_backlight(const struct drm_connector_state *old_conn_state)
@@ -1176,9 +1175,14 @@ static void pwm_enable_backlight(const struct intel_crtc_state *crtc_state,
 {
 	struct intel_connector *connector = to_intel_connector(conn_state->connector);
 	struct intel_panel *panel = &connector->panel;
+	int level = panel->backlight.level;
 
-	pwm_enable(panel->backlight.pwm);
-	intel_panel_actually_set_backlight(conn_state, panel->backlight.level);
+	level = intel_panel_compute_brightness(connector, level);
+
+	panel->backlight.pwm_state.duty_cycle =
+		DIV_ROUND_UP(level * panel->backlight.pwm_state.period, 100);
+	panel->backlight.pwm_state.enabled = true;
+	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
 }
 
 static void __intel_panel_enable_backlight(const struct intel_crtc_state *crtc_state,
@@ -1897,8 +1901,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct intel_panel *panel = &connector->panel;
 	const char *desc;
-	u32 level, ns;
-	int retval;
+	u32 level;
 
 	/* Get the right PWM chip for DSI backlight according to VBT */
 	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
@@ -1916,36 +1919,30 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 		return -ENODEV;
 	}
 
-	panel->backlight.pwm_period_ns = NSEC_PER_SEC /
-					 get_vbt_pwm_freq(dev_priv);
-
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(panel->backlight.pwm);
-
 	panel->backlight.max = 100; /* 100% */
 	panel->backlight.min = get_backlight_min_vbt(connector);
-	level = intel_panel_compute_brightness(connector, 100);
-	ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
 
-	retval = pwm_config(panel->backlight.pwm, ns,
-			    panel->backlight.pwm_period_ns);
-	if (retval < 0) {
-		drm_err(&dev_priv->drm, "Failed to configure the pwm chip\n");
-		pwm_put(panel->backlight.pwm);
-		panel->backlight.pwm = NULL;
-		return retval;
+	if (pwm_is_enabled(panel->backlight.pwm) &&
+	    pwm_get_period(panel->backlight.pwm)) {
+		/* PWM is already enabled, use existing settings */
+		pwm_get_state(panel->backlight.pwm, &panel->backlight.pwm_state);
+
+		level = DIV_ROUND_UP(panel->backlight.pwm_state.duty_cycle *
+					100, panel->backlight.pwm_state.period);
+		level = intel_panel_compute_brightness(connector, level);
+		panel->backlight.level = clamp(level, panel->backlight.min,
+					       panel->backlight.max);
+		panel->backlight.enabled = true;
+
+		drm_dbg_kms(&dev_priv->drm, "PWM already enabled at freq %ld, VBT freq %d, level %d\n",
+			    NSEC_PER_SEC / panel->backlight.pwm_state.period,
+			    get_vbt_pwm_freq(dev_priv), level);
+	} else {
+		/* Set period from VBT frequency, leave other setting at 0. */
+		panel->backlight.pwm_state.period =
+			NSEC_PER_SEC / get_vbt_pwm_freq(dev_priv);
 	}
 
-	level = DIV_ROUND_UP(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
-			     panel->backlight.pwm_period_ns);
-	level = intel_panel_compute_brightness(connector, level);
-	panel->backlight.level = clamp(level, panel->backlight.min,
-				       panel->backlight.max);
-	panel->backlight.enabled = panel->backlight.level != 0;
-
 	drm_info(&dev_priv->drm, "Using %s PWM for LCD backlight control\n",
 		 desc);
 	return 0;
-- 
2.26.2
