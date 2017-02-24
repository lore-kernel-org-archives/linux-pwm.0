From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v4 4/9] pwm: sunxi: Customizable control and
 period register position.
Date: Fri, 24 Feb 2017 08:41:11 +0300
Message-ID: <1487914876-8594-5-git-send-email-lis8215@gmail.com>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBBEPX7CQKGQEJCQFZYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1487914876-8594-1-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

sun6i has same registers as sun4i compatible chips, but its position
in register map are different.

This patch make register's position selectable for support sun6i in
next patches.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 418a625..9ddc812 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -79,11 +79,17 @@ static const u32 sun4i_prescaler_table[] = {
 	0, /* Actually 1 but tested separately */
 };
 
+struct sunxi_pwmch_data {
+	unsigned int ctl_reg;
+	unsigned int prd_reg;
+};
+
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
 	bool has_rdy;
 	unsigned int npwm;
 	const u32 *prescaler_table;
+	const struct sunxi_pwmch_data *chan_data[SUN4I_MAX_PWM_CHANNELS];
 };
 
 struct sun4i_pwm_chip {
@@ -100,6 +106,18 @@ static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct sun4i_pwm_chip, chip);
 }
 
+static inline unsigned int sunxi_pwm_ctl_reg(struct sun4i_pwm_chip *chip,
+					     int chan)
+{
+	return chip->data->chan_data[chan]->ctl_reg;
+}
+
+static inline unsigned int sunxi_pwm_prd_reg(struct sun4i_pwm_chip *chip,
+					     int chan)
+{
+	return chip->data->chan_data[chan]->prd_reg;
+}
+
 static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
@@ -192,7 +210,8 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
-	err = regmap_write(sun4i_pwm->regmap, PWM_CH_PRD(pwm->hwpwm), val);
+	err = regmap_write(sun4i_pwm->regmap,
+			   sunxi_pwm_prd_reg(sun4i_pwm, pwm->hwpwm), val);
 	if (err) {
 		dev_err(chip->dev, "failed to write to PRD register\n");
 		goto err_cleanup;
@@ -256,7 +275,9 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mask |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	ret = regmap_update_bits(sun4i_pwm->regmap, PWM_CTRL_REG, mask, mask);
+	ret = regmap_update_bits(sun4i_pwm->regmap,
+				 sunxi_pwm_ctl_reg(sun4i_pwm, pwm->hwpwm),
+				 mask, mask);
 	if (ret)
 		dev_err(chip->dev, "failed to write to CTL register\n");
 	spin_unlock(&sun4i_pwm->ctrl_lock);
@@ -276,7 +297,9 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mask |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-	err = regmap_update_bits(sun4i_pwm->regmap, PWM_CTRL_REG, mask, 0);
+	err = regmap_update_bits(sun4i_pwm->regmap,
+				 sunxi_pwm_ctl_reg(sun4i_pwm, pwm->hwpwm),
+				 mask, 0);
 	if (err)
 		dev_err(chip->dev, "failed to write to CTL register\n");
 	spin_unlock(&sun4i_pwm->ctrl_lock);
@@ -308,11 +331,25 @@ sun4i_pwm_regfields[SUN4I_MAX_PWM_CHANNELS][NUM_FIELDS] = {
 	},
 };
 
+static const struct sunxi_pwmch_data sun4i_pwm_chan0_data = {
+	.ctl_reg = PWM_CTRL_REG,
+	.prd_reg = PWM_CH_PRD(0),
+};
+
+static const struct sunxi_pwmch_data sun4i_pwm_chan1_data = {
+	.ctl_reg = PWM_CTRL_REG,
+	.prd_reg = PWM_CH_PRD(1),
+};
+
 static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
 	.npwm = 2,
 	.prescaler_table = sun4i_prescaler_table,
+	.chan_data = {
+		&sun4i_pwm_chan0_data,
+		&sun4i_pwm_chan1_data,
+	}
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
@@ -320,6 +357,10 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_rdy = true,
 	.npwm = 2,
 	.prescaler_table = sun4i_prescaler_table,
+	.chan_data = {
+		&sun4i_pwm_chan0_data,
+		&sun4i_pwm_chan1_data,
+	}
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
@@ -327,6 +368,9 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_rdy = true,
 	.npwm = 1,
 	.prescaler_table = sun4i_prescaler_table,
+	.chan_data = {
+		&sun4i_pwm_chan0_data,
+	}
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
@@ -334,6 +378,10 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_rdy = true,
 	.npwm = 2,
 	.prescaler_table = sun4i_prescaler_table,
+	.chan_data = {
+		&sun4i_pwm_chan0_data,
+		&sun4i_pwm_chan1_data,
+	}
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
@@ -341,6 +389,9 @@ static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_rdy = true,
 	.npwm = 1,
 	.prescaler_table = sun4i_prescaler_table,
+	.chan_data = {
+		&sun4i_pwm_chan0_data,
+	}
 };
 
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
-- 
2.4.11
