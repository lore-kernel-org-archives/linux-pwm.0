Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] pwm: lpss: Add get_state callback
Date: Tue, 11 Sep 2018 19:45:33 +0200
Message-Id: <20180911174533.4484-3-hdegoede@redhat.com>
In-Reply-To: <20180911174533.4484-1-hdegoede@redhat.com>
References: <20180911174533.4484-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Add a get_state callback so that the initial state correctly reflects
the actual hardware state.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/pwm/pwm-lpss.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index d39158800baa..882a71f1a66c 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -174,8 +174,41 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+/* This function gets called once from pwmchip_add to get the initial state */
+static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
+	unsigned long base_unit_range;
+	unsigned long long base_unit, freq, on_time_div;
+	u32 ctrl;
+
+	base_unit_range = BIT(lpwm->info->base_unit_bits);
+
+	ctrl = pwm_lpss_read(pwm);
+	on_time_div = 255 - (ctrl & PWM_ON_TIME_DIV_MASK);
+	base_unit = (ctrl >> PWM_BASE_UNIT_SHIFT) & (base_unit_range - 1);
+
+	freq = base_unit * lpwm->info->clk_rate;
+	do_div(freq, base_unit_range);
+	if (freq == 0)
+		state->period = NSEC_PER_SEC;
+	else
+		state->period = NSEC_PER_SEC / (unsigned long)freq;
+
+	on_time_div *= state->period;
+	do_div(on_time_div, 255);
+	state->duty_cycle = on_time_div;
+
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->enabled = !!(ctrl & PWM_ENABLE);
+
+	pwm_lpss_get_put_runtime_pm(chip, false, state->enabled);
+}
+
 static const struct pwm_ops pwm_lpss_ops = {
 	.apply = pwm_lpss_apply,
+	.get_state = pwm_lpss_get_state,
 	.owner = THIS_MODULE,
 };
 
-- 
2.19.0.rc0
