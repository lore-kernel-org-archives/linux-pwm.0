From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 17/20] pwm: sti: Add PWM Capture call-back
Date: Wed,  8 Jun 2016 10:21:32 +0100
Message-ID: <20160608092135.21184-18-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Once a PWM Capture has been initiated, the capture call
enables a rising edge detection IRQ, then waits.  Once each
of the 3 phase changes have been recorded the thread then
wakes.  The remaining part of the call carries out the
relevant calculations and passes back a formatted string to
the caller.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 2230afb..cecb6d4 100644
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
+			   struct pwm_capture *result, unsigned int timeout_ms)
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
+					       msecs_to_jiffies(timeout_ms));
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
+		do_div(result->period, effective_ticks);
+
+		result->duty_cycle = SECS_TO_NANOSECS(high);
+		do_div(result->duty_cycle, effective_ticks);
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
2.8.3
