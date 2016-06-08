From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 01/13] pwm: Add new helpers to create/manipulate PWM states
Date: Wed,  8 Jun 2016 18:34:36 +0200
Message-ID: <1465403688-17098-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58986 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757901AbcFHQfH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jun 2016 12:35:07 -0400
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

The pwm_prepare_new_state() helper prepares a new state object
containing the current PWM state except for the polarity and period
fields which are set to the reference values.
This is particurly useful for PWM users who want to apply a new
duty-cycle expressed relatively to the reference period without
changing the enable state.

The PWM framework expect PWM users to configure the duty cycle in
nanosecond, but most users just want to express this duty cycle
relatively to the period value (i.e. duty_cycle = 33% of the period).
Add pwm_{get,set}_relative_duty_cycle() helpers to ease this kind of
conversion.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/pwm.h | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 17018f3..e09babf 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -148,6 +148,87 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
 }
 
 /**
+ * pwm_prepare_new_state() - prepare a new state to be applied with
+ *			     pwm_apply_state()
+ * @pwm: PWM device
+ * @state: state to fill with the prepared PWM state
+ *
+ * This functions prepares a state that can later be tweaked and applied
+ * to the PWM device with pwm_apply_state(). This is a convenient function
+ * that first retrieves the current PWM state and the replaces the period
+ * and polarity fields with the reference values defined in pwm->args.
+ * Once the new state is created you can adjust the ->enable and ->duty_cycle
+ * according to your need before calling pwm_apply_state().
+ */
+static inline void pwm_prepare_new_state(const struct pwm_device *pwm,
+					 struct pwm_state *state)
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
+ * pwm_get_relative_duty_cycle() - Get a relative duty_cycle value
+ * @state: the PWM state to extract period and duty_cycle from
+ * @scale: the scale you want to use for you relative duty_cycle value
+ *
+ * This functions converts the absolute duty_cycle stored in @state
+ * (expressed in nanosecond) into a relative value.
+ * For example if you want to get the duty_cycle expressed in nanosecond,
+ * call:
+ *
+ * pwm_get_state(pwm, &state);
+ * duty = pwm_get_relative_duty_cycle(&state, 100);
+ */
+static inline unsigned int
+pwm_get_relative_duty_cycle(const struct pwm_state *state, unsigned int scale)
+{
+	if (!state->period)
+		return 0;
+
+	return DIV_ROUND_CLOSEST_ULL((u64)state->duty_cycle * scale,
+				     state->period);
+}
+
+/**
+ * pwm_set_relative_duty_cycle() - Set a relative duty_cycle value
+ * @state: the PWM state to fill
+ * @val: the relative duty_cycle value
+ * @scale: the scale you use for you relative duty_cycle value
+ *
+ * This functions converts a relative duty_cycle stored into an absolute
+ * one (expressed in nanoseconds), and put the result in state->duty_cycle.
+ * For example if you want to change configure a 50% duty_cycle, call:
+ *
+ * pwm_prepare_new_state(pwm, &state);
+ * pwm_set_relative_duty_cycle(&state, 50, 100);
+ * pwm_apply_state(pwm, &state);
+ */
+static inline void
+pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int val,
+			    unsigned int scale)
+{
+	if (!scale)
+		return;
+
+	/* Make sure we don't have duty_cycle > period */
+	if (val > scale)
+		val = scale;
+
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)val * state->period,
+						  scale);
+}
+
+/**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
-- 
2.7.4
