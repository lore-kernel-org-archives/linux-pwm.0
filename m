From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 3/7] pwm: rockchip: Use pwm_apply instead of the pwm_enable
Date: Tue,  8 Aug 2017 23:38:31 +0800
Message-ID: <1502206715-24174-4-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Drop the custom hook of pwm_enable and implement
pwm_apply_v1 and pwm_apply_v2 instead.

Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/pwm/pwm-rockchip.c | 141 +++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 33bbb5a..4bbecbd 100644
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
@@ -276,8 +289,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 2,
 	.ops = &rockchip_pwm_ops_v1,
-	.set_enable = rockchip_pwm_set_enable_v1,
 	.get_state = rockchip_pwm_get_state_v1,
+	.pwm_apply = rockchip_pwm_apply_v1,
 };
 
 static const struct rockchip_pwm_data pwm_data_v2 = {
@@ -290,8 +303,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	.prescaler = 1,
 	.supports_polarity = true,
 	.ops = &rockchip_pwm_ops_v2,
-	.set_enable = rockchip_pwm_set_enable_v2,
 	.get_state = rockchip_pwm_get_state_v2,
+	.pwm_apply = rockchip_pwm_apply_v2,
 };
 
 static const struct rockchip_pwm_data pwm_data_vop = {
@@ -304,8 +317,8 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	.prescaler = 1,
 	.supports_polarity = true,
 	.ops = &rockchip_pwm_ops_v2,
-	.set_enable = rockchip_pwm_set_enable_v2,
 	.get_state = rockchip_pwm_get_state_v2,
+	.pwm_apply = rockchip_pwm_apply_v2,
 };
 
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
-- 
1.9.1
