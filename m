From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v3 4/7] pwm: rockchip: Move the configuration of polarity from rockchip_pwm_set_enable() to rockchip_pwm_config()
Date: Tue,  8 Aug 2017 23:38:32 +0800
Message-ID: <1502206715-24174-5-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

It is usually possible to configure the polarity, cycle and duty all at once,
so that the polarity and cycle and duty should be binding together. Move it
into rockchip_pwm_config(), as well as prepared for the next atomic update
commit.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/pwm/pwm-rockchip.c | 48 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 4bbecbd..fbd9c1a 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -27,6 +27,7 @@
 #define PWM_DUTY_NEGATIVE	(0 << 3)
 #define PWM_INACTIVE_NEGATIVE	(0 << 4)
 #define PWM_INACTIVE_POSITIVE	(1 << 4)
+#define PWM_POLARITY_MASK	(PWM_DUTY_POSITIVE | PWM_INACTIVE_POSITIVE)
 #define PWM_OUTPUT_LEFT		(0 << 5)
 #define PWM_LP_DISABLE		(0 << 8)
 
@@ -123,11 +124,12 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 }
 
 static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       int duty_ns, int period_ns)
+			       struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	unsigned long period, duty;
 	u64 clk_rate, div;
+	u32 ctrl;
 
 	clk_rate = clk_get_rate(pc->clk);
 
@@ -136,22 +138,31 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * bits, every possible input period can be obtained using the
 	 * default prescaler value for all practical clock rate values.
 	 */
-	div = clk_rate * period_ns;
+	div = clk_rate * state->period;
 	period = DIV_ROUND_CLOSEST_ULL(div,
 				       pc->data->prescaler * NSEC_PER_SEC);
 
-	div = clk_rate * duty_ns;
+	div = clk_rate * state->duty_cycle;
 	duty = DIV_ROUND_CLOSEST_ULL(div, pc->data->prescaler * NSEC_PER_SEC);
 
 	writel(period, pc->base + pc->data->regs.period);
 	writel(duty, pc->base + pc->data->regs.duty);
+
+	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	if (pc->data->supports_polarity) {
+		ctrl &= ~PWM_POLARITY_MASK;
+		if (state->polarity == PWM_POLARITY_INVERSED)
+			ctrl |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
+		else
+			ctrl |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
+	}
+	writel(ctrl, pc->base + pc->data->regs.ctrl);
 }
 
 static int rockchip_pwm_enable(struct pwm_chip *chip,
-			 struct pwm_device *pwm,
-			 bool enable,
-			 enum pwm_polarity polarity,
-			 u32 enable_conf)
+			       struct pwm_device *pwm,
+			       bool enable,
+			       u32 enable_conf)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	int ret;
@@ -163,15 +174,6 @@ static int rockchip_pwm_enable(struct pwm_chip *chip,
 			return ret;
 	}
 
-	if (pc->data->supports_polarity) {
-		if (polarity == PWM_POLARITY_INVERSED)
-			enable_conf |= PWM_DUTY_NEGATIVE |
-				       PWM_INACTIVE_POSITIVE;
-		else
-			enable_conf |= PWM_DUTY_POSITIVE |
-				       PWM_INACTIVE_NEGATIVE;
-	}
-
 	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
 
 	if (enable)
@@ -199,17 +201,16 @@ static int rockchip_pwm_apply_v1(struct pwm_chip *chip, struct pwm_device *pwm,
 	enabled = curstate.enabled;
 
 	if (state->polarity != curstate.polarity && enabled) {
-		ret = rockchip_pwm_enable(chip, pwm, false, state->polarity,
-					  enable_conf);
+		ret = rockchip_pwm_enable(chip, pwm, false, enable_conf);
 		if (ret)
 			return ret;
 		enabled = false;
 	}
 
-	rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	rockchip_pwm_config(chip, pwm, state);
 	if (state->enabled != enabled)
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-				    state->polarity, enable_conf);
+					  enable_conf);
 
 	return ret;
 }
@@ -227,17 +228,16 @@ static int rockchip_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 	enabled = curstate.enabled;
 
 	if (state->polarity != curstate.polarity && enabled) {
-		ret = rockchip_pwm_enable(chip, pwm, false, state->polarity,
-					  enable_conf);
+		ret = rockchip_pwm_enable(chip, pwm, false, enable_conf);
 		if (ret)
 			return ret;
 		enabled = false;
 	}
 
-	rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	rockchip_pwm_config(chip, pwm, state);
 	if (state->enabled != enabled)
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-					  state->polarity, enable_conf);
+					  enable_conf);
 
 	return ret;
 }
-- 
1.9.1
