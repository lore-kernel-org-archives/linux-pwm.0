From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] pwm: sun4i: switch to atomic PWM
Date: Fri, 28 Apr 2017 00:00:02 +0200
Message-ID: <20170427220002.20266-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49380 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034173AbdD0WAH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Apr 2017 18:00:07 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Switch the driver to atomic PWM. This makes it easier to wait a proper
amount of time when changing the duty cycle before disabling the channel
(main use case is switching the duty cycle to 0 before disabling).

Also, the hardware read out is now greatly improved as it was formerly only
handling PWM polarity.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/pwm-sun4i.c | 272 ++++++++++++++++++++++++++----------------------
 1 file changed, 150 insertions(+), 122 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b0803f6c64d9..de300779c811 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -27,7 +28,6 @@
 
 #define PWMCH_OFFSET		15
 #define PWM_PRESCAL_MASK	GENMASK(3, 0)
-#define PWM_PRESCAL_OFF		0
 #define PWM_EN			BIT(4)
 #define PWM_ACT_STATE		BIT(5)
 #define PWM_CLK_GATING		BIT(6)
@@ -44,6 +44,11 @@
 
 #define PWM_DTY_MASK		GENMASK(15, 0)
 
+#define PWM_MAX_PRD_US		198000000
+#define PWM_REG_PRD(reg)	(((reg >> 16) & PWM_PRD_MASK) + 1)
+#define PWM_REG_DTY(reg)	(reg & PWM_DTY_MASK)
+#define PWM_REG_PRESCAL(reg, chan)	((reg >> ((chan) * PWMCH_OFFSET)) & PWM_PRESCAL_MASK)
+
 #define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
 
 static const u32 prescaler_table[] = {
@@ -96,26 +101,65 @@ static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
 	writel(val, chip->base + offset);
 }
 
-static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+static void sun4i_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 prd, dty, val, clk_gate;
+	u64 clk_rate, tmp;
+	u32 val;
+	unsigned int prescaler;
+
+	clk_rate = clk_get_rate(sun4i_pwm->clk);
+
+	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+
+	if ((val == PWM_PRESCAL_MASK) && sun4i_pwm->data->has_prescaler_bypass)
+		prescaler = 1;
+	else
+		prescaler = prescaler_table[PWM_REG_PRESCAL(val, pwm->hwpwm)];
+
+	if (prescaler == 0)
+		return;
+
+	if (val & BIT_CH(PWM_ACT_STATE, pwm->hwpwm))
+		state->polarity = PWM_POLARITY_NORMAL;
+	else
+		state->polarity = PWM_POLARITY_INVERSED;
+
+	if (val & BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm))
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	val = sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
+
+	tmp = prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+
+	tmp = prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+}
+
+static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
+			       struct pwm_state *state,
+			       u32 *dty, u32 *prd, unsigned int *prsclr)
+{
 	u64 clk_rate, div = 0;
-	unsigned int prescaler = 0;
-	int err;
+	unsigned int pval, prescaler = 0;
 
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
 
 	if (sun4i_pwm->data->has_prescaler_bypass) {
 		/* First, test without any prescaler when available */
 		prescaler = PWM_PRESCAL_MASK;
+		pval = 1;
 		/*
 		 * When not using any prescaler, the clock period in nanoseconds
 		 * is not an integer so round it half up instead of
 		 * truncating to get less surprising values.
 		 */
-		div = clk_rate * period_ns + NSEC_PER_SEC / 2;
+		div = clk_rate * state->period + NSEC_PER_SEC / 2;
 		do_div(div, NSEC_PER_SEC);
 		if (div - 1 > PWM_PRD_MASK)
 			prescaler = 0;
@@ -126,137 +170,139 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		for (prescaler = 0; prescaler < PWM_PRESCAL_MASK; prescaler++) {
 			if (!prescaler_table[prescaler])
 				continue;
+			pval = prescaler_table[prescaler];
 			div = clk_rate;
-			do_div(div, prescaler_table[prescaler]);
-			div = div * period_ns;
+			do_div(div, pval);
+			div = div * state->period;
 			do_div(div, NSEC_PER_SEC);
 			if (div - 1 <= PWM_PRD_MASK)
 				break;
 		}
 
-		if (div - 1 > PWM_PRD_MASK) {
-			dev_err(chip->dev, "period exceeds the maximum value\n");
+		if (div - 1 > PWM_PRD_MASK)
 			return -EINVAL;
-		}
-	}
-
-	prd = div;
-	div *= duty_ns;
-	do_div(div, period_ns);
-	dty = div;
-
-	err = clk_prepare_enable(sun4i_pwm->clk);
-	if (err) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return err;
-	}
-
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-
-	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
-		spin_unlock(&sun4i_pwm->ctrl_lock);
-		clk_disable_unprepare(sun4i_pwm->clk);
-		return -EBUSY;
-	}
-
-	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	if (clk_gate) {
-		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
 	}
 
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
-	val |= BIT_CH(prescaler, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-
-	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
+	*prd = div;
+	div *= state->duty_cycle;
+	do_div(div, state->period);
+	*dty = div;
+	*prsclr = prescaler;
 
-	if (clk_gate) {
-		val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-		val |= clk_gate;
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-	}
+	div = (u64)pval * NSEC_PER_SEC * *prd;
+	state->period = DIV_ROUND_CLOSEST_ULL(div, clk_rate);
 
-	spin_unlock(&sun4i_pwm->ctrl_lock);
-	clk_disable_unprepare(sun4i_pwm->clk);
+	div = (u64)pval * NSEC_PER_SEC * *dty;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(div, clk_rate);
 
 	return 0;
 }
 
