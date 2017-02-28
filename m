From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
Date: Tue, 28 Feb 2017 12:40:14 +0200
Message-ID: <1488278415-2786-2-git-send-email-claudiu.beznea@microchip.com>
References: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488278415-2786-1-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The currently Atmel PWM controllers supported by this driver
could change period and duty factor without channel disable
(sama5d3 supports this by using period and duty factor update
registers, sam9rl support this by writing channel update
register and select the corresponding update: period or duty
factor). The chip doesn't support run time changings of signal
polarity. This has been adapted by first disabling the channel,
update registers and the enabling the channel.

Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 drivers/pwm/pwm-atmel.c | 217 ++++++++++++++++++++++++++----------------------
 1 file changed, 118 insertions(+), 99 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 67a7023..014b86c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -68,7 +68,7 @@ struct atmel_pwm_chip {
 	struct mutex isr_lock;
 
 	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
-		       unsigned long dty, unsigned long prd);
+		       unsigned long dty, unsigned long prd, bool enabled);
 };
 
 static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
@@ -105,99 +105,120 @@ static inline void atmel_pwm_ch_writel(struct atmel_pwm_chip *chip,
 	writel_relaxed(val, chip->base + base + offset);
 }
 
-static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+static int atmel_pwm_config_prepare(struct pwm_chip *chip,
+				    struct pwm_state *state, unsigned long *prd,
+				    unsigned long *dty, unsigned int *pres)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	unsigned long prd, dty;
 	unsigned long long div;
-	unsigned int pres = 0;
-	u32 val;
-	int ret;
-
-	if (pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
-		dev_err(chip->dev, "cannot change PWM period while enabled\n");
-		return -EBUSY;
-	}
 
 	/* Calculate the period cycles and prescale value */
-	div = (unsigned long long)clk_get_rate(atmel_pwm->clk) * period_ns;
+	div = (unsigned long long)clk_get_rate(atmel_pwm->clk) * state->period;
 	do_div(div, NSEC_PER_SEC);
 
+	*pres = 0;
 	while (div > PWM_MAX_PRD) {
 		div >>= 1;
-		pres++;
+		(*pres)++;
 	}
 
-	if (pres > PRD_MAX_PRES) {
+	if (*pres > PRD_MAX_PRES) {
 		dev_err(chip->dev, "pres exceeds the maximum value\n");
 		return -EINVAL;
 	}
 
 	/* Calculate the duty cycles */
-	prd = div;
-	div *= duty_ns;
-	do_div(div, period_ns);
-	dty = prd - div;
+	*prd = div;
+	div *= state->duty_cycle;
+	do_div(div, state->period);
+	*dty = *prd - div;
 
-	ret = clk_enable(atmel_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
-	}
+	return 0;
+}
+
+static void atmel_pwm_config_set(struct pwm_chip *chip, struct pwm_device *pwm,
+				 unsigned long dty, unsigned long prd,
+				 unsigned long pres, enum pwm_polarity polarity,
+				 bool enabled)
+{
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+	u32 val;
 
 	/* It is necessary to preserve CPOL, inside CMR */
 	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
 	val = (val & ~PWM_CMR_CPRE_MSK) | (pres & PWM_CMR_CPRE_MSK);
+	if (polarity == PWM_POLARITY_NORMAL)
+		val &= ~PWM_CMR_CPOL;
+	else
+		val |= PWM_CMR_CPOL;
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
-	atmel_pwm->config(chip, pwm, dty, prd);
+	atmel_pwm->config(chip, pwm, dty, prd, enabled);
 	mutex_lock(&atmel_pwm->isr_lock);
 	atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
 	atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
 	mutex_unlock(&atmel_pwm->isr_lock);
-
-	clk_disable(atmel_pwm->clk);
-	return ret;
 }
 
 static void atmel_pwm_config_v1(struct pwm_chip *chip, struct pwm_device *pwm,
-				unsigned long dty, unsigned long prd)
+				unsigned long dty, unsigned long prd,
+				bool enabled)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned int val;
+	unsigned long timeout;
 
