From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] pwm: lpss: Simplify update check in pwm_lpss_apply
Date: Mon, 20 Feb 2017 21:16:56 +0100
Message-ID: <20170220201657.24801-3-hdegoede@redhat.com>
References: <20170220201657.24801-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdBTURD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Feb 2017 15:17:03 -0500
In-Reply-To: <20170220201657.24801-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org

Simple keep a pm ref over the entire function and do the update check
once at the beginning. This simplifies the code and makes sure we also
check the update bit when disabling the pwm.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 6c99abc..0b549dc 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -128,34 +128,30 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	int ret;
 
+	pm_runtime_get_sync(chip->dev);
+	ret = pwm_lpss_is_updating(pwm);
+	if (ret)
+		goto out;
+
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
-			pm_runtime_get_sync(chip->dev);
-			ret = pwm_lpss_is_updating(pwm);
-			if (ret) {
-				pm_runtime_put(chip->dev);
-				return ret;
-			}
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
 			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 			ret = pwm_lpss_update(pwm);
-			if (ret) {
-				pm_runtime_put(chip->dev);
-				return ret;
-			}
+			if (ret == 0)
+				pm_runtime_get(chip->dev);
 		} else {
-			ret = pwm_lpss_is_updating(pwm);
-			if (ret)
-				return ret;
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			return pwm_lpss_update(pwm);
+			ret = pwm_lpss_update(pwm);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
 		pm_runtime_put(chip->dev);
 	}
 
-	return 0;
+out:
+	pm_runtime_put(chip->dev);
+	return ret;
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
-- 
2.9.3
