From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v4 2/9] pwm: sunxi: Use regmap fields for bit operations.
Date: Fri, 24 Feb 2017 08:41:09 +0300
Message-ID: <1487914876-8594-3-git-send-email-lis8215@gmail.com>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBAUPX7CQKGQEULMIGKY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

This patch replaces a bunch of custom read-modify-write operations
by regmap fields.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 197 ++++++++++++++++++++++++++----------------------
 1 file changed, 108 insertions(+), 89 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5565f03..7af6bd8 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -46,6 +46,20 @@
 
 #define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
 
+#define SUN4I_MAX_PWM_CHANNELS	2
+
+/* regmap fields */
+enum {
+	/* Used bit fields in control register */
+	FIELD_PRESCALER = 0,
+	FIELD_POLARITY,
+	FIELD_CLK_GATING,
+	FIELD_READY,
+
+	/* Keep last */
+	NUM_FIELDS,
+};
+
 static const u32 prescaler_table[] = {
 	120,
 	180,
@@ -75,6 +89,7 @@ struct sun4i_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
+	struct regmap_field *fields[SUN4I_MAX_PWM_CHANNELS][NUM_FIELDS];
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
 };
@@ -88,6 +103,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	struct regmap_field **chan_fields = sun4i_pwm->fields[pwm->hwpwm];
 	u32 prd, dty, val, clk_gate;
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
@@ -140,38 +156,36 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
-	if (err) {
-		dev_err(chip->dev, "failed to read from CTL register\n");
-		goto err_cleanup;
-	}
 
-	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
-		spin_unlock(&sun4i_pwm->ctrl_lock);
-		clk_disable_unprepare(sun4i_pwm->clk);
-		return -EBUSY;
-	}
-
-	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	if (clk_gate) {
-		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-		err = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
+	if (sun4i_pwm->data->has_rdy) {
+		err = regmap_field_read(chan_fields[FIELD_READY], &val);
 		if (err) {
-			dev_err(chip->dev, "failed to write to CTL register\n");
+			dev_err(chip->dev, "failed to read ready bit\n");
+			goto err_cleanup;
+		}
+		if (val) {
+			err = -EBUSY;
 			goto err_cleanup;
 		}
 	}
 
-	err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
+	err = regmap_field_read(chan_fields[FIELD_CLK_GATING], &clk_gate);
 	if (err) {
-		dev_err(chip->dev, "failed to read from CTL register\n");
+		dev_err(chip->dev, "failed to read clock_gating bit\n");
 		goto err_cleanup;
 	}
-	val &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
-	val |= BIT_CH(prescaler, pwm->hwpwm);
-	err = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
+	if (clk_gate) {
+		err = regmap_field_write(chan_fields[FIELD_CLK_GATING], 0);
+		if (err) {
+			dev_err(chip->dev,
+				"failed to write to clock_gating bit\n");
+			goto err_cleanup;
+		}
+	}
+
+	err = regmap_field_write(chan_fields[FIELD_PRESCALER], prescaler);
 	if (err) {
-		dev_err(chip->dev, "failed to write to CTL register\n");
+		dev_err(chip->dev, "failed to write to prescaler field\n");
 		goto err_cleanup;
 	}
 
@@ -183,16 +197,10 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clk_gate) {
-		err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
+		err = regmap_field_write(chan_fields[FIELD_CLK_GATING], 1);
 		if (err) {
 			dev_err(chip->dev,
-				"failed to read from CTL register\n");
-			goto err_cleanup;
-		}
-		val |= clk_gate;
-		err = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
-		if (err) {
-			dev_err(chip->dev, "failed to write to CTL register\n");
+				"failed to write to clock_gating bit\n");
 			goto err_cleanup;
 		}
 	}
@@ -208,7 +216,7 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				  enum pwm_polarity polarity)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
+	struct regmap_field **chan_fields = sun4i_pwm->fields[pwm->hwpwm];
 	int ret;
 
 	ret = clk_prepare_enable(sun4i_pwm->clk);
@@ -218,27 +226,14 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	ret = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
-	if (ret) {
-		dev_err(chip->dev,
-			"failed to read from CTL register\n");
-		goto err_cleanup;
-	}
-
-	if (polarity != PWM_POLARITY_NORMAL)
-		val &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-	else
-		val |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-
-	ret = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
-	if (ret) {
-		dev_err(chip->dev, "failed to write to CTL register\n");
-		goto err_cleanup;
-	}
+	ret = regmap_field_write(chan_fields[FIELD_POLARITY],
+				 polarity == PWM_POLARITY_NORMAL);
+	if (ret)
+		dev_err(chip->dev, "failed to write to polarity bit\n");
 
-err_cleanup:
 	spin_unlock(&sun4i_pwm->ctrl_lock);
-	clk_disable_unprepare(sun4i_pwm->clk);
+	if (ret)
+		clk_disable_unprepare(sun4i_pwm->clk);
 
 	return ret;
 }
