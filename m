From: Lee Jones <lee.jones@linaro.org>
Subject: [RESEND 03/11] pwm: sti: Reorganise register names in preparation for new functionality
Date: Wed,  2 Mar 2016 15:32:01 +0000
Message-ID: <1456932729-9667-4-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Exciting functionality is on the way to this device.  But
before we can add it, we need to do some basic housekeeping
so the additions can be added cleanly.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 76 +++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 92abbd5..4e06c4d 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -21,18 +21,22 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 
-#define STI_DS_REG(ch)	(4 * (ch))	/* Channel's Duty Cycle register */
-#define STI_PWMCR	0x50		/* Control/Config register */
-#define STI_INTEN	0x54		/* Interrupt Enable/Disable register */
+#define PWM_OUT_VAL(x)	(0x00 + (4 * (x))) /* Channel's Duty Cycle register */
+
+#define STI_PWM_CTRL	0x50		/* Control/Config register */
+#define STI_INT_EN	0x54		/* Interrupt Enable/Disable register */
 #define PWM_PRESCALE_LOW_MASK		0x0f
 #define PWM_PRESCALE_HIGH_MASK		0xf0
 
 /* Regfield IDs */
 enum {
+	/* Bits in PWM_CTRL*/
 	PWMCLK_PRESCALE_LOW,
 	PWMCLK_PRESCALE_HIGH,
-	PWM_EN,
-	PWM_INT_EN,
+
+	PWM_OUT_EN,
+
+	PWM_CPT_INT_EN,
 
 	/* Keep last */
 	MAX_REGFIELDS
@@ -47,14 +51,14 @@ struct sti_pwm_compat_data {
 
 struct sti_pwm_chip {
 	struct device *dev;
-	struct clk *clk;
 	unsigned long clk_rate;
+	struct clk *pwm_clk;
 	struct regmap *regmap;
 	struct sti_pwm_compat_data *cdata;
 	struct regmap_field *prescale_low;
 	struct regmap_field *prescale_high;
-	struct regmap_field *pwm_en;
-	struct regmap_field *pwm_int_en;
+	struct regmap_field *pwm_out_en;
+	struct regmap_field *pwm_cpt_int_en;
 	struct pwm_chip chip;
 	struct pwm_device *cur;
 	unsigned long configured;
@@ -64,10 +68,10 @@ struct sti_pwm_chip {
 };
 
 static const struct reg_field sti_pwm_regfields[MAX_REGFIELDS] = {
-	[PWMCLK_PRESCALE_LOW]	= REG_FIELD(STI_PWMCR, 0, 3),
-	[PWMCLK_PRESCALE_HIGH]	= REG_FIELD(STI_PWMCR, 11, 14),
-	[PWM_EN]		= REG_FIELD(STI_PWMCR, 9, 9),
-	[PWM_INT_EN]		= REG_FIELD(STI_INTEN, 0, 0),
+	[PWMCLK_PRESCALE_LOW]	= REG_FIELD(STI_PWM_CTRL, 0, 3),
+	[PWMCLK_PRESCALE_HIGH]	= REG_FIELD(STI_PWM_CTRL, 11, 14),
+	[PWM_OUT_EN]		= REG_FIELD(STI_PWM_CTRL, 9, 9),
+	[PWM_CPT_INT_EN]	= REG_FIELD(STI_INT_EN, 1, 4),
 };
 
 static inline struct sti_pwm_chip *to_sti_pwmchip(struct pwm_chip *chip)
@@ -144,7 +148,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	    ((ncfg == 1) && (pwm->hwpwm != cur->hwpwm) && period_same) ||
 	    ((ncfg > 1) && period_same)) {
 		/* Enable clock before writing to PWM registers. */
-		ret = clk_enable(pc->clk);
+		ret = clk_enable(pc->pwm_clk);
 		if (ret)
 			return ret;
 
@@ -174,11 +178,12 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 */
 		pwmvalx = cdata->max_pwm_cnt * duty_ns / period_ns;
 
-		ret = regmap_write(pc->regmap, STI_DS_REG(pwm->hwpwm), pwmvalx);
+		ret = regmap_write(pc->regmap,
+				   PWM_OUT_VAL(pwm->hwpwm), pwmvalx);
 		if (ret)
 			goto clk_dis;
 
-		ret = regmap_field_write(pc->pwm_int_en, 0);
+		ret = regmap_field_write(pc->pwm_cpt_int_en, 0);
 
 		set_bit(pwm->hwpwm, &pc->configured);
 		pc->cur = pwm;
@@ -190,7 +195,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 clk_dis:
-	clk_disable(pc->clk);
+	clk_disable(pc->pwm_clk);
 	return ret;
 }
 
@@ -206,11 +211,11 @@ static int sti_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	 */
 	mutex_lock(&pc->sti_pwm_lock);
 	if (!pc->en_count) {
-		ret = clk_enable(pc->clk);
+		ret = clk_enable(pc->pwm_clk);
 		if (ret)
 			goto out;
 
-		ret = regmap_field_write(pc->pwm_en, 1);
+		ret = regmap_field_write(pc->pwm_out_en, 1);
 		if (ret) {
 			dev_err(dev, "failed to enable PWM device:%d\n",
 				pwm->hwpwm);
@@ -232,9 +237,9 @@ static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 		mutex_unlock(&pc->sti_pwm_lock);
 		return;
 	}
-	regmap_field_write(pc->pwm_en, 0);
+	regmap_field_write(pc->pwm_out_en, 0);
 
-	clk_disable(pc->clk);
+	clk_disable(pc->pwm_clk);
 	mutex_unlock(&pc->sti_pwm_lock);
 }
 
@@ -277,15 +282,16 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	if (IS_ERR(pc->prescale_high))
 		return PTR_ERR(pc->prescale_high);
 
-	pc->pwm_en = devm_regmap_field_alloc(dev, pc->regmap,
-					     reg_fields[PWM_EN]);
-	if (IS_ERR(pc->pwm_en))
-		return PTR_ERR(pc->pwm_en);
 
-	pc->pwm_int_en = devm_regmap_field_alloc(dev, pc->regmap,
-						 reg_fields[PWM_INT_EN]);
-	if (IS_ERR(pc->pwm_int_en))
-		return PTR_ERR(pc->pwm_int_en);
+	pc->pwm_out_en = devm_regmap_field_alloc(dev, pc->regmap,
+						 reg_fields[PWM_OUT_EN]);
+	if (IS_ERR(pc->pwm_out_en))
+		return PTR_ERR(pc->pwm_out_en);
+
+	pc->pwm_cpt_int_en = devm_regmap_field_alloc(dev, pc->regmap,
+						 reg_fields[PWM_CPT_INT_EN]);
+	if (IS_ERR(pc->pwm_cpt_int_en))
+		return PTR_ERR(pc->pwm_cpt_int_en);
 
 	return 0;
 }
@@ -341,19 +347,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pc->clk = of_clk_get_by_name(dev->of_node, "pwm");
-	if (IS_ERR(pc->clk)) {
+	pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
+	if (IS_ERR(pc->pwm_clk)) {
 		dev_err(dev, "failed to get PWM clock\n");
-		return PTR_ERR(pc->clk);
+		return PTR_ERR(pc->pwm_clk);
 	}
 
-	pc->clk_rate = clk_get_rate(pc->clk);
+	pc->clk_rate = clk_get_rate(pc->pwm_clk);
 	if (!pc->clk_rate) {
 		dev_err(dev, "failed to get clock rate\n");
 		return -EINVAL;
 	}
 
-	ret = clk_prepare(pc->clk);
+	ret = clk_prepare(pc->pwm_clk);
 	if (ret) {
 		dev_err(dev, "failed to prepare clock\n");
 		return ret;
@@ -367,7 +373,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
-		clk_unprepare(pc->clk);
+		clk_unprepare(pc->pwm_clk);
 		return ret;
 	}
 
@@ -384,7 +390,7 @@ static int sti_pwm_remove(struct platform_device *pdev)
 	for (i = 0; i < pc->cdata->num_chan; i++)
 		pwm_disable(&pc->chip.pwms[i]);
 
-	clk_unprepare(pc->clk);
+	clk_unprepare(pc->pwm_clk);
 
 	return pwmchip_remove(&pc->chip);
 }
-- 
1.9.1
