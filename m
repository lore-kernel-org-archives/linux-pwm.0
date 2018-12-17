From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v7 1/6] pwm: extend PWM framework with PWM modes
Date: Mon, 17 Dec 2018 14:13:40 +0000
Message-ID: <1545055999-23950-2-git-send-email-claudiu.beznea@microchip.com>
References: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh@kernel.org, corbet@lwn.net, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add basic PWM modes: normal and complementary. These modes should
differentiate the single output PWM channels from two outputs PWM
channels. These modes could be set as follow:
1. PWM channels with one output per channel:
- normal mode
2. PWM channels with two outputs per channel:
- normal mode
- complementary mode
Since users could use a PWM channel with two output as one output PWM
channel, the PWM normal mode is allowed to be set for PWM channels with
two outputs; in fact PWM normal mode should be supported by all PWMs.

The PWM capabilities were implemented per PWM channel. Every PWM controller
will register a function to get PWM capabilities. If this is not explicitly
set by the driver a default function will be used to retrieve the PWM
capabilities (in this case the PWM capabilities will contain only PWM
normal mode). To retrieve capabilities the pwm_get_caps() function could
be used.

Every PWM channel have associated a mode in the PWM state. Proper
support was added to get/set PWM mode. Only modes supported by PWM channel
could be set.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pwm/sysfs.c | 61 +++++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 35 +++++++++++++++++++++
 3 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..eb444ee8d486 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -249,6 +249,88 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
 	return false;
 }
 
