From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
Date: Thu, 2 Mar 2017 17:28:44 +0200
Message-ID: <1488468525-28726-2-git-send-email-claudiu.beznea@microchip.com>
References: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The currently Atmel PWM controllers supported by this driver
could change period or duty factor without channel disable,
for regular channels (sama5d3 support this by using period
or duty factor update registers, sam9rl support this by
writing channel update register and select the corresponding
update: period or duty factor). The chip doesn't support run
time changings of signal polarity. To take advantage of
atomic PWM framework and let controller works without glitches,
in this patch only the duty factor could be changed without
disabling PWM channel. For period and signal polarity the
atomic PWM is simulated by disabling + enabling the right PWM channel.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

---
 drivers/pwm/pwm-atmel.c | 271 ++++++++++++++++++++++++------------------------
 1 file changed, 138 insertions(+), 133 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 67a7023..3db82c3 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -58,17 +58,30 @@
 #define PWM_MAX_PRD		0xFFFF
 #define PRD_MAX_PRES		10
 
+struct atmel_pwm_reg_data {
+	u8 period;
+	u8 period_upd;
+	u8 duty;
+	u8 duty_upd;
+};
+
+struct atmel_pwm_data {
+	void (*update_cdty)(struct pwm_chip *chip, struct pwm_device *pwm,
+			    unsigned long cdty);
+	void (*set_cprd_cdty)(struct pwm_chip *chip, struct pwm_device *pwm,
+			      unsigned long cprd, unsigned long cdty);
+	const struct atmel_pwm_reg_data regs;
+};
+
 struct atmel_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
+	const struct atmel_pwm_data *data;
 
 	unsigned int updated_pwms;
 	/* ISR is cleared when read, ensure only one thread does that */
 	struct mutex isr_lock;
-
-	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
-		       unsigned long dty, unsigned long prd);
 };
 
 static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
@@ -105,153 +118,71 @@ static inline void atmel_pwm_ch_writel(struct atmel_pwm_chip *chip,
 	writel_relaxed(val, chip->base + base + offset);
 }
 
-static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
+					     const struct pwm_state *state,
+					     unsigned long *cprd, u32 *pres)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	unsigned long prd, dty;
-	unsigned long long div;
-	unsigned int pres = 0;
-	u32 val;
-	int ret;
-
-	if (pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
-		dev_err(chip->dev, "cannot change PWM period while enabled\n");
-		return -EBUSY;
-	}
+	unsigned long long cycles = state->period;
 
 	/* Calculate the period cycles and prescale value */
-	div = (unsigned long long)clk_get_rate(atmel_pwm->clk) * period_ns;
-	do_div(div, NSEC_PER_SEC);
+	cycles *= clk_get_rate(atmel_pwm->clk);
+	do_div(cycles, NSEC_PER_SEC);
 
-	while (div > PWM_MAX_PRD) {
-		div >>= 1;
-		pres++;
-	}
+	for (*pres = 0; cycles > PWM_MAX_PRD; cycles >>= 1)
+		(*pres)++;
 
-	if (pres > PRD_MAX_PRES) {
+	if (*pres > PRD_MAX_PRES) {
 		dev_err(chip->dev, "pres exceeds the maximum value\n");
 		return -EINVAL;
 	}
 
-	/* Calculate the duty cycles */
-	prd = div;
-	div *= duty_ns;
-	do_div(div, period_ns);
-	dty = prd - div;
-
-	ret = clk_enable(atmel_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
-	}
+	*cprd = cycles;
 
-	/* It is necessary to preserve CPOL, inside CMR */
-	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
-	val = (val & ~PWM_CMR_CPRE_MSK) | (pres & PWM_CMR_CPRE_MSK);
-	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
-	atmel_pwm->config(chip, pwm, dty, prd);
-	mutex_lock(&atmel_pwm->isr_lock);
-	atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
-	atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
-	mutex_unlock(&atmel_pwm->isr_lock);
-
-	clk_disable(atmel_pwm->clk);
-	return ret;
-}
-
-static void atmel_pwm_config_v1(struct pwm_chip *chip, struct pwm_device *pwm,
-				unsigned long dty, unsigned long prd)
-{
-	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	unsigned int val;
-
-
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
+	return 0;
 }
 
-static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
-				unsigned long dty, unsigned long prd)
+static void atmel_pwm_calculate_cdty(const struct pwm_state *state,
+				     unsigned long cprd, unsigned long *cdty)
 {
-	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+	unsigned long long cycles = state->duty_cycle;
 
-	if (pwm_is_enabled(pwm)) {
-		/*
-		 * If the PWM channel is enabled, using the duty update register
-		 * to update the value.
-		 */
-		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTYUPD, dty);
-	} else {
-		/*
-		 * If the PWM channel is disabled, write value to duty and
-		 * period registers directly.
-		 */
-		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTY, dty);
-		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRD, prd);
-	}
+	cycles *= cprd;
+	do_div(cycles, state->period);
+	*cdty = cprd - cycles;
 }
 
-static int atmel_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				  enum pwm_polarity polarity)
+static void atmel_pwm_update_cdty(struct pwm_chip *chip, struct pwm_device *pwm,
+				  unsigned long cdty)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	u32 val;
-	int ret;
-
-	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
 
