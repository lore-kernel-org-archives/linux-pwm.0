From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 02/12] pwm: define a new pwm_state struct
Date: Mon, 21 Sep 2015 11:33:19 +0200
Message-ID: <1442828009-6241-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBDE676XQKGQEV2NHVVQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The PWM state, represented by its period, duty_cycle and polarity,
is currently directly stored in the PWM device.
Declare a pwm_state structure embedding those field so that we can later
use this struct to atomically update all the PWM parameters at once.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/core.c  |  6 +++---
 include/linux/pwm.h | 30 +++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 732375d..09037de 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -446,8 +446,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (err)
 		return err;
 
-	pwm->duty_cycle = duty_ns;
-	pwm->period = period_ns;
+	pwm->state.duty_cycle = duty_ns;
+	pwm->state.period = period_ns;
 
 	return 0;
 }
@@ -480,7 +480,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (err)
 		return err;
 
-	pwm->polarity = polarity;
+	pwm->state.polarity = polarity;
 
 	return 0;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 31239a9..e0e0ed8 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -79,6 +79,18 @@ enum {
 	PWMF_EXPORTED = 1 << 2,
 };
 
+/*
+ * struct pwm_state - state of a PWM channel
+ * @period: PWM period (in nanoseconds)
+ * @duty_cycle: PWM duty cycle (in nanoseconds)
+ * @polarity: PWM polarity
+ */
+struct pwm_state {
+	unsigned int period;
+	unsigned int duty_cycle;
+	enum pwm_polarity polarity;
+};
+
 /**
  * struct pwm_device - PWM channel object
  * @label: name of the PWM device
@@ -87,9 +99,7 @@ enum {
  * @pwm: global index of the PWM device
  * @chip: PWM chip providing this PWM device
  * @chip_data: chip-private data associated with the PWM device
- * @period: period of the PWM signal (in nanoseconds)
- * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
- * @polarity: polarity of the PWM signal
+ * @state: curent PWM channel state
  */
 struct pwm_device {
 	const char *label;
@@ -99,9 +109,7 @@ struct pwm_device {
 	struct pwm_chip *chip;
 	void *chip_data;
 
-	unsigned int period;
-	unsigned int duty_cycle;
-	enum pwm_polarity polarity;
+	struct pwm_state state;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -112,7 +120,7 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 {
 	if (pwm)
-		pwm->period = period;
+		pwm->state.period = period;
 }
 
 static inline void pwm_set_default_period(struct pwm_device *pwm,
@@ -123,7 +131,7 @@ static inline void pwm_set_default_period(struct pwm_device *pwm,
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->period : 0;
+	return pwm ? pwm->state.period : 0;
 }
 
 static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
@@ -134,12 +142,12 @@ static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
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
@@ -155,7 +163,7 @@ static inline void pwm_set_default_polarity(struct pwm_device *pwm,
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
+	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
 }
 
 /**
-- 
1.9.1
