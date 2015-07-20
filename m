From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 09/10] pwm: rockchip: add initial state retrieval
Date: Mon, 20 Jul 2015 17:32:06 +0200
Message-ID: <1437406327-6207-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Doug Anderson <dianders@google.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Implement the ->reset_state() function to expose initial state.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-rockchip.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 7d9cc90..6eab25c 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -51,6 +51,7 @@ struct rockchip_pwm_data {
 
 	void (*set_enable)(struct pwm_chip *chip,
 			   struct pwm_device *pwm, bool enable);
+	void (*reset_state)(struct pwm_chip *chip, struct pwm_device *pwm);
 };
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
@@ -75,6 +76,18 @@ static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_reset_state_v1(struct pwm_chip *chip,
+					struct pwm_device *pwm)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
+	u32 val;
+
+	val = readl(pc->base + pc->data->regs.ctrl);
+	if ((val & enable_conf) == enable_conf)
+		pwm->state.enabled = true;
+}
+
 static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 				       struct pwm_device *pwm, bool enable)
 {
@@ -98,6 +111,54 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_reset_state_v2(struct pwm_chip *chip,
+					struct pwm_device *pwm)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
+			  PWM_CONTINUOUS;
+	u32 val;
+
+	val = readl(pc->base + pc->data->regs.ctrl);
+	if ((val & enable_conf) != enable_conf)
+		return;
+
+	pwm->state.enabled = true;
+
+	if (!(val & PWM_DUTY_POSITIVE))
+		pwm->state.polarity = PWM_POLARITY_INVERSED;
+}
+
+static void rockchip_pwm_reset_state(struct pwm_chip *chip,
+				     struct pwm_device *pwm)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	unsigned long clk_rate;
+	u64 tmp;
+	int ret;
+
+	ret = clk_enable(pc->clk);
+	if (ret)
+		return;
+
+	clk_rate = clk_get_rate(pc->clk);
+
+	tmp = readl(pc->base + pc->data->regs.period);
+	tmp *= pc->data->prescaler * NSEC_PER_SEC;
+	do_div(tmp, clk_rate);
+	pwm->state.period = tmp;
+
+	tmp = readl(pc->base + pc->data->regs.duty);
+	tmp *= pc->data->prescaler * NSEC_PER_SEC;
+	do_div(tmp, clk_rate);
+	pwm->state.duty_cycle = tmp;
+
+	pc->data->reset_state(chip, chip->pwms);
+
+	if (!pwm_is_enabled(pwm))
+		clk_disable(pc->clk);
+}
+
 static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -171,6 +232,7 @@ static void rockchip_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static const struct pwm_ops rockchip_pwm_ops_v1 = {
+	.reset_state = rockchip_pwm_reset_state,
 	.config = rockchip_pwm_config,
 	.enable = rockchip_pwm_enable,
 	.disable = rockchip_pwm_disable,
@@ -178,6 +240,7 @@ static const struct pwm_ops rockchip_pwm_ops_v1 = {
 };
 
 static const struct pwm_ops rockchip_pwm_ops_v2 = {
+	.reset_state = rockchip_pwm_reset_state,
 	.config = rockchip_pwm_config,
 	.set_polarity = rockchip_pwm_set_polarity,
 	.enable = rockchip_pwm_enable,
@@ -195,6 +258,7 @@ static const struct rockchip_pwm_data pwm_data_v1 = {
 	.prescaler = 2,
 	.ops = &rockchip_pwm_ops_v1,
 	.set_enable = rockchip_pwm_set_enable_v1,
+	.reset_state = rockchip_pwm_reset_state_v1,
 };
 
 static const struct rockchip_pwm_data pwm_data_v2 = {
@@ -207,6 +271,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
 	.prescaler = 1,
 	.ops = &rockchip_pwm_ops_v2,
 	.set_enable = rockchip_pwm_set_enable_v2,
+	.reset_state = rockchip_pwm_reset_state_v2,
 };
 
 static const struct rockchip_pwm_data pwm_data_vop = {
@@ -219,6 +284,7 @@ static const struct rockchip_pwm_data pwm_data_vop = {
 	.prescaler = 1,
 	.ops = &rockchip_pwm_ops_v2,
 	.set_enable = rockchip_pwm_set_enable_v2,
+	.reset_state = rockchip_pwm_reset_state_v2,
 };
 
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
-- 
1.9.1
