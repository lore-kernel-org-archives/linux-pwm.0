From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 resend] pwm: lpss: Set enable-bit before waiting for update-bit to go low
Date: Sat, 25 Mar 2017 15:06:58 +0100
Message-ID: <20170325140658.26868-2-hdegoede@redhat.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdCYOHC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 25 Mar 2017 10:07:02 -0400
In-Reply-To: <20170325140658.26868-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, Ilkka Koskinen <ilkka.koskinen@intel.com>

At least on cherrytrail, the update bit will never go low when the
enabled bit is not set.

This causes the backlight on my cube iwork8 air tablet to never turn on
again after being turned off because in the pwm_lpss_apply enable path
pwm_lpss_update will fail causing an error exit and the enable-bit to
never get set. Any following pwm_lpss_apply calls will fail the
pwm_lpss_is_updating check.

Since the docs say that the update bit should be set before the
enable-bit, split pwm_lpss_update into setting the update-bit and
pwm_lpss_wait_for_update, and move the pwm_lpss_wait_for_update call
in the enable path to after setting the enable-bit.

Fixes: 10d56a4 ("pwm: lpss: Avoid reconfiguring while UPDATE bit...")
Cc: Ilkka Koskinen <ilkka.koskinen@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new approach to fixing the problem, replacing
 "pwm: lpss: Do not set / wait_for update_bit when not enabled"
---
 drivers/pwm/pwm-lpss.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 689d2c1..eac3d52 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -57,7 +57,7 @@ static inline void pwm_lpss_write(const struct pwm_device *pwm, u32 value)
 	writel(value, lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM);
 }
 
-static int pwm_lpss_update(struct pwm_device *pwm)
+static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(pwm->chip);
 	const void __iomem *addr = lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM;
@@ -65,8 +65,6 @@ static int pwm_lpss_update(struct pwm_device *pwm)
 	u32 val;
 	int err;
 
-	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
-
 	/*
 	 * PWM Configuration register has SW_UPDATE bit that is set when a new
 	 * configuration is written to the register. The bit is automatically
@@ -137,18 +135,20 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				return ret;
 			}
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			ret = pwm_lpss_update(pwm);
+			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
+			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
+			ret = pwm_lpss_wait_for_update(pwm);
 			if (ret) {
 				pm_runtime_put(chip->dev);
 				return ret;
 			}
-			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 		} else {
 			ret = pwm_lpss_is_updating(pwm);
 			if (ret)
 				return ret;
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			return pwm_lpss_update(pwm);
+			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
+			return pwm_lpss_wait_for_update(pwm);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-- 
2.9.3