+static int pwm_get_default_caps(struct pwm_caps *caps)
+{
+	static const struct pwm_caps default_caps = {
+		.modes_msk = PWM_MODE_BIT(NORMAL),
+	};
+
+	if (!caps)
+		return -EINVAL;
+
+	*caps = default_caps;
+
+	return 0;
+}
+
+/**
+ * pwm_get_caps() - get PWM capabilities of a PWM device
+ * @pwm: PWM device to get the capabilities for
+ * @caps: returned capabilities
+ *
+ * Returns: 0 on success or a negative error code on failure
+ */
+int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps)
+{
+	if (!pwm || !caps)
+		return -EINVAL;
+
+	if (pwm->chip->ops->get_caps)
+		return pwm->chip->ops->get_caps(pwm->chip, pwm, caps);
+
+	return pwm_get_default_caps(caps);
+}
+EXPORT_SYMBOL_GPL(pwm_get_caps);
+
+/**
+ * pwm_get_default_modebit() - get the default mode for PWM (as a bit mask)
+ * @pwm: PWM device to get the default mode for
+ *
+ * Returns: the default PWM mode (as a bit mask) for PWM device
+ */
+unsigned long pwm_get_default_modebit(const struct pwm_device *pwm)
+{
+	struct pwm_caps caps;
+
+	if (pwm_get_caps(pwm, &caps))
+		return PWM_MODE_BIT(NORMAL);
+
+	return BIT(ffs(caps.modes_msk) - 1);
+}
+EXPORT_SYMBOL_GPL(pwm_get_default_modebit);
+
+/**
+ * pwm_supports_mode() - check if PWM mode is supported by PWM device
+ * @pwm: PWM device
+ * @modebit: PWM mode bit mask to be checked (see PWM_MODE_BIT())
+ *
+ * Returns: true if PWM mode is supported, false otherwise
+ */
+bool pwm_supports_mode(const struct pwm_device *pwm, unsigned long modebit)
+{
+	struct pwm_caps caps;
+
+	if (!pwm || !modebit)
+		return false;
+
+	if (hweight_long(modebit) != 1 || ffs(modebit) - 1 >= PWM_MODE_CNT)
+		return false;
+
+	if (pwm_get_caps(pwm, &caps))
+		return false;
+
+	return !!(caps.modes_msk & modebit);
+}
+EXPORT_SYMBOL_GPL(pwm_supports_mode);
+
+const char *pwm_get_mode_name(unsigned long modebit)
+{
+	if (modebit == PWM_MODE_BIT(COMPLEMENTARY))
+		return "complementary";
+
+	return "normal";
+}
+
 /**
  * pwmchip_add_with_polarity() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -294,6 +376,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
+		pwm->state.modebit = pwm_get_default_modebit(pwm);
 
 		if (chip->ops->get_state)
 			chip->ops->get_state(chip, pwm, &pwm->state);
@@ -469,7 +552,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	int err;
 
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_cycle > state->period ||
+	    !pwm_supports_mode(pwm, state->modebit))
 		return -EINVAL;
 
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
@@ -530,6 +614,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 
 			pwm->state.enabled = state->enabled;
 		}
+
+		pwm->state.modebit = state->modebit;
 	}
 
 	return 0;
@@ -579,6 +665,8 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	pwm_get_args(pwm, &pargs);
 	pwm_get_state(pwm, &state);
 
+	state.modebit = pwm_get_default_modebit(pwm);
+
 	/*
 	 * If the current period is zero it means that either the PWM driver
 	 * does not support initial state retrieval or the PWM has not yet
@@ -999,6 +1087,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		seq_printf(s, " duty: %u ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
+		seq_printf(s, " mode: %s", pwm_get_mode_name(state.modebit));
 
 		seq_puts(s, "\n");
 	}
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index ceb233dd6048..7865fbafbeb4 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -223,11 +223,71 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t mode_show(struct device *child,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_state state;
+	unsigned long modebit;
+	enum pwm_mode mode;
+	int len = 0;
+
+	pwm_get_state(pwm, &state);
+
+	for (mode = PWM_MODE_NORMAL; mode < PWM_MODE_CNT; mode++) {
+		modebit = BIT(mode);
+		if (pwm_supports_mode(pwm, modebit)) {
+			if (state.modebit == modebit)
+				len += scnprintf(buf + len,
+						 PAGE_SIZE - len, "[%s] ",
+						 pwm_get_mode_name(modebit));
+			else
+				len += scnprintf(buf + len,
+						 PAGE_SIZE - len, "%s ",
+						 pwm_get_mode_name(modebit));
+		}
+	}
+
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	return len;
+}
+
+static ssize_t mode_store(struct device *child,
+			  struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	unsigned long modebit;
+	enum pwm_mode mode;
+	int ret;
+
+	for (mode = PWM_MODE_NORMAL; mode < PWM_MODE_CNT; mode++) {
+		modebit = BIT(mode);
+		if (sysfs_streq(buf, pwm_get_mode_name(modebit)))
+			break;
+	}
+
+	if (mode == PWM_MODE_CNT)
+		return -EINVAL;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.modebit = modebit;
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
+static DEVICE_ATTR_RW(mode);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
@@ -235,6 +295,7 @@ static struct attribute *pwm_attrs[] = {
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_mode.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 56518adc31dd..abe189d891af 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -10,6 +10,9 @@ struct pwm_capture;
 struct seq_file;
 
 struct pwm_chip;
+struct pwm_device;
+
+unsigned long pwm_get_default_modebit(const struct pwm_device *pwm);
 
 /**
  * enum pwm_polarity - polarity of a PWM signal
@@ -26,6 +29,28 @@ enum pwm_polarity {
 };
 
 /**
+ * PWM modes capabilities
+ * @PWM_MODE_NORMAL: PWM has one output
+ * @PWM_MODE_COMPLEMENTARY: PWM has 2 outputs with opposite polarities
+ * @PWM_MODE_CNT: PWM modes count
+ */
+enum pwm_mode {
+	PWM_MODE_NORMAL,
+	PWM_MODE_COMPLEMENTARY,
+	PWM_MODE_CNT,
+};
+
+#define PWM_MODE_BIT(name)		BIT(PWM_MODE_##name)
+
+/**
+ * struct pwm_caps - PWM capabilities
+ * @modes_msk: bitmask of supported modes (see PWM_MODE_*)
+ */
+struct pwm_caps {
+	unsigned long modes_msk;
+};
+
+/**
  * struct pwm_args - board-dependent PWM arguments
  * @period: reference period
  * @polarity: reference polarity
@@ -53,12 +78,14 @@ enum {
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
+ * @modebit: PWM mode bit
  * @enabled: PWM enabled status
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	unsigned long modebit;
 	bool enabled;
 };
 
@@ -181,6 +208,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	state->period = args.period;
 	state->polarity = args.polarity;
 	state->duty_cycle = 0;
+	state->modebit = pwm_get_default_modebit(pwm);
 }
 
 /**
@@ -254,6 +282,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
+ * @get_caps: get PWM capabilities.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -272,6 +301,8 @@ struct pwm_ops {
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
+	int (*get_caps)(const struct pwm_chip *chip,
+			const struct pwm_device *pwm, struct pwm_caps *caps);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
 #endif
@@ -438,6 +469,9 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
 
+int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps);
+bool pwm_supports_mode(const struct pwm_device *pwm, unsigned long modebit);
+const char *pwm_get_mode_name(unsigned long modebit);
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
@@ -592,6 +626,7 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	state.enabled = false;
 	state.polarity = pwm->args.polarity;
 	state.period = pwm->args.period;
+	state.modebit = pwm_get_default_modebit(pwm);
 
 	pwm_apply_state(pwm, &state);
 }
-- 
2.7.4
