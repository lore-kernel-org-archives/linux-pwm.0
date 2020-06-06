From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 06/16] pwm: lpss: Add debug prints, test patch for moving i915 to atomic PWM
Date: Sat,  6 Jun 2020 22:25:51 +0200
Message-ID: <20200606202601.48410-7-hdegoede@redhat.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200606202601.48410-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add debug prints, test patch for moving i915 to atomic PWM.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 2cb0e2a9c08c..c1f8e6da0cd7 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -119,6 +119,8 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 		ctrl |= PWM_ENABLE;
 
 	if (orig_ctrl != ctrl) {
+		dev_err(pwm->chip->dev, "prepare 0x%08x -> 0x%08lx\n",
+			orig_ctrl, ctrl | PWM_SW_UPDATE);
 		pwm_lpss_write(pwm, ctrl);
 		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
 	}
@@ -126,8 +128,15 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 
 static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
 {
-	if (cond)
-		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
+	if (cond) {
+		u32 orig_ctrl, ctrl;
+
+		orig_ctrl = ctrl = pwm_lpss_read(pwm);
+		ctrl |= PWM_ENABLE;
+		dev_err(pwm->chip->dev, "enable 0x%08x -> 0x%08x\n",
+			orig_ctrl, ctrl);
+		pwm_lpss_write(pwm, ctrl);
+	}
 }
 
 static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -200,6 +209,9 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->enabled = !!(ctrl & PWM_ENABLE);
 
 	pm_runtime_put(chip->dev);
+
+	dev_err(pwm->chip->dev, "initial state 0x%08x period %d duty_cycle %d enabled %d\n",
+		ctrl, state->period, state->duty_cycle, state->enabled);
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
-- 
2.26.2
