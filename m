Return-Path: <matthieu.castet@gmail.com>
Return-Path: <matthieu.castet@gmail.com>
Sender: Castet Matthieu <matthieu.castet@gmail.com>
From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH] pwm: Add tracepoint for apply state
Date: Fri,  3 Aug 2018 16:00:29 +0200
Message-Id: <20180803140029.29810-1-matthieu.castet@parrot.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthieu CASTET <matthieu.castet@parrot.com>

This allows to trace pwm with ftrace

Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
---
 drivers/pwm/core.c         |  5 ++++
 include/trace/events/pwm.h | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/trace/events/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..4342974af31a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -32,6 +32,9 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/pwm.h>
+
 #define MAX_PWMS 1024
 
 static DEFINE_MUTEX(pwm_lookup_lock);
@@ -475,6 +478,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
 		return 0;
 
+	trace_pwm_apply_state(pwm, state);
+
 	if (pwm->chip->ops->apply) {
 		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
 		if (err)
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
new file mode 100644
index 000000000000..0c28a76b1f60
--- /dev/null
+++ b/include/trace/events/pwm.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pwm
+
+#if !defined(_TRACE_PWM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PWM_H
+
+#include <linux/pwm.h>
+#include <linux/tracepoint.h>
+
+
+TRACE_EVENT(pwm_apply_state,
+
+	TP_PROTO(struct pwm_device *pwm, struct pwm_state *state),
+
+	TP_ARGS(pwm, state),
+
+	TP_STRUCT__entry(
+		__string(name,			pwm->label)
+		__field(struct pwm_device *,	pwm)
+		__field(unsigned int,			num)
+		__field(unsigned int,			period)
+		__field(unsigned int,			duty_cycle)
+		__field(enum pwm_polarity,		polarity)
+		__field(bool,					enabled)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, pwm->label);
+		__entry->pwm = pwm;
+		__entry->num = pwm->pwm;
+		__entry->period = state->period;
+		__entry->duty_cycle = state->duty_cycle;
+		__entry->polarity = state->polarity;
+		__entry->enabled = state->enabled;
+	),
+
+	TP_printk("%s: apply state struct pwm[%p]: pwm%u "
+		"enabled=%d polarity=%u period_ns=%u duty_ns=%u",
+		  __get_str(name), __entry->pwm, __entry->num,
+		  __entry->enabled, __entry->polarity,
+		  __entry->period, __entry->duty_cycle)
+);
+
+#endif /* _TRACE_PWM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.18.0
