From: lis8215@gmail.com
Subject: [PATCH v4 1/9] pwm: sunxi: Use regmap API for register access.
Date: Fri, 24 Feb 2017 08:41:08 +0300
Message-ID: <1487914876-8594-2-git-send-email-lis8215@gmail.com>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35208 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdBXFlW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Feb 2017 00:41:22 -0500
Received: by mail-lf0-f68.google.com with SMTP id z127so745238lfa.2
        for <linux-pwm@vger.kernel.org>; Thu, 23 Feb 2017 21:41:21 -0800 (PST)
In-Reply-To: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-sunxi@googlegroups.com
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, linux-pwm@vger.kernel.org, Siarhei Volkau <lis8215@gmail.com>

From: Siarhei Volkau <lis8215@gmail.com>

The patch replaces iomem register access routines to regmap
equivalents.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/pwm/Kconfig     |   2 +-
 drivers/pwm/pwm-sun4i.c | 143 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 110 insertions(+), 35 deletions(-)

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
index b0803f6..5565f03 100644
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
@@ -74,7 +74,7 @@ struct sun4i_pwm_data {
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
-	void __iomem *base;
+	struct regmap *regmap;
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
 };
@@ -84,18 +84,6 @@ static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
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
@@ -152,7 +140,11 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
+	if (err) {
+		dev_err(chip->dev, "failed to read from CTL register\n");
+		goto err_cleanup;
+	}
 
 	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
 		spin_unlock(&sun4i_pwm->ctrl_lock);
@@ -163,27 +155,53 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	if (clk_gate) {
 		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+		err = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
+		if (err) {
+			dev_err(chip->dev, "failed to write to CTL register\n");
+			goto err_cleanup;
+		}
 	}
 
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
+	if (err) {
+		dev_err(chip->dev, "failed to read from CTL register\n");
+		goto err_cleanup;
+	}
 	val &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
 	val |= BIT_CH(prescaler, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	err = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
+	if (err) {
+		dev_err(chip->dev, "failed to write to CTL register\n");
+		goto err_cleanup;
+	}
 
 	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
+	err = regmap_write(sun4i_pwm->regmap, PWM_CH_PRD(pwm->hwpwm), val);
+	if (err) {
+		dev_err(chip->dev, "failed to write to PRD register\n");
+		goto err_cleanup;
+	}
 
 	if (clk_gate) {
-		val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+		err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
+		if (err) {
+			dev_err(chip->dev,
+				"failed to read from CTL register\n");
+			goto err_cleanup;
+		}
 		val |= clk_gate;
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+		err = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
+		if (err) {
+			dev_err(chip->dev, "failed to write to CTL register\n");
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
@@ -200,19 +218,29 @@ static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	ret = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
+	if (ret) {
+		dev_err(chip->dev,
+			"failed to read from CTL register\n");
+		goto err_cleanup;
+	}
 
 	if (polarity != PWM_POLARITY_NORMAL)
 		val &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 	else
 		val |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	ret = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
+	if (ret) {
+		dev_err(chip->dev, "failed to write to CTL register\n");
+		goto err_cleanup;
+	}
 
+err_cleanup:
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 	clk_disable_unprepare(sun4i_pwm->clk);
 
-	return 0;
+	return ret;
 }
 
 static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -228,25 +256,53 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	ret = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
+	if (ret) {
+		dev_err(chip->dev,
+			"failed to read from CTL register\n");
+		goto err_cleanup;
+	}
 	val |= BIT_CH(PWM_EN, pwm->hwpwm);
 	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	ret = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
+	if (ret) {
+		dev_err(chip->dev, "failed to write to CTL register\n");
+		goto err_cleanup;
+	}
+
 	spin_unlock(&sun4i_pwm->ctrl_lock);
+	return ret;
 
-	return 0;
+err_cleanup:
+	spin_unlock(&sun4i_pwm->ctrl_lock);
+	if (ret)
+		clk_disable_unprepare(sun4i_pwm->clk);
+
+	return ret;
 }
 
 static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	u32 val;
+	int err;
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
+	if (err) {
+		dev_err(chip->dev,
+			"failed to read from CTL register\n");
+		goto err_cleanup;
+	}
 	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
 	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	err = regmap_write(sun4i_pwm->regmap, PWM_CTRL_REG, val);
+	if (err) {
+		dev_err(chip->dev, "failed to write to CTL register\n");
+		goto err_cleanup;
+	}
+
+err_cleanup:
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 
 	clk_disable_unprepare(sun4i_pwm->clk);
@@ -312,10 +368,17 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 
+static const struct regmap_config sunxi_pwm_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *pwm;
 	struct resource *res;
+	void __iomem *base;
 	u32 val;
 	int i, ret;
 	const struct of_device_id *match;
@@ -327,9 +390,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
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
+					    &sunxi_pwm_regmap_config);
+	if (IS_ERR(pwm->regmap))
+		return PTR_ERR(pwm->regmap);
 
 	pwm->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pwm->clk))
@@ -360,7 +428,11 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto clk_error;
 	}
 
-	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
+	ret = regmap_read(pwm->regmap, PWM_CTRL_REG, &val);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read from CTL register\n");
+		goto read_error;
+	}
 	for (i = 0; i < pwm->chip.npwm; i++)
 		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
 			pwm_set_polarity(&pwm->chip.pwms[i],
@@ -369,6 +441,9 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 	return 0;
 
+read_error:
+	clk_disable_unprepare(pwm->clk);
+
 clk_error:
 	pwmchip_remove(&pwm->chip);
 	return ret;
-- 
2.4.11
