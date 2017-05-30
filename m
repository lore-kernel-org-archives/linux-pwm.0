From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 52/58] PWM: atmel-tcb: switch to new binding
Date: Tue, 30 May 2017 23:51:33 +0200
Message-ID: <20170530215139.9983-53-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The PWM is now a subnode of the used TCB. This is cleaner and it mainly
allows to stop wasting TCB channels when only 4 PWMs are used.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/Kconfig         |   3 +-
 drivers/pwm/pwm-atmel-tcb.c | 221 ++++++++++++++++++++++++--------------------
 2 files changed, 122 insertions(+), 102 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 313c10789ca2..d154f1fb610e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -64,7 +64,8 @@ config PWM_ATMEL_HLCDC_PWM
 
 config PWM_ATMEL_TCB
 	tristate "Atmel TC Block PWM support"
-	depends on ATMEL_TCLIB && OF
+	depends on OF
+	select REGMAP_MMIO
 	help
 	  Generic PWM framework driver for Atmel Timer Counter Block.
 
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 75db585a2a94..9aa569835b97 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -16,19 +16,26 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
-#include <linux/atmel_tc.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
+#include <soc/at91/atmel_tcb.h>
 
-#define NPWM	6
+#define NPWM	2
 
-#define ATMEL_TC_ACMR_MASK	(ATMEL_TC_ACPA | ATMEL_TC_ACPC |	\
-				 ATMEL_TC_AEEVT | ATMEL_TC_ASWTRG)
+#define ATMEL_TC_ACMR_MASK	(ATMEL_TC_CMR_ACPA_MSK | \
+				 ATMEL_TC_CMR_ACPC_MSK | \
+				 ATMEL_TC_CMR_AEEVT_MSK | \
+				 ATMEL_TC_CMR_ASWTRG_MSK)
 
