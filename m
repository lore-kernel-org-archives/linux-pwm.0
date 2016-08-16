From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 14/17] pwm: sti: Add PWM Capture call-back
Date: Tue, 16 Aug 2016 10:35:05 +0100
Message-ID: <20160816093508.28307-15-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816093508.28307-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Once a PWM Capture has been initiated, the capture call
enables a rising edge detection IRQ, then waits.  Once each
of the 3 phase changes have been recorded the thread then
wakes.  The remaining part of the call carries out the
relevant calculations and passes back a formatted string to
the caller.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/pwm/pwm-sti.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 4686ba0..fcc80eb 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -24,6 +24,8 @@
 #include <linux/time.h>
 #include <linux/wait.h>
 
+#define SECS_TO_NANOSECS(x) ((x) * 1000 * 1000 * 1000)
+
 #define PWM_OUT_VAL(x)	(0x00 + (4 * (x))) /* Device's Duty Cycle register */
 #define PWM_CPT_VAL(x)	(0x10 + (4 * (x))) /* Capture value */
 #define PWM_CPT_EDGE(x) (0x30 + (4 * (x))) /* Edge to capture on */
@@ -305,7 +307,88 @@ static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clear_bit(pwm->hwpwm, &pc->configured);
 }
 
+static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_capture *result, unsigned long timeout)
+{
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+	struct sti_pwm_compat_data *cdata = pc->cdata;
+	struct sti_cpt_ddata *ddata = pwm_get_chip_data(pwm);
+	struct device *dev = pc->dev;
+	unsigned int effective_ticks;
+	unsigned long long high, low;
+	int ret;
+
+	if (pwm->hwpwm > cdata->cpt_num_devs - 1) {
+		dev_err(dev, "Device %d is not valid\n", pwm->hwpwm);
+		return -EINVAL;
+	}
+
+	mutex_lock(&ddata->lock);
+
+	/* Prepare capture measurement */
+	ddata->index = 0;
+	regmap_write(pc->regmap, PWM_CPT_EDGE(pwm->hwpwm), CPT_EDGE_RISING);
+	regmap_field_write(pc->pwm_cpt_int_en, BIT(pwm->hwpwm));
+
+	/* Enable capture */
+	ret = regmap_field_write(pc->pwm_cpt_en, 1);
+	if (ret) {
+		dev_err(dev, "failed to enable PWM capture %d\n", pwm->hwpwm);
+		goto out;
+	}
+
+	ret = wait_event_interruptible_timeout(ddata->wait,
+					       ddata->index > 1,
+					       msecs_to_jiffies(timeout));
+
+	regmap_write(pc->regmap, PWM_CPT_EDGE(pwm->hwpwm), CPT_EDGE_DISABLED);
+
+	if (ret == -ERESTARTSYS)
+		goto out;
+
+	switch (ddata->index) {
+	case 0:
+	case 1:
+		/*
+		 * Getting here could mean :
+		 *  - input signal is constant of less than 1Hz
+		 *  - there is no input signal at all
+		 *
+		 * In such case the frequency is rounded down to 0
+		 */
+
+		result->period = 0;
+		result->duty_cycle = 0;
+
+		break;
+	case 2:
+		/* We have everying we need */
+		high = ddata->snapshot[1] - ddata->snapshot[0];
+		low  = ddata->snapshot[2] - ddata->snapshot[1];
+
+		effective_ticks = clk_get_rate(pc->cpt_clk);
+
+		result->period = SECS_TO_NANOSECS(high + low);
+		result->period /= effective_ticks;
+
+		result->duty_cycle = SECS_TO_NANOSECS(high);
+		result->duty_cycle /= effective_ticks;
+
+		break;
+	default:
+		dev_err(dev, "Internal error\n");
+	}
+
+out:
+	/* Disable capture */
+	regmap_field_write(pc->pwm_cpt_en, 0);
+
+	mutex_unlock(&ddata->lock);
+	return ret;
+}
+
 static const struct pwm_ops sti_pwm_ops = {
+	.capture = sti_pwm_capture,
 	.config = sti_pwm_config,
 	.enable = sti_pwm_enable,
 	.disable = sti_pwm_disable,
@@ -418,6 +501,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	if (IS_ERR(pc->pwm_out_en))
 		return PTR_ERR(pc->pwm_out_en);
 
+	pc->pwm_cpt_en = devm_regmap_field_alloc(dev, pc->regmap,
+						 reg_fields[PWM_CPT_EN]);
+	if (IS_ERR(pc->pwm_cpt_en))
+		return PTR_ERR(pc->pwm_cpt_en);
+
 	pc->pwm_cpt_int_en = devm_regmap_field_alloc(dev, pc->regmap,
 						 reg_fields[PWM_CPT_INT_EN]);
 	if (IS_ERR(pc->pwm_cpt_int_en))
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
