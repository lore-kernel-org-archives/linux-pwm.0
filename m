From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 3/3] pwm: sun4i: drop legacy callbacks
Date: Tue, 30 May 2017 21:32:09 +0200
Message-ID: <20170530193209.19247-4-alexandre.belloni@free-electrons.com>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Remove the legacy callbacks .enable(), .disable(), .set_polarity() and
.config().

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/pwm-sun4i.c | 160 ------------------------------------------------
 1 file changed, 160 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index cd8737d0804f..6d23f1d1c9b7 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -305,167 +305,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
-{
-	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 prd, dty, val, clk_gate;
-	u64 clk_rate, div = 0;
-	unsigned int prescaler = 0;
-	int err;
-
-	clk_rate = clk_get_rate(sun4i_pwm->clk);
-
-	if (sun4i_pwm->data->has_prescaler_bypass) {
-		/* First, test without any prescaler when available */
-		prescaler = PWM_PRESCAL_MASK;
-		/*
-		 * When not using any prescaler, the clock period in nanoseconds
-		 * is not an integer so round it half up instead of
-		 * truncating to get less surprising values.
-		 */
-		div = clk_rate * period_ns + NSEC_PER_SEC / 2;
-		do_div(div, NSEC_PER_SEC);
-		if (div - 1 > PWM_PRD_MASK)
-			prescaler = 0;
-	}
-
-	if (prescaler == 0) {
-		/* Go up from the first divider */
-		for (prescaler = 0; prescaler < PWM_PRESCAL_MASK; prescaler++) {
-			if (!prescaler_table[prescaler])
-				continue;
-			div = clk_rate;
-			do_div(div, prescaler_table[prescaler]);
-			div = div * period_ns;
-			do_div(div, NSEC_PER_SEC);
-			if (div - 1 <= PWM_PRD_MASK)
-				break;
-		}
-
-		if (div - 1 > PWM_PRD_MASK) {
-			dev_err(chip->dev, "period exceeds the maximum value\n");
-			return -EINVAL;
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
-	}
-
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
-	val |= BIT_CH(prescaler, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-
-	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
-
-	if (clk_gate) {
-		val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-		val |= clk_gate;
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-	}
-
-	spin_unlock(&sun4i_pwm->ctrl_lock);
-	clk_disable_unprepare(sun4i_pwm->clk);
-
-	return 0;
-}
-
-static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				  enum pwm_polarity polarity)
-{
-	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
-	int ret;
-
-	ret = clk_prepare_enable(sun4i_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
-	}
-
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-
-	if (polarity != PWM_POLARITY_NORMAL)
-		val &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-	else
-		val |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-
-	spin_unlock(&sun4i_pwm->ctrl_lock);
-	clk_disable_unprepare(sun4i_pwm->clk);
-
-	return 0;
-}
-
-static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
-	int ret;
-
-	ret = clk_prepare_enable(sun4i_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
-	}
-
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val |= BIT_CH(PWM_EN, pwm->hwpwm);
-	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-	spin_unlock(&sun4i_pwm->ctrl_lock);
-
-	return 0;
-}
-
-static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
-
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-	spin_unlock(&sun4i_pwm->ctrl_lock);
-
-	clk_disable_unprepare(sun4i_pwm->clk);
-}
-
 static const struct pwm_ops sun4i_pwm_ops = {
-	.config = sun4i_pwm_config,
-	.set_polarity = sun4i_pwm_set_polarity,
-	.enable = sun4i_pwm_enable,
-	.disable = sun4i_pwm_disable,
 	.apply = sun4i_pwm_apply,
 	.get_state = sun4i_pwm_get_state,
 	.owner = THIS_MODULE,
-- 
2.11.0
