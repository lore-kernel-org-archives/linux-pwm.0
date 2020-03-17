From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Tue, 17 Mar 2020 14:32:25 +0200
Message-ID: <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
Rename it to PWM_POLARITY_INVERTED.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---

 drivers/pwm/core.c             |  4 ++--
 drivers/pwm/pwm-atmel-hlcdc.c  |  2 +-
 drivers/pwm/pwm-atmel-tcb.c    | 16 ++++++++--------
 drivers/pwm/pwm-atmel.c        |  2 +-
 drivers/pwm/pwm-bcm-iproc.c    |  2 +-
 drivers/pwm/pwm-bcm-kona.c     |  2 +-
 drivers/pwm/pwm-ep93xx.c       |  2 +-
 drivers/pwm/pwm-fsl-ftm.c      |  2 +-
 drivers/pwm/pwm-hibvt.c        |  2 +-
 drivers/pwm/pwm-imx-tpm.c      |  2 +-
 drivers/pwm/pwm-imx27.c        |  4 ++--
 drivers/pwm/pwm-jz4740.c       |  2 +-
 drivers/pwm/pwm-meson.c        |  6 +++---
 drivers/pwm/pwm-omap-dmtimer.c |  4 ++--
 drivers/pwm/pwm-renesas-tpu.c  |  6 +++---
 drivers/pwm/pwm-rockchip.c     |  4 ++--
 drivers/pwm/pwm-sifive.c       |  4 ++--
 drivers/pwm/pwm-sun4i.c        |  2 +-
 drivers/pwm/pwm-tiecap.c       |  2 +-
 drivers/pwm/pwm-tiehrpwm.c     |  4 ++--
 drivers/pwm/pwm-vt8500.c       |  2 +-
 drivers/pwm/pwm-zx.c           |  4 ++--
 drivers/pwm/sysfs.c            |  4 ++--
 include/linux/pwm.h            |  4 ++--
 24 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5a7f6598c05f..08afbb5b98aa 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -152,7 +152,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
 	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+		pwm->args.polarity = PWM_POLARITY_INVERTED;
 
 	return pwm;
 }
@@ -819,7 +819,7 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
 	if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+		pwm->args.polarity = PWM_POLARITY_INVERTED;
 #endif
 
 	return pwm;
diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index dcbc0489dfd4..b53a188479b0 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -270,7 +270,7 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	chip->chip.of_pwm_n_cells = 3;
 
