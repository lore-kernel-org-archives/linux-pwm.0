From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 2/3] pwm: sun4i: switch to atomic PWM
Date: Tue, 30 May 2017 21:32:08 +0200
Message-ID: <20170530193209.19247-3-alexandre.belloni@free-electrons.com>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58884 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdE3TcY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 May 2017 15:32:24 -0400
In-Reply-To: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Switch the driver to atomic PWM. This makes it easier to wait a proper
amount of time when changing the duty cycle before disabling the channel
(main use case is switching the duty cycle to 0 before disabling).

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/pwm-sun4i.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 175a69245a8a..cd8737d0804f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -8,8 +8,10 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -81,6 +83,8 @@ struct sun4i_pwm_chip {
 	void __iomem *base;
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
+	unsigned long next_period[2];
+	bool needs_delay[2];
 };
 
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
@@ -140,6 +144,167 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
 }
 
+static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
+			       struct pwm_state *state,
+			       u32 *dty, u32 *prd, unsigned int *prsclr)
+{
+	u64 clk_rate, div = 0;
+	unsigned int pval, prescaler = 0;
+
+	clk_rate = clk_get_rate(sun4i_pwm->clk);
+
+	if (sun4i_pwm->data->has_prescaler_bypass) {
+		/* First, test without any prescaler when available */
+		prescaler = PWM_PRESCAL_MASK;
+		pval = 1;
+		/*
+		 * When not using any prescaler, the clock period in nanoseconds
+		 * is not an integer so round it half up instead of
+		 * truncating to get less surprising values.
+		 */
+		div = clk_rate * state->period + NSEC_PER_SEC / 2;
+		do_div(div, NSEC_PER_SEC);
+		if (div - 1 > PWM_PRD_MASK)
+			prescaler = 0;
+	}
+
+	if (prescaler == 0) {
+		/* Go up from the first divider */
+		for (prescaler = 0; prescaler < PWM_PRESCAL_MASK; prescaler++) {
+			if (!prescaler_table[prescaler])
+				continue;
+			pval = prescaler_table[prescaler];
+			div = clk_rate;
+			do_div(div, pval);
+			div = div * state->period;
+			do_div(div, NSEC_PER_SEC);
+			if (div - 1 <= PWM_PRD_MASK)
+				break;
+		}
+
+		if (div - 1 > PWM_PRD_MASK)
+			return -EINVAL;
+	}
+
+	*prd = div;
+	div *= state->duty_cycle;
+	do_div(div, state->period);
+	*dty = div;
+	*prsclr = prescaler;
+
+	div = (u64)pval * NSEC_PER_SEC * *prd;
+	state->period = DIV_ROUND_CLOSEST_ULL(div, clk_rate);
+
+	div = (u64)pval * NSEC_PER_SEC * *dty;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(div, clk_rate);
+
+	return 0;
+}
+
+static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
+{
+	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	struct pwm_state cstate;
+	u32 ctrl;
+	int ret;
+	unsigned int delay_us;
+	unsigned long now;
+
+	pwm_get_state(pwm, &cstate);
+
+	if (!cstate.enabled) {
+		ret = clk_prepare_enable(sun4i_pwm->clk);
+		if (ret) {
+			dev_err(chip->dev, "failed to enable PWM clock\n");
+			return ret;
+		}
+	}
+
+	spin_lock(&sun4i_pwm->ctrl_lock);
+	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+
+	if ((cstate.period != state->period) ||
+	    (cstate.duty_cycle != state->duty_cycle)) {
+		u32 period, duty, val;
+		unsigned int prescaler;
+
+		ret = sun4i_pwm_calculate(sun4i_pwm, state,
+					  &duty, &period, &prescaler);
+		if (ret) {
+			dev_err(chip->dev, "period exceeds the maximum value\n");
+			spin_unlock(&sun4i_pwm->ctrl_lock);
+			if (!cstate.enabled)
+				clk_disable_unprepare(sun4i_pwm->clk);
+			return ret;
+		}
+
+		if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
+			/* Prescaler changed, the clock has to be gated */
+			ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+			sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+
+			ctrl &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
+			ctrl |= BIT_CH(prescaler, pwm->hwpwm);
+		}
+
+		val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
+		sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
+		sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
+			usecs_to_jiffies(cstate.period / 1000 + 1);
+		sun4i_pwm->needs_delay[pwm->hwpwm] = true;
+	}
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
+	else
+		ctrl |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
+
+	ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	if (state->enabled) {
+		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
+	} else if (!sun4i_pwm->needs_delay[pwm->hwpwm]) {
+		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
+		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	}
+
+	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+
+	spin_unlock(&sun4i_pwm->ctrl_lock);
+
+	if (state->enabled)
+		return 0;
+
+	if (!sun4i_pwm->needs_delay[pwm->hwpwm]) {
+		clk_disable_unprepare(sun4i_pwm->clk);
+		return 0;
+	}
+
+	/* We need a full period to elapse before disabling the channel. */
+	now = jiffies;
+	if (sun4i_pwm->needs_delay[pwm->hwpwm] &&
+	    time_before(now, sun4i_pwm->next_period[pwm->hwpwm])) {
+		delay_us = jiffies_to_usecs(sun4i_pwm->next_period[pwm->hwpwm] -
+					   now);
+		if ((delay_us / 500) > MAX_UDELAY_MS)
+			msleep(delay_us / 1000 + 1);
+		else
+			usleep_range(delay_us, delay_us * 2);
+	}
+	sun4i_pwm->needs_delay[pwm->hwpwm] = false;
+
+	spin_lock(&sun4i_pwm->ctrl_lock);
+	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
+	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+	spin_unlock(&sun4i_pwm->ctrl_lock);
+
+	clk_disable_unprepare(sun4i_pwm->clk);
+
+	return 0;
+}
+
 static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
@@ -301,6 +466,7 @@ static const struct pwm_ops sun4i_pwm_ops = {
 	.set_polarity = sun4i_pwm_set_polarity,
 	.enable = sun4i_pwm_enable,
 	.disable = sun4i_pwm_disable,
+	.apply = sun4i_pwm_apply,
 	.get_state = sun4i_pwm_get_state,
 	.owner = THIS_MODULE,
 };
-- 
2.11.0