+	if (pwm_is_enabled(pwm) && enabled) {
+		/* Update duty factor. */
+		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
+		val &= ~PWM_CMR_UPD_CDTY;
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
 
-	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
-
-	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
-	val &= ~PWM_CMR_UPD_CDTY;
-	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
-
-	/*
-	 * If the PWM channel is enabled, only update CDTY by using the update
-	 * register, it needs to set bit 10 of CMR to 0
-	 */
-	if (pwm_is_enabled(pwm))
-		return;
-	/*
-	 * If the PWM channel is disabled, write value to duty and period
-	 * registers directly.
-	 */
-	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
-	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
+		/*
+		 * Wait for the duty factor update.
+		 */
+		mutex_lock(&atmel_pwm->isr_lock);
+		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR) &
+				~(1 << pwm->hwpwm);
+
+		timeout = jiffies + 2 * HZ;
+		while (!(atmel_pwm->updated_pwms & (1 << pwm->hwpwm)) &&
+		       time_before(jiffies, timeout)) {
+			usleep_range(10, 100);
+			atmel_pwm->updated_pwms |=
+					atmel_pwm_readl(atmel_pwm, PWM_ISR);
+		}
+
+		mutex_unlock(&atmel_pwm->isr_lock);
+
+		/* Update period. */
+		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
+		val |= PWM_CMR_UPD_CDTY;
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, prd);
+	} else {
+		/*
+		 * If the PWM channel is disabled, write value to duty and
+		 * period registers directly.
+		 */
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
+	}
 }
 
 static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
-				unsigned long dty, unsigned long prd)
+				unsigned long dty, unsigned long prd,
+				bool enabled)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 
-	if (pwm_is_enabled(pwm)) {
+	if (pwm_is_enabled(pwm) && enabled) {
 		/*
-		 * If the PWM channel is enabled, using the duty update register
-		 * to update the value.
+		 * If the PWM channel is enabled, use update registers
+		 * to update the duty and period.
 		 */
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTYUPD, dty);
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRDUPD, prd);
 	} else {
 		/*
 		 * If the PWM channel is disabled, write value to duty and
@@ -208,49 +229,6 @@ static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 }
 
-static int atmel_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				  enum pwm_polarity polarity)
-{
-	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	u32 val;
-	int ret;
-
-	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
-
-	if (polarity == PWM_POLARITY_NORMAL)
-		val &= ~PWM_CMR_CPOL;
-	else
-		val |= PWM_CMR_CPOL;
-
-	ret = clk_enable(atmel_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
-	}
-
-	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
-
-	clk_disable(atmel_pwm->clk);
-
-	return 0;
-}
-
-static int atmel_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	int ret;
-
-	ret = clk_enable(atmel_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
-	}
-
-	atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
-
-	return 0;
-}
-
 static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
@@ -285,17 +263,58 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable(atmel_pwm->clk);
 }
 
+static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
+{
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+	struct pwm_state cstate;
+	unsigned long prd, dty;
+	unsigned int pres;
+	bool enabled = true;
+	int ret;
+
+	pwm_get_state(pwm, &cstate);
+
+	if (state->enabled) {
+		ret = atmel_pwm_config_prepare(chip, state, &prd, &dty,
+					       &pres);
+		if (ret) {
+			dev_err(chip->dev, "failed to prepare config\n");
+			return ret;
+		}
+
+		if (cstate.polarity != state->polarity) {
+			atmel_pwm_disable(chip, pwm);
+			enabled = false;
+		}
+
+		if (!cstate.enabled || !enabled) {
+			ret = clk_enable(atmel_pwm->clk);
+			if (ret) {
+				dev_err(chip->dev, "failed to enable clock\n");
+				return ret;
+			}
+		}
+
+		atmel_pwm_config_set(chip, pwm, dty, prd, pres,
+				     state->polarity, enabled);
+		if (!cstate.enabled || !enabled)
+			atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
+	} else if (cstate.enabled) {
+		atmel_pwm_disable(chip, pwm);
+	}
+
+	return 0;
+}
+
 static const struct pwm_ops atmel_pwm_ops = {
-	.config = atmel_pwm_config,
-	.set_polarity = atmel_pwm_set_polarity,
-	.enable = atmel_pwm_enable,
-	.disable = atmel_pwm_disable,
+	.apply = atmel_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
 struct atmel_pwm_data {
 	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
-		       unsigned long dty, unsigned long prd);
+		       unsigned long dty, unsigned long prd, bool enabled);
 };
 
 static const struct atmel_pwm_data atmel_pwm_data_v1 = {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
