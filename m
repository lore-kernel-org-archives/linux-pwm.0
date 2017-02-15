From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v3 1/4] pwm: sunxi: Code switched to regmap API
 instead of iomem.
Date: Wed, 15 Feb 2017 23:06:04 +0300
Message-ID: <1487189167-32486-2-git-send-email-lis8215@gmail.com>
References: <1487189167-32486-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBNHJSLCQKGQEB46O3GA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1487189167-32486-1-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

sun6i PWM has different register map in comparison to sun4i compatible
SoCs. But bit map of the registers and behavior are very similar.

This patch introduces a uniform way to access PWM registers.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/Kconfig     |   2 +-
 drivers/pwm/pwm-sun4i.c | 263 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 191 insertions(+), 74 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 2d0cfaa..6b4dc1a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -416,7 +416,7 @@ config PWM_STMPE
 config PWM_SUN4I
 	tristate "Allwinner PWM support"
 	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on HAS_IOMEM && COMMON_CLK
+	depends on REGMAP_MMIO && COMMON_CLK
 	help
 	  Generic PWM framework driver for Allwinner SoCs.

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b0803f6..7291000 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -9,7 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/io.h>
+#include <linux/regmap.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -26,25 +26,56 @@
 #define PWM_CH_PRD(ch)		(PWM_CH_PRD_BASE + PWM_CH_PRD_OFFSET * (ch))

 #define PWMCH_OFFSET		15
-#define PWM_PRESCAL_MASK	GENMASK(3, 0)
-#define PWM_PRESCAL_OFF		0
-#define PWM_EN			BIT(4)
-#define PWM_ACT_STATE		BIT(5)
-#define PWM_CLK_GATING		BIT(6)
-#define PWM_MODE		BIT(7)
-#define PWM_PULSE		BIT(8)
-#define PWM_BYPASS		BIT(9)
+
+#define PWM_PRESCAL_LSB		0
+#define PWM_PRESCAL_MSB		3
+#define PWM_PRESCAL_MASK	GENMASK(PWM_PRESCAL_MSB - PWM_PRESCAL_LSB, 0)
+
+#define PWM_EN_BIT		4
+#define PWM_ACT_STATE_BIT	5
+#define PWM_CLK_GATING_BIT	6
+#define PWM_MODE_BIT		7
+#define PWM_PULSE_BIT		8
+#define PWM_BYPASS_BIT		9

 #define PWM_RDY_BASE		28
 #define PWM_RDY_OFFSET		1
-#define PWM_RDY(ch)		BIT(PWM_RDY_BASE + PWM_RDY_OFFSET * (ch))
+#define PWM_RDY_BIT(ch)		(PWM_RDY_BASE + PWM_RDY_OFFSET * (ch))

 #define PWM_PRD(prd)		(((prd) - 1) << 16)
 #define PWM_PRD_MASK		GENMASK(15, 0)

 #define PWM_DTY_MASK		GENMASK(15, 0)

-#define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
+#define BIT_CH(bit, chan)	((bit) + ((chan) * PWMCH_OFFSET))
+
+#define FIELD_PRESCALER		0
+#define FIELD_POLARITY		1
+#define FIELD_CLK_GATING	2
+#define FIELD_READY		3
+#define NUM_FIELDS		4
+
+#define MAX_CHANNELS		2
+
+#define SUN4I_REGMAP_FIELDS(chan) {\
+	[FIELD_PRESCALER] = \
+		REG_FIELD(PWM_CTRL_REG, \
+			  BIT_CH(PWM_PRESCAL_LSB, chan), \
+			  BIT_CH(PWM_PRESCAL_MSB, chan)), \
+	[FIELD_POLARITY] = \
+		REG_FIELD(PWM_CTRL_REG, \
+			  BIT_CH(PWM_ACT_STATE_BIT, chan), \
+			  BIT_CH(PWM_ACT_STATE_BIT, chan)), \
+	[FIELD_CLK_GATING] = \
+		REG_FIELD(PWM_CTRL_REG, \
+			  BIT_CH(PWM_CLK_GATING_BIT, chan), \
+			  BIT_CH(PWM_CLK_GATING_BIT, chan)), \
+	[FIELD_READY] = \
+		REG_FIELD(PWM_CTRL_REG, \
+			  PWM_RDY_BIT(chan), \
+			  PWM_RDY_BIT(chan)), \
+}
+

 static const u32 prescaler_table[] = {
 	120,
@@ -65,17 +96,26 @@ static const u32 prescaler_table[] = {
 	0, /* Actually 1 but tested separately */
 };

+struct sunxi_pwmch_reg_info {
+	struct reg_field fields[NUM_FIELDS];
+	unsigned int control_reg;
+	unsigned int period_reg;
+	u32 enable_bitmask;
+};
+
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
 	bool has_rdy;
 	unsigned int npwm;
+	const struct sunxi_pwmch_reg_info *chan_info;
 };

 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
