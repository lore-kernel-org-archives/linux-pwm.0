From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/6] pwm: lpss: Switch to new atomic API
Date: Sat, 28 Jan 2017 17:10:41 +0200
Message-ID: <20170128151044.87572-4-andriy.shevchenko@linux.intel.com>
References: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:25395 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752063AbdA1PO3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 28 Jan 2017 10:14:29 -0500
In-Reply-To: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of doing things separately, which is not so reliable on some platforms,
switch the driver to use new atomic API, i.e. ->apply() callback.

The change has been tested on Intel platforms such as Broxton, BayTrail, and
Merrifield.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 64 +++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index ffa01ab907a6..09869f91d2d0 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -82,15 +82,20 @@ static inline void pwm_lpss_write(const struct pwm_device *pwm, u32 value)
 
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
-			   int duty_ns, int period_ns)
+static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
+			     int duty_ns, int period_ns)
 {
-	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	unsigned long long on_time_div;
 	unsigned long c = lpwm->info->clk_rate, base_unit_range;
 	unsigned long long base_unit, freq = NSEC_PER_SEC;
@@ -111,8 +116,6 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(on_time_div, period_ns);
 	on_time_div = 255ULL - on_time_div;
 
-	pm_runtime_get_sync(chip->dev);
-
 	ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~PWM_ON_TIME_DIV_MASK;
 	ctrl &= ~(base_unit_range << PWM_BASE_UNIT_SHIFT);
@@ -120,42 +123,33 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 	pwm_lpss_write(pwm, ctrl);
-
-	/*
-	 * If the PWM is already enabled we need to notify the hardware
-	 * about the change by setting PWM_SW_UPDATE.
-	 */
-	if (pwm_is_enabled(pwm))
-		pwm_lpss_update(pwm);
-
-	pm_runtime_put(chip->dev);
-
-	return 0;
 }
 
-static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  struct pwm_state *state)
 {
-	pm_runtime_get_sync(chip->dev);
+	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 
-	/*
-	 * Hardware must first see PWM_SW_UPDATE before the PWM can be
-	 * enabled.
-	 */
-	pwm_lpss_update(pwm);
-	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
-	return 0;
-}
+	if (state->enabled) {
+		if (!pwm_is_enabled(pwm)) {
+			pm_runtime_get_sync(chip->dev);
+			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
+			pwm_lpss_update(pwm);
+			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
+		} else {
+			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
+			pwm_lpss_update(pwm);
+		}
+	} else if (pwm_is_enabled(pwm)) {
+		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
+		pm_runtime_put(chip->dev);
+	}
 
-static void pwm_lpss_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-	pm_runtime_put(chip->dev);
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
