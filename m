From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 04/14] pwm: rockchip: Add support for hardware readout
Date: Tue, 14 Jun 2016 11:13:12 +0200
Message-ID: <1465895602-31008-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@st.com>, Laxman Dewangan <ldewangan@nvidia.com>, kernel@stlinux.com, Boris Brezillon <boris.brezillon@free-electrons.com>, Brian Norris <briannorris@chromium.org>, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Doug Anderson <dianders@google.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pwm@vger.kernel.org

Implement the ->get_state() function to expose initial state.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
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
