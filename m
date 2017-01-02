From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/4] pwm: lpss: Switch to new atomic API
Date: Mon,  2 Jan 2017 11:16:47 +0200
Message-ID: <20170102091647.86910-5-andriy.shevchenko@linux.intel.com>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6313 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755193AbdABJRW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Jan 2017 04:17:22 -0500
In-Reply-To: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of doing things separately, which is not so reliable on some platforms,
switch the driver to use new atomic API, i.e. ->apply() callback.

The change has been tested on Intel platforms such as Broxton, BayTrail, and
Merrifield.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 63 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index e7d612e9df51..7d3ac8204618 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -85,15 +85,20 @@ static inline void pwm_lpss_write(const struct pwm_device *pwm, u32 value)
 
 static void pwm_lpss_update(struct pwm_device *pwm)
 {
+	/*
+	 * Set a limit for busyloop since not all implementations correctly
+	 * clear PWM_SW_UPDATE bit (at least it's not visible on OS side).
+	 */
+	unsigned int count = 10;
+
 	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
-	/* Give it some time to propagate */
-	usleep_range(10, 50);
+	while (pwm_lpss_read(pwm) & PWM_SW_UPDATE && --count)
+		usleep_range(10, 20);
 }
 
-static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
+static int pwm_lpss_config(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 			   int duty_ns, int period_ns)
 {
-	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	unsigned long long on_time_div;
 	unsigned long c = lpwm->info->clk_rate, base_unit_range;
 	unsigned long long base_unit, freq = NSEC_PER_SEC;
@@ -114,8 +119,6 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(on_time_div, period_ns);
 	on_time_div = 255ULL - on_time_div;
 
-	pm_runtime_get_sync(chip->dev);
-
 	ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~PWM_ON_TIME_DIV_MASK;
 	ctrl &= ~(base_unit_range << PWM_BASE_UNIT_SHIFT);
@@ -124,41 +127,43 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	ctrl |= on_time_div;
 	pwm_lpss_write(pwm, ctrl);
 
-	/*
-	 * If the PWM is already enabled we need to notify the hardware
-	 * about the change by setting PWM_SW_UPDATE.
-	 */
-	if (pwm_is_enabled(pwm))
-		pwm_lpss_update(pwm);
-
-	pm_runtime_put(chip->dev);
-
+	pwm_lpss_update(pwm);
 	return 0;
 }
 
-static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void pwm_lpss_enable(struct pwm_device *pwm)
 {
-	pm_runtime_get_sync(chip->dev);
-
-	/*
-	 * Hardware must first see PWM_SW_UPDATE before the PWM can be
-	 * enabled.
-	 */
-	pwm_lpss_update(pwm);
 	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
-	return 0;
 }
 
-static void pwm_lpss_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void pwm_lpss_disable(struct pwm_device *pwm)
 {
 	pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-	pm_runtime_put(chip->dev);
+}
+
+static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  struct pwm_state *state)
+{
+	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
+
+	if (state->enabled) {
+		if (!pwm_is_enabled(pwm)) {
+			pm_runtime_get_sync(chip->dev);
+			pwm_lpss_config(lpwm, pwm, state->duty_cycle, state->period);
+			pwm_lpss_enable(pwm);
+		} else {
+			pwm_lpss_config(lpwm, pwm, state->duty_cycle, state->period);
+		}
+	} else if (pwm_is_enabled(pwm)) {
+		pwm_lpss_disable(pwm);
+		pm_runtime_put(chip->dev);
+	}
+
+	return 0;
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
-	.config = pwm_lpss_config,
-	.enable = pwm_lpss_enable,
-	.disable = pwm_lpss_disable,
+	.apply = pwm_lpss_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.11.0
