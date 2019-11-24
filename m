From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v9 5/6] pwm: sun4i: Add support to output source
 clock directly
Date: Sun, 24 Nov 2019 18:29:07 +0100
Message-ID: <20191124172908.10804-6-peron.clem@gmail.com>
References: <20191124172908.10804-1-peron.clem@gmail.com>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBBIX45LXAKGQEJYEXZMA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20191124172908.10804-1-peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <pza-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>

PWM core has an option to bypass whole logic and output unchanged source
clock as PWM output. This is achieved by enabling bypass bit.

Note that when bypass is enabled, no other setting has any meaning, not
even enable bit.

This mode of operation is needed to achieve high enough frequency to
serve as clock source for AC200 chip which is integrated into same
package as H6 SoC.

Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index e369b5a398f4..07bf7be6074b 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -3,6 +3,10 @@
  * Driver for Allwinner sun4i Pulse Width Modulation Controller
  *
  * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electrons.=
com>
+ *
+ * Limitations:
+ * - When outputing the source clock directly, the PWM logic will be bypas=
sed
+ *   and the currently running period is not guaranteed to be completed
  */
=20
 #include <linux/bitops.h>
@@ -73,6 +77,7 @@ static const u32 prescaler_table[] =3D {
=20
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
+	bool has_direct_mod_clk_output;
 	unsigned int npwm;
 };
=20
@@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
=20
 	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
=20
+	/*
+	 * PWM chapter in H6 manual has a diagram which explains that if bypass
+	 * bit is set, no other setting has any meaning. Even more, experiment
+	 * proved that also enable bit is ignored in this case.
+	 */
+	if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
+	    sun4i_pwm->data->has_direct_mod_clk_output) {
+		state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate);
+		state->duty_cycle =3D DIV_ROUND_UP_ULL(state->period, 2);
+		state->polarity =3D PWM_POLARITY_NORMAL;
+		state->enabled =3D true;
+		return;
+	}
+
 	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
 	    sun4i_pwm->data->has_prescaler_bypass)
 		prescaler =3D 1;
@@ -149,13 +168,24 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip=
,
=20
 static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 			       const struct pwm_state *state,
-			       u32 *dty, u32 *prd, unsigned int *prsclr)
+			       u32 *dty, u32 *prd, unsigned int *prsclr,
+			       bool *bypass)
 {
 	u64 clk_rate, div =3D 0;
 	unsigned int pval, prescaler =3D 0;
=20
 	clk_rate =3D clk_get_rate(sun4i_pwm->clk);
=20
+	*bypass =3D sun4i_pwm->data->has_direct_mod_clk_output &&
+		  state->enabled &&
+		  (state->period * clk_rate >=3D NSEC_PER_SEC) &&
+		  (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
+		  (state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC);
+
+	/* Skip calculation of other parameters if we bypass them */
+	if (*bypass)
+		return 0;
+
 	if (sun4i_pwm->data->has_prescaler_bypass) {
 		/* First, test without any prescaler when available */
 		prescaler =3D PWM_PRESCAL_MASK;
@@ -206,6 +236,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 	int ret;
 	unsigned int delay_us, prescaler;
 	unsigned long now;
+	bool bypass;
=20
 	pwm_get_state(pwm, &cstate);
=20
@@ -220,7 +251,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
=20
-	ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler)=
;
+	ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
+				  &bypass);
 	if (ret) {
 		dev_err(chip->dev, "period exceeds the maximum value\n");
 		spin_unlock(&sun4i_pwm->ctrl_lock);
@@ -229,6 +261,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 		return ret;
 	}
=20
+	if (sun4i_pwm->data->has_direct_mod_clk_output) {
+		if (bypass) {
+			ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
+			/* We can skip other parameter */
+			sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+			spin_unlock(&sun4i_pwm->ctrl_lock);
+			return 0;
+		} else {
+			ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
+		}
+	}
+
 	if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) !=3D prescaler) {
 		/* Prescaler changed, the clock has to be gated */
 		ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
--=20
2.20.1

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/20191124172908.10804-6-peron.clem%40gmail.com.
