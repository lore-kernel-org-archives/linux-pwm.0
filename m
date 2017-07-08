From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 5/7] pwm: rockchip: Move the configuration of polarity from rockchip_pwm_set_enable() to rockchip_pwm_config()
Date: Sat,  8 Jul 2017 12:08:28 +0800
Message-ID: <1499486908-9821-1-git-send-email-david.wu@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499486629-9659-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

It is usually possible to configure the polarity, cycle and duty all at once,
so that the polarity and cycle and duty should be binding together. Move it
into rockchip_pwm_config(), as well as prepared for the next atomic update
commit.

Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/pwm/pwm-rockchip.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 12e7b4a8..83703e1 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -27,6 +27,7 @@
 #define PWM_DUTY_NEGATIVE	(0 << 3)
 #define PWM_INACTIVE_NEGATIVE	(0 << 4)
 #define PWM_INACTIVE_POSITIVE	(1 << 4)
+#define PWM_POLARITY_MASK	(PWM_DUTY_POSITIVE | PWM_INACTIVE_POSITIVE)
 #define PWM_OUTPUT_LEFT		(0 << 5)
 #define PWM_LP_DISABLE		(0 << 8)
 
@@ -122,12 +123,13 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 	clk_disable(pc->pclk);
 }
 
-static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       int duty_ns, int period_ns)
+static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state, bool polarity)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	unsigned long period, duty;
 	u64 clk_rate, div;
+	u32 ctrl;
 
 	clk_rate = clk_get_rate(pc->clk);
 
@@ -136,21 +138,32 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	if (polarity) {
+		ctrl &= ~PWM_POLARITY_MASK;
+		if (state->polarity == PWM_POLARITY_INVERSED)
+			ctrl |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
+		else
+			ctrl |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
+	}
+	writel(ctrl, pc->base + pc->data->regs.ctrl);
+
+	return 0;
 }
 
 static int rockchip_pwm_enable(struct pwm_chip *chip,
 			 struct pwm_device *pwm,
 			 bool enable,
-			 enum pwm_polarity polarity,
 			 u32 enable_conf)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
@@ -163,15 +176,6 @@ static int rockchip_pwm_enable(struct pwm_chip *chip,
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
@@ -199,17 +203,16 @@ static int rockchip_pwm_apply_v1(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	rockchip_pwm_config(chip, pwm, state, false);
 	if (state->enabled != enabled)
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-				    state->polarity, enable_conf);
+				    enable_conf);
 
 	return ret;
 }
@@ -227,17 +230,16 @@ static int rockchip_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	rockchip_pwm_config(chip, pwm, state, true);
 	if (state->enabled != enabled)
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-					  state->polarity, enable_conf);
+					  enable_conf);
 
 	return ret;
 }
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
