From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 1/4] ARM: pwm: sun4i: unification of register
 operations for support sun6i.
Date: Tue,  7 Feb 2017 20:50:43 +0300
Message-ID: <1486489846-662-2-git-send-email-lis8215@gmail.com>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBEES5DCAKGQEPSTZ5AI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1486489846-662-1-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch not introduce new features, just prepare code for
adding sun6i PWM driver in next commits.

A31 SoC have a different map of PWM registers than others ASoCs,
but register bits purposes are very similar.

This patch introduce set of register access routines, which
are common for existing in driver ASoCs:
 - ctl_rdy   - checks the ready bit of specified PWM channel,
 - ctl_read  - reads value from control register of specified PWM channel,
 - ctl_write - writes significant bits to control register of specified PWM channel,
 - prd_read  - reads value from period register of specified PWM channel,
 - prd_write - writes value to period register of specified PWM channel.
Driver code redesigned to use the new routines.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 113 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b0803f6..04ad3b4 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -34,6 +34,7 @@
 #define PWM_MODE		BIT(7)
 #define PWM_PULSE		BIT(8)
 #define PWM_BYPASS		BIT(9)
+#define PWM_CHCTL_MASK		GENMASK(9, 0)
 
 #define PWM_RDY_BASE		28
 #define PWM_RDY_OFFSET		1
@@ -46,6 +47,8 @@
 
 #define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
 
+struct sun4i_pwm_chip;
+
 static const u32 prescaler_table[] = {
 	120,
 	180,
@@ -65,10 +68,19 @@ static const u32 prescaler_table[] = {
 	0, /* Actually 1 but tested separately */
 };
 
+struct sunxi_reg_ops {
+	int (*ctl_rdy)(struct sun4i_pwm_chip *chip, int npwm);
+	u32 (*ctl_read)(struct sun4i_pwm_chip *chip, int npwm);
+	void (*ctl_write)(struct sun4i_pwm_chip *chip, int npwm, u32 val);
+	u32 (*prd_read)(struct sun4i_pwm_chip *chip, int npwm);
+	void (*prd_write)(struct sun4i_pwm_chip *chip, int npwm, u32 val);
+};
+
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
 	bool has_rdy;
 	unsigned int npwm;
+	const struct sunxi_reg_ops *ops;
 };
 
 struct sun4i_pwm_chip {
@@ -96,10 +108,42 @@ static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
 	writel(val, chip->base + offset);
 }
 
+static int sun4i_reg_ctl_rdy(struct sun4i_pwm_chip *chip, int npwm)
+{
+	return PWM_RDY(npwm) & sun4i_pwm_readl(chip, PWM_CTRL_REG);
+}
+
+static u32 sun4i_reg_ctl_read(struct sun4i_pwm_chip *chip, int npwm)
+{
+	u32 val = sun4i_pwm_readl(chip, PWM_CTRL_REG);
+
+	return val >> (PWMCH_OFFSET * (npwm));
+}
+
+static void sun4i_reg_ctl_write(struct sun4i_pwm_chip *chip, int npwm, u32 val)
+{
+	u32 rd = sun4i_pwm_readl(chip, PWM_CTRL_REG);
+
+	rd &= ~(PWM_CHCTL_MASK << (PWMCH_OFFSET * npwm));
+	val &= (PWM_CHCTL_MASK << (PWMCH_OFFSET * npwm));
+	sun4i_pwm_writel(chip, rd | val, PWM_CTRL_REG);
+}
+
+static u32 sun4i_reg_prd_read(struct sun4i_pwm_chip *chip, int npwm)
+{
+	return sun4i_pwm_readl(chip, PWM_CH_PRD(npwm));
+}
+
+static void sun4i_reg_prd_write(struct sun4i_pwm_chip *chip, int npwm, u32 val)
+{
+	sun4i_pwm_writel(chip, val, PWM_CH_PRD(npwm));
+}
+
 static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	const struct sunxi_reg_ops *reg_ops = sun4i_pwm->data->ops;
 	u32 prd, dty, val, clk_gate;
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
@@ -152,32 +196,31 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
+	if (sun4i_pwm->data->has_rdy &&
+	    reg_ops->ctl_rdy(sun4i_pwm, pwm->hwpwm)) {
 		spin_unlock(&sun4i_pwm->ctrl_lock);
 		clk_disable_unprepare(sun4i_pwm->clk);
 		return -EBUSY;
 	}
 
