From: Denis Carikli <denis@eukrea.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20pwm=3A=20Add=20MC34708=20PWM=20driver=20support=2E?=
Date: Mon, 23 Jun 2014 14:10:05 +0200
Message-ID: <1403525405-5336-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:19737 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbaFWMKK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 23 Jun 2014 08:10:10 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, linux-pwm@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Denis Carikli <denis@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:

- The driver now uses retrives mc13xxx without having to export it
  trough a globally exported function.
- The .enable() and .disable() are now handled.
- The registers calculations have been reworked.
- Defines have been reworked to be more readable.
- The driver only supports the mc34708, so now we don't claim to suppor=
t
  other devices anymore, and the prefix has been changed from mc13xxx
  to mc34708. The documentation was also updated to reflect that.
- Spelling errors have been fixed.
- There is now less code thanks to the use of mc13xxx_reg_rmw and
  range checking functions.
- Many other cosmetics fixes and code cleanups.
---
 Documentation/devicetree/bindings/mfd/mc13xxx.txt |    3 +
 drivers/mfd/mc13xxx-core.c                        |   16 ++
 drivers/pwm/Kconfig                               |    6 +
 drivers/pwm/Makefile                              |    1 +
 drivers/pwm/pwm-mc34708.c                         |  224 +++++++++++++=
++++++++
 5 files changed, 250 insertions(+)
 create mode 100644 drivers/pwm/pwm-mc34708.c

diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt b/Docume=
ntation/devicetree/bindings/mfd/mc13xxx.txt
index 8aba488..464a663 100644
--- a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
+++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
@@ -22,6 +22,9 @@ Sub-nodes:
   Each led node should contain "reg", which used as LED ID (described =
below).
   Optional properties "label" and "linux,default-trigger" is described=
 in
   Documentation/devicetree/bindings/leds/common.txt.
+- pwm: For MC34708, contain the PWM controller:
+  - compatible: must be "fsl,mc34708-pwm".
+  - #pwm-cells: must be 2.
 - regulators : Contain the regulator nodes. The regulators are bound u=
sing
   their names as listed below with their registers and bits for enabli=
ng.
=20
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index acf5dd7..71b7d84c 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -599,6 +599,20 @@ static int mc13xxx_add_subdevice_pdata(struct mc13=
xxx *mc13xxx,
 	if (!cell.name)
 		return -ENOMEM;
=20
+	/* mfd_add_devices won't adds a .of_node to the child's dev if the
+	 * cell's .off_compatible is NULL, which result in
+	 * of_node_to_pwmchip beeing unable to find the pwm device.
+	 */
+	if (!strncmp(format, "%s-pwm", sizeof("%s-pwm"))) {
+		if (snprintf(buf, sizeof(buf),
+			     "fsl,%s", cell.name) > sizeof(buf))
+			return -E2BIG;
+
+		cell.of_compatible =3D kmemdup(buf, strlen(buf) + 1, GFP_KERNEL);
+		if (!cell.of_compatible)
+			return -ENOMEM;
+	}
+
 	return mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0, NULL);
 }
=20
@@ -681,6 +695,7 @@ int mc13xxx_common_init(struct device *dev)
 			&pdata->regulators, sizeof(pdata->regulators));
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
 				pdata->leds, sizeof(*pdata->leds));
+		mc13xxx_add_subdevice(mc13xxx, "%s-pwm");
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
 				pdata->buttons, sizeof(*pdata->buttons));
 		if (mc13xxx->flags & MC13XXX_USE_CODEC)
