From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] pwm: lpss: Add get_state callback
Date: Fri,  2 Dec 2016 11:17:36 +0100
Message-ID: <20161202101736.12236-2-hdegoede@redhat.com>
References: <20161202101736.12236-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759436AbcLBKRl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Dec 2016 05:17:41 -0500
In-Reply-To: <20161202101736.12236-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>

Add a get_state callback so that the initial state correctly reflects
the actual hardware state.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index b4d8835..f5603c0 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -135,6 +135,33 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
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
 static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	pm_runtime_get_sync(chip->dev);
@@ -156,6 +183,7 @@ static void pwm_lpss_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static const struct pwm_ops pwm_lpss_ops = {
 	.config = pwm_lpss_config,
+	.get_state = pwm_lpss_get_state,
 	.enable = pwm_lpss_enable,
 	.disable = pwm_lpss_disable,
 	.owner = THIS_MODULE,
-- 
2.9.3
