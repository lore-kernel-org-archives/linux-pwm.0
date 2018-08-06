Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 6 Aug 2018 17:51:29 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: RFC: don't let drivers issue pwm_disable after pwm_config(pwm, 0,
 period)
Message-ID: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

(If you have a d=E9j=E0 vu: Yes, I tried to argue this case already in the
past, it's just that I'm just faced with a new use case that's broken
with the current state.)

Currently the idiom

	pwm_config(mypwm, value, period);
	if (!value)
		pwm_disable(mypwm);
	else
		pwm_enable(mypwm);

(and it's equivalent:

	state.duty_cycle =3D ...
	state.enable =3D state.duty_cycle ? true : false;
	pwm_apply_state(...);

) is quite present in the kernel.

In my eyes this is bad for two reasons:

 a) if the caller is supposed to call pwm_disable() after configuring the
    duty cycle to zero, then why doesn't pwm_config() contains this to
    unburden pwm-API users and so reduce open coding this assumption?

 b) it is actually wrong in at least two cases:
    - On i.MX28 pwm_config(mypwm, 0, period) only programs a register
      and only after the current period is elapsed this is clocked into
      the hardware. So it is very likely that when pwm_disable() is
      called the period is still not over, and then the clk is disabled
      and the period never ends resulting in the pwm pin being frozen in
      whatever state it happend to be when the clk was stopped.
    - on i.MX6 if a pwm is inverted pwm_config(mypwm, 0, period)
      correctly ensures the PWM pin to stay at 1. But then pwm_disable()
      puts it to 0. In the current case this implies that the backlight
      is fully enabled instead of off.

Both issues are hard (or at least ugly) to fix. The IMHO most sane
approach is to not let PWM-API-users care about power saving when they
still care about the output level and update the samantic of
pwm_disable() (and struct pwm_state::enabled =3D=3D 0) to mean: "Stop
toggling, I don't care about the level of the output." in contrast to
the current semantic "Stop toggling. If pwm_config(mypwm, 0, period) was
called before, stop the pin at (maybe inverted) low level (for most pwms
at least).".

This is in my eyes more clear, removes code duplication and power saving
can (and should) be implemented in the pwm backend drivers that have the
domain specific knowledge about the effects of pwm_disable and
eventually unwanted side effects when duty cycle is 0 and just do the
corresponding action if its safe. We could even put something like:

	if (pwm->flags & PWM_AUTO_DISABLE && pwm->period =3D=3D 0)
		pwm_disable(pwm);

in pwm_config to help backend driver authors of "sane" PWMs.

I grepped in the kernel for callers of pwm_disable and adapted them for
this. I didn't verify all changes are correct, so take with a grain of
salt. The only fishy one is drivers/gpu/drm/i915/intel_panel.c in my
eyes, I'm not sure about drivers/pwm/pwm-lpc18xx-sct.c.

See below for my wip changes.

Looking forward to your comments.

Best regards
Uwe

diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/ma=
ch-rx1950.c
index 7f5a18fa305b..55db3b63add8 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -429,7 +429,6 @@ static void rx1950_lcd_power(int enable)
 		/* GPB1->OUTPUT, GPB1->0 */
 		gpio_direction_output(S3C2410_GPB(1), 0);
 		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
-		pwm_disable(lcd_pwm);
=20
 		/* GPC0->0, GPC10->0 */
 		gpio_direction_output(S3C2410_GPC(0), 0);
diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/inte=
l_panel.c
index b443278e569c..a2b0e5f74ac8 100644
--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -784,8 +784,6 @@ static void pwm_disable_backlight(const struct drm_conn=
ector_state *old_conn_sta
=20
 	/* Disable the backlight */
 	pwm_config(panel->backlight.pwm, 0, CRC_PMIC_PWM_PERIOD_NS);
-	usleep_range(2000, 3000);
-	pwm_disable(panel->backlight.pwm);
 }
=20
 void intel_panel_disable_backlight(const struct drm_connector_state *old_c=
onn_state)
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7838af58f92d..0f1b597bb252 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -51,7 +51,7 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned l=
ong pwm)
 	pwm_init_state(ctx->pwm, &state);
 	period =3D ctx->pwm->args.period;
 	state.duty_cycle =3D DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
