From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [RFC PATCH 06/10] pwm: ntxec: Add driver for PWM function in Netronix EC
Date: Sun, 21 Jun 2020 00:42:17 +0200
Message-ID: <20200620224222.1312520-5-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:46107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgFTWnU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:43:20 -0400
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Stephan Gerhold <stephan@gerhold.net>, Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.>

The Netronix EC provides a PWM output, which is used for the backlight
on ebook readers. This patches adds a driver for the PWM output.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/pwm/Kconfig     |   4 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-ntxec.c | 148 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/pwm/pwm-ntxec.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cb8d739067d2f..147d6629e662c 100644
=2D-- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -350,6 +350,10 @@ config PWM_MXS
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mxs.

+config PWM_NTXEC
+	tristate "Netronix embedded controller PWM support"
+	depends on MFD_NTXEC && OF
+
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a59c710e98c76..15507a6d9ca12 100644
=2D-- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
 obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
+obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
 obj-$(CONFIG_PWM_PUV3)		+=3D pwm-puv3.o
diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
new file mode 100644
index 0000000000000..eca305d8e915b
=2D-- /dev/null
+++ b/drivers/pwm/pwm-ntxec.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2020 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+//
+// PWM driver for Netronix embedded controller.
+
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/of_device.h>
+#include <linux/types.h>
+
+struct ntxec_pwm {
+	struct device *dev;
+	struct ntxec *ec;
+	struct pwm_chip chip;
+};
+
+static struct ntxec_pwm *pwmchip_to_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ntxec_pwm, chip);
+}
+
+#define NTXEC_UNK_A		0xa1
+#define NTXEC_UNK_B		0xa2
+#define NTXEC_ENABLE		0xa3
+#define NTXEC_PERIOD_LOW	0xa4
+#define NTXEC_PERIOD_HIGH	0xa5
+#define NTXEC_DUTY_LOW		0xa6
+#define NTXEC_DUTY_HIGH		0xa7
+
+/*
+ * The time base used in the EC is 8MHz, or 125ns. Period and duty cycle =
are
+ * measured in this unit.
+ */
+static int ntxec_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm=
_dev,
+				 int duty_ns, int period_ns)
+{
+	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
+	uint64_t duty =3D duty_ns;
+	uint64_t period =3D period_ns;
+	int res =3D 0;
+
+	do_div(period, 125);
+	if (period > 0xffff) {
+		dev_warn(pwm->dev,
+			 "Period is not representable in 16 bits: %llu\n", period);
+		return -ERANGE;
+	}
+
+	do_div(duty, 125);
+	if (duty > 0xffff) {
+		dev_warn(pwm->dev, "Duty cycle is not representable in 16 bits: %llu\n"=
,
+			duty);
+		return -ERANGE;
+	}
+
+	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_HIGH, period >> 8);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_LOW, period);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_HIGH, duty >> 8);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_LOW, duty);
+
+	return (res < 0) ? -EIO : 0;
+}
+
+static int ntxec_pwm_enable(struct pwm_chip *chip,
+				 struct pwm_device *pwm_dev)
+{
+	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
+
+	return ntxec_write8(pwm->ec, NTXEC_ENABLE, 1);
+}
+
+static void ntxec_pwm_disable(struct pwm_chip *chip,
+				   struct pwm_device *pwm_dev)
+{
+	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
+
+	ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
+}
+
+static struct pwm_ops ntxec_pwm_ops =3D {
+	.config		=3D ntxec_pwm_config,
+	.enable		=3D ntxec_pwm_enable,
+	.disable	=3D ntxec_pwm_disable,
+	.owner		=3D THIS_MODULE,
+};
+
+static int ntxec_pwm_probe(struct platform_device *pdev)
+{
+	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
+	struct ntxec_pwm *pwm;
+	struct pwm_chip *chip;
+	int res;
+
+	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->ec =3D ec;
+	pwm->dev =3D &pdev->dev;
+
+	chip =3D &pwm->chip;
+	chip->dev =3D &pdev->dev;
+	chip->ops =3D &ntxec_pwm_ops;
+	chip->base =3D -1;
+	chip->npwm =3D 1;
+
+	res =3D pwmchip_add(chip);
+	if (res < 0)
+		return res;
+
+	platform_set_drvdata(pdev, pwm);
+
+	res |=3D ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_A, 0xff);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_B, 0xff);
+
+	return (res < 0) ? -EIO : 0;
+}
+
+static int ntxec_pwm_remove(struct platform_device *pdev)
+{
+	struct ntxec_pwm *pwm =3D platform_get_drvdata(pdev);
+	struct pwm_chip *chip =3D &pwm->chip;
+
+	return pwmchip_remove(chip);
+}
+
+static const struct of_device_id ntxec_pwm_of_match[] =3D {
+	{ .compatible =3D "netronix,ntxec-pwm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ntxec_pwm_of_match);
+
+static struct platform_driver ntxec_pwm_driver =3D {
+	.driver =3D {
+		.name =3D "ntxec-pwm",
+		.of_match_table =3D ntxec_pwm_of_match,
+	},
+	.probe =3D ntxec_pwm_probe,
+	.remove =3D ntxec_pwm_remove,
+};
+module_platform_driver(ntxec_pwm_driver);
+
+MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
+MODULE_DESCRIPTION("PWM driver for Netronix EC");
+MODULE_LICENSE("GPL");
=2D-
2.27.0
