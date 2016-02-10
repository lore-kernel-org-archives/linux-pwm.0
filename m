From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 11/11] pwm: sti: Take the opportunity to conduct a little house keeping
Date: Wed, 10 Feb 2016 13:02:28 +0000
Message-ID: <1455109348-32767-12-git-send-email-lee.jones@linaro.org>
References: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37812 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcBJNEr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2016 08:04:47 -0500
Received: by mail-wm0-f54.google.com with SMTP id g62so25828843wme.0
        for <linux-pwm@vger.kernel.org>; Wed, 10 Feb 2016 05:04:47 -0800 (PST)
In-Reply-To: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
Cc: kernel@stlinux.com, maxime.coquelin@st.com, Lee Jones <lee.jones@linaro.org>

This includes fixing some Coding Style issues and re-ordering/
simplifying a little code.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 93cf20e..93e3abf 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -144,13 +144,13 @@ static int sti_pwm_get_prescale(struct sti_pwm_chip *pc, unsigned long period,
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
@@ -166,7 +166,7 @@ static int sti_pwm_get_prescale(struct sti_pwm_chip *pc, unsigned long period,
  * 256 values.
  */
 static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			 int duty_ns, int period_ns)
+			int duty_ns, int period_ns)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 	struct sti_pwm_compat_data *cdata = pc->cdata;
@@ -212,7 +212,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 			ret =
 			regmap_field_write(pc->prescale_low,
-					   prescale & PWM_PRESCALE_LOW_MASK);
+				prescale & PWM_PRESCALE_LOW_MASK);
 			if (ret)
 				goto clk_dis;
 
@@ -506,7 +506,7 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 		return PTR_ERR(pc->pwm_cpt_en);
 
 	pc->pwm_cpt_int_en = devm_regmap_field_alloc(dev, pc->regmap,
-						 reg_fields[PWM_CPT_INT_EN]);
+						reg_fields[PWM_CPT_INT_EN]);
 	if (IS_ERR(pc->pwm_cpt_int_en))
 		return PTR_ERR(pc->pwm_cpt_int_en);
 
@@ -570,10 +570,11 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	 * Setup PWM data with default values: some values could be replaced
 	 * with specific ones provided from Device Tree.
 	 */
-	cdata->reg_fields   = &sti_pwm_regfields[0];
-	cdata->max_prescale = 0xff;
-	cdata->max_pwm_cnt  = 255;
-	cdata->pwm_num_chan     = 1;
+
+	cdata->reg_fields	= &sti_pwm_regfields[0];
+	cdata->max_prescale	= 0xff;
+	cdata->max_pwm_cnt	= 255;
+	cdata->pwm_num_chan	= 1;
 	cdata->cpt_num_chan	= 0;
 
 	pc->cdata = cdata;
-- 
1.9.1
