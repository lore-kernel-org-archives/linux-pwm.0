From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 08/16] drivers: pwm: core: extend PWM framework with PWM modes
Date: Fri, 12 Jan 2018 16:22:55 +0200
Message-ID: <1515766983-15151-9-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pwm@vger.kernel.org

Add basic PWM modes: normal and complementary. These modes should
differentiate the single output per channel PWM controllers from multiple
outputs per channel PWM controllers. These modes whould be set as follow:
1. PWM controllers with only one output per channel:
- normal mode
2. PWM controllers with more than one output per channel:
- normal mode
- complementary mode
Since users could use the PWM channel of a multiple output per channel PWM
controller, he could set the channel in normal mode and use only one
physical output.
The PWM modes were implemented as capabilities of PWM chip. In the probe
function of PWM driver the PWM capabilities (which currently contains only
PWM modes) should be provided in the structure of PWM chip. If no
capabilities are provided by the probe function, the default capabilities
will be used (the default capabilities involves PWM normal mode).
Every PWM channel will have associated a mode in the PWM state. Proper
helper functions were added to get/set PWM mode. The mode could also be set
from DT. Only modes registered for PWM chip could be set for a PWM channel.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pwm/sysfs.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7208b95e8d2f..99126127a467 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -41,6 +41,10 @@ static LIST_HEAD(pwm_chips);
 static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
 static RADIX_TREE(pwm_tree, GFP_KERNEL);
 
+static const struct pwm_caps pwm_chip_default_caps = {
+	.modes = PWM_MODE_NORMAL,
+};
+
 static struct pwm_device *pwm_to_device(unsigned int pwm)
 {
 	return radix_tree_lookup(&pwm_tree, pwm);
@@ -142,6 +146,31 @@ static inline void of_pwm_xlate_flags(struct pwm_device *pwm,
 		pwm->args.polarity = PWM_POLARITY_NORMAL;
 }
 
+static inline bool pwm_mode_valid(const struct pwm_chip *chip,
+				  const enum pwm_mode mode)
+{
+	return !!(chip->caps->modes & mode);
+}
+
+static inline void of_pwm_xlate_mode(struct pwm_device *pwm,
+				     const struct of_phandle_args *args)
+{
+	unsigned int first = 0, last = 0;
+
+	if (args->args_count >= PWM_ARGS_CNT_XLATE_MODE) {
+		first = ffs(args->args[PWM_ARGS_CNT_XLATE_MODE - 1]);
+		last = fls(args->args[PWM_ARGS_CNT_XLATE_MODE - 1]);
+	}
+
+	/* At least one valid mode provided from DT: use one valid mode */
+	if (first && pwm_mode_valid(pwm->chip, BIT(first - 1)))
+		pwm->args.mode = BIT(first - 1);
+	else if (last && pwm_mode_valid(pwm->chip, BIT(last - 1)))
+		pwm->args.mode = BIT(last - 1);
+	else /* Invalid modes provided from DT: use first available chip mode */
+		pwm->args.mode = BIT(ffs(pwm->chip->caps->modes) - 1);
+}
+
 struct pwm_device *of_pwm_xlate(struct pwm_chip *pc,
 				const struct of_phandle_args *args)
 {
@@ -161,6 +190,7 @@ struct pwm_device *of_pwm_xlate(struct pwm_chip *pc,
 	pwm->args.period = args->args[PWM_ARGS_CNT_XLATE_PERIOD - 1];
 
 	of_pwm_xlate_flags(pwm, args);
+	of_pwm_xlate_mode(pwm, args);
 
 	return pwm;
 }
@@ -223,6 +253,18 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
 	return false;
 }
 
+static inline bool pwm_caps_valid(const struct pwm_caps *caps)
+{
+	unsigned long modes = PWM_MODE_MAX - 1;
+
+	return !!((modes & caps->modes) == caps->modes);
+}
+
+static inline bool pwm_caps_zero(const struct pwm_caps *caps)
+{
+	return !!(caps->modes == 0);
+}
+
 /**
  * pwmchip_add_with_polarity() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -247,8 +289,14 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 	if (!pwm_ops_check(chip->ops))
 		return -EINVAL;
 
+	if (chip->caps && !pwm_caps_valid(chip->caps))
+		return -EINVAL;
+
 	mutex_lock(&pwm_lock);
 
+	if (!chip->caps || (chip->caps && pwm_caps_zero(chip->caps)))
+		chip->caps = &pwm_chip_default_caps;
+
 	ret = alloc_pwms(chip->base, chip->npwm);
 	if (ret < 0)
 		goto out;
@@ -268,6 +316,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
+		pwm->state.mode = BIT(ffs(chip->caps->modes) - 1);
 
 		if (chip->ops->get_state)
 			chip->ops->get_state(chip, pwm, &pwm->state);
@@ -443,7 +492,11 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	int err;
 
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_cycle > state->period ||
+	    !pwm->chip || !pwm->chip->caps ||
+	    !pwm_mode_valid(pwm->chip, state->mode) ||
+	    /* Only one active mode at a time. */
+	    fls(state->mode) != ffs(state->mode))
 		return -EINVAL;
 
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
@@ -504,6 +557,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 
 			pwm->state.enabled = state->enabled;
 		}
