From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume functions
Date: Mon, 10 Apr 2017 17:20:20 +0300
Message-ID: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63600 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdDJOUd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Apr 2017 10:20:33 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com
Cc: nicolas.ferre@microchip.com, claudiu.beznea@microchip.com

Implement suspend and resume power management specific
function to allow PWM controller to correctly suspend
and resume.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc..75177c6 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -58,6 +58,8 @@
 #define PWM_MAX_PRD		0xFFFF
 #define PRD_MAX_PRES		10
 
+#define PWM_MAX_CH_NUM		(4)
+
 struct atmel_pwm_registers {
 	u8 period;
 	u8 period_upd;
@@ -65,11 +67,18 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
 
+struct atmel_pwm_pm_ctx {
+	u32 cmr;
+	u32 cdty;
+	u32 cprd;
+};
+
 struct atmel_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	const struct atmel_pwm_registers *regs;
+	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];
 
 	unsigned int updated_pwms;
 	/* ISR is cleared when read, ensure only one thread does that */
@@ -333,6 +342,77 @@ atmel_pwm_get_driver_data(struct platform_device *pdev)
 	return (struct atmel_pwm_registers *)id->driver_data;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int atmel_pwm_suspend(struct device *dev)
+{
+	struct atmel_pwm_chip *atmel_pwm = dev_get_drvdata(dev);
+	struct pwm_device *pwm = atmel_pwm->chip.pwms;
+	int i;
+	bool disable_clk = false;
+
+	for (i = 0; i < atmel_pwm->chip.npwm; i++, pwm++) {
+		if (!pwm_is_enabled(pwm))
+			continue;
+
+		disable_clk = true;
+		atmel_pwm->ctx[i].cdty =
+			atmel_pwm_ch_readl(atmel_pwm, i,
+					   atmel_pwm->regs->duty);
+		atmel_pwm->ctx[i].cprd =
+			atmel_pwm_ch_readl(atmel_pwm, i,
+					   atmel_pwm->regs->period);
+		atmel_pwm->ctx[i].cmr =
+			atmel_pwm_ch_readl(atmel_pwm, i, PWM_CMR);
+
+		atmel_pwm_disable(&atmel_pwm->chip, pwm, false);
+	}
+
+	if (disable_clk)
+		clk_disable(atmel_pwm->clk);
+
+	return 0;
+}
+
+static int atmel_pwm_resume(struct device *dev)
+{
+	struct atmel_pwm_chip *atmel_pwm = dev_get_drvdata(dev);
+	struct pwm_device *pwm = atmel_pwm->chip.pwms;
+	int i, ret;
+	bool disable_clk = true;
+
+	ret = clk_enable(atmel_pwm->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	for (i = 0; i < atmel_pwm->chip.npwm; i++, pwm++) {
+		if (!pwm_is_enabled(pwm))
+			continue;
+
+		disable_clk = false;
+		atmel_pwm_ch_writel(atmel_pwm, i, PWM_CMR,
+				    atmel_pwm->ctx[i].cmr);
+		atmel_pwm_set_cprd_cdty(&atmel_pwm->chip, pwm,
+					atmel_pwm->ctx[i].cprd,
+					atmel_pwm->ctx[i].cdty);
+		mutex_lock(&atmel_pwm->isr_lock);
+		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
+		atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
+		mutex_unlock(&atmel_pwm->isr_lock);
+		atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
+	}
+
+	if (disable_clk)
+		clk_disable(atmel_pwm->clk);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(atmel_pwm_pm_ops,
+			 atmel_pwm_suspend, atmel_pwm_resume);
+
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	const struct atmel_pwm_registers *regs;
@@ -406,6 +486,7 @@ static struct platform_driver atmel_pwm_driver = {
 	.driver = {
 		.name = "atmel-pwm",
 		.of_match_table = of_match_ptr(atmel_pwm_dt_ids),
+		.pm = &atmel_pwm_pm_ops,
 	},
 	.id_table = atmel_pwm_devtypes,
 	.probe = atmel_pwm_probe,
-- 
2.7.4
