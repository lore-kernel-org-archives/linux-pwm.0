From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 5/7] pwm: add pwm-atmel-lcdc driver
Date: Sun, 12 Aug 2018 20:46:27 +0200
Message-ID: <20180812184629.3808-5-sam@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180812184152.GA22343@ravnborg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The LCDC IP used by some Atmel SOC's have a
multifunction device that include two sub-devices:
- pwm
- display controller

This driver add support for the pwm sub-device
exposing a single PWM device that can be used
for backlight.

The driver is based on the pwm-atmel-hlcdc driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/Kconfig          |  13 ++++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-atmel-lcdc.c | 178 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/pwm/pwm-atmel-lcdc.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a4d262db9945..3976c1840778 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -62,6 +62,19 @@ config PWM_ATMEL_HLCDC_PWM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-hlcdc.
 
+config PWM_ATMEL_LCDC_PWM
+	tristate "Atmel LCDC PWM support"
+	depends on MFD_ATMEL_LCDC
+	depends on HAVE_CLK
+	help
+	  Generic PWM framework driver for the PWM output of the LCDC
+	  (Atmel LCD Controller). This PWM output is mainly used
+	  to control the LCD backlight.
+	  The Atmel LCD Controller is found in the at91sam9x family.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-atmel-lcdc.
+
 config PWM_ATMEL_TCB
 	tristate "Atmel TC Block PWM support"
 	depends on ATMEL_TCLIB && OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9c676a0dadf5..85d884cb0977 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
+obj-$(CONFIG_PWM_ATMEL_LCDC_PWM)	+= pwm-atmel-lcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
diff --git a/drivers/pwm/pwm-atmel-lcdc.c b/drivers/pwm/pwm-atmel-lcdc.c
new file mode 100644
index 000000000000..3d528e75cf9f
--- /dev/null
+++ b/drivers/pwm/pwm-atmel-lcdc.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Sam Ravnborg
+ *
+ * Author: Sam Ravnborg <sam@ravnborg.org>
+ *
+ * PWM embedded in the LCD Controller.
+ * A sub-device of the Atmel LCDC driver.
+ *
+ * Based on pwm-atmel-hlcdc which is:
+ * Copyright (C) 2014 Free Electrons
+ * Copyright (C) 2014 Atmel
+ * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/clk.h>
+#include <linux/pwm.h>
+
+#include <linux/platform_device.h>
+#include <linux/mfd/atmel-lcdc.h>
+
+struct lcdc_pwm {
+	struct pwm_chip chip;
+	struct atmel_mfd_lcdc *mfd_lcdc;
+};
+
+static inline struct lcdc_pwm *to_lcdc_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct lcdc_pwm, chip);
+}
+
+static int lcdc_pwm_apply(struct pwm_chip *pwm_chip, struct pwm_device *pwm,
+			  struct pwm_state *state)
+{
+	struct lcdc_pwm *chip;
+	int contrast_ctr;
+	int contrast_val;
+	int ret;
+
+	chip = to_lcdc_pwm(pwm_chip);
+
+	if (state->enabled) {
+		contrast_val = pwm_get_relative_duty_cycle(state,
+							   ATMEL_LCDC_CVAL);
+		ret = regmap_write(chip->mfd_lcdc->regmap,
+				   ATMEL_LCDC_CONTRAST_VAL, contrast_val);
+		if (ret)
+			return ret;
+
+		contrast_ctr = ATMEL_LCDC_ENA_PWMENABLE | ATMEL_LCDC_PS_DIV8;
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			contrast_ctr |= ATMEL_LCDC_POL_POSITIVE;
+		else
+			contrast_ctr |= ATMEL_LCDC_POL_NEGATIVE;
+
+		ret = regmap_write(chip->mfd_lcdc->regmap,
+				   ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
+	} else {
+		contrast_ctr = ATMEL_LCDC_ENA_PWMDISABLE;
+		ret = regmap_write(chip->mfd_lcdc->regmap,
+				   ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
+	}
+
+	return ret;
+}
+
+static const struct pwm_ops lcdc_pwm_ops = {
+	.apply = lcdc_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int lcdc_pwm_suspend(struct device *dev)
+{
+	struct lcdc_pwm *chip = dev_get_drvdata(dev);
+
+	/* Keep the lcdc clock enabled if the PWM is still running. */
+	if (pwm_is_enabled(&chip->chip.pwms[0]))
+		clk_disable_unprepare(chip->mfd_lcdc->lcdc_clk);
+
+	return 0;
+}
+
+static int lcdc_pwm_resume(struct device *dev)
+{
+	struct lcdc_pwm *chip = dev_get_drvdata(dev);
+	struct pwm_state state;
+	int ret;
+
+	pwm_get_state(&chip->chip.pwms[0], &state);
+
+	/* Re-enable the lcdc clock if it was stopped during suspend. */
+	if (!state.enabled) {
+		ret = clk_prepare_enable(chip->mfd_lcdc->lcdc_clk);
+		if (ret)
+			return ret;
+	}
+
+	return lcdc_pwm_apply(&chip->chip, &chip->chip.pwms[0], &state);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(lcdc_pwm_pm_ops,
+			 lcdc_pwm_suspend, lcdc_pwm_resume);
+
+static int lcdc_pwm_probe(struct platform_device *pdev)
+{
+	struct atmel_mfd_lcdc *mfd_lcdc;
+	struct lcdc_pwm *chip;
+	struct device *dev;
+	int ret;
+
+	dev = &pdev->dev;
+	mfd_lcdc = dev_get_drvdata(dev->parent);
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	ret = clk_prepare_enable(mfd_lcdc->lcdc_clk);
+	if (ret)
+		return ret;
+
+	chip->mfd_lcdc = mfd_lcdc;
+	chip->chip.ops = &lcdc_pwm_ops;
+	chip->chip.dev = dev;
+	chip->chip.base = -1;
+	chip->chip.npwm = 1;
+	chip->chip.of_xlate = of_pwm_xlate_with_flags;
+	chip->chip.of_pwm_n_cells = 3;
+
+	ret = pwmchip_add_with_polarity(&chip->chip, PWM_POLARITY_INVERSED);
+	if (ret) {
+		clk_disable_unprepare(mfd_lcdc->lcdc_clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+static int lcdc_pwm_remove(struct platform_device *pdev)
+{
+	struct lcdc_pwm *chip = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&chip->chip);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(chip->mfd_lcdc->lcdc_clk);
+
+	return 0;
+}
+
+static const struct of_device_id lcdc_pwm_dt_ids[] = {
+	{ .compatible = "atmel,lcdc-pwm" },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver lcdc_pwm_driver = {
+	.driver = {
+		.name = "atmel-lcdc-pwm",
+		.of_match_table = lcdc_pwm_dt_ids,
+		.pm = &lcdc_pwm_pm_ops,
+	},
+	.probe = lcdc_pwm_probe,
+	.remove = lcdc_pwm_remove,
+};
+module_platform_driver(lcdc_pwm_driver);
+
+MODULE_ALIAS("platform:pwm-atmel-lcdc");
+MODULE_AUTHOR("Sam Ravnborg <sam@ravnborg.org>");
+MODULE_DESCRIPTION("Atmel LCDC PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.12.0
