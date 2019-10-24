Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: implement tracing for .get_state() and .apply_state()
Date: Thu, 24 Oct 2019 10:08:29 +0200
Message-Id: <20191024080829.16783-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

This allows to log all calls to the driver's lowlevel functions which
simplifies debugging in some cases.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I didn't add a trace call to .get_state added in 
01ccf903edd6 ("pwm: Let pwm_get_state() return the last implemented state")
in the expectation that this will be reverted very soon anyhow and
addint it there would only complicate reverting (or applying this
patch).

Best regards
Uwe

 drivers/pwm/core.c         |  9 +++++-
 include/trace/events/pwm.h | 58 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6ad51aa60c03..7af8e5200d1d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -20,6 +20,9 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/pwm.h>
+
 #define MAX_PWMS 1024
 
 static DEFINE_MUTEX(pwm_lookup_lock);
@@ -283,8 +286,10 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
 
-		if (chip->ops->get_state)
+		if (chip->ops->get_state) {
 			chip->ops->get_state(chip, pwm, &pwm->state);
+			trace_pwm_get(pwm, &pwm->state);
+		}
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -472,6 +477,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 		if (err)
 			return err;
 
+		trace_pwm_apply(pwm, state);
+
 		/*
 		 * .apply might have to round some values in *state, if possible
 		 * read the actually implemented value back.
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
new file mode 100644
index 000000000000..cf243de41cc8
--- /dev/null
+++ b/include/trace/events/pwm.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pwm
+
+#if !defined(_TRACE_PWM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PWM_H
+
+#include <linux/pwm.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(pwm,
+
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
+
+	TP_ARGS(pwm, state),
+
+	TP_STRUCT__entry(
+		__field(struct pwm_device *, pwm)
+		__field(u64, period)
+		__field(u64, duty_cycle)
+		__field(enum pwm_polarity, polarity)
+		__field(bool, enabled)
+	),
+
+	TP_fast_assign(
+		__entry->pwm = pwm;
+		__entry->period = state->period;
+		__entry->duty_cycle = state->duty_cycle;
+		__entry->polarity = state->polarity;
+		__entry->enabled = state->enabled;
+	),
+
+	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d",
+		  __entry->pwm, __entry->period, __entry->duty_cycle,
+		  __entry->polarity, __entry->enabled)
+
+);
+
+DEFINE_EVENT(pwm, pwm_apply,
+
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
+
+	TP_ARGS(pwm, state)
+
+);
+
+DEFINE_EVENT(pwm, pwm_get,
+
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
+
+	TP_ARGS(pwm, state)
+
+);
+
+#endif /* _TRACE_PWM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.23.0
