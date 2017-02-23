From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] drivers: pwm: pwm-atmel: add support to allow run time changing of pwm parameters
Date: Thu, 23 Feb 2017 10:38:40 +0200
Message-ID: <1487839120-13650-3-git-send-email-claudiu.beznea@microchip.com>
References: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtpout.microchip.com ([198.175.253.82]:30522 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751298AbdBWInI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Feb 2017 03:43:08 -0500
In-Reply-To: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Claudiu Beznea <claudiu.beznea@microchip.com>

sama5d2 supports changing of pwm parameters like period and
duty factor without first to disable pwm. Since pwm code
is supported by more than one SoC add allow_runtime_cfg
parameter to atmel_pwm_chip data structure. This will be
filled statically for every SoC, saved in pwm specific
structure at probing time and checked while configuring
the device. Based on this, pwm clock will not be
enabled/disabled while configuring if it still enabled.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 4406639..9e1dece 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -68,6 +68,8 @@ struct atmel_pwm_chip {
 
 	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
 		       unsigned long dty, unsigned long prd);
+
+	bool allow_runtime_cfg;
 };
 
 static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
@@ -114,7 +116,8 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 val;
 	int ret;
 
-	if (pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
+	if (!atmel_pwm->allow_runtime_cfg &&
+	    pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
 		dev_err(chip->dev, "cannot change PWM period while enabled\n");
 		return -EBUSY;
 	}
@@ -139,10 +142,12 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, period_ns);
 	dty = prd - div;
 
-	ret = clk_enable(atmel_pwm->clk);
-	if (ret) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return ret;
+	if (!pwm_is_enabled(pwm)) {
+		ret = clk_enable(atmel_pwm->clk);
+		if (ret) {
+			dev_err(chip->dev, "failed to enable PWM clock\n");
+			return ret;
+		}
 	}
 
 	/* It is necessary to preserve CPOL, inside CMR */
@@ -155,7 +160,9 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
 	mutex_unlock(&atmel_pwm->isr_lock);
 
-	clk_disable(atmel_pwm->clk);
+	if (!pwm_is_enabled(pwm))
+		clk_disable(atmel_pwm->clk);
+
 	return ret;
 }
 
@@ -294,18 +301,22 @@ static const struct pwm_ops atmel_pwm_ops = {
 struct atmel_pwm_data {
 	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
 		       unsigned long dty, unsigned long prd);
+	bool allow_runtime_cfg;
 };
 
 static const struct atmel_pwm_data atmel_pwm_data_v1 = {
 	.config = atmel_pwm_config_v1,
+	.allow_runtime_cfg = false,
 };
 
 static const struct atmel_pwm_data atmel_pwm_data_v2 = {
 	.config = atmel_pwm_config_v2,
+	.allow_runtime_cfg = false,
 };
 
 static const struct atmel_pwm_data atmel_pwm_data_v3 = {
 	.config = atmel_pwm_config_v3,
+	.allow_runtime_cfg = true,
 };
 
 static const struct platform_device_id atmel_pwm_devtypes[] = {
@@ -399,6 +410,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.npwm = 4;
 	atmel_pwm->chip.can_sleep = true;
 	atmel_pwm->config = data->config;
+	atmel_pwm->allow_runtime_cfg = data->allow_runtime_cfg;
 	atmel_pwm->updated_pwms = 0;
 	mutex_init(&atmel_pwm->isr_lock);
 
-- 
2.7.4
