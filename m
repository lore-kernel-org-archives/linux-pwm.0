From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2 6/7] pwm: rockchip: Add rk3328 pwm support
Date: Sat,  8 Jul 2017 12:09:23 +0800
Message-ID: <1499486963-9892-1-git-send-email-david.wu@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

The rk3328 soc supports atomic update, we could lock the configuration
of period and duty at first, after unlock is configured, the period and
duty are effective at the same time.

If the polarity, period and duty need to be configured together,
the way for atomic update is "configure lock and old polarity" ->
"configure period and duty" -> "configure unlock and new polarity".

Signed-off-by: David Wu <david.wu@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
change in v2:
 - 3 different pwm_ops apply(),one for each IP revision.
 .../devicetree/bindings/pwm/pwm-rockchip.txt       |  1 +
 drivers/pwm/pwm-rockchip.c                         | 63 ++++++++++++++++++++--
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
index 2350ef9..152c736 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
@@ -4,6 +4,7 @@ Required properties:
  - compatible: should be "rockchip,<name>-pwm"
    "rockchip,rk2928-pwm": found on RK29XX,RK3066 and RK3188 SoCs
    "rockchip,rk3288-pwm": found on RK3288 SoC
+   "rockchip,rk3328-pwm": found on RK3328 SoC
    "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
  - reg: physical base address and length of the controller's registers
  - clocks: See ../clock/clock-bindings.txt
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 83703e1..838e8fc 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -29,6 +29,7 @@
 #define PWM_INACTIVE_POSITIVE	(1 << 4)
 #define PWM_POLARITY_MASK	(PWM_DUTY_POSITIVE | PWM_INACTIVE_POSITIVE)
 #define PWM_OUTPUT_LEFT		(0 << 5)
+#define PWM_LOCK_EN		(1 << 6)
 #define PWM_LP_DISABLE		(0 << 8)
 
 struct rockchip_pwm_chip {
@@ -124,13 +125,24 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 }
 
 static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       struct pwm_state *state, bool polarity)
+			       struct pwm_state *state, bool polarity,
+			       bool lock)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	unsigned long period, duty;
 	u64 clk_rate, div;
 	u32 ctrl;
 
+	/*
+	 * Lock the period and duty of previous configuration, then
+	 * change the duty and period, that would not be effective.
+	 */
+	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	if (lock) {
+		ctrl |= PWM_LOCK_EN;
+		writel_relaxed(ctrl, pc->base + pc->data->regs.ctrl);
+	}
+
 	clk_rate = clk_get_rate(pc->clk);
 
 	/*
@@ -148,7 +160,6 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(period, pc->base + pc->data->regs.period);
 	writel(duty, pc->base + pc->data->regs.duty);
 
-	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	if (polarity) {
 		ctrl &= ~PWM_POLARITY_MASK;
 		if (state->polarity == PWM_POLARITY_INVERSED)
@@ -156,6 +167,15 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		else
 			ctrl |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
 	}
+
+	/*
+	 * Unlock and set polarity at the same time,
+	 * the configuration of duty, period and polarity
+	 * would be effective together at next period.
+	 */
+	if (lock)
+		ctrl &= ~PWM_LOCK_EN;
+
 	writel(ctrl, pc->base + pc->data->regs.ctrl);
 
 	return 0;
@@ -209,7 +229,7 @@ static int rockchip_pwm_apply_v1(struct pwm_chip *chip, struct pwm_device *pwm,
 		enabled = false;
 	}
 
-	rockchip_pwm_config(chip, pwm, state, false);
+	rockchip_pwm_config(chip, pwm, state, false, false);
 	if (state->enabled != enabled)
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
 				    enable_conf);
@@ -236,7 +256,27 @@ static int rockchip_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		enabled = false;
 	}
 
-	rockchip_pwm_config(chip, pwm, state, true);
+	rockchip_pwm_config(chip, pwm, state, true, false);
+	if (state->enabled != enabled)
+		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
+					  enable_conf);
+
+	return ret;
+}
+
+static int rockchip_pwm_apply_v3(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	rockchip_pwm_config(chip, pwm, state, true, true);
 	if (state->enabled != enabled)
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
 					  enable_conf);
@@ -317,9 +357,24 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	.pwm_apply = rockchip_pwm_apply_v2,
 };
 
+static const struct rockchip_pwm_data pwm_data_v3 = {
+	.regs = {
+		.duty = 0x08,
+		.period = 0x04,
+		.cntr = 0x00,
+		.ctrl = 0x0c,
+	},
+	.prescaler = 1,
+	.supports_polarity = true,
+	.ops = &rockchip_pwm_ops,
+	.get_state = rockchip_pwm_get_state_v2,
+	.pwm_apply = rockchip_pwm_apply_v3,
+};
+
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
 	{ .compatible = "rockchip,rk2928-pwm", .data = &pwm_data_v1},
 	{ .compatible = "rockchip,rk3288-pwm", .data = &pwm_data_v2},
+	{ .compatible = "rockchip,rk3328-pwm", .data = &pwm_data_v2},
 	{ .compatible = "rockchip,vop-pwm", .data = &pwm_data_vop},
 	{ /* sentinel */ }
 };
-- 
1.9.1