-	state.enabled =3D pwm ? true : false;
+	state.enabled =3D true;
=20
 	ret =3D pwm_apply_state(ctx->pwm, &state);
 	if (!ret)
@@ -244,8 +244,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
 		dev_err(&pdev->dev, "Failed to register hwmon device\n");
-		ret =3D PTR_ERR(hwmon);
-		goto err_pwm_disable;
+		return PTR_ERR(hwmon);
 	}
=20
 	ret =3D pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
@@ -260,20 +259,13 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		if (IS_ERR(cdev)) {
 			dev_err(&pdev->dev,
 				"Failed to register pwm-fan as cooling device");
-			ret =3D PTR_ERR(cdev);
-			goto err_pwm_disable;
+			return PTR_ERR(cdev);
 		}
 		ctx->cdev =3D cdev;
 		thermal_cdev_update(cdev);
 	}
=20
 	return 0;
-
-err_pwm_disable:
-	state.enabled =3D false;
-	pwm_apply_state(ctx->pwm, &state);
-
-	return ret;
 }
=20
 static int pwm_fan_remove(struct platform_device *pdev)
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index df80c89ebe7f..755e13721a16 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -40,11 +40,6 @@ static void __led_pwm_set(struct led_pwm_data *led_dat)
 	int new_duty =3D led_dat->duty;
=20
 	pwm_config(led_dat->pwm, new_duty, led_dat->period);
-
-	if (new_duty =3D=3D 0)
-		pwm_disable(led_dat->pwm);
-	else
-		pwm_enable(led_dat->pwm);
 }
=20
 static int led_pwm_set(struct led_classdev *led_cdev,
@@ -105,6 +100,8 @@ static int led_pwm_add(struct device *dev, struct led_p=
wm_priv *priv,
 		return ret;
 	}
=20
+	pwm_enable(led_data->pwm);
+
 	led_data->cdev.brightness_set_blocking =3D led_pwm_set;
=20
 	/*

(This should better make use of pwm_state instead.)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..38f17c8b6364 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -864,6 +864,8 @@ void pwm_put(struct pwm_device *pwm)
 	if (!pwm)
 		return;
=20
+	pwm_disable(pwm);
+
 	mutex_lock(&pwm_lock);
=20
 	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index d7f5f7de030d..61125052ac3d 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -306,8 +306,6 @@ static void lpc18xx_pwm_free(struct pwm_chip *chip, str=
uct pwm_device *pwm)
 	struct lpc18xx_pwm_chip *lpc18xx_pwm =3D to_lpc18xx_pwm_chip(chip);
 	struct lpc18xx_pwm_data *lpc18xx_data =3D pwm_get_chip_data(pwm);
=20
-	pwm_disable(pwm);
-	pwm_set_duty_cycle(pwm, 0);
 	clear_bit(lpc18xx_data->duty_event, &lpc18xx_pwm->event_map);
 }
=20
diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight=
/lm3630a_bl.c
index 2030a6b77a09..293abb823fde 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -165,12 +165,15 @@ static void lm3630a_pwm_ctrl(struct lm3630a_chip *pch=
ip, int br, int br_max)
 {
 	unsigned int period =3D pchip->pdata->pwm_period;
 	unsigned int duty =3D br * period / br_max;
+	struct pwm_state state;
=20
-	pwm_config(pchip->pwmd, duty, period);
-	if (duty)
-		pwm_enable(pchip->pwmd);
-	else
-		pwm_disable(pchip->pwmd);
+	pwm_get_state(pchip->pwmd);
+
+	state.duty_cycle =3D duty;
+	state.period =3D period;
+	state.enabled =3D true;
+
+	pwm_apply_state(pchip->pwmd, &state);
 }
=20
 /* update and get brightness */
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/=
lp855x_bl.c
index 73612485ed07..ba4e71b99c45 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -240,6 +240,7 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, =
int max_br)
 	unsigned int period =3D lp->pdata->period_ns;
 	unsigned int duty =3D br * period / max_br;
 	struct pwm_device *pwm;
