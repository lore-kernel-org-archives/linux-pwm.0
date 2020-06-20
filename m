From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 05/15] pwm: lpss: Use pwm_lpss_apply() when
 restoring state on resume
Date: Sat, 20 Jun 2020 14:17:48 +0200
Message-ID: <20200620121758.14836-6-hdegoede@redhat.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200620121758.14836-1-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

Before this commit a suspend + resume of the LPSS PWM controller
would result in the controller being reset to its defaults of
output-freq = clock/256, duty-cycle=100%, until someone changes
to the output-freq and/or duty-cycle are made.

This problem has been masked so far because the main consumer
(the i915 driver) was always making duty-cycle changes on resume.
With the conversion of the i915 driver to the atomic PWM API the
driver now only disables/enables the PWM on suspend/resume leaving
the output-freq and duty as is, triggering this problem.

The LPSS PWM controller has a mechanism where the ctrl register value
and the actual base-unit and on-time-div values used are latched. When
software sets the SW_UPDATE bit then at the end of the current PWM cycle,
the new values from the ctrl-register will be latched into the actual
registers, and the SW_UPDATE bit will be cleared.

The problem is that before this commit our suspend/resume handling
consisted of simply saving the PWM ctrl register on suspend and
restoring it on resume, without setting the PWM_SW_UPDATE bit.
When the controller has lost its state over a suspend/resume and thus
has been reset to the defaults, just restoring the register is not
enough. We must also set the SW_UPDATE bit to tell the controller to
latch the restored values into the actual registers.

Fixing this problem is not as simple as just or-ing in the value which
is being restored with SW_UPDATE. If the PWM was enabled before we must
write the new settings + PWM_SW_UPDATE before setting PWM_ENABLE.
We must also wait for PWM_SW_UPDATE to become 0 again and depending on the
model we must do this either before or after the setting of PWM_ENABLE.

All the necessary logic for doing this is already present inside
pwm_lpss_apply(), so instead of duplicating this inside the resume
handler, this commit makes the resume handler use pwm_lpss_apply() to
restore the settings when necessary. This fixes the output-freq and
duty-cycle being reset to their defaults on resume.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- This replaces the "pwm: lpss: Set SW_UPDATE bit when enabling the PWM"
  patch from previous versions of this patch-set, which really was a hack
  working around the resume issue which this patch fixes properly.
---
 drivers/pwm/pwm-lpss.c | 62 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 80d0f9c64f9d..4f3d60ce9929 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -123,25 +123,31 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 }
 
-static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			  const struct pwm_state *state)
+static int __pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state, bool from_resume)
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	int ret;
 
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
-			pm_runtime_get_sync(chip->dev);
+			if (!from_resume)
+				pm_runtime_get_sync(chip->dev);
+
 			ret = pwm_lpss_is_updating(pwm);
 			if (ret) {
-				pm_runtime_put(chip->dev);
+				if (!from_resume)
+					pm_runtime_put(chip->dev);
+
 				return ret;
 			}
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
 			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
 			ret = pwm_lpss_wait_for_update(pwm);
 			if (ret) {
-				pm_runtime_put(chip->dev);
+				if (!from_resume)
+					pm_runtime_put(chip->dev);
+
 				return ret;
 			}
 			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
@@ -154,12 +160,20 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-		pm_runtime_put(chip->dev);
+
+		if (!from_resume)
+			pm_runtime_put(chip->dev);
 	}
 
 	return 0;
 }
 
+static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	return __pwm_lpss_apply(chip, pwm, state, false);
+}
+
 static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			       struct pwm_state *state)
 {
@@ -272,10 +286,40 @@ EXPORT_SYMBOL_GPL(pwm_lpss_suspend);
 int pwm_lpss_resume(struct device *dev)
 {
 	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
-	int i;
+	struct pwm_state saved_state;
+	struct pwm_device *pwm;
+	int i, ret;
+	u32 ctrl;
 
-	for (i = 0; i < lpwm->info->npwm; i++)
-		writel(lpwm->saved_ctrl[i], lpwm->regs + i * PWM_SIZE + PWM);
+	for (i = 0; i < lpwm->info->npwm; i++) {
+		pwm = &lpwm->chip.pwms[i];
+
+		ctrl = pwm_lpss_read(pwm);
+		/* If we did not reach S0i3/S3 the controller keeps its state */
+		if (ctrl == lpwm->saved_ctrl[i])
+			continue;
+
+		/*
+		 * We cannot just blindly restore the old value here. Since we
+		 * are changing the settings we must set SW_UPDATE and if the
+		 * PWM was enabled before we must write the new settings +
+		 * PWM_SW_UPDATE before setting PWM_ENABLE. We must also wait
+		 * for PWM_SW_UPDATE to become 0 again and depending on the
+		 * model we must do this either before or after the setting of
+		 * PWM_ENABLE.
+		 * So instead of reproducing all the code from pwm_apply() here,
+		 * we just reapply the state as stored in pwm->state.
+		 */
+		saved_state = pwm->state;
+		/*
+		 * Update enabled to its actual setting for the
+		 * enabled<->disabled transitions inside apply().
+		 */
+		pwm->state.enabled = !!(ctrl & PWM_ENABLE);
+		ret = __pwm_lpss_apply(&lpwm->chip, pwm, &saved_state, true);
+		if (ret)
+			dev_err(dev, "Error restoring state on resume\n");
+	}
 
 	return 0;
 }
-- 
2.26.2
