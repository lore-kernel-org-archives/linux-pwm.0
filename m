From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 03/13] pwm: rockchip: Add support for hardware readout
Date: Wed,  8 Jun 2016 18:34:38 +0200
Message-ID: <1465403688-17098-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Implement the ->get_state() function to expose initial state.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/pwm/pwm-rockchip.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 68d72ce..c72b419 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -51,6 +51,8 @@ struct rockchip_pwm_data {
 
 	void (*set_enable)(struct pwm_chip *chip,
 			   struct pwm_device *pwm, bool enable);
+	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
+			  struct pwm_state *state);
 };
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
@@ -75,6 +77,19 @@ static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
+				      struct pwm_device *pwm,
+				      struct pwm_state *state)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
+	u32 val;
+
+	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	if ((val & enable_conf) == enable_conf)
+		state->enabled = true;
+}
+
 static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 				       struct pwm_device *pwm, bool enable)
 {
@@ -98,6 +113,53 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_get_state_v2(struct pwm_chip *chip,
+				      struct pwm_device *pwm,
+				      struct pwm_state *state)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
+			  PWM_CONTINUOUS;
+	u32 val;
+
+	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	if ((val & enable_conf) != enable_conf)
+		return;
+
+	state->enabled = true;
+
+	if (!(val & PWM_DUTY_POSITIVE))
+		state->polarity = PWM_POLARITY_INVERSED;
+}
+
+static void rockchip_pwm_get_state(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   struct pwm_state *state)
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
+	tmp = readl_relaxed(pc->base + pc->data->regs.period);
+	tmp *= pc->data->prescaler * NSEC_PER_SEC;
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+
+	tmp = readl_relaxed(pc->base + pc->data->regs.duty);
+	tmp *= pc->data->prescaler * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+
+	pc->data->get_state(chip, pwm, state);
+
+	clk_disable(pc->clk);
+}
+
 static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -170,6 +232,7 @@ static void rockchip_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static const struct pwm_ops rockchip_pwm_ops_v1 = {
+	.get_state = rockchip_pwm_get_state,
 	.config = rockchip_pwm_config,
 	.enable = rockchip_pwm_enable,
 	.disable = rockchip_pwm_disable,
@@ -177,6 +240,7 @@ static const struct pwm_ops rockchip_pwm_ops_v1 = {
 };
 
 static const struct pwm_ops rockchip_pwm_ops_v2 = {
+	.get_state = rockchip_pwm_get_state,
 	.config = rockchip_pwm_config,
 	.set_polarity = rockchip_pwm_set_polarity,
 	.enable = rockchip_pwm_enable,
@@ -194,6 +258,7 @@ static const struct rockchip_pwm_data pwm_data_v1 = {
 	.prescaler = 2,
 	.ops = &rockchip_pwm_ops_v1,
 	.set_enable = rockchip_pwm_set_enable_v1,
+	.get_state = rockchip_pwm_get_state_v1,
 };
 
 static const struct rockchip_pwm_data pwm_data_v2 = {
@@ -206,6 +271,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
 	.prescaler = 1,
 	.ops = &rockchip_pwm_ops_v2,
 	.set_enable = rockchip_pwm_set_enable_v2,
+	.get_state = rockchip_pwm_get_state_v2,
 };
 
 static const struct rockchip_pwm_data pwm_data_vop = {
@@ -218,6 +284,7 @@ static const struct rockchip_pwm_data pwm_data_vop = {
 	.prescaler = 1,
 	.ops = &rockchip_pwm_ops_v2,
 	.set_enable = rockchip_pwm_set_enable_v2,
+	.get_state = rockchip_pwm_get_state_v2,
 };
 
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
-- 
2.7.4
