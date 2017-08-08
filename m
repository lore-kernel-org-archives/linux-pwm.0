From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v3 6/7] pwm: rockchip: Add rk3328 pwm support
Date: Tue,  8 Aug 2017 23:42:47 +0800
Message-ID: <1502206967-24366-1-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
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
 drivers/pwm/pwm-rockchip.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index a3fcb40..4d99d46 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -29,6 +29,7 @@
 #define PWM_INACTIVE_POSITIVE	(1 << 4)
 #define PWM_POLARITY_MASK	(PWM_DUTY_POSITIVE | PWM_INACTIVE_POSITIVE)
 #define PWM_OUTPUT_LEFT		(0 << 5)
+#define PWM_LOCK_EN		(1 << 6)
 #define PWM_LP_DISABLE		(0 << 8)
 
 struct rockchip_pwm_chip {
@@ -50,6 +51,7 @@ struct rockchip_pwm_data {
 	struct rockchip_pwm_regs regs;
 	unsigned int prescaler;
 	bool supports_polarity;
+	bool supports_lock;
 	u32 enable_conf;
 };
 
@@ -121,10 +123,19 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	div = clk_rate * state->duty_cycle;
 	duty = DIV_ROUND_CLOSEST_ULL(div, pc->data->prescaler * NSEC_PER_SEC);
 
+	/*
+	 * Lock the period and duty of previous configuration, then
+	 * change the duty and period, that would not be effective.
+	 */
+	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	if (pc->data->supports_lock) {
+		ctrl |= PWM_LOCK_EN;
+		writel_relaxed(ctrl, pc->base + pc->data->regs.ctrl);
+	}
+
 	writel(period, pc->base + pc->data->regs.period);
 	writel(duty, pc->base + pc->data->regs.duty);
 
-	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	if (pc->data->supports_polarity) {
 		ctrl &= ~PWM_POLARITY_MASK;
 		if (state->polarity == PWM_POLARITY_INVERSED)
@@ -132,6 +143,15 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		else
 			ctrl |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
 	}
+
+	/*
+	 * Unlock and set polarity at the same time,
+	 * the configuration of duty, period and polarity
+	 * would be effective together at next period.
+	 */
+	if (pc->data->supports_lock)
+		ctrl &= ~PWM_LOCK_EN;
+
 	writel(ctrl, pc->base + pc->data->regs.ctrl);
 }
 
@@ -180,7 +200,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_get_state(pwm, &curstate);
 	enabled = curstate.enabled;
 
-	if (state->polarity != curstate.polarity && enabled) {
+	if (state->polarity != curstate.polarity && enabled &&
+	    !pc->data->supports_lock) {
 		ret = rockchip_pwm_enable(chip, pwm, false);
 		if (ret)
 			goto out;
@@ -221,6 +242,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 2,
 	.supports_polarity = false,
+	.supports_lock = false,
 	.enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN,
 };
 
@@ -233,6 +255,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 1,
 	.supports_polarity = true,
+	.supports_lock = false,
 	.enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
 		       PWM_CONTINUOUS,
 };
@@ -246,6 +269,21 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 1,
 	.supports_polarity = true,
+	.supports_lock = false,
+	.enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
+		       PWM_CONTINUOUS,
+};
+
+static const struct rockchip_pwm_data pwm_data_v3 = {
+	.regs = {
+		.duty = 0x08,
+		.period = 0x04,
+		.cntr = 0x00,
+		.ctrl = 0x0c,
+	},
+	.prescaler = 1,
+	.supports_polarity = true,
+	.supports_lock = true,
 	.enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
 		       PWM_CONTINUOUS,
 };
@@ -254,6 +292,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	{ .compatible = "rockchip,rk2928-pwm", .data = &pwm_data_v1},
 	{ .compatible = "rockchip,rk3288-pwm", .data = &pwm_data_v2},
 	{ .compatible = "rockchip,vop-pwm", .data = &pwm_data_vop},
+	{ .compatible = "rockchip,rk3328-pwm", .data = &pwm_data_v3},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
-- 
1.9.1
