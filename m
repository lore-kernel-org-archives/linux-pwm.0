From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Date: Fri, 15 Mar 2019 00:46:51 +0000
Message-ID: <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "stefan@agner.ch" <stefan@agner.ch>, Leonard Crestez <leonard.crestez@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, add TPM PWM driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- use "PWM_IMX_" as macro definition prefix and "pwm_imx_" as function pre=
fix;
	- improve the limitation txt;
	- return error for configuring period/prescale fail;
	- disable clock when driver probe failed and remove;
	- improve module build dependency;
	- introduce user_count to determine whether configuing period is allowed;
	- some logic improvement for setting duty/status etc.;
---
 drivers/pwm/Kconfig       |  12 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 396 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 409 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..6117fe6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -201,6 +201,18 @@ config PWM_IMX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx.
=20
+config PWM_IMX_TPM
+	tristate "i.MX TPM PWM support"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
+
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
index 0000000..f108f75
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 NXP.
+ *
+ * Limitations:
+ * - The TPM counter and period counter are shared between
+ *   multiple channels, so all channels should use same period
+ *   settings.
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
+
+#define PWM_IMX_TPM_GLOBAL	0x8
+#define PWM_IMX_TPM_SC		0x10
+#define PWM_IMX_TPM_CNT		0x14
+#define PWM_IMX_TPM_MOD		0x18
+#define PWM_IMX_TPM_C0SC	0x20
+#define PWM_IMX_TPM_C0V		0x24
+
+#define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
+#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK	BIT(3)
+#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
+
+#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
+#define PWM_IMX_TPM_CnSC_MSnB	BIT(5)
+#define PWM_IMX_TPM_CnSC_MSnA	BIT(4)
+#define PWM_IMX_TPM_CnSC_ELSnB	BIT(3)
+#define PWM_IMX_TPM_CnSC_ELSnA	BIT(2)
+
+#define PWM_IMX_TPM_SC_PS_MASK		0x7
+#define PWM_IMX_TPM_MOD_MOD_MASK	0xffff
+
+#define PWM_IMX_TPM_MAX_COUNT		0xffff
+
+#define PWM_IMX_TPM_MAX_CHANNEL_NUM	6
+
+#define PWM_IMX_TPM_CnSC(n)	(PWM_IMX_TPM_C0SC + n * 0x8)
+#define PWM_IMX_TPM_CnV(n)	(PWM_IMX_TPM_C0V + n * 0x8)
+
+struct imx_tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	struct mutex lock;
+	u32 user_count;
+	u32 chn_config[PWM_IMX_TPM_MAX_CHANNEL_NUM];
+	bool chn_status[PWM_IMX_TPM_MAX_CHANNEL_NUM];
+};
+
+#define to_imx_tpm_pwm_chip(_chip)	\
+		container_of(_chip, struct imx_tpm_pwm_chip, chip)
+
+static int pwm_imx_tpm_config_counter(struct pwm_chip *chip, u32 period)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 period_cnt, val, div, saved_cmod;
+	u64 tmp;
+
+	tmp =3D clk_get_rate(tpm->clk);
+	tmp *=3D period;
+	val =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	if (val < PWM_IMX_TPM_MAX_COUNT)
+		div =3D 0;
+	else
+		div =3D ilog2(roundup_pow_of_two(val /
+			(PWM_IMX_TPM_MAX_COUNT + 1)));
+	if (div > PWM_IMX_TPM_SC_PS_MASK) {
+		dev_err(chip->dev,
+			"failed to find valid prescale value!\n");
+		return -EINVAL;
+	}
+
+	/* make sure counter is disabled for programming prescale */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	saved_cmod =3D val & PWM_IMX_TPM_SC_CMOD;
+	val &=3D ~PWM_IMX_TPM_SC_CMOD;
+	writel(val, tpm->base + PWM_IMX_TPM_SC);
+
+	/* set TPM counter prescale */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val &=3D ~PWM_IMX_TPM_SC_PS_MASK;
+	val |=3D div;
+	writel(val, tpm->base + PWM_IMX_TPM_SC);
+
+	/*
+	 * set period counter: according to RM, the MOD register is
+	 * updated immediately when CMOD[1:0] =3D 2b'00 (counter disabled).
+	 */
+	do_div(tmp, NSEC_PER_SEC);
+	period_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, 1 << div)
+			& PWM_IMX_TPM_MOD_MOD_MASK;
+	writel(period_cnt, tpm->base + PWM_IMX_TPM_MOD);
+
+	/* restore the clock mode */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val |=3D saved_cmod;
+	writel(val, tpm->base + PWM_IMX_TPM_SC);
+
+	return 0;
+}
+
+static void pwm_imx_tpm_config(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       u32 period,
+			       u32 duty_cycle,
+			       enum pwm_polarity polarity)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 duty_cnt, val;
+	u64 tmp;
+
+	/* set duty counter */
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD_MASK;
+	tmp *=3D duty_cycle;
+	duty_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, period);
+	writel(duty_cnt & PWM_IMX_TPM_MOD_MOD_MASK,
+		 tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
+
+	/* set polarity */
+	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+	val &=3D ~(PWM_IMX_TPM_CnSC_ELSnB | PWM_IMX_TPM_CnSC_ELSnA |
+		 PWM_IMX_TPM_CnSC_MSnA);
+	val |=3D PWM_IMX_TPM_CnSC_MSnB;
+	val |=3D polarity ? PWM_IMX_TPM_CnSC_ELSnA : PWM_IMX_TPM_CnSC_ELSnB;
+	/*
+	 * polarity settings will enabled/disable output statue
+	 * immediately, so here ONLY save the config and will be
+	 * written into register when channel is enabled/disabled.
+	 */
+	tpm->chn_config[pwm->hwpwm] =3D val;
+}
+
+static void pwm_imx_tpm_enable(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       bool enable)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 val, i;
+
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	if (enable) {
+		/* restore channel config */
+		writel(tpm->chn_config[pwm->hwpwm],
+			tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+
+		/* start TPM counter anyway */
+		val |=3D PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
+		writel(val, tpm->base + PWM_IMX_TPM_SC);
+	} else {
+		/*
+		 * When a channel is disabled, its polarity settings will be
+		 * saved and its output will be disabled by clearing polarity
+		 * setting, when channel is enabled, polarity settings will be
+		 * restored and output will be enabled again.
+		 */
+		/* save channel config */
+		tpm->chn_config[pwm->hwpwm] =3D readl(tpm->base +
+			PWM_IMX_TPM_CnSC(pwm->hwpwm));
+		/* disable channel */
+		writel(PWM_IMX_TPM_CnSC_CHF,
+			tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+
+		for (i =3D 0; i < chip->npwm; i++)
+			if (i !=3D pwm->hwpwm && tpm->chn_status[i])
+				break;
+		if (i =3D=3D chip->npwm) {
+			/* stop TPM counter since all channels are disabled */
+			val &=3D ~PWM_IMX_TPM_SC_CMOD;
+			writel(val, tpm->base + PWM_IMX_TPM_SC);
+		}
+	}
+
+	/* update channel statue */
+	tpm->chn_status[pwm->hwpwm] =3D enable;
+}
+
+static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u64 tmp;
+	u32 val, rate;
+
+	mutex_lock(&tpm->lock);
+
+	/* get period */
+	rate =3D clk_get_rate(tpm->clk);
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD);
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val &=3D PWM_IMX_TPM_SC_PS_MASK;
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get duty cycle */
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get polarity */
+	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+	if (val & PWM_IMX_TPM_CnSC_ELSnA)
+		state->polarity =3D PWM_POLARITY_INVERSED;
+	else
+		state->polarity =3D PWM_POLARITY_NORMAL;
+
+	/* get channel status */
+	state->enabled =3D tpm->chn_status[pwm->hwpwm] ? true : false;
+
+	mutex_unlock(&tpm->lock);
+}
+
+static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
+			     struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	struct pwm_state curstate;
+	u32 duty_cycle =3D state->duty_cycle;
+	int ret;
+
+	pwm_imx_tpm_get_state(chip, pwm, &curstate);
+
+	mutex_lock(&tpm->lock);
+
+	if (state->period !=3D curstate.period) {
+		/*
+		 * TPM counter is shared by multiple channels, so
+		 * the prescale and period can NOT be modified when
+		 * there are multiple channels used.
+		 */
+		if (tpm->user_count !=3D 1)
+			return -EBUSY;
+		ret =3D pwm_imx_tpm_config_counter(chip, state->period);
+		if (ret)
+			return ret;
+	}
+
+	if (!state->enabled)
+		duty_cycle =3D 0;
+
+	if (state->duty_cycle !=3D curstate.duty_cycle ||
+	    state->polarity !=3D curstate.polarity)
+		pwm_imx_tpm_config(chip, pwm,
+			state->period, duty_cycle, state->polarity);
+
+	if (state->enabled !=3D curstate.enabled)
+		pwm_imx_tpm_enable(chip, pwm, state->enabled);
+
+	mutex_unlock(&tpm->lock);
+
+	return 0;
+}
+
+static int pwm_imx_tpm_request(struct pwm_chip *chip, struct pwm_device *d=
ev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+
+	mutex_lock(&tpm->lock);
+	tpm->user_count++;
+	mutex_unlock(&tpm->lock);
+
+	return 0;
+}
+
+static void pwm_imx_tpm_free(struct pwm_chip *chip, struct pwm_device *dev=
)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+
+	mutex_lock(&tpm->lock);
+	tpm->user_count--;
+	mutex_unlock(&tpm->lock);
+}
+
+static const struct pwm_ops imx_tpm_pwm_ops =3D {
+	.get_state =3D pwm_imx_tpm_get_state,
+	.request =3D pwm_imx_tpm_request,
+	.apply =3D pwm_imx_tpm_apply,
+	.free =3D pwm_imx_tpm_free,
+	.owner =3D THIS_MODULE,
+};
+
+static int pwm_imx_tpm_probe(struct platform_device *pdev)
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
+	tpm->chip.npwm =3D PWM_IMX_TPM_MAX_CHANNEL_NUM;
+
+	mutex_init(&tpm->lock);
+
+	ret =3D pwmchip_add(&tpm->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+		clk_disable_unprepare(tpm->clk);
+	}
+
+	return ret;
+}
+
+static int pwm_imx_tpm_remove(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return pwmchip_remove(&tpm->chip);
+}
+
+static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
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
+			 pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
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
+	.probe	=3D pwm_imx_tpm_probe,
+	.remove =3D pwm_imx_tpm_remove,
+};
+module_platform_driver(imx_tpm_pwm_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("i.MX TPM PWM Driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4