-	void __iomem *base;
 	spinlock_t ctrl_lock;
+	struct regmap *regmap;
+	struct regmap_field *fields[MAX_CHANNELS][NUM_FIELDS];
 	const struct sun4i_pwm_data *data;
 };

@@ -84,23 +124,12 @@ static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct sun4i_pwm_chip, chip);
 }

-static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *chip,
-				  unsigned long offset)
-{
-	return readl(chip->base + offset);
-}
-
-static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
-				    u32 val, unsigned long offset)
-{
-	writel(val, chip->base + offset);
-}
-
 static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 prd, dty, val, clk_gate;
+	struct regmap_field **chan_fields = sun4i_pwm->fields[pwm->hwpwm];
+	u32 prd, dty, busy, clk_gate;
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
 	int err;
@@ -152,45 +181,63 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}

 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);

-	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
-		spin_unlock(&sun4i_pwm->ctrl_lock);
-		clk_disable_unprepare(sun4i_pwm->clk);
-		return -EBUSY;
+	if (sun4i_pwm->data->has_rdy) {
+		err = regmap_field_read(chan_fields[FIELD_READY], &busy);
+		if (err) {
+			dev_err(chip->dev, "failed to get ready bit\n");
+			goto err_cleanup;
+		}
+		if (busy) {
+			err = -EBUSY;
+			goto err_cleanup;
+		}
 	}

-	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	err = regmap_field_read(chan_fields[FIELD_CLK_GATING], &clk_gate);
+	if (err) {
+		dev_err(chip->dev, "failed to get clock_gate bit\n");
+		goto err_cleanup;
+	}
 	if (clk_gate) {
-		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+		err = regmap_field_write(chan_fields[FIELD_CLK_GATING], 0);
+		if (err) {
+			dev_err(chip->dev, "failed to set clock_gate bit\n");
+			goto err_cleanup;
+		}
 	}

-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
-	val |= BIT_CH(prescaler, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-
-	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
-
+	err = regmap_field_write(chan_fields[FIELD_PRESCALER], prescaler);
+	if (err) {
+		dev_err(chip->dev, "failed to set prescaler\n");
+		goto err_cleanup;
+	}
+	err = regmap_write(sun4i_pwm->regmap,
+			   sun4i_pwm->data->chan_info[pwm->hwpwm].period_reg,
+			   (dty & PWM_DTY_MASK) | PWM_PRD(prd));
+	if (err) {
+		dev_err(chip->dev, "failed to set period and duty cycle\n");
+		goto err_cleanup;
+	}
 	if (clk_gate) {
-		val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-		val |= clk_gate;
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+		err = regmap_field_write(chan_fields[FIELD_CLK_GATING], 1);
+		if (err) {
+			dev_err(chip->dev, "failed to set clock_gate bit\n");
+			goto err_cleanup;
+		}
 	}

+err_cleanup:
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 	clk_disable_unprepare(sun4i_pwm->clk);

-	return 0;
+	return err;
 }

 static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				  enum pwm_polarity polarity)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
 	int ret;

 	ret = clk_prepare_enable(sun4i_pwm->clk);
@@ -200,25 +247,21 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	}

 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-
-	if (polarity != PWM_POLARITY_NORMAL)
-		val &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-	else
-		val |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
-
+	ret = regmap_field_write(sun4i_pwm->fields[pwm->hwpwm][FIELD_POLARITY],
+				 polarity == PWM_POLARITY_NORMAL);
+	if (ret)
+		dev_err(chip->dev, "failed to set polarity bit\n");
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 	clk_disable_unprepare(sun4i_pwm->clk);

-	return 0;
+	return ret;
 }

 static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
+	unsigned int ctl_reg;
+	u32 bit_mask;
 	int ret;

 	ret = clk_prepare_enable(sun4i_pwm->clk);
@@ -228,30 +271,51 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	}

 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val |= BIT_CH(PWM_EN, pwm->hwpwm);
