From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v4 5/9] pwm: sunxi: Customizable regmap fields
 and enable bit mask.
Date: Fri, 24 Feb 2017 08:41:12 +0300
Message-ID: <1487914876-8594-6-git-send-email-lis8215@gmail.com>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBBMPX7CQKGQEWZ6OIFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1487914876-8594-1-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

sun6i has similar control registers bit map in comparison
to sun4i channel 0, but each channel has its own control
register.

This patch make:
 - regmap fields declarations selectable,
 - enable/disable bitmask selectable.
These things needed for support sun6i in next patches.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 9ddc812..9463148 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -82,6 +82,8 @@ static const u32 sun4i_prescaler_table[] = {
 struct sunxi_pwmch_data {
 	unsigned int ctl_reg;
 	unsigned int prd_reg;
+	u32 enable_bits;
+	struct reg_field fields[NUM_FIELDS];
 };
 
 struct sun4i_pwm_data {
@@ -271,8 +273,7 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return ret;
 	}
 
-	mask = BIT_CH(PWM_EN, pwm->hwpwm);
-	mask |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	mask = sun4i_pwm->data->chan_data[pwm->hwpwm]->enable_bits;
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ret = regmap_update_bits(sun4i_pwm->regmap,
@@ -293,8 +294,7 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u32 mask;
 	int err;
 
-	mask = BIT_CH(PWM_EN, pwm->hwpwm);
-	mask |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	mask = sun4i_pwm->data->chan_data[pwm->hwpwm]->enable_bits;
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	err = regmap_update_bits(sun4i_pwm->regmap,
@@ -315,30 +315,28 @@ static const struct pwm_ops sun4i_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
-static const struct reg_field
-sun4i_pwm_regfields[SUN4I_MAX_PWM_CHANNELS][NUM_FIELDS] = {
-	{
+static const struct sunxi_pwmch_data sun4i_pwm_chan0_data = {
+	.ctl_reg = PWM_CTRL_REG,
+	.prd_reg = PWM_CH_PRD(0),
+	.enable_bits = BIT_CH(PWM_EN | PWM_CLK_GATING, 0),
+	.fields = {
 		[FIELD_PRESCALER]  = REG_FIELD(PWM_CTRL_REG,  0,  3),
 		[FIELD_POLARITY]   = REG_FIELD(PWM_CTRL_REG,  5,  5),
 		[FIELD_CLK_GATING] = REG_FIELD(PWM_CTRL_REG,  6,  6),
 		[FIELD_READY]      = REG_FIELD(PWM_CTRL_REG, 28, 28),
 	},
-	{
-		[FIELD_PRESCALER]  = REG_FIELD(PWM_CTRL_REG, 15, 18),
-		[FIELD_POLARITY]   = REG_FIELD(PWM_CTRL_REG, 20, 20),
-		[FIELD_CLK_GATING] = REG_FIELD(PWM_CTRL_REG, 21, 21),
-		[FIELD_READY]      = REG_FIELD(PWM_CTRL_REG, 29, 29),
-	},
-};
-
-static const struct sunxi_pwmch_data sun4i_pwm_chan0_data = {
-	.ctl_reg = PWM_CTRL_REG,
-	.prd_reg = PWM_CH_PRD(0),
 };
 
 static const struct sunxi_pwmch_data sun4i_pwm_chan1_data = {
 	.ctl_reg = PWM_CTRL_REG,
 	.prd_reg = PWM_CH_PRD(1),
+	.enable_bits = BIT_CH(PWM_EN | PWM_CLK_GATING, 1),
+	.fields = {
+		[FIELD_PRESCALER]  = REG_FIELD(PWM_CTRL_REG, 15, 18),
+		[FIELD_POLARITY]   = REG_FIELD(PWM_CTRL_REG, 20, 20),
+		[FIELD_CLK_GATING] = REG_FIELD(PWM_CTRL_REG, 21, 21),
+		[FIELD_READY]      = REG_FIELD(PWM_CTRL_REG, 29, 29),
+	},
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
@@ -422,17 +420,18 @@ static const struct regmap_config sunxi_pwm_regmap_config = {
 	.reg_stride = 4,
 };
 
-static int sun4i_alloc_reg_fields(struct device *dev,
+static int sunxi_alloc_reg_fields(struct device *dev,
 				  struct sun4i_pwm_chip *pwm, int chan)
 {
 	int i, err;
+	const struct sunxi_pwmch_data *data = pwm->data->chan_data[chan];
 
-	if (chan >= SUN4I_MAX_PWM_CHANNELS)
+	if (!data || chan >= SUN4I_MAX_PWM_CHANNELS)
 		return -EINVAL;
 	for (i = 0; i < NUM_FIELDS; i++) {
 		pwm->fields[chan][i] =
 			devm_regmap_field_alloc(dev, pwm->regmap,
-						sun4i_pwm_regfields[chan][i]);
+						data->fields[i]);
 		if (IS_ERR(pwm->fields[chan][i])) {
 			dev_err(dev, "regmap field allocation failed\n");
 			err = PTR_ERR(pwm->fields[chan][i]);
@@ -499,7 +498,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < pwm->chip.npwm; i++) {
-		ret = sun4i_alloc_reg_fields(&pdev->dev, pwm, i);
+		ret = sunxi_alloc_reg_fields(&pdev->dev, pwm, i);
 		if (ret)
 			goto read_error;
 	}
-- 
2.4.11
