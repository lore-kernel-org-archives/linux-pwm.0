From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 07/14] pwm: sti: Add support for hardware readout
Date: Fri,  3 Jun 2016 10:23:05 +0200
Message-ID: <1464942192-25967-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1464942192-25967-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Implement ->get_state() to provide support for initial state retrieval.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