-#define ATMEL_TC_BCMR_MASK	(ATMEL_TC_BCPB | ATMEL_TC_BCPC |	\
-				 ATMEL_TC_BEEVT | ATMEL_TC_BSWTRG)
+#define ATMEL_TC_BCMR_MASK	(ATMEL_TC_CMR_BCPB_MSK | \
+				 ATMEL_TC_CMR_BCPC_MSK | \
+				 ATMEL_TC_CMR_BEEVT_MSK | \
+				 ATMEL_TC_CMR_BSWTRG_MSK)
 
 struct atmel_tcb_pwm_device {
 	enum pwm_polarity polarity;	/* PWM polarity */
@@ -40,7 +47,11 @@ struct atmel_tcb_pwm_device {
 struct atmel_tcb_pwm_chip {
 	struct pwm_chip chip;
 	spinlock_t lock;
-	struct atmel_tc *tc;
+	u8 channel;
+	u8 width;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct clk *slow_clk;
 	struct atmel_tcb_pwm_device *pwms[NPWM];
 };
 
@@ -65,10 +76,6 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm;
-	struct atmel_tc *tc = tcbpwmc->tc;
-	void __iomem *regs = tc->regs;
-	unsigned group = pwm->hwpwm / 2;
-	unsigned index = pwm->hwpwm % 2;
 	unsigned cmr;
 	int ret;
 
@@ -76,7 +83,7 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	if (!tcbpwm)
 		return -ENOMEM;
 
-	ret = clk_prepare_enable(tc->clk[group]);
+	ret = clk_prepare_enable(tcbpwmc->clk);
 	if (ret) {
 		devm_kfree(chip->dev, tcbpwm);
 		return ret;
@@ -89,28 +96,32 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	tcbpwm->div = 0;
 
 	spin_lock(&tcbpwmc->lock);
-	cmr = __raw_readl(regs + ATMEL_TC_REG(group, CMR));
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_CMR(tcbpwmc->channel), &cmr);
 	/*
 	 * Get init config from Timer Counter registers if
 	 * Timer Counter is already configured as a PWM generator.
 	 */
-	if (cmr & ATMEL_TC_WAVE) {
-		if (index == 0)
-			tcbpwm->duty =
-				__raw_readl(regs + ATMEL_TC_REG(group, RA));
+	if (cmr & ATMEL_TC_CMR_WAVE) {
+		if (pwm->hwpwm == 0)
+			regmap_read(tcbpwmc->regmap,
+				    ATMEL_TC_RA(tcbpwmc->channel),
+				    &tcbpwm->duty);
 		else
-			tcbpwm->duty =
-				__raw_readl(regs + ATMEL_TC_REG(group, RB));
-
-		tcbpwm->div = cmr & ATMEL_TC_TCCLKS;
-		tcbpwm->period = __raw_readl(regs + ATMEL_TC_REG(group, RC));
-		cmr &= (ATMEL_TC_TCCLKS | ATMEL_TC_ACMR_MASK |
+			regmap_read(tcbpwmc->regmap,
+				    ATMEL_TC_RB(tcbpwmc->channel),
+				    &tcbpwm->duty);
+
+		tcbpwm->div = cmr & ATMEL_TC_CMR_TCLKS_MSK;
+		regmap_read(tcbpwmc->regmap, ATMEL_TC_RC(tcbpwmc->channel),
+			    &tcbpwm->period);
+		cmr &= (ATMEL_TC_CMR_TCLKS_MSK | ATMEL_TC_ACMR_MASK |
 			ATMEL_TC_BCMR_MASK);
 	} else
 		cmr = 0;
 
-	cmr |= ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO | ATMEL_TC_EEVT_XC0;
-	__raw_writel(cmr, regs + ATMEL_TC_REG(group, CMR));
+	cmr |= ATMEL_TC_CMR_WAVE | ATMEL_TC_CMR_WAVESEL_UPRC |
+	       ATMEL_TC_CMR_EEVT_XC(0);
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_CMR(tcbpwmc->channel), cmr);
 	spin_unlock(&tcbpwmc->lock);
 
 	tcbpwmc->pwms[pwm->hwpwm] = tcbpwm;
@@ -122,9 +133,8 @@ static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
-	struct atmel_tc *tc = tcbpwmc->tc;
 
-	clk_disable_unprepare(tc->clk[pwm->hwpwm / 2]);
+	clk_disable_unprepare(tcbpwmc->clk);
 	tcbpwmc->pwms[pwm->hwpwm] = NULL;
 	devm_kfree(chip->dev, tcbpwm);
 }
@@ -133,10 +143,6 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
-	struct atmel_tc *tc = tcbpwmc->tc;
-	void __iomem *regs = tc->regs;
-	unsigned group = pwm->hwpwm / 2;
-	unsigned index = pwm->hwpwm % 2;
 	unsigned cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
@@ -152,35 +158,35 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 		polarity = !polarity;
 
 	spin_lock(&tcbpwmc->lock);
-	cmr = __raw_readl(regs + ATMEL_TC_REG(group, CMR));
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_CMR(tcbpwmc->channel), &cmr);
 
 	/* flush old setting and set the new one */
-	if (index == 0) {
+	if (pwm->hwpwm == 0) {
 		cmr &= ~ATMEL_TC_ACMR_MASK;
 		if (polarity == PWM_POLARITY_INVERSED)
-			cmr |= ATMEL_TC_ASWTRG_CLEAR;
+			cmr |= ATMEL_TC_CMR_ASWTRG(CLEAR);
 		else
-			cmr |= ATMEL_TC_ASWTRG_SET;
+			cmr |= ATMEL_TC_CMR_ASWTRG(SET);
 	} else {
 		cmr &= ~ATMEL_TC_BCMR_MASK;
 		if (polarity == PWM_POLARITY_INVERSED)
-			cmr |= ATMEL_TC_BSWTRG_CLEAR;
+			cmr |= ATMEL_TC_CMR_BSWTRG(CLEAR);
 		else
-			cmr |= ATMEL_TC_BSWTRG_SET;
+			cmr |= ATMEL_TC_CMR_BSWTRG(SET);
 	}
 
-	__raw_writel(cmr, regs + ATMEL_TC_REG(group, CMR));
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_CMR(tcbpwmc->channel), cmr);
 
 	/*
 	 * Use software trigger to apply the new setting.
 	 * If both PWM devices in this group are disabled we stop the clock.
 	 */
-	if (!(cmr & (ATMEL_TC_ACPC | ATMEL_TC_BCPC)))
-		__raw_writel(ATMEL_TC_SWTRG | ATMEL_TC_CLKDIS,
-			     regs + ATMEL_TC_REG(group, CCR));
+	if (!(cmr & (ATMEL_TC_CMR_ACPC_MSK | ATMEL_TC_CMR_BCPC_MSK)))
+		regmap_write(tcbpwmc->regmap, ATMEL_TC_CCR(tcbpwmc->channel),
+			     ATMEL_TC_CCR_SWTRG | ATMEL_TC_CCR_CLKDIS);
 	else
-		__raw_writel(ATMEL_TC_SWTRG, regs +
-			     ATMEL_TC_REG(group, CCR));
+		regmap_write(tcbpwmc->regmap, ATMEL_TC_CCR(tcbpwmc->channel),
+			     ATMEL_TC_CCR_SWTRG);
 
 	spin_unlock(&tcbpwmc->lock);
 }
