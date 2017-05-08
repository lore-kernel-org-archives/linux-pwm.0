From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] drivers: pwm: core: implement pwm dead-times
Date: Mon, 8 May 2017 17:24:22 +0300
Message-ID: <1494253463-26993-2-git-send-email-claudiu.beznea@microchip.com>
References: <1494253463-26993-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494253463-26993-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, corbet@lwn.net, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

Extends PWM framework to support PWM dead-times.
The notions introduced are rising edge dead-time
and falling edge dead-time. These are useful for
PWM controllers with channels that have more than
one outputs.
The implementation add sysfs interface for
configuration. It extends the pwm_state structure
with two new members which keeps the values for
dead-times.
There were no additions in device tree for PWM channels
initialized by device tree.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/pwm.txt | 55 ++++++++++++++++++++++++++++++++++++++
 drivers/pwm/core.c    | 10 ++++++-
 drivers/pwm/sysfs.c   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h   | 36 +++++++++++++++++++++++++
 4 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 789b27c..61de0f9 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -100,6 +100,61 @@ enable - Enable/disable the PWM signal (read/write).
 	0 - disabled
 	1 - enabled
 
+deadtime_re -The rising edge dead-time
+deadtime_fe - the falling edge dead-time
+	For a PWM controller with more than one output signals per PWM channel
+	dead-times are the delays introduced between the edges of the output
+	signals and the original signal introduced in dead-time generator
+	engine.
+	E.g. consider a PWM controller with a dead-time engine as in the following
+	diagram:
+
+                        -----------------
+                       |                 |---> PWMH
+        PWM signal --->| Dead-time engine|
+                       |                 |---> PWML
+                        -----------------
+
+	With no dead-time configured, the PWMH and PWML signals will be
+	complementary signals (rising and falling edges of PWMH and PWML
+	have opposite leves, same duration and same starting time) as
+	follows:
+
+                      ____0    D____P     ____      ____      ____
+        PWM signal __|    |____|    |____|    |____|    |____|    |___
+                      ____      ____      ____      ____      ____
+              PWMH __|    |____|    |____|    |____|    |____|    |___
+                   __      ____      ____      ____      ____      ___
+              PWML   |____|    |____|    |____|    |____|    |____|
+
+	Where - 0 is the starting point of the signal
+	      - D is the starting point of the duty-cycle
+	      - P is the signal period
+
+	Based on the above diagram:
+	- rising edge dead-time - is the delay introduced in one of the
+	dead-time engine output signals; the delay is introduced after
+	rising edge of the original PWM signal
+	- falling edge dead-time - is the delay introduced in one of the
+	dead-time engine output signals; the delay is introduced after
+	the end of falling edge of the original PWM signal
+	See the following diagram:
+
+                      ____0    D____P     ____      ____      ____
+        PWM signal __|    |____|    |____|    |____|    |____|    |___
+                        __        __        __        __        __
+              PWMH ____|  |____re|  |______|  |______|  |______|  |___
+                   __        __        __        __        __        __
+              PWML   |______|  |____fe|  |______|  |______|  |______|
+
+	In the upper diagram:
+	- re = rising edge = the delay between D point of the original PWM signal
+	(rising edge) and the starting point of the next edge of one of the PWM
+	dead-time engine output
+	- fe = falling edge = the delay between P point of the original PWM signal
+	(falling edge) and the starting point of the next edge of one of the PWM
+	dead-time engine output
+
 Implementing a PWM driver
 -------------------------
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a0860b3..c1a9828 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -469,7 +469,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	int err;
 
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_cycle > state->period ||
+	    state->deadtime_re + state->deadtime_fe > state->period)
 		return -EINVAL;
 
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
@@ -579,6 +580,9 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	pwm_get_args(pwm, &pargs);
 	pwm_get_state(pwm, &state);
 
+	state.deadtime_re = 0;
+	state.deadtime_fe = 0;
+
 	/*
 	 * If the current period is zero it means that either the PWM driver
 	 * does not support initial state retrieval or the PWM has not yet
@@ -997,6 +1001,10 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		seq_printf(s, " duty: %u ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
+		seq_printf(s, " dead-time rising edge: %u ns",
+			   state.deadtime_re);
+		seq_printf(s, " dead-time falling edge: %u ns",
+			   state.deadtime_fe);
 
 		seq_puts(s, "\n");
 	}
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index a813239..f91686e 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -223,11 +223,83 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t deadtime_re_show(struct device *child,
+				struct device_attribute *attr,
+				char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sprintf(buf, "%u\n", state.deadtime_re);
+}
+
+static ssize_t deadtime_re_store(struct device *child,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.deadtime_re = val;
+	ret = pwm_apply_state(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
+static ssize_t deadtime_fe_show(struct device *child,
+				struct device_attribute *attr,
+				char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sprintf(buf, "%u\n", state.deadtime_fe);
+}
+
+static ssize_t deadtime_fe_store(struct device *child,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.deadtime_fe = val;
+	ret = pwm_apply_state(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
+static DEVICE_ATTR_RW(deadtime_re);
+static DEVICE_ATTR_RW(deadtime_fe);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
@@ -235,6 +307,8 @@ static struct attribute *pwm_attrs[] = {
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_deadtime_re.attr,
+	&dev_attr_deadtime_fe.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 08fad7c..7547053 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -53,10 +53,14 @@ enum {
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
  * @enabled: PWM enabled status
+ * @deadtime_re: PWM rising edge deadtime
+ * @deadtime_fe: PWM falling edge deadtime
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
+	unsigned int deadtime_re;
+	unsigned int deadtime_fe;
 	enum pwm_polarity polarity;
 	bool enabled;
 };
@@ -143,6 +147,36 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return state.polarity;
 }
 
+static inline void pwm_set_deadtime_re(struct pwm_device *pwm, unsigned int dt)
+{
+	if (pwm)
+		pwm->state.deadtime_re = dt;
+}
+
+static inline unsigned int pwm_get_deadtime_re(const struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.deadtime_re;
+}
+
+static inline void pwm_set_deadtime_fe(struct pwm_device *pwm, unsigned int dt)
+{
+	if (pwm)
+		pwm->state.deadtime_fe = dt;
+}
+
+static inline unsigned int pwm_get_deadtime_fe(const struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.deadtime_fe;
+}
+
 static inline void pwm_get_args(const struct pwm_device *pwm,
 				struct pwm_args *args)
 {
@@ -180,6 +214,8 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	state->period = args.period;
 	state->polarity = args.polarity;
 	state->duty_cycle = 0;
+	state->deadtime_re = 0;
+	state->deadtime_fe = 0;
 }
 
 /**
-- 
2.7.4
