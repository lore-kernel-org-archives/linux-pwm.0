From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/4] pwm: add ChromeOS EC PWM driver
Date: Fri, 27 May 2016 18:39:16 -0700
Message-ID: <1464399556-17222-5-git-send-email-briannorris@chromium.org>
References: <1464399556-17222-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464399556-17222-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Use the new ChromeOS EC EC_CMD_PWM_{GET,SET}_DUTY commands to control
one or more PWMs attached to the Embedded Controller. Because the EC
allows us to modify the duty cycle (as a percentage, where U16_MAX is
100%) but not the period, we assign the period a fixed value of
EC_PWM_MAX_DUTY and reject all attempts to change it.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/pwm/Kconfig       |   7 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-cros-ec.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 drivers/pwm/pwm-cros-ec.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c182efc62c7b..4f2b16a50f42 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -137,6 +137,13 @@ config PWM_CRC
 	  Generic PWM framework driver for Crystalcove (CRC) PMIC based PWM
 	  control.
 
+config PWM_CROS_EC
+	tristate "ChromeOS EC PWM driver"
+	depends on MFD_CROS_EC
+	help
+	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
+	  Controller.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index dd35bc121a18..ffde923cf3df 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
+obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
new file mode 100644
index 000000000000..cf65e44fe355
--- /dev/null
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -0,0 +1,230 @@
+/*
+ * Copyright (C) 2016 Google, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2, as published by
+ * the Free Software Foundation.
+ *
+ * Expose a PWM controlled by the ChromeOS EC to the host processor.
+ */
+
+#include <linux/module.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+/**
+ * struct cros_ec_pwm_device - Driver data for EC PWM
+ *
+ * @dev: Device node
+ * @ec: Pointer to EC device
+ * @chip: PWM controller chip
+ */
+struct cros_ec_pwm_device {
+	struct device *dev;
+	struct cros_ec_device *ec;
+	struct pwm_chip chip;
+};
+
+static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
+{
+	return container_of(c, struct cros_ec_pwm_device, chip);
+}
+
+static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm,
+				   struct pwm_device *pwm,
+				   uint16_t duty)
+{
+	struct cros_ec_device *ec = ec_pwm->ec;
+	struct ec_params_pwm_set_duty *params;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + sizeof(*params), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	params = (void *)&msg->data[0];
+
+	msg->version = 0;
+	msg->command = EC_CMD_PWM_SET_DUTY;
+	msg->insize = 0;
+	msg->outsize = sizeof(*params);
+
+	params->duty = duty;
+	params->pwm_type = EC_PWM_TYPE_GENERIC;
+	params->index = pwm->hwpwm;
+
+	ret = cros_ec_cmd_xfer_status(ec, msg);
+	kfree(msg);
+	return ret;
+}
+
+static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm,
+				struct pwm_device *pwm)
+{
+	struct cros_ec_device *ec = ec_pwm->ec;
+	struct ec_params_pwm_get_duty *params;
+	struct ec_response_pwm_get_duty *resp;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
+			GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	params = (void *)&msg->data[0];
+	resp = (void *)&msg->data[0];
+
+	msg->version = 0;
+	msg->command = EC_CMD_PWM_GET_DUTY;
+	msg->insize = sizeof(*params);
+	msg->outsize = sizeof(*resp);
+
+	params->pwm_type = EC_PWM_TYPE_GENERIC;
+	params->index = pwm->hwpwm;
+
+	ret = cros_ec_cmd_xfer_status(ec, msg);
+	if (ret < 0)
+		goto out;
+
+	ret = resp->duty;
+
+out:
+	kfree(msg);
+	return ret;
+}
+
+static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
+
+	/* The EC won't let us change the period */
+	if (state->period != EC_PWM_MAX_DUTY)
+		return -EINVAL;
+
+	return cros_ec_pwm_set_duty(ec_pwm, pwm, state->duty_cycle);
+}
+
+static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
+	int ret;
+
+	ret = cros_ec_pwm_get_duty(ec_pwm, pwm);
+	if (ret < 0) {
+		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
+		return;
+	}
+
+	state->enabled = (ret > 0);
+	state->period = EC_PWM_MAX_DUTY;
+	state->duty_cycle = ret;
+}
+
+static struct pwm_device *
+cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	if (args->args[0] >= pc->npwm)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	/* The EC won't let us change the period */
+	pwm->args.period = EC_PWM_MAX_DUTY;
+
+	return pwm;
+}
+
+static const struct pwm_ops cros_ec_pwm_ops = {
+	.get_state	= cros_ec_pwm_get_state,
+	.apply		= cros_ec_pwm_apply,
+	.owner		= THIS_MODULE,
+};
+
+static int cros_ec_pwm_probe(struct platform_device *pdev)
+{
+	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct cros_ec_pwm_device *ec_pwm;
+	struct pwm_chip *chip;
+	u32 val;
+	int ret;
+
+	if (!ec) {
+		dev_err(dev, "no parent EC device\n");
+		return -EINVAL;
+	}
+
+	ec_pwm = devm_kzalloc(dev, sizeof(*ec_pwm), GFP_KERNEL);
+	if (!ec_pwm)
+		return -ENOMEM;
+	chip = &ec_pwm->chip;
+	ec_pwm->ec = ec;
+
+	/* PWM chip */
+	chip->dev = dev;
+	chip->ops = &cros_ec_pwm_ops;
+	chip->of_xlate = cros_ec_pwm_xlate;
+	chip->of_pwm_n_cells = 1;
+	chip->base = -1;
+	ret = of_property_read_u32(np, "google,max-pwms", &val);
+	if (ret) {
+		dev_err(dev, "Couldn't read max-pwms property: %d\n", ret);
+		return ret;
+	}
+	/* The index field is only 8 bits */
+	if (val > U8_MAX) {
+		dev_err(dev, "Can't support %u PWMs\n", val);
+		return -EINVAL;
+	}
+	chip->npwm = val;
+
+	ret = pwmchip_add(chip);
+	if (ret < 0) {
+		dev_err(dev, "cannot register PWM: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, ec_pwm);
+
+	return ret;
+}
+
+static int cros_ec_pwm_remove(struct platform_device *dev)
+{
+	struct cros_ec_pwm_device *ec_pwm = platform_get_drvdata(dev);
+	struct pwm_chip *chip = &ec_pwm->chip;
+
+	return pwmchip_remove(chip);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_pwm_of_match[] = {
+	{ .compatible = "google,cros-ec-pwm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
+#endif
+
+static struct platform_driver cros_ec_pwm_driver = {
+	.probe = cros_ec_pwm_probe,
+	.remove = cros_ec_pwm_remove,
+	.driver = {
+		.name = "cros-ec-pwm",
+		.of_match_table = of_match_ptr(cros_ec_pwm_of_match),
+	},
+};
+module_platform_driver(cros_ec_pwm_driver);
+
+MODULE_ALIAS("platform:cros-ec-pwm");
+MODULE_DESCRIPTION("ChromeOS EC PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.8.0.rc3.226.g39d4020
