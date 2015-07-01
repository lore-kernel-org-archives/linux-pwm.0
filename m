From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [RFC PATCH 09/15] pwm: declare a default PWM state
Date: Wed,  1 Jul 2015 10:21:55 +0200
Message-ID: <1435738921-25027-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Prepare the addition of the PWM initial state retrieval by adding a default
state where all the parameters retrieved from DT, platform data or
statically forced by the hardware will be stored.
Once done we will be able to store the initial state in the ->state field
without risking to loose the default parameters.

Update the pwm_set/get_default_xxx helpers accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 include/linux/pwm.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index fd3e0f0..0f36a06 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -94,6 +94,7 @@ struct pwm_device {
 	void			*chip_data;
 
 	struct pwm_state	state;
+	struct pwm_state	default_state;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -109,7 +110,8 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 
 static inline void pwm_set_default_period(struct pwm_device *pwm, unsigned int period)
 {
-	pwm_set_period(pwm, period);
+	if (pwm)
+		pwm->default_state.period = period;
 }
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
@@ -119,7 +121,7 @@ static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 
 static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
 {
-	return pwm_get_period(pwm);
+	return pwm ? pwm->default_state.period : 0;
 }
 
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
@@ -140,7 +142,8 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
 
 static inline void pwm_set_default_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 {
-	pwm_set_polarity(pwm, polarity);
+	if (pwm)
+		pwm->default_state.polarity = polarity;
 }
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
-- 
1.9.1
