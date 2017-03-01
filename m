From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2] pwm: atmel-hlcdc: Convert to the atomic PWM API
Date: Wed,  1 Mar 2017 15:48:51 +0100
Message-ID: <1488379731-12951-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Implement the ->apply() hook and drop the ->enable(), ->disable,
->set_polarity and ->config() ones.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changes from v1:
- stop the source clk when the PWM is being disabled
---
 drivers/pwm/pwm-atmel-hlcdc.c | 227 +++++++++++++++++++-----------------------
 1 file changed, 101 insertions(+), 126 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 14fc011faa32..a3c65a165a52 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -49,162 +49,137 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
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
+			if (!pres && chip->errata &&
+			    chip->errata->div1_clk_erratum)
+				continue;
 
-	if (pres > ATMEL_HLCDC_PWMPS_MAX)
-		return -EINVAL;
+			if ((clk_period_ns << pres) >= state->period)
+				break;
+		}
 
-	pwmcfg = ATMEL_HLCDC_PWMPS(pres);
-
-	if (new_clk != chip->cur_clk) {
-		u32 gencfg = 0;
-		int ret;
-
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
+			ret = regmap_update_bits(hlcdc->regmap,
+						 ATMEL_HLCDC_CFG(0),
+						 ATMEL_HLCDC_CLKPWMSEL,
+						 gencfg);
+			if (ret)
+				return ret;
+		}
 
-	return regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(6),
-				  ATMEL_HLCDC_PWMCVAL_MASK |
-				  ATMEL_HLCDC_PWMPS_MASK,
-				  pwmcfg);
-}
+		do_div(pwmcval, state->period);
 
-static int atmel_hlcdc_pwm_set_polarity(struct pwm_chip *c,
-					struct pwm_device *pwm,
-					enum pwm_polarity polarity)
-{
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
-	u32 cfg = 0;
+		/*
+		 * The PWM duty cycle is configurable from 0/256 to 255/256 of
+		 * the period cycle. Hence we can't set a duty cycle occupying
+		 * the whole period cycle if we're asked to.
+		 * Set it to 255 if pwmcval is greater than 256.
+		 */
+		if (pwmcval > 255)
+			pwmcval = 255;
 
-	if (polarity == PWM_POLARITY_NORMAL)
-		cfg = ATMEL_HLCDC_PWMPOL;
+		pwmcfg |= ATMEL_HLCDC_PWMCVAL(pwmcval);
 
-	return regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(6),
-				  ATMEL_HLCDC_PWMPOL, cfg);
-}
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			pwmcfg |= ATMEL_HLCDC_PWMPOL;
 
-static int atmel_hlcdc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
-{
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
-	u32 status;
-	int ret;
+		ret = regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(6),
+					 ATMEL_HLCDC_PWMCVAL_MASK |
+					 ATMEL_HLCDC_PWMPS_MASK |
+					 ATMEL_HLCDC_PWMPOL,
+					 pwmcfg);
+		if (ret)
+			return ret;
 
-	ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PWM);
-	if (ret)
-		return ret;
+		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN,
+				   ATMEL_HLCDC_PWM);
+		if (ret)
+			return ret;
 
-	while (true) {
-		ret = regmap_read(hlcdc->regmap, ATMEL_HLCDC_SR, &status);
+		ret = regmap_read_poll_timeout(hlcdc->regmap, ATMEL_HLCDC_SR,
+					       status,
+					       status & ATMEL_HLCDC_PWM,
+					       10, 0);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_DIS,
+				   ATMEL_HLCDC_PWM);
 		if (ret)
 			return ret;
 
-		if ((status & ATMEL_HLCDC_PWM) != 0)
-			break;
+		ret = regmap_read_poll_timeout(hlcdc->regmap, ATMEL_HLCDC_SR,
+					       status,
+					       !(status & ATMEL_HLCDC_PWM),
+					       10, 0);
+		if (ret)
+			return ret;
 
-		usleep_range(1, 10);
+		clk_disable_unprepare(chip->cur_clk);
+		chip->cur_clk = NULL;
 	}
 
 	return 0;
 }
 
-static void atmel_hlcdc_pwm_disable(struct pwm_chip *c,
-				    struct pwm_device *pwm)
-{
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
-	u32 status;
-	int ret;
-
-	ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_PWM);
-	if (ret)
-		return;
-
-	while (true) {
-		ret = regmap_read(hlcdc->regmap, ATMEL_HLCDC_SR, &status);
-		if (ret)
-			return;
-
-		if ((status & ATMEL_HLCDC_PWM) == 0)
-			break;
-
-		usleep_range(1, 10);
-	}
-}
-
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