-	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	val = reg_ops->ctl_read(sun4i_pwm, pwm->hwpwm);
+	clk_gate = val & PWM_CLK_GATING;
 	if (clk_gate) {
-		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+		val &= ~PWM_CLK_GATING;
+		reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);
 	}
 
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 	val &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
 	val |= BIT_CH(prescaler, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);
 
-	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
+	reg_ops->prd_write(sun4i_pwm, pwm->hwpwm,
+			   (dty & PWM_DTY_MASK) | PWM_PRD(prd));
 
 	if (clk_gate) {
-		val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 		val |= clk_gate;
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+		reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);
 	}
 
 	spin_unlock(&sun4i_pwm->ctrl_lock);
@@ -190,6 +233,7 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				  enum pwm_polarity polarity)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	const struct sunxi_reg_ops *reg_ops = sun4i_pwm->data->ops;
 	u32 val;
 	int ret;
 
@@ -200,14 +244,14 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	val = reg_ops->ctl_read(sun4i_pwm, pwm->hwpwm);
 
 	if (polarity != PWM_POLARITY_NORMAL)
-		val &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
+		val &= ~PWM_ACT_STATE;
 	else
-		val |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
+		val |= PWM_ACT_STATE;
 
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);
 
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 	clk_disable_unprepare(sun4i_pwm->clk);
@@ -218,6 +262,7 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	const struct sunxi_reg_ops *reg_ops = sun4i_pwm->data->ops;
 	u32 val;
 	int ret;
 
@@ -228,10 +273,9 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val |= BIT_CH(PWM_EN, pwm->hwpwm);
-	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	val = reg_ops->ctl_rdy(sun4i_pwm, pwm->hwpwm);
+	val |= PWM_EN | PWM_CLK_GATING;
+	reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 
 	return 0;
@@ -240,18 +284,26 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	const struct sunxi_reg_ops *reg_ops = sun4i_pwm->data->ops;
 	u32 val;
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	val = reg_ops->ctl_rdy(sun4i_pwm, pwm->hwpwm);
+	val &= ~(PWM_EN | PWM_CLK_GATING);
+	reg_ops->ctl_write(sun4i_pwm, pwm->hwpwm, val);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 
 	clk_disable_unprepare(sun4i_pwm->clk);
 }
 
+static const struct sunxi_reg_ops sun4i_reg_ops = {
+	.ctl_rdy   = sun4i_reg_ctl_rdy,
+	.ctl_read  = sun4i_reg_ctl_read,
+	.ctl_write = sun4i_reg_ctl_write,
+	.prd_read  = sun4i_reg_prd_read,
+	.prd_write = sun4i_reg_prd_write,
+};
+
 static const struct pwm_ops sun4i_pwm_ops = {
 	.config = sun4i_pwm_config,
 	.set_polarity = sun4i_pwm_set_polarity,
@@ -264,30 +316,35 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
 	.npwm = 2,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
@@ -319,6 +376,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	u32 val;
 	int i, ret;
 	const struct of_device_id *match;
+	const struct sunxi_reg_ops *reg_ops;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
 
@@ -360,11 +418,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto clk_error;
 	}
 
-	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
-	for (i = 0; i < pwm->chip.npwm; i++)
-		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
+	reg_ops = pwm->data->ops;
+
+	for (i = 0; i < pwm->chip.npwm; i++) {
+		val = reg_ops->ctl_read(pwm, i);
+		if (!(val & PWM_ACT_STATE))
 			pwm_set_polarity(&pwm->chip.pwms[i],
 					 PWM_POLARITY_INVERSED);
+	}
 	clk_disable_unprepare(pwm->clk);
 
 	return 0;
-- 
2.4.11