-	if (polarity == PWM_POLARITY_NORMAL)
-		val &= ~PWM_CMR_CPOL;
-	else
-		val |= PWM_CMR_CPOL;
-
-	ret = clk_enable(atmel_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
+	if (atmel_pwm->data->regs.duty_upd ==
+	    atmel_pwm->data->regs.period_upd) {
+		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
+		val &= ~PWM_CMR_UPD_CDTY;
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 	}
 
-	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
-
-	clk_disable(atmel_pwm->clk);
-
-	return 0;
+	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
+			    atmel_pwm->data->regs.duty_upd, cdty);
 }
 
-static int atmel_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    unsigned long cprd, unsigned long cdty)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	int ret;
-
-	ret = clk_enable(atmel_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
-	}
-
-	atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
 
-	return 0;
+	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
+			    atmel_pwm->data->regs.duty, cdty);
+	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
+			    atmel_pwm->data->regs.period, cprd);
 }
 
-static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
+			      bool disable_clk)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned long timeout = jiffies + 2 * HZ;
@@ -282,28 +213,102 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	       time_before(jiffies, timeout))
 		usleep_range(10, 100);
 
-	clk_disable(atmel_pwm->clk);
+	if (disable_clk)
+		clk_disable(atmel_pwm->clk);
+}
+
+static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
+{
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+	struct pwm_state cstate;
+	unsigned long cprd, cdty;
+	u32 pres, val;
+	bool pwm_reset = false;
+	int ret;
+
+	pwm_get_state(pwm, &cstate);
+
+	if (cstate.enabled &&
+	    (cstate.polarity != state->polarity ||
+	     cstate.period != state->period))
+		pwm_reset = true;
+
+	if (state->enabled) {
+		if (cstate.enabled && !pwm_reset) {
+			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
+						  atmel_pwm->data->regs.period);
+			atmel_pwm_calculate_cdty(state, cprd, &cdty);
+			atmel_pwm->data->update_cdty(chip, pwm, cdty);
+			return 0;
+		}
+
+		ret = atmel_pwm_calculate_cprd_and_pres(chip, state, &cprd,
+							&pres);
+		if (ret) {
+			dev_err(chip->dev,
+				"failed to calculate cprd and prescaler\n");
+			return ret;
+		}
+
+		atmel_pwm_calculate_cdty(state, cprd, &cdty);
+
+		if (pwm_reset) {
+			atmel_pwm_disable(chip, pwm, false);
+		} else {
+			ret = clk_enable(atmel_pwm->clk);
+			if (ret) {
+				dev_err(chip->dev, "failed to enable clock\n");
+				return ret;
+			}
+		}
+
+		/* It is necessary to preserve CPOL, inside CMR */
+		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
+		val = (val & ~PWM_CMR_CPRE_MSK) | (pres & PWM_CMR_CPRE_MSK);
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			val &= ~PWM_CMR_CPOL;
+		else
+			val |= PWM_CMR_CPOL;
+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
+		atmel_pwm->data->set_cprd_cdty(chip, pwm, cprd, cdty);
+		mutex_lock(&atmel_pwm->isr_lock);
+		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
+		atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
+		mutex_unlock(&atmel_pwm->isr_lock);
+		atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
+	} else if (cstate.enabled) {
+		atmel_pwm_disable(chip, pwm, true);
+	}
+
+	return 0;
 }
 
 static const struct pwm_ops atmel_pwm_ops = {
-	.config = atmel_pwm_config,
-	.set_polarity = atmel_pwm_set_polarity,
-	.enable = atmel_pwm_enable,
-	.disable = atmel_pwm_disable,
+	.apply = atmel_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-struct atmel_pwm_data {
-	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
-		       unsigned long dty, unsigned long prd);
-};
-
 static const struct atmel_pwm_data atmel_pwm_data_v1 = {
-	.config = atmel_pwm_config_v1,
+	.update_cdty = atmel_pwm_update_cdty,
+	.set_cprd_cdty = atmel_pwm_set_cprd_cdty,
+	.regs = {
+		.period		= PWMV1_CPRD,
+		.period_upd	= PWMV1_CUPD,
+		.duty		= PWMV1_CDTY,
+		.duty_upd	= PWMV1_CUPD,
+	}
 };
 
 static const struct atmel_pwm_data atmel_pwm_data_v2 = {
-	.config = atmel_pwm_config_v2,
+	.update_cdty = atmel_pwm_update_cdty,
+	.set_cprd_cdty = atmel_pwm_set_cprd_cdty,
+	.regs = {
+		.period		= PWMV2_CPRD,
+		.period_upd	= PWMV2_CPRDUPD,
+		.duty		= PWMV2_CDTY,
+		.duty_upd	= PWMV2_CDTYUPD,
+	}
 };
 
 static const struct platform_device_id atmel_pwm_devtypes[] = {
@@ -385,7 +390,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
-	atmel_pwm->config = data->config;
+	atmel_pwm->data = data;
 	atmel_pwm->updated_pwms = 0;
 	mutex_init(&atmel_pwm->isr_lock);
 
-- 
2.7.4
