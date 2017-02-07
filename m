From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH] Add the Allwinner A31/A31s PWM driver.
Date: Tue,  7 Feb 2017 20:40:07 +0300
Message-ID: <1486489207-446-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBUEN5DCAKGQEWZPIRQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
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

A31 SoC have a different map of PWM registers than others Allwinner
SoCs, so the operation of access to the registers reworked for all
existing in driver SoCs.

Tested on Onda V972 (a31) and Marsboard A20, but only PWM
channel 0, because other channels pins are not routed or
have another function on these boards.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi |   8 ++
 drivers/pwm/pwm-sun4i.c          | 195 +++++++++++++++++++++++++++++++++------
 2 files changed, 175 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ee1eb6d..fcba129 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -627,6 +627,14 @@
 			status = "disabled";
 		};
 
+		pwm: pwm@01c21400 {
+			compatible = "allwinner,sun6i-a31-pwm";
+			reg = <0x01c21400 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		lradc: lradc@01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b0803f6..bd049c3 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -34,6 +34,7 @@
 #define PWM_MODE		BIT(7)
 #define PWM_PULSE		BIT(8)
 #define PWM_BYPASS		BIT(9)
+#define PWM_CHCTL_MASK		GENMASK(9, 0)
 
 #define PWM_RDY_BASE		28
 #define PWM_RDY_OFFSET		1
@@ -46,7 +47,13 @@
 
 #define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
 
-static const u32 prescaler_table[] = {
+#define SUN6I_PWM_RDY_BIT	PWM_RDY_BASE
+#define SUN6I_PWM_CTL_OFFS	0x0
+#define SUN6I_PWM_PRD_OFFS	0x4
+#define SUN6I_PWM_CH_CTL(ch)	(0x10 * (ch) + SUN6I_PWM_CTL_OFFS)
+#define SUN6I_PWM_CH_PRD(ch)	(0x10 * (ch) + SUN6I_PWM_PRD_OFFS)
+
+static const u32 sun4i_prescaler_table[] = {
 	120,
 	180,
 	240,
@@ -65,10 +72,41 @@ static const u32 prescaler_table[] = {
 	0, /* Actually 1 but tested separately */
 };
 
+static const u32 sun6i_prescaler_table[] = {
+	1,
+	2,
+	4,
+	8,
+	16,
+	32,
+	64,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+};
+
+struct sun4i_pwm_chip;
+
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
+	const u32 *prescaler_table;
+	struct sunxi_reg_ops *ops;
 };
 
 struct sun4i_pwm_chip {
@@ -96,10 +134,71 @@ static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
 	writel(val, chip->base + offset);
 }
 
+static int sun4i_reg_ctl_rdy(struct sun4i_pwm_chip *chip, int npwm)
+{
+	return PWM_RDY(npwm) & sun4i_pwm_readl(chip, PWM_CTRL_REG);
+}
+
+static int sun6i_reg_ctl_rdy(struct sun4i_pwm_chip *chip, int npwm)
+{
+	u32 val = sun4i_pwm_readl(chip, SUN6I_PWM_CH_CTL(npwm));
+
+	return val & BIT(SUN6I_PWM_RDY_BIT);
+}
+
+static u32 sun4i_reg_ctl_read(struct sun4i_pwm_chip *chip, int npwm)
+{
+	u32 val = sun4i_pwm_readl(chip, PWM_CTRL_REG);
+
+	return val >> (PWMCH_OFFSET * (npwm));
+}
+
+static u32 sun6i_reg_ctl_read(struct sun4i_pwm_chip *chip, int npwm)
+{
+	return sun4i_pwm_readl(chip, SUN6I_PWM_CH_CTL(npwm));
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
+static void sun6i_reg_ctl_write(struct sun4i_pwm_chip *chip, int npwm, u32 val)
+{
+	return sun4i_pwm_writel(chip, val, SUN6I_PWM_CH_CTL(npwm));
+}
+
+static u32 sun4i_reg_prd_read(struct sun4i_pwm_chip *chip, int npwm)
+{
+	return sun4i_pwm_readl(chip, PWM_CH_PRD(npwm));
+}
+
+static u32 sun6i_reg_prd_read(struct sun4i_pwm_chip *chip, int npwm)
+{
+	return sun4i_pwm_readl(chip, SUN6I_PWM_CH_PRD(npwm));
+}
+
+static void sun4i_reg_prd_write(struct sun4i_pwm_chip *chip, int npwm, u32 val)
+{
+	sun4i_pwm_writel(chip, val, PWM_CH_PRD(npwm));
+}
+
+static void sun6i_reg_prd_write(struct sun4i_pwm_chip *chip, int npwm, u32 val)
+{
+	return sun4i_pwm_writel(chip, val, SUN6I_PWM_CH_PRD(npwm));
+}
+
 static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	const struct sun4i_pwm_data *data = sun4i_pwm->data;
+	struct sunxi_reg_ops *reg_ops = data->ops;
+	const u32 *prescaler_table = data->prescaler_table;
 	u32 prd, dty, val, clk_gate;
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
@@ -107,7 +206,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
 
-	if (sun4i_pwm->data->has_prescaler_bypass) {
+	if (data->has_prescaler_bypass) {
 		/* First, test without any prescaler when available */
 		prescaler = PWM_PRESCAL_MASK;
 		/*
@@ -152,32 +251,30 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
+	if (data->has_rdy && reg_ops->ctl_rdy(sun4i_pwm, pwm->hwpwm)) {
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
@@ -190,6 +287,7 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				  enum pwm_polarity polarity)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	struct sunxi_reg_ops *reg_ops = sun4i_pwm->data->ops;
 	u32 val;
 	int ret;
 
@@ -200,14 +298,14 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -218,6 +316,7 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	struct sunxi_reg_ops *reg_ops = sun4i_pwm->data->ops;
 	u32 val;
 	int ret;
 
@@ -228,10 +327,9 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
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
@@ -240,18 +338,34 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	struct sunxi_reg_ops *reg_ops = sun4i_pwm->data->ops;
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
 
+static struct sunxi_reg_ops sun4i_reg_ops = {
+	.ctl_rdy   = sun4i_reg_ctl_rdy,
+	.ctl_read  = sun4i_reg_ctl_read,
+	.ctl_write = sun4i_reg_ctl_write,
+	.prd_read  = sun4i_reg_prd_read,
+	.prd_write = sun4i_reg_prd_write,
+};
+
+static struct sunxi_reg_ops sun6i_reg_ops = {
+	.ctl_rdy   = sun6i_reg_ctl_rdy,
+	.ctl_read  = sun6i_reg_ctl_read,
+	.ctl_write = sun6i_reg_ctl_write,
+	.prd_read  = sun6i_reg_prd_read,
+	.prd_write = sun6i_reg_prd_write,
+};
+
 static const struct pwm_ops sun4i_pwm_ops = {
 	.config = sun4i_pwm_config,
 	.set_polarity = sun4i_pwm_set_polarity,
@@ -264,30 +378,48 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.prescaler_table = sun4i_prescaler_table,
+	.ops = &sun4i_reg_ops,
+};
+
+static const struct sun4i_pwm_data sun6i_pwm_data_a31 = {
+	.has_prescaler_bypass = false,
+	.has_rdy = true,
+	.npwm = 4,
+	.prescaler_table = sun6i_prescaler_table,
+	.ops = &sun6i_reg_ops,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.prescaler_table = sun4i_prescaler_table,
+	.ops = &sun4i_reg_ops,
 };
 
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
@@ -301,6 +433,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 		.compatible = "allwinner,sun5i-a13-pwm",
 		.data = &sun4i_pwm_data_a13,
 	}, {
+		.compatible = "allwinner,sun6i-a31-pwm",
+		.data = &sun6i_pwm_data_a31,
+	}, {
 		.compatible = "allwinner,sun7i-a20-pwm",
 		.data = &sun4i_pwm_data_a20,
 	}, {
@@ -319,6 +454,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	u32 val;
 	int i, ret;
 	const struct of_device_id *match;
+	struct sunxi_reg_ops *reg_ops = NULL;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
 
@@ -344,6 +480,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm->chip.of_pwm_n_cells = 3;
 
+	reg_ops = pwm->data->ops;
+
 	spin_lock_init(&pwm->ctrl_lock);
 
 	ret = pwmchip_add(&pwm->chip);
@@ -360,11 +498,12 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto clk_error;
 	}
 
-	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
-	for (i = 0; i < pwm->chip.npwm; i++)
-		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
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
