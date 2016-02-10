From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 06/11] pwm: sti: Supply PWM Capture clock handling
Date: Wed, 10 Feb 2016 13:02:23 +0000
Message-ID: <1455109348-32767-7-git-send-email-lee.jones@linaro.org>
References: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37708 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcBJNEm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2016 08:04:42 -0500
Received: by mail-wm0-f41.google.com with SMTP id g62so25825301wme.0
        for <linux-pwm@vger.kernel.org>; Wed, 10 Feb 2016 05:04:41 -0800 (PST)
In-Reply-To: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
Cc: kernel@stlinux.com, maxime.coquelin@st.com, Lee Jones <lee.jones@linaro.org>

ST's PWM IP is supplied by 2 different clocks.  One for PWM
Output and the other for Capture.  This patch provides clock
handling for the latter.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 2336bac..9e6b1c8 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -74,6 +74,7 @@ struct sti_pwm_compat_data {
 struct sti_pwm_chip {
 	struct device *dev;
 	struct clk *pwm_clk;
+	struct clk *cpt_clk;
 	struct regmap *regmap;
 	struct sti_pwm_compat_data *cdata;
 	struct regmap_field *prescale_low;
@@ -183,6 +184,10 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
+		ret = clk_enable(pc->cpt_clk);
+		if (ret)
+			return ret;
+
 		if (!period_same) {
 			ret = sti_pwm_get_prescale(pc, period_ns, &prescale);
 			if (ret)
@@ -227,6 +232,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 clk_dis:
 	clk_disable(pc->pwm_clk);
+	clk_disable(pc->cpt_clk);
 	return ret;
 }
 
@@ -246,6 +252,10 @@ static int sti_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		if (ret)
 			goto out;
 
+		ret = clk_enable(pc->cpt_clk);
+		if (ret)
+			goto out;
+
 		ret = regmap_field_write(pc->pwm_out_en, 1);
 		if (ret) {
 			dev_err(dev, "failed to enable PWM device:%d\n",
@@ -271,6 +281,7 @@ static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	regmap_field_write(pc->pwm_out_en, 0);
 
 	clk_disable(pc->pwm_clk);
+	clk_disable(pc->cpt_clk);
 	mutex_unlock(&pc->sti_pwm_lock);
 }
 
@@ -390,6 +401,18 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+	if (IS_ERR(pc->cpt_clk)) {
+		dev_err(dev, "failed to get PWM capture clock\n");
+		return PTR_ERR(pc->cpt_clk);
+	}
+
+	ret = clk_prepare(pc->cpt_clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare clock\n");
+		return ret;
+	}
+
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
@@ -399,6 +422,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		clk_unprepare(pc->pwm_clk);
+		clk_unprepare(pc->cpt_clk);
 		return ret;
 	}
 
@@ -416,6 +440,7 @@ static int sti_pwm_remove(struct platform_device *pdev)
 		pwm_disable(&pc->chip.pwms[i]);
 
 	clk_unprepare(pc->pwm_clk);
+	clk_unprepare(pc->cpt_clk);
 
 	return pwmchip_remove(&pc->chip);
 }
-- 
1.9.1