-static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				  enum pwm_polarity polarity)
+static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
-	int ret;
-
-	ret = clk_prepare_enable(sun4i_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
+	struct pwm_state cstate;
+	u32 ctrl;
+	int delay_us, ret;
+	bool needs_delay = false, prescaler_changed = false;
+
+	pwm_get_state(pwm, &cstate);
+
+	if (!cstate.enabled) {
+		ret = clk_prepare_enable(sun4i_pwm->clk);
+		if (ret) {
+			dev_err(chip->dev, "failed to enable PWM clock\n");
+			return ret;
+		}
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-	if (polarity != PWM_POLARITY_NORMAL)
-		val &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-	else
-		val |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
+	if ((cstate.period != state->period) ||
+	    (cstate.duty_cycle != state->duty_cycle)) {
+		u32 period, duty, val;
+		unsigned int prescaler;
 
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+		needs_delay = true;
 
-	spin_unlock(&sun4i_pwm->ctrl_lock);
-	clk_disable_unprepare(sun4i_pwm->clk);
+		ret = sun4i_pwm_calculate(sun4i_pwm, state,
+					  &duty, &period, &prescaler);
+		if (ret) {
+			dev_err(chip->dev, "period exceeds the maximum value\n");
+			spin_unlock(&sun4i_pwm->ctrl_lock);
+			if (!cstate.enabled)
+				clk_disable_unprepare(sun4i_pwm->clk);
+			return ret;
+		}
 
-	return 0;
-}
+		if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
+			prescaler_changed = true;
+			/* Prescaler changed, the clock has to be gated */
+			ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+			sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
-static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
-	int ret;
+			ctrl &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
+			ctrl |= BIT_CH(prescaler, pwm->hwpwm);
+		}
 
-	ret = clk_prepare_enable(sun4i_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
+		val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
+		sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 	}
 
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val |= BIT_CH(PWM_EN, pwm->hwpwm);
-	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-	spin_unlock(&sun4i_pwm->ctrl_lock);
-
-	return 0;
-}
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
+	else
+		ctrl |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
+
+	ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	if (state->enabled) {
+		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
+	} else if (!needs_delay) {
+		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
+		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	}
 
-static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
+	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 
-	clk_disable_unprepare(sun4i_pwm->clk);
+	if (!needs_delay)
+		return 0;
+
+	/* We need a full (previous) period to elapse before disabling the
+	 * channel. If a ready bit is available, wait for it instead of waiting
+	 * for a full period.
+	 *
+	 * If the new period is greater than the previous one, the prescaler may
+	 * have changed and the previous period may go slower.
+	 *
+	 */
+	delay_us = max(state->period / 1000 + 1, cstate.period / 1000 + 1);
+	if ((cstate.enabled && !state->enabled) || !sun4i_pwm->data->has_rdy)
+		usleep_range(delay_us, delay_us * 2);
+	else
+		readl_poll_timeout(sun4i_pwm->base + PWM_CTRL_REG, ctrl,
+				   !(ctrl & PWM_RDY(pwm->hwpwm)),
+				   delay_us / 4, PWM_MAX_PRD_US);
+
+	if (!state->enabled) {
+		spin_lock(&sun4i_pwm->ctrl_lock);
+		ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+		sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+		spin_unlock(&sun4i_pwm->ctrl_lock);
+
+		clk_disable_unprepare(sun4i_pwm->clk);
+	}
+
+	return 0;
 }
 
 static const struct pwm_ops sun4i_pwm_ops = {
-	.config = sun4i_pwm_config,
-	.set_polarity = sun4i_pwm_set_polarity,
-	.enable = sun4i_pwm_enable,
-	.disable = sun4i_pwm_disable,
+	.apply = sun4i_pwm_apply,
+	.get_state = sun4i_pwm_get_state,
 	.owner = THIS_MODULE,
 };
 
@@ -316,8 +362,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *pwm;
 	struct resource *res;
-	u32 val;
-	int i, ret;
+	int ret;
 	const struct of_device_id *match;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
@@ -354,24 +399,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pwm);
 
-	ret = clk_prepare_enable(pwm->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable PWM clock\n");
-		goto clk_error;
-	}
-
-	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
-	for (i = 0; i < pwm->chip.npwm; i++)
-		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
-			pwm_set_polarity(&pwm->chip.pwms[i],
-					 PWM_POLARITY_INVERSED);
-	clk_disable_unprepare(pwm->clk);
-
 	return 0;
-
-clk_error:
-	pwmchip_remove(&pwm->chip);
-	return ret;
 }
 
 static int sun4i_pwm_remove(struct platform_device *pdev)
-- 
2.11.0
