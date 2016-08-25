From: Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 2/2] pwm: sunxi: Yield some time to the pwm-block to become ready
Date: Thu, 25 Aug 2016 19:50:11 +0200
Message-ID: <1472147411-30424-3-git-send-email-oliver@schinagl.nl>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Olliver Schinagl <o.schinagl@ultimaker.com>
List-Id: linux-pwm@vger.kernel.org

From: Olliver Schinagl <o.schinagl@ultimaker.com>

The pwm-block of some of the sunxi chips feature a 'ready' flag to
indicate the software that it is ready for new commands.

Right now, when we call pwm_config and set the period, we write the
values to the registers, and turn off the clock to the IP. Because of
this, the hardware does not have time to configure the hardware and set
the 'ready' flag.

By running the clock just before making new changes and before checking
if the hardware is ready, the hardware has time to reconfigure itself
and set the clear the flag appropriately.

Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
---
 drivers/pwm/pwm-sun4i.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5e97c8a..dd198c3 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -105,6 +105,22 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
 	int err;
+	int ret = 0;
+
+	/* Let the PWM hardware run before making any changes. We do this to
+	 * allow the hardware to have some time to clear the 'ready' flag.
+	 */
+	err = clk_prepare_enable(sun4i_pwm->clk);
+	if (err) {
+		dev_err(chip->dev, "failed to enable PWM clock\n");
+		return err;
+	}
+	spin_lock(&sun4i_pwm->ctrl_lock);
+	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	spin_unlock(&sun4i_pwm->ctrl_lock);
 
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
 
@@ -137,7 +153,9 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		if (div - 1 > PWM_PRD_MASK) {
 			dev_err(chip->dev, "period exceeds the maximum value\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			spin_lock(&sun4i_pwm->ctrl_lock);
+			goto out;
 		}
 	}
 
@@ -146,26 +164,14 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, period_ns);
 	dty = div;
 
-	err = clk_prepare_enable(sun4i_pwm->clk);
-	if (err) {
-		dev_err(chip->dev, "failed to enable PWM clock\n");
-		return err;
-	}
-
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-
 	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
-		spin_unlock(&sun4i_pwm->ctrl_lock);
-		clk_disable_unprepare(sun4i_pwm->clk);
-		return -EBUSY;
-	}
-
-	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	if (clk_gate) {
-		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+		ret = -EBUSY;
+		goto out;
 	}
+	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 	val &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
@@ -175,6 +181,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 
+out:
 	if (clk_gate) {
 		val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 		val |= clk_gate;
@@ -184,7 +191,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 	clk_disable_unprepare(sun4i_pwm->clk);
 
-	return 0;
+	return ret;
 }
 
 static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.8.1
