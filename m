From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] pwm: lpss: Avoid potential overflow of base_unit
Date: Mon, 24 Oct 2016 17:43:22 +0300
Message-ID: <20161024144325.130353-2-andriy.shevchenko@linux.intel.com>
References: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12069 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757556AbcJXOn3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Oct 2016 10:43:29 -0400
In-Reply-To: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The resolution of base_unit is derived from base_unit_bits and thus must be
equal to (2^base_unit_bits - 1). Otherwise frequency and therefore base_unit
might potentially overflow.

Prevent the above by substracting 1 in all cases where base_unit_bits or
derevative is used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 72c0bce..8642fee 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -102,7 +102,7 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * The equation is:
 	 * base_unit = round(base_unit_range * freq / c)
 	 */
-	base_unit_range = BIT(lpwm->info->base_unit_bits);
+	base_unit_range = BIT(lpwm->info->base_unit_bits) - 1;
 	freq *= base_unit_range;
 
 	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
@@ -117,8 +117,8 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~PWM_ON_TIME_DIV_MASK;
-	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
-	base_unit &= (base_unit_range - 1);
+	ctrl &= ~(base_unit_range << PWM_BASE_UNIT_SHIFT);
+	base_unit &= base_unit_range;
 	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 	pwm_lpss_write(pwm, ctrl);
-- 
2.9.3
