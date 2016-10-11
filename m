From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH 2/5] pwm: Add Allwinner A31 SoC support
Date: Tue, 11 Oct 2016 14:34:46 +0800
Message-ID: <20161011063449.54775-2-icenowy@aosc.xyz>
References: <20161011063449.54775-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBQMQ6K7QKGQEQLL4GGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161011063449.54775-1-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This adds a generic PWM framework driver for the PWM controller found
on Allwinner A31 and A31s SoCs.

The PWM controller is different with other Allwinner SoCs, with a
control register per channel (in other SoCs the control register is
shared), and each channel are allocated 16 bytes of address (but only 8
bytes are used.)

In order to use the driver for all channels, device nodes should be
created per channel.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
 drivers/pwm/Kconfig     |  10 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-sun6i.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/pwm/pwm-sun6i.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 80a566a..e7a0a02 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -396,6 +396,16 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN6I
+	tristate "Allwinner A31 PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM && COMMON_CLK
+	help
+	  PWM framework driver for Allwinner A31 SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun6i.
+
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index feef1dd..00b9017 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN6I)		+= pwm-sun6i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
diff --git a/drivers/pwm/pwm-sun6i.c b/drivers/pwm/pwm-sun6i.c
new file mode 100644
index 0000000..9d86944
--- /dev/null
+++ b/drivers/pwm/pwm-sun6i.c
@@ -0,0 +1,323 @@
+/*
+ * Driver for Allwinner sun6i Pulse Width Modulation Controller
+ *
+ * Copyright (C) 2016 Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
+ *
+ * Derived from:
+ *   pwm-sun4i.c
+ *   Copyright (C) 2014 Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
+ *
+ * Licensed under GPLv2.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/time.h>
+
+#define PWM_CTRL_REG		0x0
+
+#define PWM_CH_PRD		0x4
+
+#define PWMCH_OFFSET		15
+#define PWM_PRESCAL_MASK	GENMASK(3, 0)
+#define PWM_PRESCAL_OFF		0
+#define PWM_EN			BIT(4)
+#define PWM_ACT_STATE		BIT(5)
+#define PWM_CLK_GATING		BIT(6)
+#define PWM_MODE		BIT(7)
+#define PWM_PULSE		BIT(8)
+
+#define PWM_RDY		BIT(28)
+
+#define PWM_PRD(prd)		(((prd) - 1) << 16)
+#define PWM_PRD_MASK		GENMASK(15, 0)
+
+#define PWM_DTY_MASK		GENMASK(15, 0)
+
+static const u32 prescaler_table[] = {
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
+struct sun6i_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	spinlock_t ctrl_lock;
+};
+
+static inline struct sun6i_pwm_chip *to_sun6i_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sun6i_pwm_chip, chip);
+}
+
+static inline u32 sun6i_pwm_readl(struct sun6i_pwm_chip *chip,
+				  unsigned long offset)
+{
+	return readl(chip->base + offset);
+}
+
+static inline void sun6i_pwm_writel(struct sun6i_pwm_chip *chip,
+				    u32 val, unsigned long offset)
+{
+	writel(val, chip->base + offset);
+}
+
+static int sun6i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    int duty_ns, int period_ns)
+{
+	struct sun6i_pwm_chip *sun6i_pwm = to_sun6i_pwm_chip(chip);
+	u32 prd, dty, val, clk_gate;
+	u64 clk_rate, div = 0;
+	unsigned int prescaler = 0;
+	int err;
+
+	clk_rate = clk_get_rate(sun6i_pwm->clk);
+
+	/* Go up from the first divider */
+	for (prescaler = 0; prescaler < PWM_PRESCAL_MASK; prescaler++) {
+		if (!prescaler_table[prescaler])
+			continue;
+		div = clk_rate;
+		do_div(div, prescaler_table[prescaler]);
+		div = div * period_ns;
+		do_div(div, NSEC_PER_SEC);
+		if (div - 1 <= PWM_PRD_MASK)
+			break;
+	}
+
+	if (div - 1 > PWM_PRD_MASK) {
+		dev_err(chip->dev, "period exceeds the maximum value\n");
+		return -EINVAL;
+	}
+
+	prd = div;
+	div *= duty_ns;
+	do_div(div, period_ns);
+	dty = div;
+
+	err = clk_prepare_enable(sun6i_pwm->clk);
+	if (err) {
+		dev_err(chip->dev, "failed to enable PWM clock\n");
+		return err;
+	}
+
+	spin_lock(&sun6i_pwm->ctrl_lock);
+	val = sun6i_pwm_readl(sun6i_pwm, PWM_CTRL_REG);
+
+	if (val & PWM_RDY) {
+		spin_unlock(&sun6i_pwm->ctrl_lock);
+		clk_disable_unprepare(sun6i_pwm->clk);
+		return -EBUSY;
+	}
+
+	clk_gate = val & PWM_CLK_GATING;
+	if (clk_gate) {
+		val &= ~PWM_CLK_GATING;
+		sun6i_pwm_writel(sun6i_pwm, val, PWM_CTRL_REG);
+	}
+
+	val = sun6i_pwm_readl(sun6i_pwm, PWM_CTRL_REG);
+	val &= ~PWM_PRESCAL_MASK;
+	val |= prescaler;
+	sun6i_pwm_writel(sun6i_pwm, val, PWM_CTRL_REG);
+
+	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
+	sun6i_pwm_writel(sun6i_pwm, val, PWM_CH_PRD);
+
+	if (clk_gate) {
+		val = sun6i_pwm_readl(sun6i_pwm, PWM_CTRL_REG);
+		val |= clk_gate;
+		sun6i_pwm_writel(sun6i_pwm, val, PWM_CTRL_REG);
+	}
+
+	spin_unlock(&sun6i_pwm->ctrl_lock);
+	clk_disable_unprepare(sun6i_pwm->clk);
+
+	return 0;
+}
+
+static int sun6i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				  enum pwm_polarity polarity)
+{
+	struct sun6i_pwm_chip *sun6i_pwm = to_sun6i_pwm_chip(chip);
+	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(sun6i_pwm->clk);
+	if (ret) {
+		dev_err(chip->dev, "failed to enable PWM clock\n");
+		return ret;
+	}
+
+	spin_lock(&sun6i_pwm->ctrl_lock);
+	val = sun6i_pwm_readl(sun6i_pwm, PWM_CTRL_REG);
+
+	if (polarity != PWM_POLARITY_NORMAL)
+		val &= ~PWM_ACT_STATE;
+	else
+		val |= PWM_ACT_STATE;
+
+	sun6i_pwm_writel(sun6i_pwm, val, PWM_CTRL_REG);
+
+	spin_unlock(&sun6i_pwm->ctrl_lock);
+	clk_disable_unprepare(sun6i_pwm->clk);
+
+	return 0;
+}
+
+static int sun6i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sun6i_pwm_chip *sun6i_pwm = to_sun6i_pwm_chip(chip);
+	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(sun6i_pwm->clk);
+	if (ret) {
+		dev_err(chip->dev, "failed to enable PWM clock\n");
+		return ret;
+	}
+
+	spin_lock(&sun6i_pwm->ctrl_lock);
+	val = sun6i_pwm_readl(sun6i_pwm, PWM_CTRL_REG);
+	val |= PWM_EN;
+	val |= PWM_CLK_GATING;
+	sun6i_pwm_writel(sun6i_pwm, val, PWM_CTRL_REG);
+	spin_unlock(&sun6i_pwm->ctrl_lock);
+
+	return 0;
+}
+
+static void sun6i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sun6i_pwm_chip *sun6i_pwm = to_sun6i_pwm_chip(chip);
+	u32 val;
+
+	spin_lock(&sun6i_pwm->ctrl_lock);
+	val = sun6i_pwm_readl(sun6i_pwm, PWM_CTRL_REG);
+	val &= ~PWM_EN;
+	val &= ~PWM_CLK_GATING;
+	sun6i_pwm_writel(sun6i_pwm, val, PWM_CTRL_REG);
+	spin_unlock(&sun6i_pwm->ctrl_lock);
+
+	clk_disable_unprepare(sun6i_pwm->clk);
+}
+
+static const struct pwm_ops sun6i_pwm_ops = {
+	.config = sun6i_pwm_config,
+	.set_polarity = sun6i_pwm_set_polarity,
+	.enable = sun6i_pwm_enable,
+	.disable = sun6i_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id sun6i_pwm_dt_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-pwm", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, sun6i_pwm_dt_ids);
+
+static int sun6i_pwm_probe(struct platform_device *pdev)
+{
+	struct sun6i_pwm_chip *pwm;
+	struct resource *res;
+	u32 val;
+	int ret;
+	const struct of_device_id *match;
+
+	match = of_match_device(sun6i_pwm_dt_ids, &pdev->dev);
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pwm->base))
+		return PTR_ERR(pwm->base);
+
+	pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return PTR_ERR(pwm->clk);
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &sun6i_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = 1;
+	pwm->chip.can_sleep = true;
+	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	pwm->chip.of_pwm_n_cells = 3;
+
+	spin_lock_init(&pwm->ctrl_lock);
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable PWM clock\n");
+		goto clk_error;
+	}
+
+	val = sun6i_pwm_readl(pwm, PWM_CTRL_REG);
+	if (!(val & PWM_ACT_STATE))
+		pwm_set_polarity(&pwm->chip.pwms[0],
+				 PWM_POLARITY_INVERSED);
+	clk_disable_unprepare(pwm->clk);
+
+	return 0;
+
+clk_error:
+	pwmchip_remove(&pwm->chip);
+	return ret;
+}
+
+static int sun6i_pwm_remove(struct platform_device *pdev)
+{
+	struct sun6i_pwm_chip *pwm = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&pwm->chip);
+}
+
+static struct platform_driver sun6i_pwm_driver = {
+	.driver = {
+		.name = "sun6i-pwm",
+		.of_match_table = sun6i_pwm_dt_ids,
+	},
+	.probe = sun6i_pwm_probe,
+	.remove = sun6i_pwm_remove,
+};
+module_platform_driver(sun6i_pwm_driver);
+
+MODULE_ALIAS("platform:sun6i-pwm");
+MODULE_AUTHOR("Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>");
+MODULE_DESCRIPTION("Allwinner sun6i PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.10.1
