From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 06/13] pwm: sti: Add support for hardware readout
Date: Wed,  8 Jun 2016 18:34:41 +0200
Message-ID: <1465403688-17098-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
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

Implement ->get_state() to provide support for initial state retrieval.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-sti.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 92abbd5..6300d3e 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -238,6 +238,43 @@ static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&pc->sti_pwm_lock);
 }
 
+static void sti_pwm_get_state(struct pwm_chip *chip,
+			      struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+	unsigned int regval, prescaler;
+	int ret;
+
+	/* The clock has to be enabled to access PWM registers */
+	ret = clk_enable(pc->clk);
+	if (ret) {
+		dev_err(chip->dev, "Failed to enable PWM clk");
+		return;
+	}
+
+	regmap_field_read(pc->prescale_high, &regval);
+	prescaler = regval << 4;
+	regmap_field_read(pc->prescale_low, &regval);
+	prescaler |= regval;
+	state->period = DIV_ROUND_CLOSEST_ULL((u64)(prescaler + 1) *
+					      NSEC_PER_SEC *
+					      (pc->cdata->max_pwm_cnt + 1),
+					      pc->clk_rate);
+
+	regmap_read(pc->regmap, STI_DS_REG(pwm->hwpwm), &regval);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)(regval + 1) *
+						  state->period,
+						  pc->cdata->max_pwm_cnt + 1);
+
+	regmap_field_read(pc->pwm_en, &regval);
+	state->enabled = regval;
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	clk_disable(pc->clk);
+}
+
 static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
@@ -249,6 +286,7 @@ static const struct pwm_ops sti_pwm_ops = {
 	.config = sti_pwm_config,
 	.enable = sti_pwm_enable,
 	.disable = sti_pwm_disable,
+	.get_state = sti_pwm_get_state,
 	.free = sti_pwm_free,
 	.owner = THIS_MODULE,
 };
-- 
2.7.4
