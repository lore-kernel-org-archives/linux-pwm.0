From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: [PATCH 10/18] pwm: add support for sl28cpld PWM controller
Date: Tue, 17 Mar 2020 21:50:09 +0100
Message-ID: <20200317205017.28280-11-michael@walle.cc>
References: <20200317205017.28280-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317205017.28280-1-michael-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This adds support for the PWM controller of the sl28cpld board
management controller. This is part of a multi-function device driver.

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
---
 drivers/pwm/Kconfig        |  10 ++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-sl28cpld.c | 192 +++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 drivers/pwm/pwm-sl28cpld.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 30190beeb6e9..516d70873b4c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -413,6 +413,16 @@ config PWM_SIFIVE
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sifive.
 
+config PWM_SL28CPLD
+	tristate "Kontron sl28 PWM support"
+	depends on MFD_SL28CPLD
+	help
+	  Generic PWM framework driver for board management controller
+	  found on the Kontron sl28 CPLD.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sl28cpld.
+
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9a475073dafc..2c2b569dcde9 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
+obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
new file mode 100644
index 000000000000..758f46898da6
--- /dev/null
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SMARC-sAL28 PWM driver.
+ *
+ * Copyright 2019 Kontron Europe GmbH
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bitfield.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+/*
+ * PWM timer block registers.
+ */
+#define SL28CPLD_PWM_CTRL	0
+#define   PWM_ENABLE		BIT(7)
+#define   PWM_MODE_250HZ	0
+#define   PWM_MODE_500HZ	1
+#define   PWM_MODE_1KHZ		2
+#define   PWM_MODE_2KHZ		3
+#define   PWM_MODE_MASK		GENMASK(1, 0)
+#define SL28CPLD_PWM_CYCLE	1
+#define   PWM_CYCLE_MAX		0x7f
+
+struct sl28cpld_pwm {
+	struct pwm_chip pwm_chip;
+	struct regmap *regmap;
+	u32 offset;
+};
+
+struct sl28cpld_pwm_periods {
+	u8 ctrl;
+	unsigned long duty_cycle;
+};
+
+struct sl28cpld_pwm_config {
+	unsigned long period_ns;
+	u8 max_duty_cycle;
+};
+
+static struct sl28cpld_pwm_config sl28cpld_pwm_config[] = {
+	[PWM_MODE_250HZ] = { .period_ns = 4000000, .max_duty_cycle = 0x80 },
+	[PWM_MODE_500HZ] = { .period_ns = 2000000, .max_duty_cycle = 0x40 },
+	[PWM_MODE_1KHZ] = { .period_ns = 1000000, .max_duty_cycle = 0x20 },
+	[PWM_MODE_2KHZ] = { .period_ns =  500000, .max_duty_cycle = 0x10 },
+};
+
+static inline struct sl28cpld_pwm *to_sl28cpld_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sl28cpld_pwm, pwm_chip);
+}
+
+static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	struct sl28cpld_pwm *spc = to_sl28cpld_pwm(chip);
+	static struct sl28cpld_pwm_config *config;
+	unsigned int reg;
+	unsigned long cycle;
+	unsigned int mode;
+
+	regmap_read(spc->regmap, spc->offset + SL28CPLD_PWM_CTRL, &reg);
+
+	state->enabled = reg & PWM_ENABLE;
+
+	mode = FIELD_GET(PWM_MODE_MASK, reg);
+	config = &sl28cpld_pwm_config[mode];
+	state->period = config->period_ns;
+
+	regmap_read(spc->regmap, spc->offset + SL28CPLD_PWM_CYCLE, &reg);
+	cycle = reg * config->period_ns;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(cycle,
+						  config->max_duty_cycle);
+}
+
+static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct sl28cpld_pwm *spc = to_sl28cpld_pwm(chip);
+	struct sl28cpld_pwm_config *config;
+	unsigned long long cycle;
+	int ret;
+	int mode;
+	u8 ctrl;
+
+	/* update config, first search best matching period */
+	for (mode = 0; mode < ARRAY_SIZE(sl28cpld_pwm_config); mode++) {
+		config = &sl28cpld_pwm_config[mode];
+		if (state->period == config->period_ns)
+			break;
+	}
+
+	if (mode == ARRAY_SIZE(sl28cpld_pwm_config))
+		return -EINVAL;
+
+	ctrl = FIELD_PREP(PWM_MODE_MASK, mode);
+	if (state->enabled)
+		ctrl |= PWM_ENABLE;
+
+	cycle = state->duty_cycle * config->max_duty_cycle;
+	do_div(cycle, state->period);
+
+	/*
+	 * The hardware doesn't allow to set max_duty_cycle if the
+	 * 250Hz mode is enabled. But since this is "all-high" output
+	 * just use the 500Hz mode with the duty cycle to max value.
+	 */
+	if (cycle == config->max_duty_cycle) {
+		ctrl &= ~PWM_MODE_MASK;
+		ctrl |= FIELD_PREP(PWM_MODE_MASK, PWM_MODE_500HZ);
+		cycle = PWM_CYCLE_MAX;
+	}
+
+	ret = regmap_write(spc->regmap,
+			   spc->offset + SL28CPLD_PWM_CTRL, ctrl);
+	if (ret)
+		return ret;
+
+	return regmap_write(spc->regmap,
+			    spc->offset + SL28CPLD_PWM_CYCLE, (u8)cycle);
+}
+
+static const struct pwm_ops sl28cpld_pwm_ops = {
+	.apply = sl28cpld_pwm_apply,
+	.get_state = sl28cpld_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int sl28cpld_pwm_probe(struct platform_device *pdev)
+{
+	struct sl28cpld_pwm *pwm;
+	struct pwm_chip *chip;
+	struct resource *res;
+	int ret;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+
+	pwm->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!pwm->regmap)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
+	if (!res)
+		return -EINVAL;
+	pwm->offset = res->start;
+
+	/* initialize struct gpio_chip */
+	chip = &pwm->pwm_chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &sl28cpld_pwm_ops;
+	chip->base = -1;
+	chip->npwm = 1;
+
+	ret = pwmchip_add(&pwm->pwm_chip);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+}
+
+static int sl28cpld_pwm_remove(struct platform_device *pdev)
+{
+	struct sl28cpld_pwm *pwm = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&pwm->pwm_chip);
+}
+
+static struct platform_driver sl28cpld_pwm_driver = {
+	.probe = sl28cpld_pwm_probe,
+	.remove	= sl28cpld_pwm_remove,
+	.driver = {
+		.name = "sl28cpld-pwm",
+	},
+};
+module_platform_driver(sl28cpld_pwm_driver);
+
+MODULE_DESCRIPTION("sl28cpld PWM Driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1