+	struct pwm_state state;
=20
 	/* request pwm device with the consumer name */
 	if (!lp->pwm) {
@@ -248,19 +249,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br=
, int max_br)
 			return;
=20
 		lp->pwm =3D pwm;
-
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(pwm);
 	}
=20
-	pwm_config(lp->pwm, duty, period);
-	if (duty)
-		pwm_enable(lp->pwm);
-	else
-		pwm_disable(lp->pwm);
+	pwm_get_state(lp->pwm, &state);
+
+	state.duty =3D duty;
+	state.period =3D period;
+	state.enabled =3D true;
+
+	pwm_apply_state(lp->pwm, &state);
 }
=20
 static int lp855x_bl_update_status(struct backlight_device *bl)
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm=
_bl.c
index 44ac5bde4e9d..e60831f3e29a 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -46,18 +46,42 @@ struct pwm_bl_data {
 	void			(*exit)(struct device *);
 };
=20
+static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
+{
+	unsigned int lth =3D pb->lth_brightness;
+	u64 duty_cycle;
+
+	if (pb->levels)
+		duty_cycle =3D pb->levels[brightness];
+	else
+		duty_cycle =3D brightness;
+
+	duty_cycle *=3D pb->period - lth;
+	do_div(duty_cycle, pb->scale);
+
+	return duty_cycle + lth;
+}
+
 static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 {
 	int err;
+	int duty_cycle;
+	struct pwm_state state;
=20
 	if (pb->enabled)
 		return;
=20
+	duty_cycle =3D compute_duty_cycle(pb, brightness);
+
 	err =3D regulator_enable(pb->power_supply);
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
=20
-	pwm_enable(pb->pwm);
+	pwm_get_state(pb->pwm, &state);
+	state.duty_cycle =3D duty_cycle;
+	state.period =3D pb->period;
+	state.enabled =3D true;
+	pwm_apply_state(pb->pwm, &state);
=20
 	if (pb->post_pwm_on_delay)
 		msleep(pb->post_pwm_on_delay);
@@ -80,33 +104,15 @@ static void pwm_backlight_power_off(struct pwm_bl_data=
 *pb)
 		msleep(pb->pwm_off_delay);
=20
 	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
=20
 	regulator_disable(pb->power_supply);
 	pb->enabled =3D false;
 }
=20
-static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
-{
-	unsigned int lth =3D pb->lth_brightness;
-	u64 duty_cycle;
-
-	if (pb->levels)
-		duty_cycle =3D pb->levels[brightness];
-	else
-		duty_cycle =3D brightness;
-
-	duty_cycle *=3D pb->period - lth;
-	do_div(duty_cycle, pb->scale);
-
-	return duty_cycle + lth;
-}
-
 static int pwm_backlight_update_status(struct backlight_device *bl)
 {
 	struct pwm_bl_data *pb =3D bl_get_data(bl);
 	int brightness =3D bl->props.brightness;
-	int duty_cycle;
=20
 	if (bl->props.power !=3D FB_BLANK_UNBLANK ||
 	    bl->props.fb_blank !=3D FB_BLANK_UNBLANK ||
@@ -116,11 +122,9 @@ static int pwm_backlight_update_status(struct backligh=
t_device *bl)
 	if (pb->notify)
 		brightness =3D pb->notify(pb->dev, brightness);
=20
-	if (brightness > 0) {
-		duty_cycle =3D compute_duty_cycle(pb, brightness);
-		pwm_config(pb->pwm, duty_cycle, pb->period);
+	if (brightness > 0)
 		pwm_backlight_power_on(pb, brightness);
-	} else
+	else
 		pwm_backlight_power_off(pb);
=20
 	if (pb->notify_after)
@@ -353,12 +357,6 @@ static int pwm_backlight_probe(struct platform_device =
*pdev)
=20
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
=20
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(pb->pwm);
-
 	/*
 	 * The DT case will set the pwm_period_ns field to 0 and store the
 	 * period, parsed from the DT, in the PWM device. For the non-DT case,
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
