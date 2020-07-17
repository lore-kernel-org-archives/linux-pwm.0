From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 05/16] pwm: lpss: Add pwm_lpss_prepare_enable() helper
Date: Fri, 17 Jul 2020 15:37:42 +0200
Message-ID: <20200717133753.127282-6-hdegoede@redhat.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60906 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726429AbgGQNiU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 09:38:20 -0400
In-Reply-To: <20200717133753.127282-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

In the not-enabled -> enabled path pwm_lpss_apply() needs to get a
runtime-pm reference; and then on any errors it needs to release it
again.

This leads to somewhat hard to read code. This commit introduces a new
pwm_lpss_prepare_enable() helper and moves all the steps necessary for
the not-enabled -> enabled transition there, so that we can error check
the entire transition in a single place and only have one pm_runtime_put()
on failure call site.

While working on this I noticed that the enabled -> enabled (update
settings) path was quite similar, so I've added an enable parameter to
the new pwm_lpss_prepare_enable() helper, which allows using it in that
path too.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 45 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index da9bc3d10104..8a136ba2a583 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -122,41 +122,48 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 }
 
+static int pwm_lpss_prepare_enable(struct pwm_lpss_chip *lpwm,
+				   struct pwm_device *pwm,
+				   const struct pwm_state *state,
+				   bool enable)
+{
+	int ret;
+
+	ret = pwm_lpss_is_updating(pwm);
+	if (ret)
+		return ret;
+
+	pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
+	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == false);
+	ret = pwm_lpss_wait_for_update(pwm);
+	if (ret)
+		return ret;
+
+	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == true);
+	return 0;
+}
+
 static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
-	int ret;
+	int ret = 0;
 
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
 			pm_runtime_get_sync(chip->dev);
-			ret = pwm_lpss_is_updating(pwm);
-			if (ret) {
-				pm_runtime_put(chip->dev);
-				return ret;
-			}
-			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
-			ret = pwm_lpss_wait_for_update(pwm);
-			if (ret) {
+			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
+			if (ret)
 				pm_runtime_put(chip->dev);
-				return ret;
-			}
-			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
 		} else {
-			ret = pwm_lpss_is_updating(pwm);
-			if (ret)
-				return ret;
-			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			return pwm_lpss_wait_for_update(pwm);
+			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
 		pm_runtime_put(chip->dev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.26.2