@@ -246,7 +241,7 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
+	u32 mask;
 	int ret;
 
 	ret = clk_prepare_enable(sun4i_pwm->clk);
@@ -255,54 +250,33 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return ret;
 	}
 
+	mask = BIT_CH(PWM_EN, pwm->hwpwm);
+	mask |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	ret = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
-	if (ret) {
-		dev_err(chip->dev,
-			"failed to read from CTL register\n");
-		goto err_cleanup;
-	}
-	val |= BIT_CH(PWM_EN, pwm->hwpwm);
-	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	ret = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
-	if (ret) {
+	ret = regmap_update_bits(sun4i_pwm->regmap, PWM_CTRL_REG, mask, mask);
+	if (ret)
 		dev_err(chip->dev, "failed to write to CTL register\n");
-		goto err_cleanup;
-	}
-
 	spin_unlock(&sun4i_pwm->ctrl_lock);
-	return ret;
 
-err_cleanup:
-	spin_unlock(&sun4i_pwm->ctrl_lock);
 	if (ret)
 		clk_disable_unprepare(sun4i_pwm->clk);
-
 	return ret;
 }
 
 static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
+	u32 mask;
 	int err;
 
+	mask = BIT_CH(PWM_EN, pwm->hwpwm);
+	mask |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
-	if (err) {
-		dev_err(chip->dev,
-			"failed to read from CTL register\n");
-		goto err_cleanup;
-	}
-	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	err = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
-	if (err) {
+	err = regmap_update_bits(sun4i_pwm->regmap, PWM_CTRL_REG, mask, 0);
+	if (err)
 		dev_err(chip->dev, "failed to write to CTL register\n");
-		goto err_cleanup;
-	}
-
-err_cleanup:
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 
 	clk_disable_unprepare(sun4i_pwm->clk);
@@ -316,6 +290,22 @@ static const struct pwm_ops sun4i_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static const struct reg_field
+sun4i_pwm_regfields[SUN4I_MAX_PWM_CHANNELS][NUM_FIELDS] = {
+	{
+		[FIELD_PRESCALER]  = REG_FIELD(PWM_CTRL_REG,  0,  3),
+		[FIELD_POLARITY]   = REG_FIELD(PWM_CTRL_REG,  5,  5),
+		[FIELD_CLK_GATING] = REG_FIELD(PWM_CTRL_REG,  6,  6),
+		[FIELD_READY]      = REG_FIELD(PWM_CTRL_REG, 28, 28),
+	},
+	{
+		[FIELD_PRESCALER]  = REG_FIELD(PWM_CTRL_REG, 15, 18),
+		[FIELD_POLARITY]   = REG_FIELD(PWM_CTRL_REG, 20, 20),
+		[FIELD_CLK_GATING] = REG_FIELD(PWM_CTRL_REG, 21, 21),
+		[FIELD_READY]      = REG_FIELD(PWM_CTRL_REG, 29, 29),
+	},
+};
+
 static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
@@ -374,6 +364,28 @@ static const struct regmap_config sunxi_pwm_regmap_config = {
 	.reg_stride = 4,
 };
 
+static int sun4i_alloc_reg_fields(struct device *dev,
+				  struct sun4i_pwm_chip *pwm, int chan)
+{
+	int i, err;
+
+	if (chan >= SUN4I_MAX_PWM_CHANNELS)
+		return -EINVAL;
+	for (i = 0; i < NUM_FIELDS; i++) {
+		pwm->fields[chan][i] =
+			devm_regmap_field_alloc(dev, pwm->regmap,
+						sun4i_pwm_regfields[chan][i]);
+		if (IS_ERR(pwm->fields[chan][i])) {
+			dev_err(dev, "regmap field allocation failed\n");
+			err = PTR_ERR(pwm->fields[chan][i]);
+			pwm->fields[chan][i] = NULL;
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *pwm;
@@ -428,15 +440,22 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto clk_error;
 	}
 
-	ret = regmap_read(pwm->regmap, PWM_CTRL_REG, &val);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to read from CTL register\n");
-		goto read_error;
+	for (i = 0; i < pwm->chip.npwm; i++) {
+		ret = sun4i_alloc_reg_fields(&pdev->dev, pwm, i);
+		if (ret)
+			goto read_error;
 	}
-	for (i = 0; i < pwm->chip.npwm; i++)
-		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
+
+	for (i = 0; i < pwm->chip.npwm; i++) {
+		ret = regmap_field_read(pwm->fields[i][FIELD_POLARITY], &val);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to read polarity bit\n");
+			goto read_error;
+		}
+		if (val)
 			pwm_set_polarity(&pwm->chip.pwms[i],
 					 PWM_POLARITY_INVERSED);
+	}
 	clk_disable_unprepare(pwm->clk);
 
 	return 0;
-- 
2.4.11
