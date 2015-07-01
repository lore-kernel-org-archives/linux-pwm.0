From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 07/15] pwm: move the enabled/disabled info to pwm_state struct
Date: Wed,  1 Jul 2015 10:21:53 +0200
Message-ID: <1435738921-25027-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Prepare the transition to PWM atomic update by moving the enabled/disabled
state into the pwm_state struct. This way we can easily update the whole
PWM state by copying the new state in the ->state field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  | 15 ++++++++++++---
 include/linux/pwm.h |  6 +++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a6bc8e6..3e830ce 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -474,8 +474,15 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
  */
 int pwm_enable(struct pwm_device *pwm)
 {
-	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
-		return pwm->chip->ops->enable(pwm->chip, pwm);
+	if (pwm && !pwm_is_enabled(pwm)) {
+		int err;
+
+		err = pwm->chip->ops->enable(pwm->chip, pwm);
+		if (!err)
+			pwm->state.enabled = true;
+
+		return err;
+	}
 
 	return pwm ? 0 : -EINVAL;
 }
@@ -487,8 +494,10 @@ EXPORT_SYMBOL_GPL(pwm_enable);
  */
 void pwm_disable(struct pwm_device *pwm)
 {
-	if (pwm && test_and_clear_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm && pwm_is_enabled(pwm)) {
 		pwm->chip->ops->disable(pwm->chip, pwm);
+		pwm->state.enabled = false;
+	}
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index bed7234..fd3e0f0 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -75,14 +75,14 @@ enum pwm_polarity {
 
 enum {
 	PWMF_REQUESTED = 1 << 0,
-	PWMF_ENABLED = 1 << 1,
-	PWMF_EXPORTED = 1 << 2,
+	PWMF_EXPORTED = 1 << 1,
 };
 
 struct pwm_state {
 	unsigned int		period; 	/* in nanoseconds */
 	unsigned int		duty_cycle;	/* in nanoseconds */
 	enum pwm_polarity	polarity;
+	bool			enabled;
 };
 
 struct pwm_device {
@@ -98,7 +98,7 @@ struct pwm_device {
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 {
-	return test_bit(PWMF_ENABLED, &pwm->flags);
+	return pwm->state.enabled;
 }
 
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
-- 
1.9.1
