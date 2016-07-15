From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 4/4] pwm: add ChromeOS EC PWM driver
Date: Fri, 15 Jul 2016 16:28:44 -0700
Message-ID: <1468625324-41229-5-git-send-email-briannorris@chromium.org>
References: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34233 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcGOXa5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Jul 2016 19:30:57 -0400
Received: by mail-pf0-f176.google.com with SMTP id p64so11693457pfb.1
        for <linux-pwm@vger.kernel.org>; Fri, 15 Jul 2016 16:30:57 -0700 (PDT)
In-Reply-To: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Brian Norris <briannorris@chromium.org>

Use the new ChromeOS EC EC_CMD_PWM_{GET,SET}_DUTY commands to control
one or more PWMs attached to the Embedded Controller. Because the EC
allows us to modify the duty cycle (as a percentage, where U16_MAX is
100%) but not the period, we assign the period a fixed value of
EC_PWM_MAX_DUTY and reject all attempts to change it.

This driver supports only device tree at the moment, because that
provides a very flexible way of describing the relationship between PWMs
and their consumer devices (e.g., backlight). On a non-DT system, we'll
probably want to use the non-GENERIC addressing (i.e., we'll need to
make special device instances that will use EC_PWM_TYPE_KB_LIGHT or
EC_PWM_TYPE_DISPLAY_LIGHT), as well as the relatively inflexible
pwm_lookup infrastructure for matching devices. Defer that work for now.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v4:
 * adapt to changed cros_ec_cmd_xfer_status() helper

v3:
 * handle 'disabled' properly in apply(), since EC conflates 0
   duty-cycle and disabled state

v2:
 * refactor some abstractions to separate the PWM layer handling from
   the cros_ec handling
 * remove dynamic kzalloc()'s and rely on on-stack memory instead
 * auto-probe the number of PWMs supported
---
 drivers/pwm/Kconfig       |   7 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-cros-ec.c | 260 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
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
index 000000000000..99b9acc1a420
--- /dev/null
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -0,0 +1,260 @@
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
+static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
+{
+	struct {
+		struct cros_ec_command msg;
+		struct ec_params_pwm_set_duty params;
+	} buf;
+	struct ec_params_pwm_set_duty *params = &buf.params;
+	struct cros_ec_command *msg = &buf.msg;
+
+	memset(&buf, 0, sizeof(buf));
+
+	msg->version = 0;
+	msg->command = EC_CMD_PWM_SET_DUTY;
+	msg->insize = 0;
+	msg->outsize = sizeof(*params);
+
+	params->duty = duty;
+	params->pwm_type = EC_PWM_TYPE_GENERIC;
+	params->index = index;
+
+	return cros_ec_cmd_xfer_status(ec, msg);
+}
+
+static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
+				  u32 *result)
+{
+	struct {
+		struct cros_ec_command msg;
+		union {
+			struct ec_params_pwm_get_duty params;
+			struct ec_response_pwm_get_duty resp;
+		};
+	} buf;
+	struct ec_params_pwm_get_duty *params = &buf.params;
+	struct ec_response_pwm_get_duty *resp = &buf.resp;
+	struct cros_ec_command *msg = &buf.msg;
+	int ret;
+
+	memset(&buf, 0, sizeof(buf));
+
+	msg->version = 0;
+	msg->command = EC_CMD_PWM_GET_DUTY;
+	msg->insize = sizeof(*params);
+	msg->outsize = sizeof(*resp);
+
+	params->pwm_type = EC_PWM_TYPE_GENERIC;
+	params->index = index;
+
+	ret = cros_ec_cmd_xfer_status(ec, msg);
+	if (result)
+		*result = msg->result;
+	if (ret < 0)
+		return ret;
+
+	return resp->duty;
+}
+
+static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
+{
+	return __cros_ec_pwm_get_duty(ec, index, NULL);
+}
+
+static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
+	int duty_cycle;
+
+	/* The EC won't let us change the period */
+	if (state->period != EC_PWM_MAX_DUTY)
+		return -EINVAL;
+
+	/*
+	 * EC doesn't separate the concept of duty cycle and enabled, but
+	 * kernel does. Translate.
+	 */
+	duty_cycle = state->enabled ? state->duty_cycle : 0;
+
+	return cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+}
+
+static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
+	int ret;
+
+	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
+	if (ret < 0) {
+		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
+		return;
+	}
+
+	state->enabled = (ret > 0);
+	state->period = EC_PWM_MAX_DUTY;
+
+	/* Note that "disabled" and "duty cycle == 0" are treated the same */
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
+static int cros_ec_num_pwms(struct cros_ec_device *ec)
+{
+	int i, ret;
+
+	/* The index field is only 8 bits */
+	for (i = 0; i <= U8_MAX; i++) {
+		u32 result = 0;
+
+		ret = __cros_ec_pwm_get_duty(ec, i, &result);
+		/* We want to parse EC protocol errors */
+		if (ret < 0 && !(ret == -EPROTO && result))
+			return ret;
+
+		/*
+		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
+		 * responses; everything else is treated as an error.
+		 */
+		if (result == EC_RES_INVALID_COMMAND)
+			return -ENODEV;
+		else if (result == EC_RES_INVALID_PARAM)
+			return i;
+		else if (result)
+			return -EPROTO;
+	}
+
+	return U8_MAX;
+}
+
+static int cros_ec_pwm_probe(struct platform_device *pdev)
+{
+	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct cros_ec_pwm_device *ec_pwm;
+	struct pwm_chip *chip;
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
+	ret = cros_ec_num_pwms(ec);
+	if (ret < 0) {
+		dev_err(dev, "Couldn't find PWMs: %d\n", ret);
+		return ret;
+	}
+	chip->npwm = ret;
+	dev_dbg(dev, "Probed %u PWMs\n", chip->npwm);
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
