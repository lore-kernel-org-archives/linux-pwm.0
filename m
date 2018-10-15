Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 15 Oct 2018 10:21:52 +0200
Message-Id: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [PATCH] PWM: drop legacy wrapper for changing polarity
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
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, =?UTF-8?q?Vok=C3=A1=C4=8D=20Michal?= <Michal.Vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

The API to configure a PWM using pwm_enable(), pwm_disable(),
pwm_config() and pwm_set_polarity() is superseeded by atomically setting
the parameters using pwm_apply_state(). To get forward with deprecating
the former set of functions use the opportunity that there is no current
user of pwm_set_polarity() and remove it.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 56518adc31dd..d5199b507d79 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -348,42 +348,6 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 	return pwm_apply_state(pwm, &state);
 }
 
-/**
- * pwm_set_polarity() - configure the polarity of a PWM signal
- * @pwm: PWM device
- * @polarity: new polarity of the PWM signal
- *
- * Note that the polarity cannot be configured while the PWM device is
- * enabled.
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-static inline int pwm_set_polarity(struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
-{
-	struct pwm_state state;
-
-	if (!pwm)
-		return -EINVAL;
-
-	pwm_get_state(pwm, &state);
-	if (state.polarity == polarity)
-		return 0;
-
-	/*
-	 * Changing the polarity of a running PWM without adjusting the
-	 * dutycycle/period value is a bit risky (can introduce glitches).
-	 * Return -EBUSY in this case.
-	 * Note that this is allowed when using pwm_apply_state() because
-	 * the user specifies all the parameters.
-	 */
-	if (state.enabled)
-		return -EBUSY;
-
-	state.polarity = polarity;
-	return pwm_apply_state(pwm, &state);
-}
-
 /**
  * pwm_enable() - start a PWM output toggling
  * @pwm: PWM device
@@ -483,12 +447,6 @@ static inline int pwm_capture(struct pwm_device *pwm,
 	return -EINVAL;
 }
 
-static inline int pwm_set_polarity(struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
-{
-	return -ENOTSUPP;
-}
-
 static inline int pwm_enable(struct pwm_device *pwm)
 {
 	return -EINVAL;
-- 
2.19.1
