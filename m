From: wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH] pwm: add support for freq_hz and duty_percent
Date: Fri, 18 Mar 2016 17:43:15 +0800
Message-ID: <1458294195-24538-2-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <1458294195-24538-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30943 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756968AbcCRJnd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 18 Mar 2016 05:43:33 -0400
In-Reply-To: <1458294195-24538-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

Add new sysfs interface, freq_hz and duty_percent, together with their
helper functions to the PWM framework. This patch will enable the
duration to be configured in unit Hertz and the "on" duration to be
configured as percentage.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 Documentation/ABI/testing/sysfs-class-pwm | 14 +++++
 drivers/pwm/core.c                        | 95 ++++++++++++++++++++++++++++++-
 drivers/pwm/sysfs.c                       | 70 +++++++++++++++++++++++
 include/linux/pwm.h                       | 50 ++++++++++++++++
 4 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-pwm b/Documentation/ABI/testing/sysfs-class-pwm
index c479d77..c0714db 100644
--- a/Documentation/ABI/testing/sysfs-class-pwm
+++ b/Documentation/ABI/testing/sysfs-class-pwm
@@ -77,3 +77,17 @@ Description:
 		Enable/disable the PWM signal.
 		0 is disabled
 		1 is enabled
+
+What:		/sys/class/pwm/pwmchipN/pwmX/freq_hz
+Date:		March 2016
+KernelVersion:	4.5
+Contact:	Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+Description:
+		Sets the PWM signal period in Hertz.
+
+What:		/sys/class/pwm/pwmchipN/pwmX/duty_percent
+Date:		March 2016
+KernelVersion:	4.5
+Contact:	Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+Description:
+		Sets the PWM signal duty cycle in percentage.
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7831bc6..949a5f8 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -32,7 +32,8 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
-#define MAX_PWMS 1024
+#define MAX_PWMS	1024
+#define NSECS_PER_SEC	1000000000UL
 
 static DEFINE_MUTEX(pwm_lookup_lock);
 static LIST_HEAD(pwm_lookup_list);
