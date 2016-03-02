From: Lee Jones <lee.jones@linaro.org>
Subject: [RESEND 11/11] pwm: sti: Take the opportunity to conduct a little house keeping
Date: Wed,  2 Mar 2016 15:32:09 +0000
Message-ID: <1456932729-9667-12-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

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