-	ret = pwmchip_add_with_polarity(&chip->chip, PWM_POLARITY_INVERSED);
+	ret = pwmchip_add_with_polarity(&chip->chip, PWM_POLARITY_INVERTED);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 85c53701958c..98526a286347 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -152,7 +152,7 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/*
 	 * If duty is 0 the timer will be stopped and we have to
 	 * configure the output correctly on software trigger:
-	 *  - set output to high if PWM_POLARITY_INVERSED
+	 *  - set output to high if PWM_POLARITY_INVERTED
 	 *  - set output to low if PWM_POLARITY_NORMAL
 	 *
 	 * This is why we're reverting polarity in this case.
@@ -166,13 +166,13 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* flush old setting and set the new one */
 	if (index == 0) {
 		cmr &= ~ATMEL_TC_ACMR_MASK;
-		if (polarity == PWM_POLARITY_INVERSED)
+		if (polarity == PWM_POLARITY_INVERTED)
 			cmr |= ATMEL_TC_ASWTRG_CLEAR;
 		else
 			cmr |= ATMEL_TC_ASWTRG_SET;
 	} else {
 		cmr &= ~ATMEL_TC_BCMR_MASK;
-		if (polarity == PWM_POLARITY_INVERSED)
+		if (polarity == PWM_POLARITY_INVERTED)
 			cmr |= ATMEL_TC_BSWTRG_CLEAR;
 		else
 			cmr |= ATMEL_TC_BSWTRG_SET;
@@ -211,7 +211,7 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/*
 	 * If duty is 0 the timer will be stopped and we have to
 	 * configure the output correctly on software trigger:
-	 *  - set output to high if PWM_POLARITY_INVERSED
+	 *  - set output to high if PWM_POLARITY_INVERTED
 	 *  - set output to low if PWM_POLARITY_NORMAL
 	 *
 	 * This is why we're reverting polarity in this case.
@@ -229,13 +229,13 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		cmr &= ~ATMEL_TC_ACMR_MASK;
 
 		/* Set CMR flags according to given polarity */
-		if (polarity == PWM_POLARITY_INVERSED)
+		if (polarity == PWM_POLARITY_INVERTED)
 			cmr |= ATMEL_TC_ASWTRG_CLEAR;
 		else
 			cmr |= ATMEL_TC_ASWTRG_SET;
 	} else {
 		cmr &= ~ATMEL_TC_BCMR_MASK;
-		if (polarity == PWM_POLARITY_INVERSED)
+		if (polarity == PWM_POLARITY_INVERTED)
 			cmr |= ATMEL_TC_BSWTRG_CLEAR;
 		else
 			cmr |= ATMEL_TC_BSWTRG_SET;
@@ -249,12 +249,12 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	 */
 	if (tcbpwm->duty != tcbpwm->period && tcbpwm->duty > 0) {
 		if (index == 0) {
-			if (polarity == PWM_POLARITY_INVERSED)
+			if (polarity == PWM_POLARITY_INVERTED)
 				cmr |= ATMEL_TC_ACPA_SET | ATMEL_TC_ACPC_CLEAR;
 			else
 				cmr |= ATMEL_TC_ACPA_CLEAR | ATMEL_TC_ACPC_SET;
 		} else {
-			if (polarity == PWM_POLARITY_INVERSED)
+			if (polarity == PWM_POLARITY_INVERTED)
 				cmr |= ATMEL_TC_BCPB_SET | ATMEL_TC_BCPC_CLEAR;
 			else
 				cmr |= ATMEL_TC_BCPB_CLEAR | ATMEL_TC_BCPC_SET;
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 6161e7e3e9ac..2d42f97e4b81 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -329,7 +329,7 @@ static void atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (cmr & PWM_CMR_CPOL)
-		state->polarity = PWM_POLARITY_INVERSED;
+		state->polarity = PWM_POLARITY_INVERTED;
 	else
 		state->polarity = PWM_POLARITY_NORMAL;
 }
diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..574bec61e0ac 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -97,7 +97,7 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (value & BIT(IPROC_PWM_CTRL_POLARITY_SHIFT(pwm->hwpwm)))
 		state->polarity = PWM_POLARITY_NORMAL;
 	else
-		state->polarity = PWM_POLARITY_INVERSED;
+		state->polarity = PWM_POLARITY_INVERTED;
 
 	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
 	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 81da91df2529..02da511814f1 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -303,7 +303,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = pwmchip_add_with_polarity(&kp->chip, PWM_POLARITY_INVERSED);
+	ret = pwmchip_add_with_polarity(&kp->chip, PWM_POLARITY_INVERTED);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 4bab73073ad7..02345b6f9fe8 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -124,7 +124,7 @@ static int ep93xx_pwm_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret)
 		return ret;
 
-	if (polarity == PWM_POLARITY_INVERSED)
+	if (polarity == PWM_POLARITY_INVERTED)
 		writew(0x1, ep93xx_pwm->base + EP93XX_PWMx_INVERT);
 	else
 		writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_INVERT);
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 59272a920479..75dc30978c19 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -287,7 +287,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	regmap_write(fpc->regmap, FTM_CV(pwm->hwpwm), duty);
 
 	reg_polarity = 0;
