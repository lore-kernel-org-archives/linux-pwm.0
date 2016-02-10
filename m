From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] pwm: add a driver for the STMPE PWM
Date: Wed, 10 Feb 2016 09:54:27 +0100
Message-ID: <1455094468-25521-3-git-send-email-linus.walleij@linaro.org>
References: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34284 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbcBJIys (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2016 03:54:48 -0500
Received: by mail-lb0-f170.google.com with SMTP id cw1so6466402lbb.1
        for <linux-pwm@vger.kernel.org>; Wed, 10 Feb 2016 00:54:47 -0800 (PST)
In-Reply-To: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

This adds a driver for the STMPE 24xx series of multi-purpose
I2C expanders. (I think STMPE means ST Microelectronics
Multi-Purpose Expander.) This PWM was designed in accordance with
Nokia specifications and is kind of weird and usually just
switched between max and zero dutycycle. However it is indeed
a PWM so it needs to live in the PWM subsystem.

This PWM is mostly used for white LED backlight.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Lee could you ACK the few lines added to drivers/mfd/stmpe.c
so that the PWM maintainers can take this through their tree?
Thanks.
---
 drivers/mfd/stmpe.c     |  37 ++++++
 drivers/pwm/Kconfig     |   7 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-stmpe.c | 297 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 342 insertions(+)
 create mode 100644 drivers/pwm/pwm-stmpe.c

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 8222e374e4b1..4eb08e0471f8 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -333,6 +333,33 @@ static const struct mfd_cell stmpe_keypad_cell = {
 	.num_resources	= ARRAY_SIZE(stmpe_keypad_resources),
 };
 
+
+/*
+ * PWM (1601, 2401, 2403)
+ */
+static struct resource stmpe_pwm_resources[] = {
+	{
+		.name	= "PWM0",
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "PWM1",
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "PWM2",
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static const struct mfd_cell stmpe_pwm_cell = {
+	.name		= "stmpe-pwm",
+	.of_compatible  = "st,stmpe-pwm",
+	.resources	= stmpe_pwm_resources,
+	.num_resources	= ARRAY_SIZE(stmpe_pwm_resources),
+};
+
+
 /*
  * STMPE801
  */
@@ -537,6 +564,11 @@ static struct stmpe_variant_block stmpe1601_blocks[] = {
 		.irq	= STMPE1601_IRQ_KEYPAD,
 		.block	= STMPE_BLOCK_KEYPAD,
 	},
+	{
+		.cell	= &stmpe_pwm_cell,
+		.irq	= STMPE1601_IRQ_PWM0,
+		.block	= STMPE_BLOCK_PWM,
+	},
 };
 
 /* supported autosleep timeout delay (in msecs) */
@@ -771,6 +803,11 @@ static struct stmpe_variant_block stmpe24xx_blocks[] = {
 		.irq	= STMPE24XX_IRQ_KEYPAD,
 		.block	= STMPE_BLOCK_KEYPAD,
 	},
+	{
+		.cell	= &stmpe_pwm_cell,
+		.irq	= STMPE24XX_IRQ_PWM0,
+		.block	= STMPE_BLOCK_PWM,
+	},
 };
 
 static int stmpe24xx_enable(struct stmpe *stmpe, unsigned int blocks,
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8cf0dae78555..89665c6d6a4d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -362,6 +362,13 @@ config PWM_STI
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sti.
 
+config PWM_STMPE
+	bool "STMPE expander PWM export"
+	depends on MFD_STMPE
+	help
+	  This enables support for the PWMs found in the STMPE I/O
+	  expanders.
+
 config PWM_SUN4I
 	tristate "Allwinner PWM support"
 	depends on ARCH_SUNXI || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index dd35bc121a18..790353b7454e 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
+obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
new file mode 100644
index 000000000000..3da117a92263
--- /dev/null
+++ b/drivers/pwm/pwm-stmpe.c
@@ -0,0 +1,297 @@
+/*
+ * Copyright (C) 2016 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pwm.h>
+#include <linux/of.h>
+#include <linux/mfd/stmpe.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+
+#define STMPE24XX_PWMCS		0x30
+#define PWMCS_EN_PWM0		BIT(0)
+#define PWMCS_EN_PWM1		BIT(1)
+#define PWMCS_EN_PWM2		BIT(2)
+#define STMPE24XX_PWMIC0	0x38
+#define STMPE24XX_PWMIC1	0x39
+#define STMPE24XX_PWMIC2	0x3a
+#define STMPE_PWM_24XX_PINBASE	21
+
+struct stmpe_pwm {
+	struct stmpe *stmpe;
+	struct pwm_chip chip;
+	u8 lastduty;
+	bool enabled;
+};
+
+static inline struct stmpe_pwm *to_stmpe_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct stmpe_pwm, chip);
+}
+
+static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct stmpe_pwm *stmpe_pwm = to_stmpe_pwm(chip);
+	int ret;
+	u8 val;
+
+	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
+	if (ret < 0) {
+		dev_err(chip->dev, "error reading PWM%d control\n",
+			pwm->hwpwm);
+		return ret;
+	}
+	val = (u8)ret;
+	val |= BIT(pwm->hwpwm);
+	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, val);
+	if (ret) {
+		dev_err(chip->dev, "error writing PWM%d control\n",
+			pwm->hwpwm);
+		return ret;
+	}
+	stmpe_pwm->enabled = true;
+
+	return 0;
+}
+
+static void stmpe_24xx_pwm_disable(struct pwm_chip *chip,
+				struct pwm_device *pwm)
+{
+	struct stmpe_pwm *stmpe_pwm = to_stmpe_pwm(chip);
+	int ret;
+	u8 val;
+
+	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
+	if (ret < 0) {
+		dev_err(chip->dev, "error reading PWM%d control\n",
+			pwm->hwpwm);
+		return;
+	}
+	val = (u8)ret;
+	val &= ~BIT(pwm->hwpwm);
+	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, val);
+	if (ret) {
+		dev_err(chip->dev, "error writing PWM%d control\n",
+			pwm->hwpwm);
+		return;
+	}
+	stmpe_pwm->enabled = false;
+}
+
+static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+				int duty_ns, int period_ns)
+{
+	struct stmpe_pwm *stmpe_pwm = to_stmpe_pwm(chip);
+	u8 reg;
+	int ret;
+	int i;
+	unsigned int pin;
+	u16 program[3] = {
+		0x007F, /* SMAX = logic low out */
+		0x0000, /* GTS */
+		0x0000, /* GTS */
+	};
+
+	/* This preserves enablement state across reconfig */
+	bool enabled = stmpe_pwm->enabled;
+
+	/* Make sure we are disabled */
+	if (enabled)
+		stmpe_24xx_pwm_disable(chip, pwm);
+
+	/* Connect the PWM to the pin */
+	pin = pwm->hwpwm;
+	/* On STMPE2401 and 2403 pins 21,22,23 are used */
+	if (stmpe_pwm->stmpe->partnum == STMPE2401 ||
+		stmpe_pwm->stmpe->partnum == STMPE2403)
+		pin += STMPE_PWM_24XX_PINBASE;
+	ret = stmpe_set_altfunc(stmpe_pwm->stmpe,
+				BIT(pin),
+				STMPE_BLOCK_PWM);
+	if (ret) {
+		dev_err(chip->dev, "unable to connect PWM%d to pin\n",
+			pwm->hwpwm);
+		return ret;
+	}
+
+	/* STMPE24XX */
+	if (pwm->hwpwm == 0)
+		reg = STMPE24XX_PWMIC0;
+	else if (pwm->hwpwm == 1)
+		reg = STMPE24XX_PWMIC1;
+	else if (pwm->hwpwm == 2)
+		reg = STMPE24XX_PWMIC1;
+	else
+		/* Should not happen as npwm is 3 */
+		return -ENODEV;
+
+	dev_dbg(chip->dev, "PWM%d: config duty %d ns, period %d ns\n",
+		pwm->hwpwm, duty_ns, period_ns);
+	if (duty_ns == 0) {
+		if (stmpe_pwm->stmpe->partnum == STMPE2401)
+			program[0] = 0x007F; /* SMAX = off all the time */
+		if (stmpe_pwm->stmpe->partnum == STMPE2403)
+			program[0] = BIT(14) | 0xFF; /* LOAD 0xFF */
+		stmpe_pwm->lastduty = 0x00;
+	} else if (duty_ns == period_ns) {
+		if (stmpe_pwm->stmpe->partnum == STMPE2401)
+			program[0] = 0x00FF; /* SMIN = on all the time */
+		if (stmpe_pwm->stmpe->partnum == STMPE2403)
+			program[0] = BIT(14); /* LOAD 0x00 */
+		stmpe_pwm->lastduty = 0xFF;
+	} else {
+		unsigned long cyc;
+		u8 val;
+
+		/*
+		 * Counter goes from 0x00 to 0xFF repeatedly at 32768 Hz,
+		 * (means a period of 30517 ns)
+		 * then this is compared to the counter from the ramp,
+		 * if this is >= pwm counter the output is high.
+		 * With LOAD we can define how much of the cycle it is on.
+		 *
+		 * Prescale = 0 -> 2 kHz -> T = 1/f = 488281,25 ns
+		 */
+		/* Scale to 0..FF */
+		cyc = duty_ns * 256;
+		cyc = DIV_ROUND_CLOSEST(cyc, period_ns);
+		val = cyc;
+
+		if (val == stmpe_pwm->lastduty) {
+			/* Do nothing */
+		} else if (stmpe_pwm->stmpe->partnum == STMPE2403) {
+			/* STMPE2403 can simply set the right PWM value */
+			program[0] = BIT(14) | val;
+			program[1] = 0x0000;
+		} else if (stmpe_pwm->stmpe->partnum == STMPE2401) {
+			/* STMPE2401 need a complex program */
+			u16 incdec = 0x0000;
+
+			if (stmpe_pwm->lastduty < val)
+				/* Count up */
+				incdec = (val - stmpe_pwm->lastduty);
+			else
+				/* Count down */
+				incdec = BIT(7) | (stmpe_pwm->lastduty - val);
+			/* Step to desired value, smoothly */
+			program[0] = BIT(14) | BIT(8) | incdec;
+			/* Loop eternally */
+			program[1] = BIT(15) | BIT(13);
+		}
+
+		dev_dbg(chip->dev, "PWM%d: val = %02x, lastduty = %02x, "
+			"program=%04x,%04x,%04x\n", pwm->hwpwm, val,
+			stmpe_pwm->lastduty, program[0], program[1],
+			program[2]);
+		stmpe_pwm->lastduty = val;
+	}
+
+	/*
+	 * We can write programs of up to 64 16-bit words into this
+	 * channel.
+	 */
+	for (i = 0; i < ARRAY_SIZE(program); i++) {
+		u8 val;
+
+		val = (program[i] >> 8) & 0xFF;
+		ret = stmpe_reg_write(stmpe_pwm->stmpe, reg, val);
+		if (ret) {
+			dev_err(chip->dev, "error writing reg\n");
+			return ret;
+		}
+		val = program[i] & 0xFF;
+		ret = stmpe_reg_write(stmpe_pwm->stmpe, reg, val);
+		if (ret) {
+			dev_err(chip->dev, "error writing reg\n");
+			return ret;
+		}
+	}
+	/* If we were enabled, re-enable this PWM */
+	if (enabled)
+		stmpe_24xx_pwm_enable(chip, pwm);
+
+	/* Sleep for 200ms so we're sure it will take effect */
+	msleep(200);
+
+	dev_dbg(chip->dev, "programmed PWM%d, %d bytes\n",
+		pwm->hwpwm, i);
+	return 0;
+}
+
+static const struct pwm_ops stmpe_24xx_pwm_ops = {
+	.config = stmpe_24xx_pwm_config,
+	.enable = stmpe_24xx_pwm_enable,
+	.disable = stmpe_24xx_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int stmpe_pwm_probe(struct platform_device *pdev)
+{
+	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
+	struct stmpe_pwm *pwm;
+	int ret;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->stmpe = stmpe;
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.base = pdev->id;
+	if (stmpe->partnum == STMPE2401 || stmpe->partnum == STMPE2403) {
+		pwm->chip.ops = &stmpe_24xx_pwm_ops;
+		pwm->chip.npwm = 3;
+	} else if (stmpe->partnum == STMPE1601) {
+		dev_err(&pdev->dev, "STMPE1601 PWM not yet supported\n");
+		return -EINVAL;
+	} else {
+		dev_err(&pdev->dev, "Unsupported STMPE PWM\n");
+		return -EINVAL;
+	}
+
+	ret = stmpe_enable(stmpe, STMPE_BLOCK_PWM);
+	if (ret)
+		return ret;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret)
+		return ret;
+
+	dev_info(&pdev->dev, "STMPE PWM registered\n");
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+}
+
+static int stmpe_pwm_remove(struct platform_device *pdev)
+{
+	struct stmpe_pwm *pwm = platform_get_drvdata(pdev);
+	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
+
+	stmpe_disable(stmpe, STMPE_BLOCK_PWM);
+	return pwmchip_remove(&pwm->chip);
+}
+
+static struct platform_driver stmpe_pwm_driver = {
+	.driver = {
+		.name = "stmpe-pwm",
+	},
+	.probe = stmpe_pwm_probe,
+	.remove = stmpe_pwm_remove,
+};
+module_platform_driver(stmpe_pwm_driver);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_DESCRIPTION("STMPE Pulse Width Modulation Driver");
+MODULE_ALIAS("platform:pwm-stmpe");
+MODULE_LICENSE("GPL v2");
-- 
2.4.3
