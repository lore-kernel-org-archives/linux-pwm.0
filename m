From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v3 5/7] pwm: rockchip: Use same pwm ops for each IP
Date: Tue,  8 Aug 2017 23:41:28 +0800
Message-ID: <1502206888-24302-1-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:38057 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdHHPhF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2017 11:37:05 -0400
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

Just use the same pwm ops for each IP, and get rid of the
ops in the struct of rockchip_pwm_data, but still define
the 3 different rockchip_pwm_data to use common interface
for each IP.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/pwm/pwm-rockchip.c | 147 ++++++++++++---------------------------------
 1 file changed, 38 insertions(+), 109 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index fbd9c1a..a3fcb40 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -50,12 +50,7 @@ struct rockchip_pwm_data {
 	struct rockchip_pwm_regs regs;
 	unsigned int prescaler;
 	bool supports_polarity;
-	const struct pwm_ops *ops;
-
-	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
-			  struct pwm_state *state);
-	int (*pwm_apply)(struct pwm_chip *chip, struct pwm_device *pwm,
-			 struct pwm_state *state);
+	u32 enable_conf;
 };
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
@@ -63,45 +58,15 @@ static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
 	return container_of(c, struct rockchip_pwm_chip, chip);
 }
 
-static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
-				      struct pwm_device *pwm,
-				      struct pwm_state *state)
-{
-	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
-	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
-	u32 val;
-
-	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
-	if ((val & enable_conf) == enable_conf)
-		state->enabled = true;
-}
-
-static void rockchip_pwm_get_state_v2(struct pwm_chip *chip,
-				      struct pwm_device *pwm,
-				      struct pwm_state *state)
-{
-	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
-	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
-			  PWM_CONTINUOUS;
-	u32 val;
-
-	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
-	if ((val & enable_conf) != enable_conf)
-		return;
-
-	state->enabled = true;
-
-	if (!(val & PWM_DUTY_POSITIVE))
-		state->polarity = PWM_POLARITY_INVERSED;
-}
-
 static void rockchip_pwm_get_state(struct pwm_chip *chip,
 				   struct pwm_device *pwm,
 				   struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = pc->data->enable_conf;
 	unsigned long clk_rate;
 	u64 tmp;
+	u32 val;
 	int ret;
 
 	ret = clk_enable(pc->pclk);
@@ -116,9 +81,20 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 
 	tmp = readl_relaxed(pc->base + pc->data->regs.duty);
 	tmp *= pc->data->prescaler * NSEC_PER_SEC;
-	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+	state->duty_cycle =  DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
 
-	pc->data->get_state(chip, pwm, state);
+	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	if (pc->data->supports_polarity)
+		state->enabled = ((val & enable_conf) != enable_conf) ?
+				 false : true;
+	else
+		state->enabled = ((val & enable_conf) == enable_conf) ?
+				 true : false;
+
+	if (pc->data->supports_polarity) {
+		if (!(val & PWM_DUTY_POSITIVE))
+			state->polarity = PWM_POLARITY_INVERSED;
+	}
 
 	clk_disable(pc->pclk);
 }
@@ -161,10 +137,10 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int rockchip_pwm_enable(struct pwm_chip *chip,
 			       struct pwm_device *pwm,
-			       bool enable,
-			       u32 enable_conf)
+			       bool enable)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = pc->data->enable_conf;
 	int ret;
 	u32 val;
 
@@ -189,73 +165,35 @@ static int rockchip_pwm_enable(struct pwm_chip *chip,
 	return 0;
 }
 
-static int rockchip_pwm_apply_v1(struct pwm_chip *chip, struct pwm_device *pwm,
-				 struct pwm_state *state)
+static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
 {
-	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	struct pwm_state curstate;
 	bool enabled;
 	int ret = 0;
 
+	ret = clk_enable(pc->pclk);
+	if (ret)
+		return ret;
+
 	pwm_get_state(pwm, &curstate);
 	enabled = curstate.enabled;
 
 	if (state->polarity != curstate.polarity && enabled) {
-		ret = rockchip_pwm_enable(chip, pwm, false, enable_conf);
+		ret = rockchip_pwm_enable(chip, pwm, false);
 		if (ret)
-			return ret;
+			goto out;
 		enabled = false;
 	}
 
 	rockchip_pwm_config(chip, pwm, state);
-	if (state->enabled != enabled)
-		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-					  enable_conf);
-
-	return ret;
-}
-
-static int rockchip_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
-				 struct pwm_state *state)
-{
-	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
-		  PWM_CONTINUOUS;
-	struct pwm_state curstate;
-	bool enabled;
-	int ret = 0;
-
-	pwm_get_state(pwm, &curstate);
-	enabled = curstate.enabled;
-
-	if (state->polarity != curstate.polarity && enabled) {
-		ret = rockchip_pwm_enable(chip, pwm, false, enable_conf);
+	if (state->enabled != enabled) {
+		ret = rockchip_pwm_enable(chip, pwm, state->enabled);
 		if (ret)
-			return ret;
-		enabled = false;
+			goto out;
 	}
 
-	rockchip_pwm_config(chip, pwm, state);
-	if (state->enabled != enabled)
-		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-					  enable_conf);
-
-	return ret;
-}
-
-static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			      struct pwm_state *state)
-{
-	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
-	int ret;
-
-	ret = clk_enable(pc->pclk);
-	if (ret)
-		return ret;
-
-	ret = pc->data->pwm_apply(chip, pwm, state);
-	if (ret)
-		goto out;
-
 	/*
 	 * Update the state with the real hardware, which can differ a bit
 	 * because of period/duty_cycle approximation.
@@ -268,13 +206,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static const struct pwm_ops rockchip_pwm_ops_v1 = {
-	.get_state = rockchip_pwm_get_state,
-	.apply = rockchip_pwm_apply,
-	.owner = THIS_MODULE,
-};
-
-static const struct pwm_ops rockchip_pwm_ops_v2 = {
+static const struct pwm_ops rockchip_pwm_ops = {
 	.get_state = rockchip_pwm_get_state,
 	.apply = rockchip_pwm_apply,
 	.owner = THIS_MODULE,
@@ -288,9 +220,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		.ctrl = 0x0c,
 	},
 	.prescaler = 2,
-	.ops = &rockchip_pwm_ops_v1,
-	.get_state = rockchip_pwm_get_state_v1,
-	.pwm_apply = rockchip_pwm_apply_v1,
+	.supports_polarity = false,
+	.enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN,
 };
 
 static const struct rockchip_pwm_data pwm_data_v2 = {
@@ -302,9 +233,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 1,
 	.supports_polarity = true,
-	.ops = &rockchip_pwm_ops_v2,
-	.get_state = rockchip_pwm_get_state_v2,
-	.pwm_apply = rockchip_pwm_apply_v2,
+	.enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
+		       PWM_CONTINUOUS,
 };
 
 static const struct rockchip_pwm_data pwm_data_vop = {
@@ -316,9 +246,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 1,
 	.supports_polarity = true,
-	.ops = &rockchip_pwm_ops_v2,
-	.get_state = rockchip_pwm_get_state_v2,
-	.pwm_apply = rockchip_pwm_apply_v2,
+	.enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
+		       PWM_CONTINUOUS,
 };
 
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
@@ -391,7 +320,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	pc->data = id->data;
 	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = pc->data->ops;
+	pc->chip.ops = &rockchip_pwm_ops;
 	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
-- 
1.9.1
