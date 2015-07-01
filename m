From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 13/15] pwm: rockchip: add support for atomic update
Date: Wed,  1 Jul 2015 10:21:59 +0200
Message-ID: <1435738921-25027-14-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34418 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750768AbbGAIWe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 04:22:34 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

Implement the ->apply() function to add support for atomic update.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-rockchip.c | 75 ++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 11e932d..cbe619bf 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -50,7 +50,8 @@ struct rockchip_pwm_data {
 	const struct pwm_ops *ops;
 
 	void (*set_enable)(struct pwm_chip *chip,
-			   struct pwm_device *pwm, bool enable);
+			   struct pwm_device *pwm, bool enable,
+			   enum pwm_polarity polarity);
 	void (*init)(struct pwm_chip *chip, struct pwm_device *pwm);
 };
 
@@ -60,7 +61,8 @@ static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
 }
 
 static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
-				       struct pwm_device *pwm, bool enable)
+				       struct pwm_device *pwm, bool enable,
+				       enum pwm_polarity polarity)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
@@ -88,14 +90,15 @@ static void rockchip_pwm_init_v1(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
-				       struct pwm_device *pwm, bool enable)
+				       struct pwm_device *pwm, bool enable,
+				       enum pwm_polarity polarity)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
 			  PWM_CONTINUOUS;
 	u32 val;
 
-	if (pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED)
+	if (polarity == PWM_POLARITY_INVERSED)
 		enable_conf |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
 	else
 		enable_conf |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
@@ -110,6 +113,26 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_init_v2(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
+			  PWM_CONTINUOUS;
+	u32 val;
+
+	val = readl(pc->base + pc->data->regs.ctrl);
+
+	if ((val & enable_conf) != enable_conf)
+		return;
+
+	pwm->state.enabled = true;
+
+	enable_conf = PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
+
+	if ((val & enable_conf) == enable_conf)
+		pwm->state.polarity = PWM_POLARITY_INVERSED;
+}
+
 static void rockchip_pwm_init_state(struct pwm_chip *chip,
 				    struct pwm_device *pwm)
 {
@@ -146,7 +169,6 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	unsigned long period, duty;
 	u64 clk_rate, div;
-	int ret;
 
 	clk_rate = clk_get_rate(pc->clk);
 
@@ -163,15 +185,8 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
 	duty = div;
 
-	ret = clk_enable(pc->clk);
-	if (ret)
-		return ret;
-
 	writel(period, pc->base + pc->data->regs.period);
 	writel(duty, pc->base + pc->data->regs.duty);
-	writel(0, pc->base + pc->data->regs.cntr);
-
-	clk_disable(pc->clk);
 
 	return 0;
 }
@@ -189,43 +204,51 @@ static int rockchip_pwm_set_polarity(struct pwm_chip *chip,
 	return 0;
 }
 
-static int rockchip_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	bool enabled = pwm_is_enabled(pwm);
 	int ret;
 
 	ret = clk_enable(pc->clk);
 	if (ret)
 		return ret;
 
-	pc->data->set_enable(chip, pwm, true);
+	if (state->polarity != pwm_get_polarity(pwm) && enabled) {
+		pc->data->set_enable(chip, pwm, false, state->polarity);
+		enabled = false;
+	}
 
-	return 0;
-}
+	ret = rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (ret) {
+		if (enabled != pwm_is_enabled(pwm))
+			pc->data->set_enable(chip, pwm, !enabled,
+					     state->polarity);
 
-static void rockchip_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+		goto out;
+	}
 
-	pc->data->set_enable(chip, pwm, false);
+	if (state->enabled != enabled)
+		pc->data->set_enable(chip, pwm, state->enabled,
+				     state->polarity);
 
+out:
 	clk_disable(pc->clk);
+
+	return ret;
 }
 
 static const struct pwm_ops rockchip_pwm_ops_v1 = {
 	.init_state = rockchip_pwm_init_state,
-	.config = rockchip_pwm_config,
-	.enable = rockchip_pwm_enable,
-	.disable = rockchip_pwm_disable,
+	.apply = rockchip_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
 static const struct pwm_ops rockchip_pwm_ops_v2 = {
 	.init_state = rockchip_pwm_init_state,
-	.config = rockchip_pwm_config,
+	.apply = rockchip_pwm_apply,
 	.set_polarity = rockchip_pwm_set_polarity,
-	.enable = rockchip_pwm_enable,
-	.disable = rockchip_pwm_disable,
 	.owner = THIS_MODULE,
 };
 
-- 
1.9.1
