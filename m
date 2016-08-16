From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 16/17] pwm: sti: Take the opportunity to conduct a little house keeping
Date: Tue, 16 Aug 2016 10:35:07 +0100
Message-ID: <20160816093508.28307-17-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, patrice.chotard@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

This includes fixing some Coding Style issues and re-ordering/
simplifying a little code.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index a1319c0..3d5b9aa 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -1,8 +1,10 @@
 /*
- * PWM device driver for ST SoCs.
- * Author: Ajit Pal Singh <ajitpal.singh@st.com>
+ * PWM device driver for ST SoCs
+ *
+ * Copyright (C) 2013-2016 STMicroelectronics (R&D) Limited
  *
- * Copyright (C) 2013-2014 STMicroelectronics (R&D) Limited
+ * Author: Ajit Pal Singh <ajitpal.singh@st.com>
+ *         Lee Jones <lee.jones@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -142,13 +144,13 @@ static int sti_pwm_get_prescale(struct sti_pwm_chip *pc, unsigned long period,
 	val = NSEC_PER_SEC / clk_rate;
 	val *= cdata->max_pwm_cnt + 1;
 
-	if (period % val) {
+	if (period % val)
 		return -EINVAL;
-	} else {
-		ps  = period / val - 1;
-		if (ps > cdata->max_prescale)
-			return -EINVAL;
-	}
+
+	ps  = period / val - 1;
+	if (ps > cdata->max_prescale)
+		return -EINVAL;
+
 	*prescale = ps;
 
 	return 0;
@@ -164,7 +166,7 @@ static int sti_pwm_get_prescale(struct sti_pwm_chip *pc, unsigned long period,
  * 256 values.
  */
 static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			 int duty_ns, int period_ns)
+			int duty_ns, int period_ns)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 	struct sti_pwm_compat_data *cdata = pc->cdata;
@@ -210,7 +212,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 			ret =
 			regmap_field_write(pc->prescale_low,
-					   prescale & PWM_PRESCALE_LOW_MASK);
+				prescale & PWM_PRESCALE_LOW_MASK);
 			if (ret)
 				goto clk_dis;
 
@@ -273,7 +275,7 @@ static int sti_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 		ret = regmap_field_write(pc->pwm_out_en, 1);
 		if (ret) {
-			dev_err(dev, "failed to enable PWM device:%d\n",
+			dev_err(dev, "failed to enable PWM device %d\n",
 				pwm->hwpwm);
 			goto out;
 		}
@@ -293,10 +295,12 @@ static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 		mutex_unlock(&pc->sti_pwm_lock);
 		return;
 	}
+
 	regmap_field_write(pc->pwm_out_en, 0);
 
 	clk_disable(pc->pwm_clk);
 	clk_disable(pc->cpt_clk);
+
 	mutex_unlock(&pc->sti_pwm_lock);
 }
 
@@ -512,7 +516,7 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 		return PTR_ERR(pc->pwm_cpt_en);
 
 	pc->pwm_cpt_int_en = devm_regmap_field_alloc(dev, pc->regmap,
-						 reg_fields[PWM_CPT_INT_EN]);
+						reg_fields[PWM_CPT_INT_EN]);
 	if (IS_ERR(pc->pwm_cpt_int_en))
 		return PTR_ERR(pc->pwm_cpt_int_en);
 
@@ -575,11 +579,11 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	 * Setup PWM data with default values: some values could be replaced
 	 * with specific ones provided from Device Tree.
 	 */
-	cdata->reg_fields   = &sti_pwm_regfields[0];
-	cdata->max_prescale = 0xff;
-	cdata->max_pwm_cnt  = 255;
-	cdata->pwm_num_devs = 0;
-	cdata->cpt_num_devs = 0;
+	cdata->reg_fields	= &sti_pwm_regfields[0];
+	cdata->max_prescale	= 0xff;
+	cdata->max_pwm_cnt	= 255;
+	cdata->pwm_num_devs	= 0;
+	cdata->cpt_num_devs	= 0;
 
 	pc->cdata = cdata;
 	pc->dev = dev;
-- 
2.9.0