@@ -692,6 +707,7 @@ int mc13xxx_common_init(struct device *dev)
 	} else {
 		mc13xxx_add_subdevice(mc13xxx, "%s-regulator");
 		mc13xxx_add_subdevice(mc13xxx, "%s-led");
+		mc13xxx_add_subdevice(mc13xxx, "%s-pwm");
 		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
 		if (mc13xxx->flags & MC13XXX_USE_CODEC)
 			mc13xxx_add_subdevice(mc13xxx, "%s-codec");
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4ad7b89..a7ca3eb 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -157,6 +157,12 @@ config PWM_LPSS
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpss.
=20
+config PWM_MC34708
+	tristate "MC34708 PWM support"
+	depends on MFD_MC13XXX
+	help
+	  Generic PWM framework driver for Freescale MC34708 PMIC.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS && OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5c86a19..0fe5ec5 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+=3D pwm-lpss.o
+obj-$(CONFIG_PWM_MC34708)	+=3D pwm-mc34708.o
 obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
 obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
 obj-$(CONFIG_PWM_PUV3)		+=3D pwm-puv3.o
diff --git a/drivers/pwm/pwm-mc34708.c b/drivers/pwm/pwm-mc34708.c
new file mode 100644
index 0000000..840f4dc
--- /dev/null
+++ b/drivers/pwm/pwm-mc34708.c
@@ -0,0 +1,224 @@
+/*
+ * Copyright 2014 Eukr=C3=A9a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#include <linux/mfd/mc13783.h>
+
+/* PWM register address */
+#define MC134708_PWM		0x37
+
+/* PWM register fields:
+ * Bit #    RegisterName Description
+ *  [0->5]  PWM1DUTY:   PWM1 duty cycle
+ *  [6->11] PWM1CLKDIV: PWM1 duty cycle
+ * [12->17] PWM2DUTY:   PWM2 clock divide setting
+ * [18->23] PWM2CLKDIV: PWM2 clock divide setting
+ */
+#define MC134708_PWM_MASK			0x3f
+#define MC134708_PWM_NUM_OFFSET			0x0c
+
+#define MC134708_PWM_DUTY_OFFSET(pwm_id)	(pwm_id * MC134708_PWM_NUM_OF=
=46SET)
+#define MC134708_PWM_PERIOD_OFFSET(pwm_id)	((pwm_id * MC134708_PWM_NUM=
_OFFSET) + 0x06)
+
+/* MC34708 PWM Constraints */
+#define MC13708_BASE_CLK_FREQ	2000000
+#define MC13708_PWM_MAX_DUTY	32
+#define MC13708_PWM_MAX_CLKDIV	64
+
+#define MC13708_MIN_PWM_PERIOD	(NSEC_PER_SEC / MC13708_BASE_CLK_FREQ)
+#define MC13708_MAX_PWM_PERIOD	(MC13708_MIN_PWM_PERIOD * MC13708_PWM_M=
AX_CLKDIV)
+
+#define MC134708_PWMS_NUM	2
+
+struct mc34708_pwm_regs {
+	int enabled;
+	int pwm_duty;
+};
+
+struct mc34708_pwm_chip {
+	struct pwm_chip pwm_chip;
+	struct mc13xxx *mc13xxx;
+	struct mc34708_pwm_regs *pwms[MC134708_PWMS_NUM];
+};
+
+static inline
+struct mc34708_pwm_chip *to_mc34708_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mc34708_pwm_chip, pwm_chip);
+}
+
+static int
+pwm_mc34708_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			      int duty_ns, int period_ns)
+{
+	struct mc34708_pwm_chip *mc34708_chip =3D to_mc34708_chip(chip);
+	struct mc34708_pwm_regs *pwmr =3D mc34708_chip->pwms[pwm->hwpwm];
+	struct mc13xxx *mc13xxx =3D mc34708_chip->mc13xxx;
+
+	int duty_offset =3D MC134708_PWM_DUTY_OFFSET(pwm->hwpwm);
+	int period_offset =3D MC134708_PWM_PERIOD_OFFSET(pwm->hwpwm);
+
+	int pwm_clkdiv, pwm_duty, ret =3D 0;
+
+	/* Period */
+	period_ns =3D clamp(period_ns, (int)MC13708_MIN_PWM_PERIOD,
+			  (int)MC13708_MAX_PWM_PERIOD);
+	pwm_clkdiv =3D DIV_ROUND_UP(NSEC_PER_SEC, period_ns); /* Frequency (H=
z) */
+	pwm_clkdiv =3D DIV_ROUND_UP(MC13708_BASE_CLK_FREQ,
+				  pwm_clkdiv) - 1; /* Clock divisor */
+
+	/* Duty cycle */
+	pwm_duty =3D DIV_ROUND_UP(MC13708_PWM_MAX_DUTY * duty_ns, period_ns);
+
+	/* Actual write to the registers */
+	mc13xxx_lock(mc13xxx);
+
+	ret =3D mc13xxx_reg_rmw(mc13xxx, MC134708_PWM,
+					MC134708_PWM_MASK << period_offset,
+					pwm_clkdiv << period_offset);
+	if (ret) {
+		mc13xxx_unlock(mc13xxx);
+		return ret;
+	}
+
+	/* The MC34708 doesn't have an enable bit for its PWM unit,
+	 * so we cache the pwm duty value for the .enable()
+	 */
+	pwmr->pwm_duty =3D pwm_duty;
+
+	if (pwmr->enabled) {
+		ret =3D mc13xxx_reg_rmw(mc13xxx, MC134708_PWM,
+				MC134708_PWM_MASK << duty_offset,
+				pwm_duty << duty_offset);
+	}
+	mc13xxx_unlock(mc13xxx);
+
+	return ret;
+}
+
+static int pwm_mc34708_enable(struct pwm_chip *chip, struct pwm_device=
 *pwm)
