From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 10/12] pwm: rockchip: add support for atomic update
Date: Mon, 21 Sep 2015 11:33:27 +0200
Message-ID: <1442828009-6241-11-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBKU676XQKGQEZ77UZXI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Implement the ->apply() function to add support for atomic update.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/pwm-rockchip.c | 53 +++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 6eab25c..48b814d 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -50,7 +50,8 @@ struct rockchip_pwm_data {
 	const struct pwm_ops *ops;
 
 	void (*set_enable)(struct pwm_chip *chip,
-			   struct pwm_device *pwm, bool enable);
+			   struct pwm_device *pwm, bool enable,
+			   enum pwm_polarity polarity);
 	void (*reset_state)(struct pwm_chip *chip, struct pwm_device *pwm);
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
@@ -89,14 +91,15 @@ static void rockchip_pwm_reset_state_v1(struct pwm_chip *chip,
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
@@ -165,7 +168,6 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	unsigned long period, duty;
 	u64 clk_rate, div;
-	int ret;
 
 	clk_rate = clk_get_rate(pc->clk);
 
@@ -182,15 +184,8 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -208,43 +203,53 @@ static int rockchip_pwm_set_polarity(struct pwm_chip *chip,
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
 	.reset_state = rockchip_pwm_reset_state,
 	.config = rockchip_pwm_config,
-	.enable = rockchip_pwm_enable,
-	.disable = rockchip_pwm_disable,
+	.apply = rockchip_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
 static const struct pwm_ops rockchip_pwm_ops_v2 = {
 	.reset_state = rockchip_pwm_reset_state,
 	.config = rockchip_pwm_config,
+	.apply = rockchip_pwm_apply,
 	.set_polarity = rockchip_pwm_set_polarity,
-	.enable = rockchip_pwm_enable,
-	.disable = rockchip_pwm_disable,
 	.owner = THIS_MODULE,
 };
 
-- 
1.9.1
