From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2 4/7] pwm: rockchip: Use pwm_apply instead of the pwm_enable
Date: Sat,  8 Jul 2017 12:03:46 +0800
Message-ID: <1499486629-9659-5-git-send-email-david.wu@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

Drop the custom hook of pwm_enable and implement
pwm_apply_v1 and pwm_apply_v2 instead.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/pwm/pwm-rockchip.c | 141 +++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 85f9515..12e7b4a8 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -51,11 +51,10 @@ struct rockchip_pwm_data {
 	bool supports_polarity;
 	const struct pwm_ops *ops;
 
-	void (*set_enable)(struct pwm_chip *chip,
-			   struct pwm_device *pwm, bool enable,
-			   enum pwm_polarity polarity);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
+	int (*pwm_apply)(struct pwm_chip *chip, struct pwm_device *pwm,
+			 struct pwm_state *state);
 };
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
@@ -63,24 +62,6 @@ static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
 	return container_of(c, struct rockchip_pwm_chip, chip);
 }
 
-static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
-				       struct pwm_device *pwm, bool enable,
-				       enum pwm_polarity polarity)
-{
-	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
-	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
-	u32 val;
-
-	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
-
-	if (enable)
-		val |= enable_conf;
-	else
-		val &= ~enable_conf;
-
-	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
-}
-
 static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
 				      struct pwm_device *pwm,
 				      struct pwm_state *state)
@@ -94,30 +75,6 @@ static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
 		state->enabled = true;
 }
 
-static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
-				       struct pwm_device *pwm, bool enable,
-				       enum pwm_polarity polarity)
-{
-	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
-	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
-			  PWM_CONTINUOUS;
-	u32 val;
-
-	if (polarity == PWM_POLARITY_INVERSED)
-		enable_conf |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
-	else
-		enable_conf |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
-
-	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
-
-	if (enable)
-		val |= enable_conf;
-	else
-		val &= ~enable_conf;
-
-	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
-}
-
 static void rockchip_pwm_get_state_v2(struct pwm_chip *chip,
 				      struct pwm_device *pwm,
 				      struct pwm_state *state)
@@ -193,10 +150,12 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int rockchip_pwm_enable(struct pwm_chip *chip,
 			 struct pwm_device *pwm,
 			 bool enable,
-			 enum pwm_polarity polarity)
+			 enum pwm_polarity polarity,
+			 u32 enable_conf)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	int ret;
+	u32 val;
 
 	if (enable) {
 		ret = clk_enable(pc->clk);
@@ -204,7 +163,23 @@ static int rockchip_pwm_enable(struct pwm_chip *chip,
 			return ret;
 	}
 
-	pc->data->set_enable(chip, pwm, enable, polarity);
+	if (pc->data->supports_polarity) {
+		if (polarity == PWM_POLARITY_INVERSED)
+			enable_conf |= PWM_DUTY_NEGATIVE |
+				       PWM_INACTIVE_POSITIVE;
+		else
+			enable_conf |= PWM_DUTY_POSITIVE |
+				       PWM_INACTIVE_NEGATIVE;
+	}
+
+	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
+
+	if (enable)
+		val |= enable_conf;
+	else
+		val &= ~enable_conf;
+
+	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 
 	if (!enable)
 		clk_disable(pc->clk);
@@ -212,37 +187,75 @@ static int rockchip_pwm_enable(struct pwm_chip *chip,
 	return 0;
 }
 
-static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			      struct pwm_state *state)
+static int rockchip_pwm_apply_v1(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
 {
-	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
 	struct pwm_state curstate;
 	bool enabled;
-	int ret;
+	int ret = 0;
 
 	pwm_get_state(pwm, &curstate);
 	enabled = curstate.enabled;
 
-	ret = clk_enable(pc->pclk);
-	if (ret)
-		return ret;
-
 	if (state->polarity != curstate.polarity && enabled) {
-		ret = rockchip_pwm_enable(chip, pwm, false, state->polarity);
+		ret = rockchip_pwm_enable(chip, pwm, false, state->polarity,
+					  enable_conf);
 		if (ret)
-			goto out;
+			return ret;
 		enabled = false;
 	}
 
 	rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
-
-	if (state->enabled != enabled) {
+	if (state->enabled != enabled)
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-				    state->polarity);
+				    state->polarity, enable_conf);
+
+	return ret;
+}
+
+static int rockchip_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
+		  PWM_CONTINUOUS;
+	struct pwm_state curstate;
+	bool enabled;
+	int ret = 0;
+
+	pwm_get_state(pwm, &curstate);
+	enabled = curstate.enabled;
+
+	if (state->polarity != curstate.polarity && enabled) {
+		ret = rockchip_pwm_enable(chip, pwm, false, state->polarity,
+					  enable_conf);
 		if (ret)
-			goto out;
+			return ret;
+		enabled = false;
 	}
 
+	rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (state->enabled != enabled)
+		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
+					  state->polarity, enable_conf);
+
+	return ret;
+}
+
+static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	int ret;
+
+	ret = clk_enable(pc->pclk);
+	if (ret)
+		return ret;
+
+	ret = pc->data->pwm_apply(chip, pwm, state);
+	if (ret)
+		goto out;
+
 	/*
 	 * Update the state with the real hardware, which can differ a bit
 	 * because of period/duty_cycle approximation.
@@ -270,8 +283,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 2,
 	.ops = &rockchip_pwm_ops,
-	.set_enable = rockchip_pwm_set_enable_v1,
 	.get_state = rockchip_pwm_get_state_v1,
+	.pwm_apply = rockchip_pwm_apply_v1,
 };
 
 static const struct rockchip_pwm_data pwm_data_v2 = {
@@ -284,8 +297,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	.prescaler = 1,
 	.supports_polarity = true,
 	.ops = &rockchip_pwm_ops,
-	.set_enable = rockchip_pwm_set_enable_v2,
 	.get_state = rockchip_pwm_get_state_v2,
+	.pwm_apply = rockchip_pwm_apply_v2,
 };
 
 static const struct rockchip_pwm_data pwm_data_vop = {
@@ -298,8 +311,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	.prescaler = 1,
 	.supports_polarity = true,
 	.ops = &rockchip_pwm_ops,
-	.set_enable = rockchip_pwm_set_enable_v2,
 	.get_state = rockchip_pwm_get_state_v2,
+	.pwm_apply = rockchip_pwm_apply_v2,
 };
 
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
-- 
1.9.1
