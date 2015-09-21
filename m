From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 01/12] pwm: introduce default period and
 polarity concepts
Date: Mon, 21 Sep 2015 11:33:18 +0200
Message-ID: <1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBA4676XQKGQEGYZE76I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

When requested by a user, the PWM is assigned a default period and polarity
extracted from the DT, the platform data or statically set by the driver.
Those default values are currently stored in the period and polarity
fields of the pwm_device struct, but they will be stored somewhere else
once we have introduced the architecture allowing for hardware state
retrieval.

The pwm_set_default_polarity and pwm_set_default_period should only be
used by PWM drivers or the PWM core infrastructure to specify the
default period and polarity values.

PWM users might call the pwm_get_default_period to query the default
period value. There is currently no helper to query the default
polarity, but it might be added later on if there is a need for it.

This patch also modifies all the places where the default helpers should
be used in place of the standard ones.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/leds/leds-pwm.c              |  2 +-
 drivers/pwm/core.c                   | 14 +++++++-------
 drivers/pwm/pwm-pxa.c                |  2 +-
 drivers/pwm/pwm-sun4i.c              |  3 ++-
 drivers/regulator/pwm-regulator.c    |  4 ++--
 drivers/video/backlight/lm3630a_bl.c |  4 ++--
 drivers/video/backlight/pwm_bl.c     |  2 +-
 drivers/video/fbdev/ssd1307fb.c      |  2 +-
 include/linux/pwm.h                  | 17 +++++++++++++++++
 9 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 1d07e3e..2c564d1 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -125,7 +125,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	if (led_data->can_sleep)
 		INIT_WORK(&led_data->work, led_pwm_work);
 
-	led_data->period = pwm_get_period(led_data->pwm);
+	led_data->period = pwm_get_default_period(led_data->pwm);
 	if (!led_data->period && (led->pwm_period_ns > 0))
 		led_data->period = led->pwm_period_ns;
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3f9df3e..732375d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -146,12 +146,12 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm_set_period(pwm, args->args[1]);
+	pwm_set_default_period(pwm, args->args[1]);
 
 	if (args->args[2] & PWM_POLARITY_INVERTED)
-		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
+		pwm_set_default_polarity(pwm, PWM_POLARITY_INVERSED);
 	else
-		pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+		pwm_set_default_polarity(pwm, PWM_POLARITY_NORMAL);
 
 	return pwm;
 }
@@ -172,7 +172,7 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm_set_period(pwm, args->args[1]);
+	pwm_set_default_period(pwm, args->args[1]);
 
 	return pwm;
 }
@@ -268,7 +268,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->chip = chip;
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
-		pwm->polarity = polarity;
+		pwm_set_default_polarity(pwm, polarity);
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -730,8 +730,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	if (IS_ERR(pwm))
 		goto out;
 
-	pwm_set_period(pwm, chosen->period);
-	pwm_set_polarity(pwm, chosen->polarity);
+	pwm_set_default_period(pwm, chosen->period);
+	pwm_set_default_polarity(pwm, chosen->polarity);
 
 out:
 	mutex_unlock(&pwm_lookup_lock);
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cb2f702..65b80aa 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -160,7 +160,7 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm_set_period(pwm, args->args[0]);
+	pwm_set_default_period(pwm, args->args[0]);
 
 	return pwm;
 }
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index cd9dde5..a364fb7 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -333,7 +333,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
 	for (i = 0; i < pwm->chip.npwm; i++)
 		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
-			pwm->chip.pwms[i].polarity = PWM_POLARITY_INVERSED;
+			pwm_set_default_polarity(&pwm->chip.pwms[i],
+						 PWM_POLARITY_INVERSED);
 	clk_disable_unprepare(pwm->clk);
 
 	return 0;
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index fc3166d..cc549b7 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -56,7 +56,7 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	int dutycycle;
 	int ret;
 
-	pwm_reg_period = pwm_get_period(drvdata->pwm);
+	pwm_reg_period = pwm_get_default_period(drvdata->pwm);
 
 	dutycycle = (pwm_reg_period *
 		    drvdata->duty_cycle_table[selector].dutycycle) / 100;
@@ -114,7 +114,7 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 	unsigned int ramp_delay = rdev->constraints->ramp_delay;
-	unsigned int period = pwm_get_period(drvdata->pwm);
+	unsigned int period = pwm_get_default_period(drvdata->pwm);
 	int duty_cycle;
 	int ret;
 
diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 35fe482..449ebc3 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -162,7 +162,7 @@ static int lm3630a_intr_config(struct lm3630a_chip *pchip)
 
 static void lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
 {
-	unsigned int period = pwm_get_period(pchip->pwmd);
+	unsigned int period = pwm_get_default_period(pchip->pwmd);
 	unsigned int duty = br * period / br_max;
 
 	pwm_config(pchip->pwmd, duty, period);
@@ -425,7 +425,7 @@ static int lm3630a_probe(struct i2c_client *client,
 			return PTR_ERR(pchip->pwmd);
 		}
 	}
-	pchip->pwmd->period = pdata->pwm_period;
+	pwm_set_default_period(pchip->pwmd, pdata->pwm_period);
 
 	/* interrupt enable  : irq 0 is not allowed */
 	pchip->irq = client->irq;
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index eff379b..ae498c1 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -294,7 +294,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	 * set the period from platform data if it has not already been set
 	 * via the PWM lookup table.
 	 */
-	pb->period = pwm_get_period(pb->pwm);
+	pb->period = pwm_get_default_period(pb->pwm);
 	if (!pb->period && (data->pwm_period_ns > 0)) {
 		pb->period = data->pwm_period_ns;
 		pwm_set_period(pb->pwm, data->pwm_period_ns);
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 93f4c90..ab3daf0 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -294,7 +294,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 			return PTR_ERR(par->pwm);
 		}
 
-		par->pwm_period = pwm_get_period(par->pwm);
+		par->pwm_period = pwm_get_default_period(par->pwm);
 		/* Enable the PWM */
 		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
 		pwm_enable(par->pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d681f68..31239a9 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -115,11 +115,22 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 		pwm->period = period;
 }
 
+static inline void pwm_set_default_period(struct pwm_device *pwm,
+					  unsigned int period)
+{
+	pwm_set_period(pwm, period);
+}
+
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
 	return pwm ? pwm->period : 0;
 }
 
+static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
+{
+	return pwm_get_period(pwm);
+}
+
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 {
 	if (pwm)
@@ -136,6 +147,12 @@ static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
  */
 int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
 
+static inline void pwm_set_default_polarity(struct pwm_device *pwm,
+					    enum pwm_polarity polarity)
+{
+	pwm_set_polarity(pwm, polarity);
+}
+
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
 	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
-- 
1.9.1
