Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:11831
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfLIAir (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Dec 2019 19:38:47 -0500
From: Jeff LaBundy <jeff@labundy.com>
Date: Mon, 9 Dec 2019 00:38:36 +0000
Message-ID: <1575851866-18919-5-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1575851866-18919-1-git-send-email-jeff@labundy.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
To: "lee.jones@linaro.org" <lee.jones@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jeff LaBundy <jeff@labundy.com>

This patch adds support for the Azoteq IQS620A, capable of generating
a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive).

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Added 'Limitations' section to introductory comments
  - Replaced 'error' with 'ret' throughout
  - Added const qualifier to state argument of iqs620_pwm_apply and removed=
 all
    modifications to the variable's contents
  - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the requeste=
d
    polarity is inverted or the requested period is below 1 ms, respectivel=
y
  - Updated iqs620_pwm_apply to disable the PWM output if duty cycle is zer=
o
  - Added iqs620_pwm_get_state
  - Eliminated tabbed alignment of pwm_ops and platform_driver struct membe=
rs
  - Moved notifier unregistration to already present iqs620_pwm_remove, whi=
ch
    eliminated the need for a device-managed action and ready flag
  - Added a comment in iqs620_pwm_probe to explain the order of operations
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/pwm/Kconfig       |  10 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-iqs620a.c | 206 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/pwm/pwm-iqs620a.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bd21655..60bcf6c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -222,6 +222,16 @@ config PWM_IMX_TPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx-tpm.

+config PWM_IQS620A
+	tristate "Azoteq IQS620A PWM support"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Generic PWM framework driver for the Azoteq IQS620A multi-function
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called pwm-iqs620a.
+
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9a47507..a59c710 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
+obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
new file mode 100644
index 0000000..1ea11b9
--- /dev/null
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A PWM Generator
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ *
+ * Limitations:
+ * - The period is not guaranteed to run to completion when the duty cycle=
 is
+ *   changed or the output is disabled.
+ * - The period is fixed to 1 ms.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define IQS620_PWR_SETTINGS			0xD2
+#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
+
+#define IQS620_PWM_DUTY_CYCLE			0xD8
+
+#define IQS620_PWM_PERIOD_NS			1000000
+
+struct iqs620_pwm_private {
+	struct iqs62x_core *iqs62x;
+	struct pwm_chip chip;
+	struct notifier_block notifier;
+};
+
+static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
+	unsigned int pwm_out =3D 0;
+	int duty_scale, ret;
+
+	if (state->polarity !=3D PWM_POLARITY_NORMAL)
+		return -ENOTSUPP;
+
+	if (state->period < IQS620_PWM_PERIOD_NS)
+		return -EINVAL;
+
+	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
+	iqs62x =3D iqs620_pwm->iqs62x;
+
+	duty_scale =3D DIV_ROUND_CLOSEST(state->duty_cycle * 256,
+				       IQS620_PWM_PERIOD_NS);
+
+	if (duty_scale) {
+		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
+				   min(duty_scale - 1, 0xFF));
+		if (ret)
+			return ret;
+
+		if (state->enabled)
+			pwm_out =3D IQS620_PWR_SETTINGS_PWM_OUT;
+	}
+
+	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
+				  IQS620_PWR_SETTINGS_PWM_OUT, pwm_out);
+}
+
+static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
+				 struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
+	unsigned int val;
+	int ret;
+
+	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
+	iqs62x =3D iqs620_pwm->iqs62x;
+
+	ret =3D regmap_read(iqs62x->map, IQS620_PWR_SETTINGS, &val);
+	if (ret)
+		goto err_out;
+	state->enabled =3D val & IQS620_PWR_SETTINGS_PWM_OUT;
+
+	ret =3D regmap_read(iqs62x->map, IQS620_PWM_DUTY_CYCLE, &val);
+	if (ret)
+		goto err_out;
+	state->duty_cycle =3D DIV_ROUND_CLOSEST((val + 1) * IQS620_PWM_PERIOD_NS,
+					      256);
+	state->period =3D IQS620_PWM_PERIOD_NS;
+
+err_out:
+	if (ret)
+		dev_err(iqs620_pwm->chip.dev, "Failed to get state: %d\n", ret);
+}
+
+static int iqs620_pwm_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct pwm_state state;
+	int ret;
+
+	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
+		return NOTIFY_DONE;
+
+	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
+				  notifier);
+	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
+
+	ret =3D iqs620_pwm_apply(&iqs620_pwm->chip,
+			       &iqs620_pwm->chip.pwms[0], &state);
+	if (ret) {
+		dev_err(iqs620_pwm->chip.dev,
+			"Failed to re-initialize device: %d\n", ret);
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
+static const struct pwm_ops iqs620_pwm_ops =3D {
+	.apply =3D iqs620_pwm_apply,
+	.get_state =3D iqs620_pwm_get_state,
+	.owner =3D THIS_MODULE,
+};
+
+static int iqs620_pwm_probe(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	int ret1, ret2;
+
+	iqs620_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERNEL);
+	if (!iqs620_pwm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, iqs620_pwm);
+	iqs620_pwm->iqs62x =3D dev_get_drvdata(pdev->dev.parent);
+
+	iqs620_pwm->chip.dev =3D &pdev->dev;
+	iqs620_pwm->chip.ops =3D &iqs620_pwm_ops;
+	iqs620_pwm->chip.base =3D -1;
+	iqs620_pwm->chip.npwm =3D 1;
+
+	ret1 =3D pwmchip_add(&iqs620_pwm->chip);
+	if (ret1) {
+		dev_err(&pdev->dev, "Failed to add device: %d\n", ret1);
+		return ret1;
+	}
+
+	/*
+	 * Since iqs620_pwm_notifier uses iqs620_pwm->chip.pwms[], the notifier
+	 * is not registered until pwmchip_add (which allocates that array) has
+	 * been called. If registration fails, the newly added device has to be
+	 * removed because the driver fails to probe and iqs620_pwm_remove will
+	 * never be called.
+	 */
+	iqs620_pwm->notifier.notifier_call =3D iqs620_pwm_notifier;
+	ret1 =3D blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
+						&iqs620_pwm->notifier);
+	if (ret1) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret1);
+
+		ret2 =3D pwmchip_remove(&iqs620_pwm->chip);
+		if (ret2) {
+			dev_err(&pdev->dev, "Failed to remove device: %d\n",
+				ret2);
+			return ret2;
+		}
+	}
+
+	return ret1;
+}
+
+static int iqs620_pwm_remove(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm =3D platform_get_drvdata(pdev);
+	int ret;
+
+	ret =3D blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
+						 &iqs620_pwm->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to unregister notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D pwmchip_remove(&iqs620_pwm->chip);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to remove device: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver iqs620_pwm_platform_driver =3D {
+	.driver =3D {
+		.name =3D IQS620_DRV_NAME_PWM,
+	},
+	.probe =3D iqs620_pwm_probe,
+	.remove =3D iqs620_pwm_remove,
+};
+module_platform_driver(iqs620_pwm_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A PWM Generator");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS620_DRV_NAME_PWM);
--
2.7.4