@@ -189,10 +195,6 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
-	struct atmel_tc *tc = tcbpwmc->tc;
-	void __iomem *regs = tc->regs;
-	unsigned group = pwm->hwpwm / 2;
-	unsigned index = pwm->hwpwm % 2;
 	u32 cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
@@ -208,25 +210,25 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		polarity = !polarity;
 
 	spin_lock(&tcbpwmc->lock);
-	cmr = __raw_readl(regs + ATMEL_TC_REG(group, CMR));
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_CMR(tcbpwmc->channel), &cmr);
 
 	/* flush old setting and set the new one */
-	cmr &= ~ATMEL_TC_TCCLKS;
+	cmr &= ~ATMEL_TC_CMR_TCLKS_MSK;
 
-	if (index == 0) {
+	if (pwm->hwpwm == 0) {
 		cmr &= ~ATMEL_TC_ACMR_MASK;
 
 		/* Set CMR flags according to given polarity */
 		if (polarity == PWM_POLARITY_INVERSED)
-			cmr |= ATMEL_TC_ASWTRG_CLEAR;
+			cmr |= ATMEL_TC_CMR_ASWTRG(CLEAR);
 		else
-			cmr |= ATMEL_TC_ASWTRG_SET;
+			cmr |= ATMEL_TC_CMR_ASWTRG(SET);
 	} else {
 		cmr &= ~ATMEL_TC_BCMR_MASK;
 		if (polarity == PWM_POLARITY_INVERSED)
-			cmr |= ATMEL_TC_BSWTRG_CLEAR;
+			cmr |= ATMEL_TC_CMR_BSWTRG(CLEAR);
 		else
-			cmr |= ATMEL_TC_BSWTRG_SET;
+			cmr |= ATMEL_TC_CMR_BSWTRG(SET);
 	}
 
 	/*
@@ -236,33 +238,40 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	 * this config till next config call.
 	 */
 	if (tcbpwm->duty != tcbpwm->period && tcbpwm->duty > 0) {
-		if (index == 0) {
+		if (pwm->hwpwm == 0) {
 			if (polarity == PWM_POLARITY_INVERSED)
-				cmr |= ATMEL_TC_ACPA_SET | ATMEL_TC_ACPC_CLEAR;
+				cmr |= ATMEL_TC_CMR_ACPA(SET) |
+				       ATMEL_TC_CMR_ACPC(CLEAR);
 			else
-				cmr |= ATMEL_TC_ACPA_CLEAR | ATMEL_TC_ACPC_SET;
+				cmr |= ATMEL_TC_CMR_ACPA(CLEAR) |
+				       ATMEL_TC_CMR_ACPC(SET);
 		} else {
 			if (polarity == PWM_POLARITY_INVERSED)
-				cmr |= ATMEL_TC_BCPB_SET | ATMEL_TC_BCPC_CLEAR;
+				cmr |= ATMEL_TC_CMR_BCPB(SET) |
+				       ATMEL_TC_CMR_BCPC(CLEAR);
 			else
-				cmr |= ATMEL_TC_BCPB_CLEAR | ATMEL_TC_BCPC_SET;
+				cmr |= ATMEL_TC_CMR_BCPB(CLEAR) |
+				       ATMEL_TC_CMR_BCPC(SET);
 		}
 	}
 
-	cmr |= (tcbpwm->div & ATMEL_TC_TCCLKS);
+	cmr |= (tcbpwm->div & ATMEL_TC_CMR_TCLKS_MSK);
 
-	__raw_writel(cmr, regs + ATMEL_TC_REG(group, CMR));
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_CMR(tcbpwmc->channel), cmr);
 
-	if (index == 0)
-		__raw_writel(tcbpwm->duty, regs + ATMEL_TC_REG(group, RA));
+	if (pwm->hwpwm == 0)
+		regmap_write(tcbpwmc->regmap, ATMEL_TC_RA(tcbpwmc->channel),
+			     tcbpwm->duty);
 	else
-		__raw_writel(tcbpwm->duty, regs + ATMEL_TC_REG(group, RB));
+		regmap_write(tcbpwmc->regmap, ATMEL_TC_RB(tcbpwmc->channel),
+			     tcbpwm->duty);
 
-	__raw_writel(tcbpwm->period, regs + ATMEL_TC_REG(group, RC));
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_RC(tcbpwmc->channel),
+		     tcbpwm->period);
 
 	/* Use software trigger to apply the new setting */
