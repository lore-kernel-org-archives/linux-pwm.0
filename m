From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] pwm: lpss: Do not set / wait_for update_bit when not enabled
Date: Mon, 20 Feb 2017 21:16:55 +0100
Message-ID: <20170220201657.24801-2-hdegoede@redhat.com>
References: <20170220201657.24801-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdBTURC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Feb 2017 15:17:02 -0500
In-Reply-To: <20170220201657.24801-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, Ilkka Koskinen <ilkka.koskinen@intel.com>

At least on cherrytrail, the update bit will never go low when the
enabled bit is not set.

This causes the backlight on my cube iwork8 air tablet to never go on
again after being turned off, because the enable path does:

	pwm_lpss_prepare();
	ret = pwm_lpss_update(pwm);
	if (ret)
		return ret;
	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);

And the pwm_lpss_update() call fails, as the setting of the
UPDATE bit never gets acked, because the ENABLE bit is not set.

Subsequent calls then all fail because of the pwm_lpss_is_updating()
check done by pwm_lpss_apply().

This commit fixes this by setting the enable bit before calling
pwm_lpss_update().

Fixes: 10d56a4cb1c6 ("pwm: lpss: Avoid reconfiguring while UPDATE bit...")
Cc: Ilkka Koskinen <ilkka.koskinen@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 689d2c1..6c99abc 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -137,12 +137,12 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				return ret;
 			}
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
+			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 			ret = pwm_lpss_update(pwm);
 			if (ret) {
 				pm_runtime_put(chip->dev);
 				return ret;
 			}
-			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 		} else {
 			ret = pwm_lpss_is_updating(pwm);
 			if (ret)
-- 
2.9.3
