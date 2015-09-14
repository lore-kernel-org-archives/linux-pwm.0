From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 2/2] pwm: Add Broadcom BCM7038 PWM controller support
Date: Mon, 14 Sep 2015 16:47:06 -0700
Message-ID: <1442274426-3507-3-git-send-email-f.fainelli@gmail.com>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442274426-3507-1-git-send-email-f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ariel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Add support for the BCM7038-style PWM controller found in all BCM7xxx STB SoCs.
This controller has a hardcoded 2 channels per controller, and cascades a
variable frequency generator on top of a fixed frequency generator which offers
a range of a 148ns period all the way to ~622ms periods.

Signed-off-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes in v4:

- address Ariel's feedback:
- add locking around HW manipulation registers
- rename I/O accessors to be less generic
- remove excessive parenthesis
- add proper error path cleanup code
- re-arrange remove function to call pwmchip_remove() first
- make the CWORD register offsets take a "ch" argument for consistency
- consistently use 'p' when referring to brcmstb_pwm_dev in code
- remove unecessary break lines

Changes in v3:

- make clock mandatory
- removed a remaining div64_u64 use

hanges in v2:

- properly format comments
- utilize do_div instead of div64_u64
- avoid using a "done" variable for the while loop
- utilize a parameterized register accessor
- remove a bunch of unnecessary assignments
- provide a module author
- update depends to build on BMIPS_GENERIC (the other user)
- removed artificial padding
- removed used only once variable: dn
- utilize devm_ioremap_resource
- do not print success message
- removed THIS_MODULE from platform_driver structure


 drivers/pwm/Kconfig       |  10 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-brcmstb.c | 345 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)
 create mode 100644 drivers/pwm/pwm-brcmstb.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ac8b0e968b6b..04d4817dda18 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -111,6 +111,16 @@ config PWM_CLPS711X
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-clps711x.
 
