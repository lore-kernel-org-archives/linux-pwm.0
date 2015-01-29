From: Ajit Pal Singh <ajitpal.singh@st.com>
Subject: [PATCH RESEND] pwm: sti: Maintain a bitmap of configured devices
Date: Thu, 29 Jan 2015 14:34:43 +0530
Message-ID: <1422522283-29757-1-git-send-email-ajitpal.singh@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: maxime.coquelin@st.com, lee.jones@linaro.org, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pwm@vger.kernel.org

This patch introduces a bitmap which is used to keep track of the
pwm channels which have been configured in a pwm chip.

The method used earlier to find the number of configured channels,
was to count the pwmdevices with PWMF_REQUESTED field set
and period value configured. This was not correct and failed
when of_pwm_get()/pwm_get() and then pwm_config() was used.

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
---
 drivers/pwm/pwm-sti.c |   30 +++++++++++-------------------
 1 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index b95115c..92abbd5 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -57,6 +57,7 @@ struct sti_pwm_chip {
 	struct regmap_field *pwm_int_en;
 	struct pwm_chip chip;
 	struct pwm_device *cur;
+	unsigned long configured;
 	unsigned int en_count;
 	struct mutex sti_pwm_lock; /* To sync between enable/disable calls */
 	void __iomem *mmio;
@@ -102,24 +103,6 @@ static int sti_pwm_get_prescale(struct sti_pwm_chip *pc, unsigned long period,
 	return 0;
 }
 
-/* Calculate the number of PWM devices configured with a period. */
-static unsigned int sti_pwm_count_configured(struct pwm_chip *chip)
-{
-	struct pwm_device *pwm;
-	unsigned int ncfg = 0;
-	unsigned int i;
-
-	for (i = 0; i < chip->npwm; i++) {
-		pwm = &chip->pwms[i];
-		if (test_bit(PWMF_REQUESTED, &pwm->flags)) {
-			if (pwm_get_period(pwm))
-				ncfg++;
-		}
-	}
-
-	return ncfg;
-}
-
 /*
  * For STiH4xx PWM IP, the PWM period is fixed to 256 local clock cycles.
  * The only way to change the period (apart from changing the PWM input clock)
@@ -141,7 +124,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int ncfg;
 	bool period_same = false;
 
-	ncfg = sti_pwm_count_configured(chip);
+	ncfg = hweight_long(pc->configured);
 	if (ncfg)
 		period_same = (period_ns == pwm_get_period(cur));
 
@@ -197,6 +180,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = regmap_field_write(pc->pwm_int_en, 0);
 
+		set_bit(pwm->hwpwm, &pc->configured);
 		pc->cur = pwm;
 
 		dev_dbg(dev, "prescale:%u, period:%i, duty:%i, pwmvalx:%u\n",
@@ -254,10 +238,18 @@ static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&pc->sti_pwm_lock);
 }
 
+static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+
+	clear_bit(pwm->hwpwm, &pc->configured);
+}
+
 static const struct pwm_ops sti_pwm_ops = {
 	.config = sti_pwm_config,
 	.enable = sti_pwm_enable,
 	.disable = sti_pwm_disable,
+	.free = sti_pwm_free,
 	.owner = THIS_MODULE,
 };
 
-- 
1.7.5.4