-	__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
-		     regs + ATMEL_TC_REG(group, CCR));
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_CCR(tcbpwmc->channel),
+		     ATMEL_TC_CCR_SWTRG | ATMEL_TC_CCR_CLKEN);
 	spin_unlock(&tcbpwmc->lock);
 	return 0;
 }
@@ -272,15 +281,12 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
-	unsigned group = pwm->hwpwm / 2;
-	unsigned index = pwm->hwpwm % 2;
 	struct atmel_tcb_pwm_device *atcbpwm = NULL;
-	struct atmel_tc *tc = tcbpwmc->tc;
 	int i;
 	int slowclk = 0;
 	unsigned period;
 	unsigned duty;
-	unsigned rate = clk_get_rate(tc->clk[group]);
+	unsigned rate = clk_get_rate(tcbpwmc->clk);
 	unsigned long long min;
 	unsigned long long max;
 
@@ -294,7 +300,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			continue;
 		}
 		min = div_u64((u64)NSEC_PER_SEC * atmel_tc_divisors[i], rate);
-		max = min << tc->tcb_config->counter_width;
+		max = min << tcbpwmc->width;
 		if (max >= period_ns)
 			break;
 	}
@@ -305,9 +311,9 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (i == 5) {
 		i = slowclk;
-		rate = clk_get_rate(tc->slow_clk);
+		rate = clk_get_rate(tcbpwmc->slow_clk);
 		min = div_u64(NSEC_PER_SEC, rate);
-		max = min << tc->tcb_config->counter_width;
+		max = min << tcbpwmc->width;
 
 		/* If period is too big return ERANGE error */
 		if (max < period_ns)
@@ -317,17 +323,13 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = div_u64(duty_ns, min);
 	period = div_u64(period_ns, min);
 
-	if (index == 0)
-		atcbpwm = tcbpwmc->pwms[pwm->hwpwm + 1];
+	if (pwm->hwpwm == 0)
+		atcbpwm = tcbpwmc->pwms[1];
 	else
-		atcbpwm = tcbpwmc->pwms[pwm->hwpwm - 1];
+		atcbpwm = tcbpwmc->pwms[0];
 
 	/*
-	 * PWM devices provided by TCB driver are grouped by 2:
-	 * - group 0: PWM 0 & 1
-	 * - group 1: PWM 2 & 3
-	 * - group 2: PWM 4 & 5
-	 *
+	 * PWM devices provided by the TCB driver are grouped by 2.
 	 * PWM devices in a given group must be configured with the
 	 * same period_ns.
 	 *
@@ -365,31 +367,41 @@ static const struct pwm_ops atmel_tcb_pwm_ops = {
 
 static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
+	const struct atmel_tcb_info *tcb_info;
 	struct atmel_tcb_pwm_chip *tcbpwm;
 	struct device_node *np = pdev->dev.of_node;
-	struct atmel_tc *tc;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct clk *slow_clk;
 	int err;
-	int tcblock;
+	int channel;
 
-	err = of_property_read_u32(np, "tc-block", &tcblock);
+	err = of_property_read_u32(np, "reg", &channel);
 	if (err < 0) {
 		dev_err(&pdev->dev,
-			"failed to get Timer Counter Block number from device tree (error: %d)\n",
+			"failed to get Timer Counter Block channel from device tree (error: %d)\n",
 			err);
 		return err;
 	}
 
-	tc = atmel_tc_alloc(tcblock);
-	if (tc == NULL) {
-		dev_err(&pdev->dev, "failed to allocate Timer Counter Block\n");
-		return -ENOMEM;
-	}
+	regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
+	if (IS_ERR(slow_clk))
+		return PTR_ERR(slow_clk);
+
+	clk = tcb_clk_get(np, channel);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
 	if (tcbpwm == NULL) {
 		err = -ENOMEM;
 		dev_err(&pdev->dev, "failed to allocate memory\n");
-		goto err_free_tc;
+		goto err_slow_clk;
 	}
 
 	tcbpwm->chip.dev = &pdev->dev;
@@ -398,11 +410,18 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	tcbpwm->chip.of_pwm_n_cells = 3;
 	tcbpwm->chip.base = -1;
 	tcbpwm->chip.npwm = NPWM;
-	tcbpwm->tc = tc;
+	tcbpwm->channel = channel;
+	tcbpwm->regmap = regmap;
+	tcbpwm->clk = clk;
+	tcbpwm->slow_clk = slow_clk;
 
-	err = clk_prepare_enable(tc->slow_clk);
+	match = of_match_node(atmel_tcb_dt_ids, np->parent);
+	tcb_info = match->data;
+	tcbpwm->width = tcb_info->bits;
+
+	err = clk_prepare_enable(slow_clk);
 	if (err)
-		goto err_free_tc;
+		goto err_slow_clk;
 
 	spin_lock_init(&tcbpwm->lock);
 
@@ -415,10 +434,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_disable_clk:
-	clk_disable_unprepare(tcbpwm->tc->slow_clk);
+	clk_disable_unprepare(tcbpwm->slow_clk);
 
-err_free_tc:
-	atmel_tc_free(tc);
+err_slow_clk:
+	clk_put(slow_clk);
 
 	return err;
 }
@@ -428,14 +447,14 @@ static int atmel_tcb_pwm_remove(struct platform_device *pdev)
 	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
 	int err;
 
-	clk_disable_unprepare(tcbpwm->tc->slow_clk);
+	clk_disable_unprepare(tcbpwm->slow_clk);
+	clk_put(tcbpwm->slow_clk);
+	clk_put(tcbpwm->clk);
 
 	err = pwmchip_remove(&tcbpwm->chip);
 	if (err < 0)
 		return err;
 
-	atmel_tc_free(tcbpwm->tc);
-
 	return 0;
 }
 
-- 
2.11.0