+config PWM_BRCMSTB
+	tristate "Broadcom STB PWM support"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	help
+	  Generic PWM framework driver for the Broadcom Set-top-Box
+	  SoCs (BCM7xxx).
+
+	  To compile this driver as a module, choose M Here: the module
+	  will be called pwm-brcmstb.c.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index cd9abef2d5b1..f03c0ed18d7a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
+obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
new file mode 100644
index 000000000000..86ab6a5025a0
--- /dev/null
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -0,0 +1,345 @@
+/*
+ * Broadcom BCM7038 PWM driver
+ * Author: Florian Fainelli
+ *
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/spinlock.h>
+
+#define PWM_CTRL		0x00
+#define  CTRL_START		BIT(0)
+#define  CTRL_OEB		BIT(1)
+#define  CTRL_FORCE_HIGH	BIT(2)
+#define  CTRL_OPENDRAIN		BIT(3)
+#define  CTRL_CHAN_OFFS		4
+
+#define PWM_CTRL2		0x04
+#define  CTRL2_OUT_SELECT	BIT(0)
+
+#define PWM_CH_SIZE		0x8
+
+#define PWM_CWORD_MSB(ch)	(0x08 + ((ch) * PWM_CH_SIZE))
+#define PWM_CWORD_LSB(ch)	(0x0C + ((ch) * PWM_CH_SIZE))
+
+/* Number of bits for the CWORD value */
+#define CWORD_BIT_SIZE		16
+
+/*
+ * Maximum control word value allowed when variable-frequency PWM is used as a
+ * clock for the constant-frequency PMW.
+ */
+#define CONST_VAR_F_MAX		32768
+#define CONST_VAR_F_MIN		1
+
+#define PWM_ON(ch)		(0x18 + ((ch) * PWM_CH_SIZE))
+#define  PWM_ON_MIN		1
+#define PWM_PERIOD(ch)		(0x1C + ((ch) * PWM_CH_SIZE))
+#define  PWM_PERIOD_MIN		0
+
+#define PWM_ON_PERIOD_MAX	0xff
+
+struct brcmstb_pwm_dev {
+	void __iomem *base;
+	spinlock_t lock;
+	struct clk *clk;
+	struct pwm_chip chip;
+};
+
+static inline u32 brcmstb_pwm_readl(struct brcmstb_pwm_dev *p, u32 off)
+{
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		return __raw_readl(p->base + off);
+	else
+		return readl_relaxed(p->base + off);
+}
+
+static inline void brcmstb_pwm_writel(struct brcmstb_pwm_dev *p,
+				      u32 val, u32 off)
+{
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		__raw_writel(val, p->base + off);
+	else
+		writel_relaxed(val, p->base + off);
+}
+
+static inline struct brcmstb_pwm_dev *to_brcmstb_pwm(struct pwm_chip *ch)
+{
+	return container_of(ch, struct brcmstb_pwm_dev, chip);
+}
+
+/*
+ * Fv is derived from the variable frequency output. The variable frequency
+ * output is configured using this formula:
+ *
+ * W = cword, if cword < 2 ^ 15 else 16-bit 2's complement of cword
+ *
+ * Fv = W x 2 ^ -16 x 27Mhz (reference clock)
+ *
+ * The period is: (period + 1) / Fv and "on" time is on / (period + 1)
+ *
+ * The PWM core framework specifies that the "duty_ns" parameter is in fact the
+ * "on" time, so this translates directly into our HW programming here.
+ */
+static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			      int duty_ns, int period_ns)
+{
+	struct brcmstb_pwm_dev *p = to_brcmstb_pwm(chip);
+	unsigned long pc, dc, cword = CONST_VAR_F_MAX;
+	unsigned int ch = pwm->hwpwm;
+	u64 val, rate;
+	u32 reg;
+
+	/*
+	 * If asking for a duty_ns equal to period_ns, we need to substract
+	 * the period value by 1 to make it shorter than the "on" time and
+	 * produce a flat 100% duty cycle signal, and max out the "on" time
+	 */
+	if (duty_ns == period_ns) {
+		dc = PWM_ON_PERIOD_MAX;
+		pc = PWM_ON_PERIOD_MAX - 1;
+		goto done;
+	}
+
+	while (1) {
+		/*
+		 * Calculate the base rate from base frequency and current
+		 * cword
+		 */
+		rate = (u64)clk_get_rate(p->clk) * (u64)cword;
+		do_div(rate, 1 << CWORD_BIT_SIZE);
+
+		val = period_ns * rate;
+		do_div(val, NSEC_PER_SEC);
+		pc = val;
+
+		val = (duty_ns + 1) * rate;
+		do_div(val, NSEC_PER_SEC);
+		dc = val;
+
+		/*
+		 * We can be called with separate duty and period updates,
+		 * so do not reject dc == 0 right away
+		 */
+		if (pc == PWM_PERIOD_MIN || (dc < PWM_ON_MIN && duty_ns))
+			return -EINVAL;
+
+		/* We converged on a calculation */
+		if (pc <= PWM_ON_PERIOD_MAX && dc <= PWM_ON_PERIOD_MAX)
+			break;
+
+		/*
+		 * The cword needs to be a power of 2 for the variable
+		 * frequency generator to output a 50% duty cycle variable
+		 * frequency which is used as input clock to the fixed
+		 * frequency generator.
+		 */
+		cword >>= 1;
+
+		/*
+		 * Desired periods are too large, we do not have a divider
+		 * for them
+		 */
+		if (cword < CONST_VAR_F_MIN)
+			return -EINVAL;
+	}
+
+done:
+	/*
+	 * Configure the defined "cword" value to have the variable frequency
+	 * generator output a base frequency for the constant frequency
+	 * generator to derive from.
+	 */
+	spin_lock(&p->lock);
+	brcmstb_pwm_writel(p, cword >> 8, PWM_CWORD_MSB(ch));
+	brcmstb_pwm_writel(p, cword & 0xff, PWM_CWORD_LSB(ch));
+
+	/* Select constant frequency signal output */
+	reg = brcmstb_pwm_readl(p, PWM_CTRL2);
+	reg |= CTRL2_OUT_SELECT << (ch * CTRL_CHAN_OFFS);
+	brcmstb_pwm_writel(p, reg, PWM_CTRL2);
+
+	/* Configure on and period value */
+	brcmstb_pwm_writel(p, pc, PWM_PERIOD(ch));
+	brcmstb_pwm_writel(p, dc, PWM_ON(ch));
+	spin_unlock(&p->lock);
+
+	return 0;
+}
+
+static inline void brcmstb_pwm_enable_set(struct brcmstb_pwm_dev *p,
+					  unsigned int ch, bool enable)
+{
+	unsigned int ofs = ch * CTRL_CHAN_OFFS;
+	u32 reg;
+
+	spin_lock(&p->lock);
+	reg = brcmstb_pwm_readl(p, PWM_CTRL);
+	if (enable) {
+		reg &= ~(CTRL_OEB << ofs);
+		reg |= (CTRL_START | CTRL_OPENDRAIN) << ofs;
+	} else {
+		reg &= ~((CTRL_START | CTRL_OPENDRAIN) << ofs);
+		reg |= CTRL_OEB << ofs;
+	}
+	brcmstb_pwm_writel(p, reg, PWM_CTRL);
+	spin_unlock(&p->lock);
+}
+
+static int brcmstb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct brcmstb_pwm_dev *p = to_brcmstb_pwm(chip);
+
+	brcmstb_pwm_enable_set(p, pwm->hwpwm, true);
+
+	return 0;
+}
+
+static void brcmstb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct brcmstb_pwm_dev *p = to_brcmstb_pwm(chip);
+
+	brcmstb_pwm_enable_set(p, pwm->hwpwm, false);
+}
+
+static const struct pwm_ops brcmstb_pwm_ops = {
+	.config	= brcmstb_pwm_config,
+	.enable	= brcmstb_pwm_enable,
+	.disable = brcmstb_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id brcmstb_pwm_of_match[] = {
+	{ .compatible = "brcm,bcm7038-pwm", },
+	{ /* sentinel */ }
+};
+
+static int brcmstb_pwm_probe(struct platform_device *pdev)
+{
+	struct brcmstb_pwm_dev *p;
+	struct resource *r;
+	int ret;
+
+	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	spin_lock_init(&p->lock);
+
+	/*
+	 * Try to grab the clock and its rate, if not available, default
+	 * to the base 27Mhz clock domain this block comes from.
+	 */
+	p->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(p->clk)) {
+		dev_err(&pdev->dev, "fail to obtain clock\n");
+		return PTR_ERR(p->clk);
+	}
+
+	clk_prepare_enable(p->clk);
+
+	platform_set_drvdata(pdev, p);
+
+	p->chip.dev = &pdev->dev;
+	p->chip.ops = &brcmstb_pwm_ops;
+	/* Dynamically assign a PWM base */
+	p->chip.base = -1;
+	/* Static number of PWM channels for this controller */
+	p->chip.npwm = 2;
+	p->chip.can_sleep = true;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	p->base = devm_ioremap_resource(&pdev->dev, r);
+	if (!p->base) {
+		ret = -ENOMEM;
+		goto out_clk;
+	}
+
+	ret = pwmchip_add(&p->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
+		goto out_clk;
+	}
+
+	return ret;
+
+out_clk:
+	clk_disable_unprepare(p->clk);
+	return ret;
+}
+
+static int brcmstb_pwm_remove(struct platform_device *pdev)
+{
+	struct brcmstb_pwm_dev *p = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&p->chip);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(p->clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int brcmstb_pwm_suspend(struct device *d)
+{
+	struct platform_device *pdev = to_platform_device(d);
+	struct brcmstb_pwm_dev *p = platform_get_drvdata(pdev);
+
+	clk_disable(p->clk);
+
+	return 0;
+}
+
+static int brcmstb_pwm_resume(struct device *d)
+{
+	struct platform_device *pdev = to_platform_device(d);
+	struct brcmstb_pwm_dev *p = platform_get_drvdata(pdev);
+
+	clk_enable(p->clk);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops,
+			 brcmstb_pwm_suspend, brcmstb_pwm_resume);
+
+static struct platform_driver brcmstb_pwm_driver = {
+	.probe	= brcmstb_pwm_probe,
+	.remove	= brcmstb_pwm_remove,
+	.driver	= {
+		.name = "pwm-brcmstb",
+		.of_match_table = brcmstb_pwm_of_match,
+		.pm = &brcmstb_pwm_pm_ops,
+	},
+};
+module_platform_driver(brcmstb_pwm_driver);
+
+MODULE_AUTHOR("Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("Broadcom STB PWM driver");
+MODULE_ALIAS("platform:pwm-brcmstb");
+MODULE_LICENSE("GPL");
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
