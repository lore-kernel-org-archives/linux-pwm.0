From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 1/3] pwm: sun4i: improve hardware read out
Date: Tue, 30 May 2017 21:32:07 +0200
Message-ID: <20170530193209.19247-2-alexandre.belloni@free-electrons.com>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Implement .get_state instead of only reading the polarity at probe time.
This allows to get the proper state, period and duty cycle.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/pwm-sun4i.c | 65 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1284ffa05921..175a69245a8a 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -44,6 +44,10 @@
 
 #define PWM_DTY_MASK		GENMASK(15, 0)
 
+#define PWM_REG_PRD(reg)	((((reg) >> 16) & PWM_PRD_MASK) + 1)
+#define PWM_REG_DTY(reg)	((reg) & PWM_DTY_MASK)
+#define PWM_REG_PRESCAL(reg, chan)	(((reg) >> ((chan) * PWMCH_OFFSET)) & PWM_PRESCAL_MASK)
+
 #define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
 
 static const u32 prescaler_table[] = {
@@ -96,6 +100,46 @@ static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
 	writel(val, chip->base + offset);
 }
 
+static void sun4i_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
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
 static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
@@ -257,6 +301,7 @@ static const struct pwm_ops sun4i_pwm_ops = {
 	.set_polarity = sun4i_pwm_set_polarity,
 	.enable = sun4i_pwm_enable,
 	.disable = sun4i_pwm_disable,
+	.get_state = sun4i_pwm_get_state,
 	.owner = THIS_MODULE,
 };
 
@@ -316,8 +361,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *pwm;
 	struct resource *res;
-	u32 val;
-	int i, ret;
+	int ret;
 	const struct of_device_id *match;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
@@ -353,24 +397,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
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
