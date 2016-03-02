From: Lee Jones <lee.jones@linaro.org>
Subject: [RESEND 08/11] pwm: sti: Add support for PWM Capture IRQs
Date: Wed,  2 Mar 2016 15:32:06 +0000
Message-ID: <1456932729-9667-9-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35708 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbcCBPeX (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Mar 2016 10:34:23 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so91157263wml.0
        for <linux-pwm@vger.kernel.org>; Wed, 02 Mar 2016 07:34:23 -0800 (PST)
In-Reply-To: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Here we're requesting the PWM Capture IRQ and supplying the
handler which will be called in the event of an IRQ fire to
handle it.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index fca692a..82a69e4 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -94,7 +95,9 @@ struct sti_pwm_chip {
 	struct regmap_field *prescale_low;
 	struct regmap_field *prescale_high;
 	struct regmap_field *pwm_out_en;
+	struct regmap_field *pwm_cpt_en;
 	struct regmap_field *pwm_cpt_int_en;
+	struct regmap_field *pwm_cpt_int_stat;
 	struct pwm_chip chip;
 	struct pwm_device *cur;
 	unsigned long configured;
@@ -314,6 +317,74 @@ static const struct pwm_ops sti_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static irqreturn_t sti_pwm_interrupt(int irq, void *data)
+{
+	struct sti_pwm_chip *pc = data;
+	struct device *dev = pc->dev;
+	struct sti_cpt_data *d;
+	int channel;
+	int cpt_int_stat;
+	int reg;
+	int ret = IRQ_NONE;
+
+	ret = regmap_field_read(pc->pwm_cpt_int_stat, &cpt_int_stat);
+	if (ret)
+		return ret;
+
+	while (cpt_int_stat) {
+		channel = ffs(cpt_int_stat) - 1;
+
+		d = pc->cpt_data[channel];
+
+		/*
+		 * Capture input:
+		 *    _______                   _______
+		 *   |       |                 |       |
+		 * __|       |_________________|       |________
+		 *   ^0      ^1                ^2
+		 *
+		 * Capture start by the first available rising edge
+		 * When a capture event occurs, capture value (CPT_VALx)
+		 * is stored, index incremented, capture edge changed.
+		 *
+		 * After the capture, if the index > 1, we have collected
+		 * the necessary data so we signal the thread waiting for it
+		 * and disable the capture by setting capture edge to none
+		 *
+		 */
+
+		regmap_read(pc->regmap,
+			    PWM_CPT_VAL(channel), &d->snapshot[d->index]);
+
+		switch (d->index) {
+		case 0:
+		case 1:
+			regmap_read(pc->regmap, PWM_CPT_EDGE(channel), &reg);
+			reg ^= PWM_CPT_EDGE_MASK;
+			regmap_write(pc->regmap, PWM_CPT_EDGE(channel), reg);
+
+			d->index++;
+			break;
+		case 2:
+			regmap_write(pc->regmap,
+				     PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
+			wake_up(&d->wait);
+			break;
+		default:
+			dev_err(dev, "Internal error\n");
+		}
+
+		clear_bit(channel, (unsigned long int *)&cpt_int_stat);
+
+		ret = IRQ_HANDLED;
+	}
+
+	/* Just ACK everything */
+	regmap_write(pc->regmap, PWM_INT_ACK, PWM_INT_ACK_MASK);
+
+	return ret;
+}
+
 static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 {
 	struct device *dev = pc->dev;
@@ -354,6 +425,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	if (IS_ERR(pc->pwm_cpt_int_en))
 		return PTR_ERR(pc->pwm_cpt_int_en);
 
+	pc->pwm_cpt_int_stat = devm_regmap_field_alloc(dev, pc->regmap,
+						reg_fields[PWM_CPT_INT_STAT]);
+	if (IS_ERR(pc->pwm_cpt_int_stat))
+		return PTR_ERR(pc->pwm_cpt_int_stat);
+
 	return 0;
 }
 
@@ -371,7 +447,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	struct sti_pwm_chip *pc;
 	struct resource *res;
 	unsigned int chan;
-	int ret;
+	int ret, irq;
 
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
@@ -392,6 +468,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regmap))
 		return PTR_ERR(pc->regmap);
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
+		return -ENODEV;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt,
+			       0, pdev->name, (void *) pc);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ\n");
+		return ret;
+	}
+
 	/*
 	 * Setup PWM data with default values: some values could be replaced
 	 * with specific ones provided from Device Tree.
-- 
1.9.1
