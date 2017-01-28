From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/6] pwm: lpss: Avoid reconfiguring while UPDATE bit is still enabled
Date: Sat, 28 Jan 2017 17:10:42 +0200
Message-ID: <20170128151044.87572-5-andriy.shevchenko@linux.intel.com>
References: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:61256 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbdA1PO3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 28 Jan 2017 10:14:29 -0500
In-Reply-To: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: Ilkka Koskinen <ilkka.koskinen@intel.com>

PWM Configuration register has SW_UPDATE bit that is set when a new
configuration is written to the register. The bit is automatically
cleared at the start of the next output cycle by the IP block.

If one writes a new configuration to the register while it still has
the bit enabled, PWM may freeze. That is, while one can still write
to the register, it won't have an effect. Thus, we try to sleep long
enough that the bit gets cleared and make sure the bit is not
enabled while we update the configuration.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Richard Griffiths <richard.a.griffiths@intel.com>
Signed-off-by: Ilkka Koskinen <ilkka.koskinen@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 52 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 09869f91d2d0..46670276690d 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -15,6 +15,7 @@
 
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -80,17 +81,37 @@ static inline void pwm_lpss_write(const struct pwm_device *pwm, u32 value)
 	writel(value, lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM);
 }
 
-static void pwm_lpss_update(struct pwm_device *pwm)
+static int pwm_lpss_update(struct pwm_device *pwm)
 {
+	struct pwm_lpss_chip *lpwm = to_lpwm(pwm->chip);
+	const void __iomem *addr = lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM;
+	const unsigned int ms = 500 * USEC_PER_MSEC;
+	u32 val;
+	int err;
+
+	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
+
 	/*
-	 * Set a limit for busyloop since not all implementations correctly
-	 * clear PWM_SW_UPDATE bit (at least it's not visible on OS side).
+	 * PWM Configuration register has SW_UPDATE bit that is set when a new
+	 * configuration is written to the register. The bit is automatically
+	 * cleared at the start of the next output cycle by the IP block.
+	 *
+	 * If one writes a new configuration to the register while it still has
+	 * the bit enabled, PWM may freeze. That is, while one can still write
+	 * to the register, it won't have an effect. Thus, we try to sleep long
+	 * enough that the bit gets cleared and make sure the bit is not
+	 * enabled while we update the configuration.
 	 */
-	unsigned int count = 10;
+	err = readl_poll_timeout(addr, val, !(val & PWM_SW_UPDATE), 40, ms);
+	if (err)
+		dev_err(pwm->chip->dev, "PWM_SW_UPDATE was not cleared\n");
 
-	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
-	while (pwm_lpss_read(pwm) & PWM_SW_UPDATE && --count)
-		usleep_range(10, 20);
+	return err;
+}
+
+static inline int pwm_lpss_is_updating(struct pwm_device *pwm)
+{
+	return (pwm_lpss_read(pwm) & PWM_SW_UPDATE) ? -EBUSY : 0;
 }
 
 static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
@@ -129,16 +150,29 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state)
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
+	int ret;
 
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
 			pm_runtime_get_sync(chip->dev);
+			ret = pwm_lpss_is_updating(pwm);
+			if (ret) {
+				pm_runtime_put(chip->dev);
+				return ret;
+			}
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			pwm_lpss_update(pwm);
+			ret = pwm_lpss_update(pwm);
+			if (ret) {
+				pm_runtime_put(chip->dev);
+				return ret;
+			}
 			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 		} else {
+			ret = pwm_lpss_is_updating(pwm);
+			if (ret)
+				return ret;
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			pwm_lpss_update(pwm);
+			return pwm_lpss_update(pwm);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-- 
2.11.0
