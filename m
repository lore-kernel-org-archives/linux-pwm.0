From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] pwm: lpss: Add get_state callback
Date: Mon, 20 Feb 2017 21:16:57 +0100
Message-ID: <20170220201657.24801-4-hdegoede@redhat.com>
References: <20170220201657.24801-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752091AbdBTURE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Feb 2017 15:17:04 -0500
In-Reply-To: <20170220201657.24801-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Add a get_state callback so that the initial state correctly reflects
the actual hardware state.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
Changes in v2:
-Rebase on top of linux-pwm/for-next
---
 drivers/pwm/pwm-lpss.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 0b549dc..5e7e9ac 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -154,8 +154,36 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
+	unsigned long base_unit_range, freq;
+	unsigned long long base_unit, on_time_div;
+	u32 ctrl;
+
+	base_unit_range = BIT(lpwm->info->base_unit_bits);
+
+	ctrl = pwm_lpss_read(pwm);
+	on_time_div = ctrl & PWM_ON_TIME_DIV_MASK;
+	base_unit = (ctrl >> PWM_BASE_UNIT_SHIFT) & (base_unit_range - 1);
+
+	freq = base_unit * lpwm->info->clk_rate / base_unit_range;
+	if (freq == 0)
+		freq = 1;
+
+	state->period = NSEC_PER_SEC / freq;
+	state->duty_cycle = state->period * on_time_div / 255ULL;
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->enabled = (ctrl & PWM_ENABLE) ? true : false;
+
+	if (state->enabled)
+		pm_runtime_get_sync(chip->dev);
+}
+
 static const struct pwm_ops pwm_lpss_ops = {
 	.apply = pwm_lpss_apply,
+	.get_state = pwm_lpss_get_state,
 	.owner = THIS_MODULE,
 };
 
-- 
2.9.3
