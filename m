From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] pwm: lpss: Use positive condition in pwm_lpss_prepare()
Date: Wed, 15 Jan 2020 17:08:49 +0200
Message-ID: <20200115150849.74036-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:37691 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbgAOPIw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 15 Jan 2020 10:08:52 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For better readability and maintenance use positive condition
in pwm_lpss_prepare(). No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 75bbfe5f3bc2..6930a1d99860 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -109,10 +109,11 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 
-	if (orig_ctrl != ctrl) {
-		pwm_lpss_write(pwm, ctrl);
-		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
-	}
+	if (orig_ctrl == ctrl)
+		return;
+
+	pwm_lpss_write(pwm, ctrl);
+	pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
 }
 
 static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
-- 
2.24.1