+
+		/* No mode support for non-atomic PWM. */
+		pwm->state.mode = state->mode;
 	}
 
 	return 0;
@@ -553,6 +609,8 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	pwm_get_args(pwm, &pargs);
 	pwm_get_state(pwm, &state);
 
+	state.mode = pargs.mode;
+
 	/*
 	 * If the current period is zero it means that either the PWM driver
 	 * does not support initial state retrieval or the PWM has not yet
@@ -824,6 +882,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
+	pwm->args.mode = BIT(ffs(chip->caps->modes) - 1);
 
 	return pwm;
 }
@@ -973,6 +1032,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		seq_printf(s, " duty: %u ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
+		seq_printf(s, " mode: %s", pwm_get_mode_desc(state.mode));
 
 		seq_puts(s, "\n");
 	}
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 83f2b0b15712..7d111ab17e43 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -223,11 +223,50 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t mode_show(struct device *child,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sprintf(buf, "%s\n", pwm_get_mode_desc(state.mode));
+}
+
+static ssize_t mode_store(struct device *child,
+			  struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	enum pwm_mode mode;
+	int ret;
+
+	if (sysfs_streq(buf, pwm_get_mode_desc(PWM_MODE_NORMAL)))
+		mode = PWM_MODE_NORMAL;
+	else if (sysfs_streq(buf, pwm_get_mode_desc(PWM_MODE_COMPLEMENTARY)))
+		mode = PWM_MODE_COMPLEMENTARY;
+	else
+		return -EINVAL;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.mode = mode;
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
@@ -235,6 +274,7 @@ static struct attribute *pwm_attrs[] = {
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_mode.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
@@ -362,10 +402,32 @@ static ssize_t npwm_show(struct device *parent, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(npwm);
 
+static ssize_t modes_show(struct device *parent,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	const struct pwm_chip *chip = dev_get_drvdata(parent);
+	enum pwm_mode mode;
+	int i, len = 0;
+
+	for (i = 0; i < PWM_MODE_MAX - 1; i++) {
+		mode = BIT(i);
+		if (chip->caps->modes & mode)
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
+					 pwm_get_mode_desc(mode));
+	}
+
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+
+	return len;
+}
+static DEVICE_ATTR_RO(modes);
+
 static struct attribute *pwm_chip_attrs[] = {
 	&dev_attr_export.attr,
 	&dev_attr_unexport.attr,
 	&dev_attr_npwm.attr,
+	&dev_attr_modes.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(pwm_chip);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 4bb628b94d88..0fdc680651aa 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -26,9 +26,23 @@ enum pwm_polarity {
 };
 
 /**
+ * enum pwm_mode - PWM working modes
+ * PWM_MODE_NORMAL: PWM has one output per channel
+ * PWM_MODE_COMPLEMENTARY: PWM has 2 outputs per channel with opposite polarity
+ * PWM_MODE_MAX: Used to get the defined PWM modes mask (PWM_MODE_MAX - 1)
+ * phase-shifted
+ */
+enum pwm_mode {
+	PWM_MODE_NORMAL		= BIT(0),
+	PWM_MODE_COMPLEMENTARY	= BIT(1),
+	PWM_MODE_MAX		= BIT(2),
+};
+
+/**
  * struct pwm_args - board-dependent PWM arguments
  * @period: reference period
  * @polarity: reference polarity
+ * @mode: reference mode
  *
  * This structure describes board-dependent arguments attached to a PWM
  * device. These arguments are usually retrieved from the PWM lookup table or
@@ -41,6 +55,7 @@ enum pwm_polarity {
 struct pwm_args {
 	unsigned int period;
 	enum pwm_polarity polarity;
+	enum pwm_mode mode;
 };
 
 enum {
@@ -52,12 +67,22 @@ enum {
  * enum pwm_args_xlate_options - options for translating PWM options
  * @PWM_ARGS_CNT_XLATE_PERIOD: translate period
  * @PWM_ARGS_CNT_XLATE_FLAGS: translate flags (polarity flags)
+ * @PWM_ARGS_CNT_XLATE_MODE: translate with flags and mode
  * @PWM_ARGS_CNT_XLATE_MAX: maximum number of translate options
  */
 enum pwm_args_xlate_options {
 	PWM_ARGS_CNT_XLATE_PERIOD = 2,
 	PWM_ARGS_CNT_XLATE_FLAGS,
-	PWM_ARGS_CNT_XLATE_MAX = PWM_ARGS_CNT_XLATE_FLAGS,
+	PWM_ARGS_CNT_XLATE_MODE,
+	PWM_ARGS_CNT_XLATE_MAX = PWM_ARGS_CNT_XLATE_MODE,
+};
+
+/**
+ * struct pwm_caps - PWM capabilities
+ * @modes: PWM chip supported modes
+ */
+struct pwm_caps {
+	unsigned long modes;
 };
 
 /*
@@ -65,12 +90,14 @@ enum pwm_args_xlate_options {
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
+ * @mode: PWM mode
  * @enabled: PWM enabled status
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	enum pwm_mode mode;
 	bool enabled;
 };
 
@@ -156,6 +183,21 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return state.polarity;
 }
 
+static inline enum pwm_mode pwm_get_mode(const struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.mode;
+}
+
+static inline void pwm_set_mode(struct pwm_device *pwm, enum pwm_mode mode)
+{
+	if (pwm)
+		pwm->state.mode = mode;
+}
+
 static inline void pwm_get_args(const struct pwm_device *pwm,
 				struct pwm_args *args)
 {
@@ -193,6 +235,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	state->period = args.period;
 	state->polarity = args.polarity;
 	state->duty_cycle = 0;
+	state->mode = args.mode;
 }
 
 /**
@@ -295,6 +338,7 @@ struct pwm_ops {
  * @dev: device providing the PWMs
  * @list: list node for internal use
  * @ops: callbacks for this PWM controller
+ * @caps: capabilities for this PWM controller
  * @base: number of first PWM controlled by this chip
  * @npwm: number of PWMs controlled by this chip
  * @pwms: array of PWM devices allocated by the framework
@@ -303,6 +347,7 @@ struct pwm_chip {
 	struct device *dev;
 	struct list_head list;
 	const struct pwm_ops *ops;
+	const struct pwm_caps *caps;
 	int base;
 	unsigned int npwm;
 	struct pwm_device *pwms;
@@ -429,6 +474,13 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	pwm_apply_state(pwm, &state);
 }
 
+static inline const char * const pwm_get_mode_desc(enum pwm_mode mode)
+{
+	static const char * const modes[] = { "normal", "complementary" };
+
+	return mode ? modes[ffs(mode) - 1] : "invalid";
+}
+
 /* PWM provider APIs */
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
@@ -503,6 +555,11 @@ static inline void pwm_disable(struct pwm_device *pwm)
 {
 }
 
+static inline const char * const pwm_get_mode_desc(enum pwm_mode mode)
+{
+	return NULL;
+}
+
 static inline int pwm_set_chip_data(struct pwm_device *pwm, void *data)
 {
 	return -EINVAL;
@@ -597,6 +654,7 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	state.enabled = false;
 	state.polarity = pwm->args.polarity;
 	state.period = pwm->args.period;
+	state.mode = pwm->args.mode;
 
 	pwm_apply_state(pwm, &state);
 }
-- 
2.7.4