-	if (newstate->polarity == PWM_POLARITY_INVERSED)
+	if (newstate->polarity == PWM_POLARITY_INVERTED)
 		reg_polarity = BIT(pwm->hwpwm);
 
 	regmap_update_bits(fpc->regmap, FTM_POL, BIT(pwm->hwpwm), reg_polarity);
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index ad205fdad372..c57a94e7da0f 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -120,7 +120,7 @@ static void hibvt_pwm_set_polarity(struct pwm_chip *chip,
 {
 	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
 
-	if (polarity == PWM_POLARITY_INVERSED)
+	if (polarity == PWM_POLARITY_INVERTED)
 		hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CTRL_ADDR(pwm->hwpwm),
 				PWM_POLARITY_MASK, (0x1 << PWM_POLARITY_SHIFT));
 	else
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 9145f6160649..461ab2c08616 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -156,7 +156,7 @@ static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
 	/* get polarity */
 	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
 	if ((val & PWM_IMX_TPM_CnSC_ELS) == PWM_IMX_TPM_CnSC_ELS_INVERSED)
-		state->polarity = PWM_POLARITY_INVERSED;
+		state->polarity = PWM_POLARITY_INVERTED;
 	else
 		/*
 		 * Assume reserved values (2b00 and 2b11) to yield
diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 35a7ac42269c..33d344445254 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -146,7 +146,7 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 		state->polarity = PWM_POLARITY_NORMAL;
 		break;
 	case MX3_PWMCR_POUTC_INVERTED:
-		state->polarity = PWM_POLARITY_INVERSED;
+		state->polarity = PWM_POLARITY_INVERTED;
 		break;
 	default:
 		dev_warn(chip->dev, "can't set polarity, output disconnected");
@@ -280,7 +280,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
 	     MX3_PWMCR_DBGEN;
 
-	if (state->polarity == PWM_POLARITY_INVERSED)
+	if (state->polarity == PWM_POLARITY_INVERTED)
 		cr |= FIELD_PREP(MX3_PWMCR_POUTC,
 				MX3_PWMCR_POUTC_INVERTED);
 
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 9d78cc21cb12..67075d18561f 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -130,7 +130,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	case PWM_POLARITY_NORMAL:
 		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
 		break;
-	case PWM_POLARITY_INVERSED:
+	case PWM_POLARITY_INVERTED:
 		ctrl |= JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
 		break;
 	}
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 6245bbdb6e6c..2d368bfc680d 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -8,7 +8,7 @@
  * N cycles for the first half period.
  * The hardware has no "polarity" setting. This driver reverses the period
  * cycles (the low length is inverted with the high length) for
- * PWM_POLARITY_INVERSED. This means that .get_state cannot read the polarity
+ * PWM_POLARITY_INVERTED. This means that .get_state cannot read the polarity
  * from the hardware.
  * Setting the duty cycle will disable and re-enable the PWM output.
  * Disabling the PWM stops the output immediately (without waiting for the
@@ -168,7 +168,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	duty = state->duty_cycle;
 	period = state->period;
 
-	if (state->polarity == PWM_POLARITY_INVERSED)
+	if (state->polarity == PWM_POLARITY_INVERTED)
 		duty = period - duty;
 
 	fin_freq = clk_get_rate(channel->clk);
@@ -275,7 +275,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		if (state->polarity == PWM_POLARITY_INVERSED) {
+		if (state->polarity == PWM_POLARITY_INVERTED) {
 			/*
 			 * This IP block revision doesn't have an "always high"
 			 * setting which we can use for "inverted disabled".
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 88a3c5690fea..082ccec93133 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -190,7 +190,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 		load_value, load_value,	match_value, match_value);
 
 	omap->pdata->set_pwm(omap->dm_timer,
-			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERTED,
 			      true,
 			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
 
@@ -220,7 +220,7 @@ static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
 	 */
 	mutex_lock(&omap->mutex);
 	omap->pdata->set_pwm(omap->dm_timer,
-			      polarity == PWM_POLARITY_INVERSED,
+			      polarity == PWM_POLARITY_INVERTED,
 			      true,
 			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
 	mutex_unlock(&omap->mutex);
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4a855a21b782..32beeb93ade1 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -108,17 +108,17 @@ static void tpu_pwm_set_pin(struct tpu_pwm_device *pwm,
 	switch (state) {
 	case TPU_PIN_INACTIVE:
 		tpu_pwm_write(pwm, TPU_TIORn,
-			      pwm->polarity == PWM_POLARITY_INVERSED ?
+			      pwm->polarity == PWM_POLARITY_INVERTED ?
 			      TPU_TIOR_IOA_1 : TPU_TIOR_IOA_0);
 		break;
 	case TPU_PIN_PWM:
 		tpu_pwm_write(pwm, TPU_TIORn,
-			      pwm->polarity == PWM_POLARITY_INVERSED ?
+			      pwm->polarity == PWM_POLARITY_INVERTED ?
 			      TPU_TIOR_IOA_0_SET : TPU_TIOR_IOA_1_CLR);
 		break;
 	case TPU_PIN_ACTIVE:
 		tpu_pwm_write(pwm, TPU_TIORn,
-			      pwm->polarity == PWM_POLARITY_INVERSED ?
+			      pwm->polarity == PWM_POLARITY_INVERTED ?
 			      TPU_TIOR_IOA_0 : TPU_TIOR_IOA_1);
 		break;
 	}
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 73352e6fbccb..c6158d559790 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -91,7 +91,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 				 true : false;
 
 	if (pc->data->supports_polarity && !(val & PWM_DUTY_POSITIVE))
-		state->polarity = PWM_POLARITY_INVERSED;
+		state->polarity = PWM_POLARITY_INVERTED;
 	else
 		state->polarity = PWM_POLARITY_NORMAL;
 
@@ -135,7 +135,7 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (pc->data->supports_polarity) {
 		ctrl &= ~PWM_POLARITY_MASK;
-		if (state->polarity == PWM_POLARITY_INVERSED)
+		if (state->polarity == PWM_POLARITY_INVERTED)
 			ctrl |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
 		else
 			ctrl |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index cc63f9baa481..409123405a11 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -124,7 +124,7 @@ static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = ddata->real_period;
 	state->duty_cycle =
 		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
-	state->polarity = PWM_POLARITY_INVERSED;
+	state->polarity = PWM_POLARITY_INVERTED;
 }
 
 static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
@@ -157,7 +157,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret = 0;
 	u32 frac;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_INVERTED)
 		return -EINVAL;
 
 	ret = clk_enable(ddata->clk);
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 3e3efa6c768f..7ddcdefd2a97 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -149,7 +149,7 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 	if (val & BIT_CH(PWM_ACT_STATE, pwm->hwpwm))
 		state->polarity = PWM_POLARITY_NORMAL;
 	else
-		state->polarity = PWM_POLARITY_INVERSED;
+		state->polarity = PWM_POLARITY_INVERTED;
 
 	if ((val & BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm)) ==
 	    BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm))
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index ab38c8203b79..b96b388f0969 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -118,7 +118,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	value = readw(pc->mmio_base + ECCTL2);
 