@@ -197,6 +198,98 @@ static void of_pwmchip_remove(struct pwm_chip *chip)
 }
 
 /**
+  * pwm_freq_hz_to_period() - convert duration unit to ns
+  * @pwm: PWM device
+  * @freq_hz: number of cycles in duration of 1 second (Hertz)
+  *
+  */
+unsigned int pwm_freq_hz_to_period(struct pwm_device *pwm,
+				   unsigned int freq_hz)
+{
+	unsigned long long period_ns = NSECS_PER_SEC;
+	int remainder;
+
+	if (!freq_hz)
+		return 0;
+
+	remainder = do_div(period_ns, freq_hz);
+	if (remainder && (remainder >= (freq_hz >> 1)))
+		period_ns++;
+
+	return period_ns;
+
+}
+EXPORT_SYMBOL_GPL(pwm_freq_hz_to_period);
+
+/**
+  * pwm_period_to_freq_hz() - convert duration unit to Hertz
+  * @pwm: PWM device
+  * @period_ns: duration (in nanoseconds) of one cycle
+  *
+  */
+unsigned int pwm_period_to_freq_hz(struct pwm_device *pwm,
+				   unsigned int period_ns)
+{
+	unsigned long long freq_hz = NSECS_PER_SEC;
+	int remainder;
+
+	if (!period_ns)
+		return 0;
+
+	remainder = do_div(freq_hz, period_ns);
+	if (remainder && (remainder >= (period_ns >> 1)))
+		freq_hz++;
+
+	return freq_hz;
+}
+EXPORT_SYMBOL_GPL(pwm_period_to_freq_hz);
+
+/**
+  * pwm_duty_percent_to_duty_cycle() - convert "on" time unit to ns
+  * @pwm: PWM device
+  * @duty_percent: "on" time (in percentage)
+  *
+  */
+unsigned int pwm_duty_percent_to_duty_cycle(struct pwm_device *pwm,
+					    unsigned int duty_percent)
+{
+	unsigned long long duty_cycle;
+	int remainder;
+
+	duty_cycle = (pwm->period) * duty_percent;
+	remainder = do_div(duty_cycle, 100);
+	if (remainder && (remainder >= 50))
+		duty_cycle++;
+
+	return duty_cycle;
+}
+EXPORT_SYMBOL_GPL(pwm_duty_percent_to_duty_cycle);
+
+/**
+  * pwm_duty_cycle_to_duty_percent() - convert "on" time unit to percentage
+  * @pwm: PWM device
+  * @duty_cycle: "on" time (in nanoseconds)
+  *
+  */
+unsigned int pwm_duty_cycle_to_duty_percent(struct pwm_device *pwm,
+					    unsigned int duty_cycle)
+{
+	unsigned long long duty_percent;
+	int remainder;
+
+	if (!pwm->period)
+		return 0;
+
+	duty_percent = duty_cycle * 100;
+	remainder = do_div(duty_percent, pwm->period);
+	if (remainder && (remainder >= (pwm->period >> 1)))
+		duty_percent++;
+
+	return duty_percent;
+}
+EXPORT_SYMBOL_GPL(pwm_duty_cycle_to_duty_percent);
+
+/**
  * pwm_set_chip_data() - set private chip data for a PWM
  * @pwm: PWM device
  * @data: pointer to chip-specific data
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9c90886..fb19a4d 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -62,6 +62,10 @@ static ssize_t period_store(struct device *child,
 		return ret;
 
 	ret = pwm_config(pwm, pwm_get_duty_cycle(pwm), val);
+	if (ret == 0) {
+		val = pwm_period_to_freq_hz(pwm, val);
+		pwm_set_freq_hz(pwm, val);
+	}
 
 	return ret ? : size;
 }
@@ -88,6 +92,10 @@ static ssize_t duty_cycle_store(struct device *child,
 		return ret;
 
 	ret = pwm_config(pwm, val, pwm_get_period(pwm));
+	if (ret == 0) {
+		val = pwm_duty_cycle_to_duty_percent(pwm, val);
+		pwm_set_duty_percent(pwm, val);
+	}
 
 	return ret ? : size;
 }
@@ -167,16 +175,78 @@ static ssize_t polarity_store(struct device *child,
 	return ret ? : size;
 }
 
+static ssize_t freq_hz_show(struct device *child,
+				struct device_attribute *attr,
+				char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+
+	return sprintf(buf, "%u\n", pwm_get_freq_hz(pwm));
+}
+
+static ssize_t freq_hz_store(struct device *child,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+	unsigned int val, tmp_val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	tmp_val = pwm_freq_hz_to_period(pwm, val);
+	ret = pwm_config(pwm, pwm_get_duty_cycle(pwm), tmp_val);
+	if (ret == 0)
+		pwm_set_freq_hz(pwm, val);
+
+	return ret ? : size;
+}
+
+static ssize_t duty_percent_show(struct device *child,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+
+	return sprintf(buf, "%u\n", pwm_get_duty_percent(pwm));
+}
+
+static ssize_t duty_percent_store(struct device *child,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+	unsigned int val, tmp_val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	tmp_val = pwm_duty_percent_to_duty_cycle(pwm, val);
+	ret = pwm_config(pwm, tmp_val, pwm_get_period(pwm));
+	if (ret == 0)
+		pwm_set_duty_percent(pwm, val);
+
+	return ret ? : size;
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
+static DEVICE_ATTR_RW(freq_hz);
+static DEVICE_ATTR_RW(duty_percent);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
 	&dev_attr_duty_cycle.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
+	&dev_attr_freq_hz.attr,
+	&dev_attr_duty_percent.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index cfc3ed4..15284b5 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -105,6 +105,8 @@ struct pwm_device {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	unsigned int freq_hz;
+	unsigned int duty_percent;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -134,6 +136,30 @@ static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
 	return pwm ? pwm->duty_cycle : 0;
 }
 
+static inline void pwm_set_freq_hz(struct pwm_device *pwm,
+				   unsigned int freq_hz)
+{
+	if (pwm)
+		pwm->freq_hz = freq_hz;
+}
+
+static inline unsigned int pwm_get_freq_hz(const struct pwm_device *pwm)
+{
+	return pwm ? pwm->freq_hz : 0;
+}
+
+static inline void pwm_set_duty_percent(struct pwm_device *pwm,
+					unsigned int duty_percent)
+{
+	if (pwm)
+		pwm->duty_percent = duty_percent;
+}
+
+static inline unsigned int pwm_get_duty_percent(const struct pwm_device *pwm)
+{
+	return pwm ? pwm->duty_percent : 0;
+}
+
 /*
  * pwm_set_polarity - configure the polarity of a PWM signal
  */
@@ -144,6 +170,30 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
 }
 
+/*
+ * pwm_freq_hz_to_period() - convert duration unit to ns
+ */
+unsigned int pwm_freq_hz_to_period(struct pwm_device *pwm,
+					unsigned int freq_hz);
+
+/*
+ * pwm_period_to_freq_hz() - convert duration unit to Hertz
+ */
+unsigned int pwm_period_to_freq_hz(struct pwm_device *pwm,
+					unsigned int period_ns);
+
+/*
+ * pwm_duty_percent_to_duty_cycle() - convert "on" time unit to ns
+ */
+unsigned int pwm_duty_percent_to_duty_cycle(struct pwm_device *pwm,
+						unsigned int duty_percent);
+
+/*
+ * pwm_duty_cycle_to_duty_percent() - convert "on" time unit to percentage
+ */
+unsigned int pwm_duty_cycle_to_duty_percent(struct pwm_device *pwm,
+						unsigned int duty_cycle);
+
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
-- 
1.9.1
