From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V2 2/5] pwm: Add i.MX TPM PWM driver support
Date: Wed, 13 Mar 2019 07:31:16 +0000
Message-ID: <1552461970-20813-3-git-send-email-Anson.Huang@nxp.com>
References: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, add TPM PWM driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- improve coding style, function name's prefix;
	- improve Kconfig's help info;
	- use .apply instead for .enable/.disable/.config etc. to simply the code;
	- improve clock operation, make clock enabled during probe phase and ONLY =
disabled
	  when suspend, as register read/write need to sync with clock, keeping it=
 enabled
	  makes the register read/write simple;
	- improve prescale calculation;
	- add error message print during probe for ioremap and clk get;
---
 drivers/pwm/Kconfig       |  10 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 332 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 343 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..c1cbb43 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -201,6 +201,16 @@ config PWM_IMX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx.
=20
+config PWM_IMX_TPM
+	tristate "i.MX TPM PWM support"
+	depends on ARCH_MXC
+	help
+	  Generic PWM framework driver for i.MX7ULP TPM module, TPM's full
+	  name is Low Power Timer/Pulse Width Modulation Module.
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
index 0000000..8c1a1ba
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 NXP.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define TPM_GLOBAL	0x8
+#define TPM_SC		0x10
+#define TPM_CNT		0x14
+#define TPM_MOD		0x18
+#define TPM_C0SC	0x20
+#define TPM_C0V		0x24
+
+#define TPM_SC_CMOD_SHIFT	3
+#define TPM_SC_CMOD_MASK	(0x3 << TPM_SC_CMOD_SHIFT)
+#define TPM_SC_CPWMS		BIT(5)
+
+#define TPM_CnSC_CHF		BIT(7)
+#define TPM_CnSC_MSnB		BIT(5)
+#define TPM_CnSC_MSnA		BIT(4)
+#define TPM_CnSC_ELSnB		BIT(3)
+#define TPM_CnSC_ELSnA		BIT(2)
+
+#define TPM_SC_PS_MASK		0x7
+#define TPM_MOD_MOD_MASK	0xffff
+
+#define TPM_COUNT_MAX		0xffff
+
+#define TPM_CHn_ADDR_OFFSET	0x8
+#define TPM_DEFAULT_PWM_CHANNEL_NUM	2
+
+struct imx_tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	spinlock_t lock;
+	u32 chn_config[TPM_DEFAULT_PWM_CHANNEL_NUM];
+	bool chn_status[TPM_DEFAULT_PWM_CHANNEL_NUM];
+};
+
+#define to_imx_tpm_pwm_chip(_chip)	container_of(_chip, struct imx_tpm_pwm_=
chip, chip)
+
+static void imx_tpm_pwm_config_counter(struct pwm_chip *chip, u32 period)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	unsigned int period_cnt;
+	u32 val, div;
+	u64 tmp;
+
+	tmp =3D clk_get_rate(tpm->clk);
+	tmp *=3D period;
+	val =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	if (val < TPM_COUNT_MAX)
+		div =3D 0;
+	else
+		div =3D ilog2(roundup_pow_of_two(val / TPM_COUNT_MAX));
+	if (div > TPM_SC_PS_MASK) {
+		dev_err(chip->dev,
+			"failed to find valid prescale value!\n");
+		return;
+	}
+	/* set TPM counter prescale */
+	val =3D readl(tpm->base + TPM_SC);
+	val &=3D ~TPM_SC_PS_MASK;
+	val |=3D div;
+	writel(val, tpm->base + TPM_SC);
+
+	/* set period counter */
+	do_div(tmp, NSEC_PER_SEC);
+	period_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, 1 << div);
+	writel(period_cnt & TPM_MOD_MOD_MASK, tpm->base + TPM_MOD);
+}
+
+static void imx_tpm_pwm_config(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	static bool tpm_cnt_initialized;
+	unsigned int duty_cnt;
+	u32 val;
+	u64 tmp;
+
+	/*
+	 * TPM counter is shared by multi channels, let's make it to be
+	 * ONLY first channel can config TPM counter's precale and period
+	 * count.
+	 */
+	if (!tpm_cnt_initialized) {
+		imx_tpm_pwm_config_counter(chip, state->period);
+		tpm_cnt_initialized =3D true;
+	}
+
+	/* set duty counter */
+	tmp =3D readl(tpm->base + TPM_MOD) & TPM_MOD_MOD_MASK;
+	tmp *=3D state->duty_cycle;
+	duty_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, state->period);
+	writel(duty_cnt & TPM_MOD_MOD_MASK, tpm->base +
+	       TPM_C0V + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+	/* set polarity */
+	val =3D readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+	val &=3D ~(TPM_CnSC_ELSnB | TPM_CnSC_ELSnA | TPM_CnSC_MSnA);
+	val |=3D TPM_CnSC_MSnB;
+	val |=3D state->polarity ? TPM_CnSC_ELSnA : TPM_CnSC_ELSnB;
+	/*
+	 * polarity settings will enabled/disable output statue
+	 * immediately, so here ONLY save the config and will be
+	 * written into register when channel is enabled/disabled.
+	 */
+	tpm->chn_config[pwm->hwpwm] =3D val;
+}
+
+static void imx_tpm_pwm_enable(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       bool enable)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 val, i;
+
+	val =3D readl(tpm->base + TPM_SC);
+	if (enable) {
+		/* restore channel config */
+		writel(tpm->chn_config[pwm->hwpwm],
+			tpm->base +
+			TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+		/* start TPM counter anyway */
+		val |=3D 0x1 << TPM_SC_CMOD_SHIFT;
+		writel(val, tpm->base + TPM_SC);
+	} else {
+		/* save channel config */
+		tpm->chn_config[pwm->hwpwm] =3D readl(tpm->base +
+			TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+		/* disable channel */
+		writel(TPM_CnSC_CHF, tpm->base +
+			TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+		for (i =3D 0; i < chip->npwm; i++)
+			if (i !=3D pwm->hwpwm && tpm->chn_status[i])
+				break;
+		if (i =3D=3D chip->npwm) {
+			/* stop TPM counter since all channels are disabled */
+			val &=3D ~TPM_SC_CMOD_MASK;
+			writel(val, tpm->base + TPM_SC);
+		}
+	}
+
+	/* update channel statue */
+	tpm->chn_status[pwm->hwpwm] =3D enable;
+}
+
+static void imx_tpm_pwm_get_state(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	unsigned long rate, flags;
+	u64 tmp;
+	u32 val;
+
+	spin_lock_irqsave(&tpm->lock, flags);
+
+	/* get period */
+	rate =3D clk_get_rate(tpm->clk);
+	tmp =3D readl(tpm->base + TPM_MOD);
+	val =3D readl(tpm->base + TPM_SC);
+	val &=3D TPM_SC_PS_MASK;
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get duty cycle */
+	tmp =3D readl(tpm->base + TPM_C0V + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get polarity */
+	val =3D readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+	if (val & TPM_CnSC_ELSnA)
+		state->polarity =3D PWM_POLARITY_INVERSED;
+	else
+		state->polarity =3D PWM_POLARITY_NORMAL;
+
+	/* get channel status */
+	state->enabled =3D tpm->chn_status[pwm->hwpwm] ? true : false;
+
+	spin_unlock_irqrestore(&tpm->lock, flags);
+}
+
+static int imx_tpm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
+			  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	struct pwm_state curstate;
+	unsigned long flags;
+
+	imx_tpm_pwm_get_state(chip, pwm, &curstate);
+
+	spin_lock_irqsave(&tpm->lock, flags);
+
+	if (state->period !=3D curstate.period ||
+	    state->duty_cycle !=3D curstate.duty_cycle ||
+	    state->polarity !=3D curstate.polarity)
+		imx_tpm_pwm_config(chip, pwm, state);
+
+	if (state->enabled !=3D curstate.enabled)
+		imx_tpm_pwm_enable(chip, pwm, state->enabled);
+
+	spin_unlock_irqrestore(&tpm->lock, flags);
+
+	return 0;
+}
+
+static const struct pwm_ops imx_tpm_pwm_ops =3D {
+	.get_state =3D imx_tpm_pwm_get_state,
+	.apply =3D imx_tpm_pwm_apply,
+	.owner =3D THIS_MODULE,
+};
+
+static int imx_tpm_pwm_probe(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm;
+	struct resource *res;
+	int ret;
+
+	tpm =3D devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	if (!tpm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, tpm);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tpm->base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tpm->base)) {
+		ret =3D PTR_ERR(tpm->base);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "pwm ioremap failed %d\n", ret);
+		return ret;
+	}
+
+	tpm->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tpm->clk)) {
+		ret =3D PTR_ERR(tpm->clk);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get pwm clk %d\n", ret);
+		return ret;
+	}
+
+	ret =3D clk_prepare_enable(tpm->clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to prepare or enable clk %d\n", ret);
+		return ret;
+	}
+
+	tpm->chip.dev =3D &pdev->dev;
+	tpm->chip.ops =3D &imx_tpm_pwm_ops;
+	tpm->chip.base =3D -1;
+	tpm->chip.npwm =3D TPM_DEFAULT_PWM_CHANNEL_NUM;
+
+	spin_lock_init(&tpm->lock);
+
+	ret =3D pwmchip_add(&tpm->chip);
+	if (ret)
+		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+
+	return ret;
+}
+
+static int imx_tpm_pwm_remove(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&tpm->chip);
+}
+
+static int __maybe_unused imx_tpm_pwm_suspend(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused imx_tpm_pwm_resume(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+	int ret =3D clk_prepare_enable(tpm->clk);
+
+	if (ret)
+		dev_err(dev,
+			"failed to prepare or enable clk %d\n", ret);
+
+	return ret;
+};
+
+static SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
+			 imx_tpm_pwm_suspend, imx_tpm_pwm_resume);
+
+static const struct of_device_id imx_tpm_pwm_dt_ids[] =3D {
+	{ .compatible =3D "fsl,imx-tpm-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_tpm_pwm_dt_ids);
+
+static struct platform_driver imx_tpm_pwm_driver =3D {
+	.driver =3D {
+		.name =3D "imx-tpm-pwm",
+		.of_match_table =3D imx_tpm_pwm_dt_ids,
+		.pm =3D &imx_tpm_pwm_pm,
+	},
+	.probe	=3D imx_tpm_pwm_probe,
+	.remove =3D imx_tpm_pwm_remove,
+};
+module_platform_driver(imx_tpm_pwm_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("i.MX TPM PWM Driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4
