From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 06/15] pwm: define a new pwm_state struct
Date: Wed,  1 Jul 2015 10:21:52 +0200
Message-ID: <1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34306 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753168AbbGAIWT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 04:22:19 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

The PWM state, represented by its period, duty_cycle and polarity,
is currently directly stored in the PWM device.
Declare a pwm_state structure embedding those field so that we can later
use this struct to atomically update all the PWM parameters at once.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  |  6 +++---
 include/linux/pwm.h | 20 ++++++++++++--------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7ffad2b..a6bc8e6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -431,8 +431,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (err)
 		return err;
 
-	pwm->duty_cycle = duty_ns;
-	pwm->period = period_ns;
+	pwm->state.duty_cycle = duty_ns;
+	pwm->state.period = period_ns;
 
 	return 0;
 }
@@ -462,7 +462,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (err)
 		return err;
 
-	pwm->polarity = polarity;
+	pwm->state.polarity = polarity;
 
 	return 0;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 72a21d5..bed7234 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -79,6 +79,12 @@ enum {
 	PWMF_EXPORTED = 1 << 2,
 };
 
+struct pwm_state {
+	unsigned int		period; 	/* in nanoseconds */
+	unsigned int		duty_cycle;	/* in nanoseconds */
+	enum pwm_polarity	polarity;
+};
+
 struct pwm_device {
 	const char		*label;
 	unsigned long		flags;
@@ -87,9 +93,7 @@ struct pwm_device {
 	struct pwm_chip		*chip;
 	void			*chip_data;
 
-	unsigned int		period; 	/* in nanoseconds */
-	unsigned int		duty_cycle;	/* in nanoseconds */
-	enum pwm_polarity	polarity;
+	struct pwm_state	state;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -100,7 +104,7 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 {
 	if (pwm)
-		pwm->period = period;
+		pwm->state.period = period;
 }
 
 static inline void pwm_set_default_period(struct pwm_device *pwm, unsigned int period)
@@ -110,7 +114,7 @@ static inline void pwm_set_default_period(struct pwm_device *pwm, unsigned int p
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->period : 0;
+	return pwm ? pwm->state.period : 0;
 }
 
 static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
@@ -121,12 +125,12 @@ static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 {
 	if (pwm)
-		pwm->duty_cycle = duty;
+		pwm->state.duty_cycle = duty;
 }
 
 static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->duty_cycle : 0;
+	return pwm ? pwm->state.duty_cycle : 0;
 }
 
 /*
@@ -141,7 +145,7 @@ static inline void pwm_set_default_polarity(struct pwm_device *pwm, enum pwm_pol
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
+	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
 }
 
 /**
-- 
1.9.1
