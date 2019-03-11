From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 2/5] pwm: Add i.MX TPM PWM driver support
Date: Mon, 11 Mar 2019 07:16:16 +0000
Message-ID: <1552288273-31028-3-git-send-email-Anson.Huang@nxp.com>
References: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, add TPM PWM driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/Kconfig       |   9 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 277 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..23839ad 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -201,6 +201,15 @@ config PWM_IMX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx.
=20
+config PWM_IMX_TPM
+	tristate "i.MX TPM PWM support"
+	depends on ARCH_MXC
+	help
+	  Generic PWM framework driver for i.MX TPM.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-imx-tpm.
+
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9c676a0..64e036c 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
 obj-$(CONFIG_PWM_IMX)		+=3D pwm-imx.o
+obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
 obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
new file mode 100644
index 0000000..a53256a
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 NXP.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#define TPM_GLOBAL	0x8
+#define TPM_SC		0x10
+#define TPM_CNT		0x14
+#define TPM_MOD		0x18
+#define TPM_C0SC	0x20
+#define TPM_C0V		0x24
+
+#define SC_CMOD		3
+#define SC_CPWMS	BIT(5)
+#define MSnB		BIT(5)
+#define MSnA		BIT(4)
+#define ELSnB		BIT(3)
+#define ELSnA		BIT(2)
+
+#define TPM_SC_PS_MASK		0x7
+#define TPM_MOD_MOD_MASK	0xffff
+
+#define PERIOD_PERIOD_MAX	0x10000
+#define PERIOD_DIV_MAX		8
+
+#define TPM_CHn_ADDR_OFFSET	0x8
+#define DEFAULT_PWM_CHANNEL_NUM	2
+
+struct tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+};
+
+static const unsigned int prediv[8] =3D {
+	1, 2, 4, 8, 16, 32, 64, 128
+};
+
+#define to_tpm_pwm_chip(_chip)	container_of(_chip, struct tpm_pwm_chip, ch=
ip)
+
+static int tpm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			  int duty_ns, int period_ns)
+{
+	struct tpm_pwm_chip *tpm =3D to_tpm_pwm_chip(chip);
+	unsigned int period_cycles, duty_cycles;
+	unsigned long rate;
+	u32 val, div =3D 0;
+	u64 c;
+	int ret;
+
+	rate =3D clk_get_rate(tpm->clk);
+	/* calculate the period_cycles and duty_cycles */
+	while (1) {
+		c =3D rate / prediv[div];
+		c =3D c * period_ns;
+		do_div(c, 1000000000);
+		if (c < PERIOD_PERIOD_MAX)
+			break;
+		div++;
+		if (div >=3D 8)
+			return -EINVAL;
+	}
+
+	/* enable the clock before writing the register */
+	if (!pwm_is_enabled(pwm)) {
+		ret =3D clk_prepare_enable(tpm->clk);
+		if (ret) {
+			dev_err(chip->dev,
+				"failed to prepare or enable clk %d\n", ret);
+			return ret;
+		}
+	}
+
+	val =3D readl(tpm->base + TPM_SC);
+	val &=3D ~TPM_SC_PS_MASK;
+	val |=3D div;
+	writel(val, tpm->base + TPM_SC);
+
+	period_cycles =3D c;
+	c *=3D duty_ns;
+	do_div(c, period_ns);
+	duty_cycles =3D c;
+
+	writel(period_cycles & TPM_MOD_MOD_MASK, tpm->base + TPM_MOD);
+	writel(duty_cycles & TPM_MOD_MOD_MASK, tpm->base +
+	       TPM_C0V + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+	/* if pwm is not enabled, disable clk after setting */
+	if (!pwm_is_enabled(pwm))
+		clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int tpm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct tpm_pwm_chip *tpm =3D to_tpm_pwm_chip(chip);
+	int ret;
+	u32 val;
+
+	ret =3D clk_prepare_enable(tpm->clk);
+	if (ret) {
+		dev_err(chip->dev,
+			"failed to prepare or enable clk %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * To enable a tpm channel, CPWMS =3D 0, MSnB:MSnA =3D 0x0,
+	 * for TPM normal polarity ELSnB:ELSnA =3D 2b'10,
+	 * inverse ELSnB:ELSnA =3D 2b'01
+	 */
+	val =3D readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+	val &=3D ~(MSnB | MSnA | ELSnB | ELSnA);
+	val |=3D MSnB;
+	val |=3D pwm->state.polarity ? ELSnA : ELSnB;
+
+	writel(val, tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+	/* start the counter */
+	val =3D readl(tpm->base + TPM_SC);
+	val |=3D 0x1 << SC_CMOD;
+	writel(val, tpm->base + TPM_SC);
+
+	return 0;
+}
+
+static void tpm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct tpm_pwm_chip *tpm =3D to_tpm_pwm_chip(chip);
+
+	clk_disable_unprepare(tpm->clk);
+}
+
+static int tpm_pwm_set_polarity(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    enum pwm_polarity polarity)
+{
+	struct tpm_pwm_chip *tpm =3D to_tpm_pwm_chip(chip);
+	int ret;
+	u32 val;
+
+	/* enable the clock before writing the register */
+	if (!pwm_is_enabled(pwm)) {
+		ret =3D clk_prepare_enable(tpm->clk);
+		if (ret) {
+			dev_err(chip->dev,
+				"failed to prepare or enable clk %d\n", ret);
+			return ret;
+		}
+	}
+
+	val =3D readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+	val &=3D ~(ELSnB | ELSnA);
+	val |=3D pwm->state.polarity ? ELSnA : ELSnB;
+	writel(val, tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+	/* disable the clock after writing the register */
+	if (!pwm_is_enabled(pwm))
+		clk_disable_unprepare(tpm->clk);
+
+	return  0;
+}
+
+static const struct pwm_ops tpm_pwm_ops =3D {
+	.config		=3D tpm_pwm_config,
+	.enable		=3D tpm_pwm_enable,
+	.disable	=3D tpm_pwm_disable,
+	.set_polarity	=3D tpm_pwm_set_polarity,
+	.owner		=3D THIS_MODULE,
+};
+
+static int tpm_pwm_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct tpm_pwm_chip *tpm;
+	struct resource *res;
+	int ret;
+
+	tpm =3D devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	if (!tpm)
+		return -ENOMEM;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tpm->base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tpm->base))
+		return PTR_ERR(tpm->base);
+
+	tpm->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tpm->clk))
+		return PTR_ERR(tpm->clk);
+
+	tpm->chip.dev =3D &pdev->dev;
+	tpm->chip.ops =3D &tpm_pwm_ops;
+	tpm->chip.base =3D -1;
+	tpm->chip.npwm =3D DEFAULT_PWM_CHANNEL_NUM;
+
+	/* init pwm channel number if "fsl,pwm-number" is found in DT */
+	ret =3D of_property_read_u32(np, "fsl,pwm-number", &tpm->chip.npwm);
+	if (ret)
+		dev_warn(&pdev->dev, "two pwm channels by default\n");
+
+	ret =3D pwmchip_add(&tpm->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, tpm);
+
+	return 0;
+}
+
+static int tpm_pwm_remove(struct platform_device *pdev)
+{
+	struct tpm_pwm_chip *tpm =3D platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&tpm->chip);
+}
+
+static int __maybe_unused tpm_pwm_suspend(struct device *dev)
+{
+	struct tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused tpm_pwm_resume(struct device *dev)
+{
+	struct tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(tpm->clk);
+	if (ret) {
+		dev_err(dev, "could not prepare or enable tpm clock\n");
+		return ret;
+	}
+
+	return 0;
+};
+
+static SIMPLE_DEV_PM_OPS(tpm_pwm_pm,
+		 tpm_pwm_suspend, tpm_pwm_resume);
+
+static const struct of_device_id tpm_pwm_dt_ids[] =3D {
+	{ .compatible =3D "fsl,imx-tpm-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tpm_pwm_dt_ids);
+
+static struct platform_driver tpm_pwm_driver =3D {
+	.driver =3D {
+		.name =3D "tpm-pwm",
+		.of_match_table =3D tpm_pwm_dt_ids,
+		.pm =3D &tpm_pwm_pm,
+	},
+	.probe	=3D tpm_pwm_probe,
+	.remove =3D tpm_pwm_remove,
+};
+module_platform_driver(tpm_pwm_driver);
+
+MODULE_AUTHOR("Jacky Bai <ping.bai@nxp.com>");
+MODULE_DESCRIPTION("i.MX TPM PWM Driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4
