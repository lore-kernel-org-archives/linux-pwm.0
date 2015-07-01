From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 11/15] pwm: add the core infrastructure to allow atomic update
Date: Wed,  1 Jul 2015 10:21:57 +0200
Message-ID: <1435738921-25027-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34394 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753387AbbGAIWa (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 04:22:30 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

Add an ->apply() method to the pwm_ops struct to allow PWM drivers to
implement atomic update.
This method will be prefered over the ->enable(), ->disable() and
->config() methods if available.

Add the pwm_get_state(), pwm_get_default_state() and pwm_apply_state()
functions for PWM users to be able to use the atomic update feature.

Note that the pwm_apply_state() does not guarantee the atomicity of the
update operation, it all depends on the availability and implementation
of the ->apply() method.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  | 110 ++++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/pwm.h |  26 +++++++++++++
 2 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 30631f5..6dafd8e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -238,8 +238,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 	unsigned int i;
 	int ret;
 
-	if (!chip || !chip->dev || !chip->ops || !chip->ops->config ||
-	    !chip->ops->enable || !chip->ops->disable || !chip->npwm)
+	if (!chip || !chip->dev || !chip->ops || (!chip->ops->apply &&
+	    (!chip->ops->config || !chip->ops->enable ||
+	     !chip->ops->disable)) || !chip->npwm)
 		return -EINVAL;
 
 	mutex_lock(&pwm_lock);
@@ -430,7 +431,17 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (!pwm || duty_ns < 0 || period_ns <= 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state = pwm->state;
+
+		state.period = period_ns;
+		state.duty_cycle = duty_ns;
+
+		err = pwm->chip->ops->apply(pwm->chip, pwm, &state);
+	} else {
+		err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
+	}
+
 	if (err)
 		return err;
 
@@ -455,6 +466,17 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (!pwm || !pwm->chip->ops)
 		return -EINVAL;
 
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state = pwm->state;
+
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
 
@@ -477,17 +499,27 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
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
+		struct pwm_state state = pwm->state;
+
+		state.enabled = true;
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
 
@@ -497,13 +529,67 @@ EXPORT_SYMBOL_GPL(pwm_enable);
  */
 void pwm_disable(struct pwm_device *pwm)
 {
-	if (pwm && pwm_is_enabled(pwm)) {
+	if (!pwm || !pwm_is_enabled(pwm))
+		return;
+
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state = pwm->state;
+
+		state.enabled = false;
+		pwm->chip->ops->apply(pwm->chip, pwm, &state);
+	} else {
 		pwm->chip->ops->disable(pwm->chip, pwm);
-		pwm->state.enabled = false;
 	}
+
+	pwm->state.enabled = false;
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
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
+			pwm->state = *state;
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
index b47244a..7e99679 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -151,6 +151,29 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
 }
 
+/*
+ * pwm_apply_state - apply a new state to the PWM device
+ */
+int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
+
+/*
+ * pwm_get_state - retrieve the current PWM state
+ */
+static inline void pwm_get_state(struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	*state = pwm->state;
+}
+
+/*
+ * pwm_get_default_state - retrieve the default PWM state
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
@@ -177,6 +200,9 @@ struct pwm_ops {
 					  struct pwm_device *pwm);
 	void			(*disable)(struct pwm_chip *chip,
 					   struct pwm_device *pwm);
+	int			(*apply)(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const struct pwm_state *state);
 	void			(*init_state)(struct pwm_chip *chip,
 					      struct pwm_device *pwm);
 #ifdef CONFIG_DEBUG_FS
-- 
1.9.1
