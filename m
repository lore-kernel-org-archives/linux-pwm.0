From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 12/15] pwm: rockchip: add initial state retrieval
Date: Wed,  1 Jul 2015 10:21:58 +0200
Message-ID: <1435738921-25027-13-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34395 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753380AbbGAIWa (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 04:22:30 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

Implement the ->init_state() function to expose initial state.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-rockchip.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 7d9cc90..11e932d 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -51,6 +51,7 @@ struct rockchip_pwm_data {
 
 	void (*set_enable)(struct pwm_chip *chip,
 			   struct pwm_device *pwm, bool enable);
+	void (*init)(struct pwm_chip *chip, struct pwm_device *pwm);
 };
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
@@ -75,6 +76,17 @@ static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_init_v1(struct pwm_chip *chip, struct pwm_device *pwm)
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
@@ -98,6 +110,36 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_init_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm)
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
+	tmp = do_div(tmp, clk_rate);
+	pwm->state.period = tmp;
+
+	tmp = readl(pc->base + pc->data->regs.duty);
+	tmp *= pc->data->prescaler * NSEC_PER_SEC;
+	tmp = do_div(tmp, clk_rate);
+	pwm->state.duty_cycle = tmp;
+
+	pc->data->init(chip, chip->pwms);
+
+	if (!pwm_is_enabled(pwm))
+		clk_disable(pc->clk);
+}
+
 static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -171,6 +213,7 @@ static void rockchip_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static const struct pwm_ops rockchip_pwm_ops_v1 = {
+	.init_state = rockchip_pwm_init_state,
 	.config = rockchip_pwm_config,
 	.enable = rockchip_pwm_enable,
 	.disable = rockchip_pwm_disable,
@@ -178,6 +221,7 @@ static const struct pwm_ops rockchip_pwm_ops_v1 = {
 };
 
 static const struct pwm_ops rockchip_pwm_ops_v2 = {
+	.init_state = rockchip_pwm_init_state,
 	.config = rockchip_pwm_config,
 	.set_polarity = rockchip_pwm_set_polarity,
 	.enable = rockchip_pwm_enable,
@@ -195,6 +239,7 @@ static const struct rockchip_pwm_data pwm_data_v1 = {
 	.prescaler = 2,
 	.ops = &rockchip_pwm_ops_v1,
 	.set_enable = rockchip_pwm_set_enable_v1,
+	.init = rockchip_pwm_init_v1,
 };
 
 static const struct rockchip_pwm_data pwm_data_v2 = {
@@ -207,6 +252,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
 	.prescaler = 1,
 	.ops = &rockchip_pwm_ops_v2,
 	.set_enable = rockchip_pwm_set_enable_v2,
+	.init = rockchip_pwm_init_v2,
 };
 
 static const struct rockchip_pwm_data pwm_data_vop = {
@@ -219,6 +265,7 @@ static const struct rockchip_pwm_data pwm_data_vop = {
 	.prescaler = 1,
 	.ops = &rockchip_pwm_ops_v2,
 	.set_enable = rockchip_pwm_set_enable_v2,
+	.init = rockchip_pwm_init_v2,
 };
 
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
-- 
1.9.1