+{
+	struct mc34708_pwm_chip *mc34708_chip =3D to_mc34708_chip(chip);
+	struct mc34708_pwm_regs *pwmr =3D mc34708_chip->pwms[pwm->hwpwm];
+	struct mc13xxx *mc13xxx =3D mc34708_chip->mc13xxx;
+	int duty_offset =3D MC134708_PWM_DUTY_OFFSET(pwm->hwpwm);
+	int ret;
+
+	mc13xxx_lock(mc13xxx);
+
+	ret =3D mc13xxx_reg_rmw(mc13xxx, MC134708_PWM,
+			MC134708_PWM_MASK << duty_offset,
+			pwmr->pwm_duty << duty_offset);
+	pwmr->enabled =3D 1;
+
+	mc13xxx_unlock(mc13xxx);
+
+	return ret;
+}
+
+static void pwm_mc34708_disable(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)
+{
+	struct mc34708_pwm_chip *mc34708_chip =3D to_mc34708_chip(chip);
+	struct mc34708_pwm_regs *pwmr =3D mc34708_chip->pwms[pwm->hwpwm];
+	struct mc13xxx *mc13xxx =3D mc34708_chip->mc13xxx;
+	int duty_offset =3D MC134708_PWM_DUTY_OFFSET(pwm->hwpwm);
+
+	mc13xxx_lock(mc13xxx);
+
+	/* To disable the PWM, the duty cycle bits have to be cleared */
+	mc13xxx_reg_rmw(mc13xxx, MC134708_PWM,
+			MC134708_PWM_MASK << duty_offset,
+			0 << duty_offset);
+	pwmr->enabled =3D 0;
+
+	mc13xxx_unlock(mc13xxx);
+}
+
+static const struct pwm_ops pwm_mc34708_ops =3D {
+	.enable		=3D pwm_mc34708_enable,
+	.disable	=3D pwm_mc34708_disable,
+	.config		=3D pwm_mc34708_config,
+	.owner		=3D THIS_MODULE,
+};
+
+static int pwm_mc34708_probe(struct platform_device *pdev)
+{
+	struct mc34708_pwm_chip *chip;
+	struct mc13xxx *mc13xxx;
+	int err, i;
+
+	mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
+
+	if (!mc13xxx)
+		return -EINVAL;
+
+	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+			return -ENOMEM;
+
+	for (i =3D 0; i < MC134708_PWMS_NUM; i++) {
+		chip->pwms[i] =3D devm_kzalloc(&pdev->dev,
+			sizeof(struct mc34708_pwm_regs), GFP_KERNEL);
+	}
+
+	chip->mc13xxx =3D mc13xxx;
+	chip->pwm_chip.dev =3D &pdev->dev;
+	chip->pwm_chip.ops =3D &pwm_mc34708_ops;
+	chip->pwm_chip.base =3D -1;
+	chip->pwm_chip.npwm =3D MC134708_PWMS_NUM;
+
+	err =3D pwmchip_add(&chip->pwm_chip);
+	if (err < 0)
+		return err;
+
+	platform_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+static int pwm_mc34708_remove(struct platform_device *pdev)
+{
+	struct mc34708_pwm_chip *chip =3D platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&chip->pwm_chip);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id pwm_mc34708_of_match[] =3D {
+	{ .compatible =3D "fsl,mc34708-pwm" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pwm_mc34708_of_match);
+#endif
+
+static struct platform_driver pwm_mc34708_driver =3D {
+	.driver	=3D {
+		.name =3D "mc34708-pwm",
+		.of_match_table =3D of_match_ptr(pwm_mc34708_of_match),
+	},
+	.probe =3D pwm_mc34708_probe,
+	.remove =3D pwm_mc34708_remove,
+};
+module_platform_driver(pwm_mc34708_driver);
+
+MODULE_ALIAS("platform:mc34708-pwm");
+MODULE_AUTHOR("Denis Carikli <denis@eukrea.com>");
+MODULE_DESCRIPTION("mc34708 Pulse Width Modulation Driver");
+MODULE_LICENSE("GPL");
--=20
1.7.9.5

