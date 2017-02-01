From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH] pwm: atmel-hlcdc: Convert to the atomic PWM API
Date: Wed,  1 Feb 2017 15:35:34 +0100
Message-ID: <1485959734-22317-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52736 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdBAOgB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Feb 2017 09:36:01 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Implement the ->apply() hook and drop the ->enable(), ->disable,
->set_polarity and ->config() ones.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 215 +++++++++++++++++-------------------------
 1 file changed, 86 insertions(+), 129 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 14fc011faa32..64f1e1662b57 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -49,162 +49,119 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
 	return container_of(chip, struct atmel_hlcdc_pwm, chip);
 }
 
-static int atmel_hlcdc_pwm_config(struct pwm_chip *c,
-				  struct pwm_device *pwm,
-				  int duty_ns, int period_ns)
+static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
+				 struct pwm_state *state)
 {
 	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
 	struct atmel_hlcdc *hlcdc = chip->hlcdc;
-	struct clk *new_clk = hlcdc->slow_clk;
-	u64 pwmcval = duty_ns * 256;
-	unsigned long clk_freq;
-	u64 clk_period_ns;
-	u32 pwmcfg;
-	int pres;
-
-	if (!chip->errata || !chip->errata->slow_clk_erratum) {
-		clk_freq = clk_get_rate(new_clk);
-		if (!clk_freq)
-			return -EINVAL;
-
-		clk_period_ns = (u64)NSEC_PER_SEC * 256;
-		do_div(clk_period_ns, clk_freq);
-	}
-
-	/* Errata: cannot use slow clk on some IP revisions */
-	if ((chip->errata && chip->errata->slow_clk_erratum) ||
-	    clk_period_ns > period_ns) {
-		new_clk = hlcdc->sys_clk;
-		clk_freq = clk_get_rate(new_clk);
-		if (!clk_freq)
-			return -EINVAL;
-
-		clk_period_ns = (u64)NSEC_PER_SEC * 256;
-		do_div(clk_period_ns, clk_freq);
-	}
+	unsigned int status;
+	int ret;
 
-	for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
+	if (state->enabled) {
+		struct clk *new_clk = hlcdc->slow_clk;
+		u64 pwmcval = state->duty_cycle * 256;
+		unsigned long clk_freq;
+		u64 clk_period_ns;
+		u32 pwmcfg;
+		int pres;
+
+		if (!chip->errata || !chip->errata->slow_clk_erratum) {
+			clk_freq = clk_get_rate(new_clk);
+			if (!clk_freq)
+				return -EINVAL;
+
+			clk_period_ns = (u64)NSEC_PER_SEC * 256;
+			do_div(clk_period_ns, clk_freq);
+		}
+
+		/* Errata: cannot use slow clk on some IP revisions */
+		if ((chip->errata && chip->errata->slow_clk_erratum) ||
+		    clk_period_ns > state->period) {
+			new_clk = hlcdc->sys_clk;
+			clk_freq = clk_get_rate(new_clk);
+			if (!clk_freq)
+				return -EINVAL;
+
+			clk_period_ns = (u64)NSEC_PER_SEC * 256;
+			do_div(clk_period_ns, clk_freq);
+		}
+
+		for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
 		/* Errata: cannot divide by 1 on some IP revisions */
-		if (!pres && chip->errata && chip->errata->div1_clk_erratum)
-			continue;
-
-		if ((clk_period_ns << pres) >= period_ns)
-			break;
-	}
-
-	if (pres > ATMEL_HLCDC_PWMPS_MAX)
-		return -EINVAL;
-
-	pwmcfg = ATMEL_HLCDC_PWMPS(pres);
+			if (!pres && chip->errata &&
+			    chip->errata->div1_clk_erratum)
+				continue;
 
-	if (new_clk != chip->cur_clk) {
-		u32 gencfg = 0;
-		int ret;
+			if ((clk_period_ns << pres) >= state->period)
+				break;
+		}
 
-		ret = clk_prepare_enable(new_clk);
-		if (ret)
-			return ret;
+		if (pres > ATMEL_HLCDC_PWMPS_MAX)
+			return -EINVAL;
 
-		clk_disable_unprepare(chip->cur_clk);
-		chip->cur_clk = new_clk;
+		pwmcfg = ATMEL_HLCDC_PWMPS(pres);
 
-		if (new_clk == hlcdc->sys_clk)
-			gencfg = ATMEL_HLCDC_CLKPWMSEL;
+		if (new_clk != chip->cur_clk) {
+			u32 gencfg = 0;
+			int ret;
 
-		ret = regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(0),
-					 ATMEL_HLCDC_CLKPWMSEL, gencfg);
-		if (ret)
-			return ret;
-	}
+			ret = clk_prepare_enable(new_clk);
+			if (ret)
+				return ret;
 