-	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	ctl_reg = sun4i_pwm->data->chan_info[pwm->hwpwm].control_reg;
+	bit_mask = sun4i_pwm->data->chan_info[pwm->hwpwm].enable_bitmask;
+	ret = regmap_update_bits(sun4i_pwm->regmap, ctl_reg,
+				 bit_mask, bit_mask);
+	if (ret)
+		dev_err(chip->dev, "failed to set clock_gate and enable bit\n");
 	spin_unlock(&sun4i_pwm->ctrl_lock);

-	return 0;
+	return ret;
 }

 static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
-	u32 val;
+	unsigned int ctl_reg;
+	u32 bit_mask;
+	int ret;

 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	ctl_reg = sun4i_pwm->data->chan_info[pwm->hwpwm].control_reg;
+	bit_mask = sun4i_pwm->data->chan_info[pwm->hwpwm].enable_bitmask;
+	ret = regmap_update_bits(sun4i_pwm->regmap, ctl_reg, bit_mask, 0);
+	if (ret)
+		dev_err(chip->dev, "failed to set clock_gate and enable bit\n");
 	spin_unlock(&sun4i_pwm->ctrl_lock);

 	clk_disable_unprepare(sun4i_pwm->clk);
 }

+static const struct sunxi_pwmch_reg_info sun4i_field_info[2] = {
+	{
+		.fields = SUN4I_REGMAP_FIELDS(0),
+		.control_reg =    PWM_CTRL_REG,
+		.period_reg  =    PWM_CH_PRD(0),
+		.enable_bitmask = BIT(PWM_EN_BIT) | BIT(PWM_CLK_GATING_BIT),
+	},
+	{
+		.fields = SUN4I_REGMAP_FIELDS(1),
+		.control_reg =    PWM_CTRL_REG,
+		.period_reg  =    PWM_CH_PRD(1),
+		.enable_bitmask = BIT(PWM_EN_BIT + PWMCH_OFFSET) |
+				  BIT(PWM_CLK_GATING_BIT + PWMCH_OFFSET),
+	},
+};
+
 static const struct pwm_ops sun4i_pwm_ops = {
 	.config = sun4i_pwm_config,
 	.set_polarity = sun4i_pwm_set_polarity,
@@ -264,30 +328,35 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
 	.npwm = 2,
+	.chan_info = sun4i_field_info,
 };

 static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.chan_info = sun4i_field_info,
 };

 static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.chan_info = sun4i_field_info,
 };

 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.chan_info = sun4i_field_info,
 };

 static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.chan_info = sun4i_field_info,
 };

 static const struct of_device_id sun4i_pwm_dt_ids[] = {
@@ -312,10 +381,37 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);

+static const struct regmap_config sunxi_mmio_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int sunxi_alloc_chan_fields(struct device *dev,
+				   struct sun4i_pwm_chip *pwm, int chan)
+{
+	struct regmap_field **fields = pwm->fields[chan];
+	const struct reg_field *info = pwm->data->chan_info[chan].fields;
+	int i;
+
+	for (i = 0; i < NUM_FIELDS; i++) {
+		fields[i] = devm_regmap_field_alloc(dev, pwm->regmap, info[i]);
+		if (IS_ERR(fields[i])) {
+			int err = PTR_ERR(fields[i]);
+
+			fields[i] = NULL;
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
 	struct resource *res;
+	void __iomem *base;
 	u32 val;
 	int i, ret;
 	const struct of_device_id *match;
@@ -327,9 +423,16 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		return -ENOMEM;

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pwm->base))
-		return PTR_ERR(pwm->base);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pwm->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					    &sunxi_mmio_regmap_config);
+	if (IS_ERR(pwm->regmap)) {
+		dev_err(&pdev->dev, "failed to initialise regmap\n");
+		return PTR_ERR(pwm->regmap);
+	}

 	pwm->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pwm->clk))
@@ -346,6 +449,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)

 	spin_lock_init(&pwm->ctrl_lock);

+	for (i = 0; i < pwm->chip.npwm; i++) {
+		ret = sunxi_alloc_chan_fields(&pdev->dev, pwm, i);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to alloc regmap fields\n");
+			return ret;
+		}
+	}
+
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
@@ -360,11 +471,17 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto clk_error;
 	}

-	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
-	for (i = 0; i < pwm->chip.npwm; i++)
-		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
+	for (i = 0; i < pwm->chip.npwm; i++) {
+		ret = regmap_field_read(pwm->fields[i][FIELD_POLARITY], &val);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get polarity bit\n");
+			goto clk_error;
+		}
+		if (!val)
 			pwm_set_polarity(&pwm->chip.pwms[i],
 					 PWM_POLARITY_INVERSED);
+	}
+
 	clk_disable_unprepare(pwm->clk);

 	return 0;
--
2.4.11
