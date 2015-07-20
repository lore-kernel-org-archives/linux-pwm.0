From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 07/10] pwm: add the core infrastructure to allow atomic update
Date: Mon, 20 Jul 2015 17:32:04 +0200
Message-ID: <1437406327-6207-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Doug Anderson <dianders@google.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Add an ->apply() method to the pwm_ops struct to allow PWM drivers to
implement atomic update.
This method will be preferred over the ->enable(), ->disable() and
->config() methods if available.

Add the pwm_get_state(), pwm_get_default_state() and pwm_apply_state()
functions for PWM users to be able to use the atomic update feature.

Note that the pwm_apply_state() does not guarantee the atomicity of the
update operation, it all depends on the availability and implementation
of the ->apply() method.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  | 142 +++++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/pwm.h |  28 +++++++++++
 2 files changed, 158 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 236a8cf..4fe4703 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -46,6 +46,12 @@ static struct pwm_device *pwm_to_device(unsigned int pwm)
 	return radix_tree_lookup(&pwm_tree, pwm);
 }
 
+static void pwm_set_state(struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	pwm->state = *state;
+}
+
 static int alloc_pwms(int pwm, unsigned int count)
 {
 	unsigned int from = 0;
@@ -222,6 +228,19 @@ void *pwm_get_chip_data(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_get_chip_data);
 
+static bool pwm_ops_check(const struct pwm_ops *ops)
+{
+	/* driver supports legacy, non-atomic operation */
+	if (ops->config && ops->enable && ops->disable)
+		return true;
+
+	/* driver supports atomic operation */
+	if (ops->apply)
+		return true;
+
+	return false;
+}
+
 /**
  * pwmchip_add_with_polarity() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -238,8 +257,10 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 	unsigned int i;
 	int ret;
 
-	if (!chip || !chip->dev || !chip->ops || !chip->ops->config ||
-	    !chip->ops->enable || !chip->ops->disable || !chip->npwm)
+	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
+		return -EINVAL;
+
+	if (!pwm_ops_check(chip->ops))
 		return -EINVAL;
 
 	mutex_lock(&pwm_lock);
@@ -430,7 +451,19 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (!pwm || duty_ns < 0 || period_ns <= 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state;
+
+		pwm_get_state(pwm, &state);
+		state.period = period_ns;
+		state.duty_cycle = duty_ns;
+
+		err = pwm->chip->ops->apply(pwm->chip, pwm, &state);
+	} else {
+		err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns,
+					     period_ns);
+	}
+
 	if (err)
 		return err;
 
@@ -455,6 +488,18 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (!pwm || !pwm->chip->ops)
 		return -EINVAL;
 
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state;
+
+		pwm_get_state(pwm, &state);
+		state.polarity = polarity;
+		err = pwm->chip->ops->apply(pwm->chip, pwm, &state);
+		if (!err)
+			pwm->state.polarity = polarity;
+
+		return err;
+	}
+
 	if (!pwm->chip->ops->set_polarity)
 		return -ENOSYS;
 
@@ -477,17 +522,29 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
  */
 int pwm_enable(struct pwm_device *pwm)
 {
-	if (pwm && !pwm_is_enabled(pwm)) {
-		int err;
+	int err;
 
-		err = pwm->chip->ops->enable(pwm->chip, pwm);
-		if (!err)
-			pwm->state.enabled = true;
+	if (!pwm)
+		return -EINVAL;
 
-		return err;
+	if (pwm_is_enabled(pwm))
+		return 0;
+
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state;
+
+		pwm_get_state(pwm, &state);
+		state.enabled = true;
+
+		err = pwm->chip->ops->apply(pwm->chip, pwm, &state);
+	} else {
+		err = pwm->chip->ops->enable(pwm->chip, pwm);
 	}
 
-	return pwm ? 0 : -EINVAL;
+	if (!err)
+		pwm->state.enabled = true;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_enable);
 
@@ -497,13 +554,74 @@ EXPORT_SYMBOL_GPL(pwm_enable);
  */
 void pwm_disable(struct pwm_device *pwm)
 {
-	if (pwm && pwm_is_enabled(pwm)) {
+	if (!pwm || !pwm_is_enabled(pwm))
+		return;
+
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state;
+
+		pwm_get_state(pwm, &state);
+		state.enabled = false;
+
+		pwm->chip->ops->apply(pwm->chip, pwm, &state);
+	} else {
 		pwm->chip->ops->disable(pwm->chip, pwm);
-		pwm->state.enabled = false;
 	}
+
+	pwm->state.enabled = false;
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
+/**
+ * pwm_apply_state() - atomically apply a new state to a PWM device
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	int err = 0;
+
+	if (!pwm)
+		return -EINVAL;
+
+	if (!memcmp(state, &pwm->state, sizeof(*state)))
+		return 0;
+
+	if (pwm->chip->ops->apply) {
+		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
+		if (!err)
+			pwm_set_state(pwm, state);
+	} else {
+		/*
+		 * FIXME: restore the initial state in case of error.
+		 */
+		if (state->polarity != pwm->state.polarity) {
+			pwm_disable(pwm);
+			err = pwm_set_polarity(pwm, state->polarity);
+			if (err)
+				goto out;
+		}
+
+		if (state->period != pwm->state.period ||
+		    state->duty_cycle != pwm->state.duty_cycle) {
+			err = pwm_config(pwm, state->period, state->duty_cycle);
+			if (err)
+				goto out;
+		}
+
+		if (state->enabled != pwm->state.enabled) {
+			if (state->enabled)
+				err = pwm_enable(pwm);
+			else
+				pwm_disable(pwm);
+		}
+	}
+
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(pwm_apply_state);
+
 static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 {
 	struct pwm_chip *chip;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index df78211..25f7bd1 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -160,6 +160,30 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
 }
 
+int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
+
+/**
+ * pwm_get_state() - retrieve the current PWM state
+ * @pwm: PWM device
+ * @state: state to fill with the current PWM state
+ */
+static inline void pwm_get_state(struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	*state = pwm->state;
+}
+
+/**
+ * pwm_get_default_state() - retrieve the default PWM state
+ * @pwm: PWM device
+ * @state: state to fill with the default PWM state
+ */
+static inline void pwm_get_default_state(struct pwm_device *pwm,
+					 struct pwm_state *state)
+{
+	*state = pwm->default_state;
+}
+
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
@@ -168,6 +192,7 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
+ * @apply: atomically apply a new PWM config
  * @reset_state: reset the current PWM state (pwm->state) to the actual
  *		 hardware state. This function is only called once per
  *		 PWM device when the PWM chip is registered.
@@ -189,6 +214,9 @@ struct pwm_ops {
 					  struct pwm_device *pwm);
 	void			(*disable)(struct pwm_chip *chip,
 					   struct pwm_device *pwm);
+	int			(*apply)(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const struct pwm_state *state);
 	void			(*reset_state)(struct pwm_chip *chip,
 					       struct pwm_device *pwm);
 #ifdef CONFIG_DEBUG_FS
-- 
1.9.1
