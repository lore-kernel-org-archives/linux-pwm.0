From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V3 2/5] pwm: Add i.MX TPM PWM driver support
Date: Thu, 14 Mar 2019 06:27:20 +0000
Message-ID: <1552544534-5295-3-git-send-email-Anson.Huang@nxp.com>
References: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, add TPM PWM driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- Add "IMX_" as prefix to macro define as TPM is already used;
	- Use macro define for channel registers address instead of calculation in everywhere.
	- Add limitations statement in copyright.
---
 drivers/pwm/Kconfig       |  10 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 343 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..c1cbb43 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -201,6 +201,16 @@ config PWM_IMX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx.
 
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
@@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
+obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
new file mode 100644
index 0000000..cdb29f6
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 NXP.
+ *
+ * Limitations:
+ * - The TPM counter and period counter are shared between
+ *   multiple channels, so all channels should use same period
+ *   settings.
+ * - When a channel is disabled, its polarity settings will be
+ *   saved and its output will be disabled by clearing polarity
+ *   setting, when channel is enabled, polarity settings will be
+ *   restored and output will be enabled again.
+ * - ONLY when all channels are disabled, then TPM counter will
+ *   be disabled.
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
+#define IMX_TPM_GLOBAL		0x8
+#define IMX_TPM_SC		0x10
+#define IMX_TPM_CNT		0x14
+#define IMX_TPM_MOD		0x18
+#define IMX_TPM_C0SC		0x20
+#define IMX_TPM_C0V		0x24
+
+#define IMX_TPM_SC_CMOD_SHIFT	3
+#define IMX_TPM_SC_CMOD_MASK	GENMASK(4, 3)
+#define IMX_TPM_SC_CPWMS	BIT(5)
+
+#define IMX_TPM_CnSC_CHF	BIT(7)
+#define IMX_TPM_CnSC_MSnB	BIT(5)
+#define IMX_TPM_CnSC_MSnA	BIT(4)
+#define IMX_TPM_CnSC_ELSnB	BIT(3)
+#define IMX_TPM_CnSC_ELSnA	BIT(2)
+
+#define IMX_TPM_SC_PS_MASK	0x7
+#define IMX_TPM_MOD_MOD_MASK	0xffff
+
+#define IMX_TPM_COUNT_MAX	0xffff
+
+#define IMX_TPM_DEFAULT_PWM_CHANNEL_NUM	2
+
+#define IMX_TPM_CnSC(n)	(IMX_TPM_C0SC + n * 0x8)
+#define IMX_TPM_CnV(n)	(IMX_TPM_C0V + n * 0x8)
+
+struct imx_tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	spinlock_t lock;
+	u32 chn_config[IMX_TPM_DEFAULT_PWM_CHANNEL_NUM];
+	bool chn_status[IMX_TPM_DEFAULT_PWM_CHANNEL_NUM];
+};
+
+#define to_imx_tpm_pwm_chip(_chip)	container_of(_chip, struct imx_tpm_pwm_chip, chip)
+
+static void imx_tpm_pwm_config_counter(struct pwm_chip *chip, u32 period)
+{
+	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
+	unsigned int period_cnt;
+	u32 val, div;
+	u64 tmp;
+
+	tmp = clk_get_rate(tpm->clk);
+	tmp *= period;
+	val = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	if (val < IMX_TPM_COUNT_MAX)
+		div = 0;
+	else
+		div = ilog2(roundup_pow_of_two(val / IMX_TPM_COUNT_MAX));
+	if (div > IMX_TPM_SC_PS_MASK) {
+		dev_err(chip->dev,
+			"failed to find valid prescale value!\n");
+		return;
+	}
+	/* set TPM counter prescale */
+	val = readl(tpm->base + IMX_TPM_SC);
+	val &= ~IMX_TPM_SC_PS_MASK;
+	val |= div;
+	writel(val, tpm->base + IMX_TPM_SC);
+
+	/* set period counter */
+	do_div(tmp, NSEC_PER_SEC);
+	period_cnt = DIV_ROUND_CLOSEST_ULL(tmp, 1 << div);
+	writel(period_cnt & IMX_TPM_MOD_MOD_MASK, tpm->base + IMX_TPM_MOD);
+}
+
+static void imx_tpm_pwm_config(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
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
+		tpm_cnt_initialized = true;
+	}
+
+	/* set duty counter */
+	tmp = readl(tpm->base + IMX_TPM_MOD) & IMX_TPM_MOD_MOD_MASK;
+	tmp *= state->duty_cycle;
+	duty_cnt = DIV_ROUND_CLOSEST_ULL(tmp, state->period);
+	writel(duty_cnt & IMX_TPM_MOD_MOD_MASK,
+		 tpm->base + IMX_TPM_CnV(pwm->hwpwm));
+
+	/* set polarity */
+	val = readl(tpm->base + IMX_TPM_CnSC(pwm->hwpwm));
+	val &= ~(IMX_TPM_CnSC_ELSnB | IMX_TPM_CnSC_ELSnA | IMX_TPM_CnSC_MSnA);
+	val |= IMX_TPM_CnSC_MSnB;
+	val |= state->polarity ? IMX_TPM_CnSC_ELSnA : IMX_TPM_CnSC_ELSnB;
+	/*
+	 * polarity settings will enabled/disable output statue
+	 * immediately, so here ONLY save the config and will be
+	 * written into register when channel is enabled/disabled.
+	 */
+	tpm->chn_config[pwm->hwpwm] = val;
+}
+
+static void imx_tpm_pwm_enable(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       bool enable)
+{
+	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
+	u32 val, i;
+
+	val = readl(tpm->base + IMX_TPM_SC);
+	if (enable) {
+		/* restore channel config */
+		writel(tpm->chn_config[pwm->hwpwm],
+			tpm->base + IMX_TPM_CnSC(pwm->hwpwm));
+
+		/* start TPM counter anyway */
+		val |= 0x1 << IMX_TPM_SC_CMOD_SHIFT;
+		writel(val, tpm->base + IMX_TPM_SC);
+	} else {
+		/* save channel config */
+		tpm->chn_config[pwm->hwpwm] = readl(tpm->base +
+			IMX_TPM_CnSC(pwm->hwpwm));
+		/* disable channel */
+		writel(IMX_TPM_CnSC_CHF, tpm->base + IMX_TPM_CnSC(pwm->hwpwm));
+
+		for (i = 0; i < chip->npwm; i++)
+			if (i != pwm->hwpwm && tpm->chn_status[i])
+				break;
+		if (i == chip->npwm) {
+			/* stop TPM counter since all channels are disabled */
+			val &= ~IMX_TPM_SC_CMOD_MASK;
+			writel(val, tpm->base + IMX_TPM_SC);
+		}
+	}
+
+	/* update channel statue */
+	tpm->chn_status[pwm->hwpwm] = enable;
+}
+
+static void imx_tpm_pwm_get_state(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
+	unsigned long rate, flags;
+	u64 tmp;
+	u32 val;
+
+	spin_lock_irqsave(&tpm->lock, flags);
+
+	/* get period */
+	rate = clk_get_rate(tpm->clk);
+	tmp = readl(tpm->base + IMX_TPM_MOD);
+	val = readl(tpm->base + IMX_TPM_SC);
+	val &= IMX_TPM_SC_PS_MASK;
+	tmp *= (1 << val) * NSEC_PER_SEC;
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get duty cycle */
+	tmp = readl(tpm->base + IMX_TPM_CnV(pwm->hwpwm));
+	tmp *= (1 << val) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get polarity */
+	val = readl(tpm->base + IMX_TPM_CnSC(pwm->hwpwm));
+	if (val & IMX_TPM_CnSC_ELSnA)
+		state->polarity = PWM_POLARITY_INVERSED;
+	else
+		state->polarity = PWM_POLARITY_NORMAL;
+
+	/* get channel status */
+	state->enabled = tpm->chn_status[pwm->hwpwm] ? true : false;
+
+	spin_unlock_irqrestore(&tpm->lock, flags);
+}
+
+static int imx_tpm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
+	struct pwm_state curstate;
+	unsigned long flags;
+
+	imx_tpm_pwm_get_state(chip, pwm, &curstate);
+
+	spin_lock_irqsave(&tpm->lock, flags);
+
+	if (state->period != curstate.period ||
+	    state->duty_cycle != curstate.duty_cycle ||
+	    state->polarity != curstate.polarity)
+		imx_tpm_pwm_config(chip, pwm, state);
+
+	if (state->enabled != curstate.enabled)
+		imx_tpm_pwm_enable(chip, pwm, state->enabled);
+
+	spin_unlock_irqrestore(&tpm->lock, flags);
+
+	return 0;
+}
+
+static const struct pwm_ops imx_tpm_pwm_ops = {
+	.get_state = imx_tpm_pwm_get_state,
+	.apply = imx_tpm_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static int imx_tpm_pwm_probe(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm;
+	struct resource *res;
+	int ret;
+
+	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	if (!tpm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, tpm);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tpm->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tpm->base)) {
+		ret = PTR_ERR(tpm->base);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "pwm ioremap failed %d\n", ret);
+		return ret;
+	}
+
+	tpm->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tpm->clk)) {
+		ret = PTR_ERR(tpm->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get pwm clk %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(tpm->clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to prepare or enable clk %d\n", ret);
+		return ret;
+	}
+
+	tpm->chip.dev = &pdev->dev;
+	tpm->chip.ops = &imx_tpm_pwm_ops;
+	tpm->chip.base = -1;
+	tpm->chip.npwm = IMX_TPM_DEFAULT_PWM_CHANNEL_NUM;
+
+	spin_lock_init(&tpm->lock);
+
+	ret = pwmchip_add(&tpm->chip);
+	if (ret)
+		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+
+	return ret;
+}
+
+static int imx_tpm_pwm_remove(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&tpm->chip);
+}
+
+static int __maybe_unused imx_tpm_pwm_suspend(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused imx_tpm_pwm_resume(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
+	int ret = clk_prepare_enable(tpm->clk);
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
+static const struct of_device_id imx_tpm_pwm_dt_ids[] = {
+	{ .compatible = "fsl,imx-tpm-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_tpm_pwm_dt_ids);
+
+static struct platform_driver imx_tpm_pwm_driver = {
+	.driver = {
+		.name = "imx-tpm-pwm",
+		.of_match_table = imx_tpm_pwm_dt_ids,
+		.pm = &imx_tpm_pwm_pm,
+	},
+	.probe	= imx_tpm_pwm_probe,
+	.remove = imx_tpm_pwm_remove,
+};
+module_platform_driver(imx_tpm_pwm_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("i.MX TPM PWM Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