-	if (polarity == PWM_POLARITY_INVERSED)
+	if (polarity == PWM_POLARITY_INVERTED)
 		/* Duty cycle defines LOW period of PWM */
 		value |= ECCTL2_APWM_POL_LOW;
 	else
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7b4c770ce9d6..71c337443dd5 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -193,7 +193,7 @@ static void configure_polarity(struct ehrpwm_pwm_chip *pc, int chan)
 		aqctl_reg = AQCTLB;
 		aqctl_mask = AQCTL_CBU_MASK;
 
-		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
+		if (pc->polarity[chan] == PWM_POLARITY_INVERTED)
 			aqctl_val = AQCTL_CHANB_POLINVERSED;
 		else
 			aqctl_val = AQCTL_CHANB_POLNORMAL;
@@ -201,7 +201,7 @@ static void configure_polarity(struct ehrpwm_pwm_chip *pc, int chan)
 		aqctl_reg = AQCTLA;
 		aqctl_mask = AQCTL_CAU_MASK;
 
-		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
+		if (pc->polarity[chan] == PWM_POLARITY_INVERTED)
 			aqctl_val = AQCTL_CHANA_POLINVERSED;
 		else
 			aqctl_val = AQCTL_CHANA_POLNORMAL;
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 11d45e56a923..fc434965c5ed 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -165,7 +165,7 @@ static int vt8500_pwm_set_polarity(struct pwm_chip *chip,
 
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 
-	if (polarity == PWM_POLARITY_INVERSED)
+	if (polarity == PWM_POLARITY_INVERTED)
 		val |= CTRL_INVERT;
 	else
 		val &= ~CTRL_INVERT;
diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
index e2c21cc34a96..dc7d20e52c52 100644
--- a/drivers/pwm/pwm-zx.c
+++ b/drivers/pwm/pwm-zx.c
@@ -75,7 +75,7 @@ static void zx_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (value & ZX_PWM_POLAR)
 		state->polarity = PWM_POLARITY_NORMAL;
 	else
-		state->polarity = PWM_POLARITY_INVERSED;
+		state->polarity = PWM_POLARITY_INVERTED;
 
 	if (value & ZX_PWM_EN)
 		state->enabled = true;
@@ -158,7 +158,7 @@ static int zx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->polarity != cstate.polarity)
 		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_POLAR,
-				(state->polarity == PWM_POLARITY_INVERSED) ?
+				(state->polarity == PWM_POLARITY_INVERTED) ?
 				 0 : ZX_PWM_POLAR);
 
 	if (state->period != cstate.period ||
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 2389b8669846..769ac09c56c2 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -166,7 +166,7 @@ static ssize_t polarity_show(struct device *child,
 		polarity = "normal";
 		break;
 
-	case PWM_POLARITY_INVERSED:
+	case PWM_POLARITY_INVERTED:
 		polarity = "inversed";
 		break;
 	}
@@ -187,7 +187,7 @@ static ssize_t polarity_store(struct device *child,
 	if (sysfs_streq(buf, "normal"))
 		polarity = PWM_POLARITY_NORMAL;
 	else if (sysfs_streq(buf, "inversed"))
-		polarity = PWM_POLARITY_INVERSED;
+		polarity = PWM_POLARITY_INVERTED;
 	else
 		return -EINVAL;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0ef808d925bb..38b7ed8ef913 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -16,13 +16,13 @@ struct pwm_chip;
  * @PWM_POLARITY_NORMAL: a high signal for the duration of the duty-
  * cycle, followed by a low signal for the remainder of the pulse
  * period
- * @PWM_POLARITY_INVERSED: a low signal for the duration of the duty-
+ * @PWM_POLARITY_INVERTED: a low signal for the duration of the duty-
  * cycle, followed by a high signal for the remainder of the pulse
  * period
  */
 enum pwm_polarity {
 	PWM_POLARITY_NORMAL,
-	PWM_POLARITY_INVERSED,
+	PWM_POLARITY_INVERTED,
 };
 
 /**
-- 
2.24.1
