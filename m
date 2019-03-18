From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V5 2/5] pwm: Add i.MX TPM PWM driver support
Date: Mon, 18 Mar 2019 07:41:42 +0000
Message-ID: <1552894581-3391-3-git-send-email-Anson.Huang@nxp.com>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "stefan@agner.ch" <stefan@agner.ch>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kern>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, add TPM PWM driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V4:
	- improve register read/write using bit field operations;
	- correct some logic issue;
	- ONLY disable clock when PWM is NOT in use during suspend;
	- add some comments for PWM mode settings;
	- fix some spelling errors;
	- reading channel number from register instead of using fix value.
---
 drivers/pwm/Kconfig       |  11 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 436 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 448 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 54f8238..3ea0391 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -210,6 +210,17 @@ config PWM_IMX27
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx27.
=20
+config PWM_IMX_TPM
+	tristate "i.MX TPM PWM support"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
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
index 448825e..c368599 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
+obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
 obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
new file mode 100644
index 0000000..12cb16c
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,436 @@
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
+#include <linux/bitfield.h>
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
+#define PWM_IMX_TPM_PARAM	0x4
+#define PWM_IMX_TPM_GLOBAL	0x8
+#define PWM_IMX_TPM_SC		0x10
+#define PWM_IMX_TPM_CNT		0x14
+#define PWM_IMX_TPM_MOD		0x18
+#define PWM_IMX_TPM_C0SC	0x20
+#define PWM_IMX_TPM_C0V		0x24
+
+#define PWM_IMX_TPM_PARAM_CHAN			GENMASK(7, 0)
+
+#define PWM_IMX_TPM_SC_PS			GENMASK(2, 0)
+#define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
+#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK	BIT(3)
+#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
+
+#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
+#define PWM_IMX_TPM_CnSC_MSB	BIT(5)
+#define PWM_IMX_TPM_CnSC_MSA	BIT(4)
+#define PWM_IMX_TPM_CnSC_ELSB	BIT(3)
+#define PWM_IMX_TPM_CnSC_ELSA	BIT(2)
+
+#define PWM_IMX_TPM_MOD_MOD	GENMASK(15, 0)
+
+#define PWM_IMX_TPM_MAX_COUNT		0xffff
+
+#define PWM_IMX_TPM_MAX_CHANNEL_NUM	6
+
+#define PWM_IMX_TPM_CnSC(n)	(PWM_IMX_TPM_C0SC + (n) * 0x8)
+#define PWM_IMX_TPM_CnV(n)	(PWM_IMX_TPM_C0V + (n) * 0x8)
+
+struct imx_tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	struct mutex lock;
+	u32 user_count;
+	u32 enable_count;
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
+	if (val <=3D PWM_IMX_TPM_MAX_COUNT)
+		div =3D 0;
+	else
+		div =3D ilog2(roundup_pow_of_two(val /
+			(PWM_IMX_TPM_MAX_COUNT + 1)));
+	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, div))) {
+		dev_err(chip->dev,
+			"failed to find valid prescale value!\n");
+		return -EINVAL;
+	}
+
+	/* make sure counter is disabled for programming prescale */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	saved_cmod =3D FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
+	if (saved_cmod) {
+		val &=3D ~PWM_IMX_TPM_SC_CMOD;
+		writel(val, tpm->base + PWM_IMX_TPM_SC);
+	}
+
+	/* set TPM counter prescale */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val &=3D ~PWM_IMX_TPM_SC_PS;
+	val |=3D FIELD_PREP(PWM_IMX_TPM_SC_PS, div);
+	writel(val, tpm->base + PWM_IMX_TPM_SC);
+
+	/*
+	 * set period counter: according to RM, the MOD register is
+	 * updated immediately after CMOD[1:0] =3D 2b'00 above
+	 */
+	do_div(tmp, NSEC_PER_SEC);
+	period_cnt =3D (tmp + ((1 << div) >> 1)) >> div;
+	if (period_cnt > PWM_IMX_TPM_MOD_MOD) {
+		dev_err(chip->dev,
+			"failed to find valid period count!\n");
+		return -EINVAL;
+	}
+	writel(period_cnt, tpm->base + PWM_IMX_TPM_MOD);
+
+	/* restore the clock mode if necessary */
+	if (saved_cmod) {
+		val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+		val |=3D FIELD_PREP(PWM_IMX_TPM_SC_CMOD, saved_cmod);
+		writel(val, tpm->base + PWM_IMX_TPM_SC);
+	}
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
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD;
+	tmp *=3D duty_cycle;
+	duty_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, period);
+	writel(duty_cnt & PWM_IMX_TPM_MOD_MOD,
+	       tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
+
+	/*
+	 * set polarity (for edge-aligned PWM modes)
+	 *
+	 * CPWMS  MSB:MSA  ELSB:ELSA  Mode  Configuration
+	 * 0	  10	   10	      PWM   High-true pulse
+	 * 0	  10	   00	      PWM   Reserved
+	 * 0	  10	   01	      PWM   Low-true pulse
+	 * 0	  10	   11	      PWM   Reserved
+	 *
+	 * High-true pulse: clear output on counter match, set output on
+	 * counter reload, set output when counter first enabled or paused.
+	 *
+	 * Low-true pulse: set output on counter match, clear output on
+	 * counter reload, clear output when counter first enabled or paused.
+	 */
+
+	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+	val &=3D ~(PWM_IMX_TPM_CnSC_ELSB | PWM_IMX_TPM_CnSC_ELSA |
+		 PWM_IMX_TPM_CnSC_MSA);
+	val |=3D PWM_IMX_TPM_CnSC_MSB;
+	val |=3D (polarity =3D=3D PWM_POLARITY_NORMAL) ?
+		PWM_IMX_TPM_CnSC_ELSB : PWM_IMX_TPM_CnSC_ELSA;
+	/*
+	 * polarity settings will enabled/disable output status
+	 * immediately, so here ONLY save the config and write
+	 * it into register when channel is enabled/disabled.
+	 */
+	tpm->chn_config[pwm->hwpwm] =3D val;
+}
+
+/*
+ * When a channel's polarity is configured, the polarity settings
+ * will be saved and ONLY write into the register when the channel
+ * is enabled.
+ *
+ * When a channel is disabled, its polarity settings will be saved
+ * and its output will be disabled by clearing polarity settings.
+ *
+ * when a channel is enabled, its polarity settings will be restored
+ * and output will be enabled again.
+ */
+static void pwm_imx_tpm_enable(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       bool enable)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 val;
+
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	if (enable) {
+		/* restore channel config */
+		writel(tpm->chn_config[pwm->hwpwm],
+		       tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+
+		if (++tpm->enable_count =3D=3D 1) {
+			/* start TPM counter */
+			val |=3D PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
+			writel(val, tpm->base + PWM_IMX_TPM_SC);
+		}
+	} else {
+		/* disable channel */
+		val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+		val &=3D ~(PWM_IMX_TPM_CnSC_MSA | PWM_IMX_TPM_CnSC_MSB |
+			 PWM_IMX_TPM_CnSC_ELSB | PWM_IMX_TPM_CnSC_ELSA);
+		writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+
+		if (--tpm->enable_count =3D=3D 0) {
+			/* stop TPM counter since all channels are disabled */
+			val &=3D ~PWM_IMX_TPM_SC_CMOD;
+			writel(val, tpm->base + PWM_IMX_TPM_SC);
+		}
+	}
+
+	/* update channel status */
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
+	/* get period */
+	rate =3D clk_get_rate(tpm->clk);
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD);
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val &=3D PWM_IMX_TPM_SC_PS;
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
+	if (val & PWM_IMX_TPM_CnSC_ELSA)
+		state->polarity =3D PWM_POLARITY_INVERSED;
+	else
+		state->polarity =3D PWM_POLARITY_NORMAL;
+
+	/* get channel status */
+	state->enabled =3D tpm->chn_status[pwm->hwpwm] ? true : false;
+}
+
+static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
+			     struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	struct pwm_state curstate;
+	int ret;
+
+	mutex_lock(&tpm->lock);
+
+	pwm_imx_tpm_get_state(chip, pwm, &curstate);
+
+	if (state->period !=3D curstate.period) {
+		/*
+		 * TPM counter is shared by multiple channels, so
+		 * prescale and period can NOT be modified when
+		 * there are multiple channels in use.
+		 */
+		if (tpm->user_count !=3D 1)
+			return -EBUSY;
+		ret =3D pwm_imx_tpm_config_counter(chip, state->period);
+		if (ret)
+			return ret;
+	}
+
+	if (state->enabled =3D=3D false) {
+		/*
+		 * if eventually the PWM output is LOW, either
+		 * duty cycle is 0 or status is disabled, need
+		 * to make sure the output pin is LOW.
+		 */
+		pwm_imx_tpm_config(chip, pwm, state->period,
+				   0, state->polarity);
+		if (curstate.enabled)
+			pwm_imx_tpm_enable(chip, pwm, false);
+	} else {
+		pwm_imx_tpm_config(chip, pwm, state->period,
+				   state->duty_cycle, state->polarity);
+		if (!curstate.enabled)
+			pwm_imx_tpm_enable(chip, pwm, true);
+	}
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
+	.request =3D pwm_imx_tpm_request,
+	.free =3D pwm_imx_tpm_free,
+	.get_state =3D pwm_imx_tpm_get_state,
+	.apply =3D pwm_imx_tpm_apply,
+	.owner =3D THIS_MODULE,
+};
+
+static int pwm_imx_tpm_probe(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm;
+	int ret;
+	u32 val;
+
+	tpm =3D devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	if (!tpm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, tpm);
+
+	tpm->base =3D devm_platform_ioremap_resource(pdev, 0);
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
+	/* get channel number */
+	val =3D readl(tpm->base + PWM_IMX_TPM_PARAM);
+	tpm->chip.npwm =3D FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
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
+	int ret =3D pwmchip_remove(&tpm->chip);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return ret;
+}
+
+static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+
+	if (tpm->enable_count =3D=3D 0)
+		clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+	int ret =3D 0;
+
+	if (tpm->enable_count =3D=3D 0) {
+		ret =3D clk_prepare_enable(tpm->clk);
+		if (ret)
+			dev_err(dev,
+				"failed to prepare or enable clk %d\n",
+				ret);
+	}
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