-	do_div(pwmcval, period_ns);
+			clk_disable_unprepare(chip->cur_clk);
+			chip->cur_clk = new_clk;
 
-	/*
-	 * The PWM duty cycle is configurable from 0/256 to 255/256 of the
-	 * period cycle. Hence we can't set a duty cycle occupying the
-	 * whole period cycle if we're asked to.
-	 * Set it to 255 if pwmcval is greater than 256.
-	 */
-	if (pwmcval > 255)
-		pwmcval = 255;
+			if (new_clk == hlcdc->sys_clk)
+				gencfg = ATMEL_HLCDC_CLKPWMSEL;
 
-	pwmcfg |= ATMEL_HLCDC_PWMCVAL(pwmcval);
-
-	return regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(6),
-				  ATMEL_HLCDC_PWMCVAL_MASK |
-				  ATMEL_HLCDC_PWMPS_MASK,
-				  pwmcfg);
-}
-
-static int atmel_hlcdc_pwm_set_polarity(struct pwm_chip *c,
-					struct pwm_device *pwm,
-					enum pwm_polarity polarity)
-{
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
-	u32 cfg = 0;
+			ret = regmap_update_bits(hlcdc->regmap,
+						 ATMEL_HLCDC_CFG(0),
+						 ATMEL_HLCDC_CLKPWMSEL,
+						 gencfg);
+			if (ret)
+				return ret;
+		}
 
-	if (polarity == PWM_POLARITY_NORMAL)
-		cfg = ATMEL_HLCDC_PWMPOL;
+		do_div(pwmcval, state->period);
 
-	return regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(6),
-				  ATMEL_HLCDC_PWMPOL, cfg);
-}
+		/*
+		 * The PWM duty cycle is configurable from 0/256 to 255/256 of
+		 * the period cycle. Hence we can't set a duty cycle occupying
+		 * the whole period cycle if we're asked to.
+		 * Set it to 255 if pwmcval is greater than 256.
+		 */
+		if (pwmcval > 255)
+			pwmcval = 255;
 
-static int atmel_hlcdc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
-{
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
-	u32 status;
-	int ret;
+		pwmcfg |= ATMEL_HLCDC_PWMCVAL(pwmcval);
 
-	ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PWM);
-	if (ret)
-		return ret;
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			pwmcfg |= ATMEL_HLCDC_PWMPOL;
 
-	while (true) {
-		ret = regmap_read(hlcdc->regmap, ATMEL_HLCDC_SR, &status);
+		ret = regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(6),
+					 ATMEL_HLCDC_PWMCVAL_MASK |
+					 ATMEL_HLCDC_PWMPS_MASK |
+					 ATMEL_HLCDC_PWMPOL,
+					 pwmcfg);
 		if (ret)
 			return ret;
-
-		if ((status & ATMEL_HLCDC_PWM) != 0)
-			break;
-
-		usleep_range(1, 10);
 	}
 
-	return 0;
-}
-
-static void atmel_hlcdc_pwm_disable(struct pwm_chip *c,
-				    struct pwm_device *pwm)
-{
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
-	u32 status;
-	int ret;
-
-	ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_PWM);
+	ret = regmap_write(hlcdc->regmap,
+			   state->enabled ? ATMEL_HLCDC_EN : ATMEL_HLCDC_DIS,
+			   ATMEL_HLCDC_PWM);
 	if (ret)
-		return;
-
-	while (true) {
-		ret = regmap_read(hlcdc->regmap, ATMEL_HLCDC_SR, &status);
-		if (ret)
-			return;
-
-		if ((status & ATMEL_HLCDC_PWM) == 0)
-			break;
+		return ret;
 
-		usleep_range(1, 10);
-	}
+	return regmap_read_poll_timeout(hlcdc->regmap, ATMEL_HLCDC_SR, status,
+					(status & ATMEL_HLCDC_PWM) ==
+					(state->enabled ? ATMEL_HLCDC_PWM : 0),
+					10, 0);
 }
 
 static const struct pwm_ops atmel_hlcdc_pwm_ops = {
-	.config = atmel_hlcdc_pwm_config,
-	.set_polarity = atmel_hlcdc_pwm_set_polarity,
-	.enable = atmel_hlcdc_pwm_enable,
-	.disable = atmel_hlcdc_pwm_disable,
+	.apply = atmel_hlcdc_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.7.4
