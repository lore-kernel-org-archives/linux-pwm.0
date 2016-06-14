From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 01/14] pwm: Add an helper to prepare a new PWM state
Date: Tue, 14 Jun 2016 11:13:09 +0200
Message-ID: <1465895602-31008-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The pwm_init_state() helper prepares a new state object containing the
current PWM state except for the polarity and period fields which are
set to the reference values (those in pwm_args).
This is particularly useful for PWM users who want to apply a new
duty-cycle expressed relatively to the reference period without
changing the enable state.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 include/linux/pwm.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 17018f3..a100f6e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -148,6 +148,39 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
 }
 
 /**
+ * pwm_init_state() - prepare a new state to be applied with pwm_apply_state()
+ * @pwm: PWM device
+ * @state: state to fill with the prepared PWM state
+ *
+ * This functions prepares a state that can later be tweaked and applied
+ * to the PWM device with pwm_apply_state(). This is a convenient function
+ * that first retrieves the current PWM state and the replaces the period
+ * and polarity fields with the reference values defined in pwm->args.
+ * Once the function returns, you can adjust the ->enabled and ->duty_cycle
+ * fields according to your needs before calling pwm_apply_state().
+ *
+ * ->duty_cycle is initially set to zero to avoid cases where the current
+ * ->duty_cycle value exceed the pwm_args->period one, which would trigger
+ * an error if the user calls pwm_apply_state() without adjusting ->duty_cycle
+ * first.
+ */
+static inline void pwm_init_state(const struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pwm_args args;
+
+	/* First get the current state. */
+	pwm_get_state(pwm, state);
+
+	/* Then fill it with the reference config */
+	pwm_get_args(pwm, &args);
+
+	state->period = args.period;
+	state->polarity = args.polarity;
+	state->duty_cycle = 0;
+}
+
+/**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
