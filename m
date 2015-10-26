From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
Date: Mon, 26 Oct 2015 22:32:39 +0100
Message-ID: <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

Some hardware PWM's have the possibility to only send out one (or more)
pulses. This can be quite a useful feature in case one wants or needs
only a single pulse, but at the exact width.

Additionally, if multiple pulses are possible, outputting a fixed amount
of pulses can be useful for various timing specific purposes.

A few new functions have been expanded or added for this new behavior.

* pwm_config()	now takes an additional parameter to setup the number of
		pulses to output. The driver may force this to 0 or 1
		for if example if this feature is not or only partially
		supported
* pwm_[sg]et_pulse_count()	get or set the number of pulses the pwm
				framework is configured for
* pwm_get_pulse_count_max()	get the maximum number of pulses the pwm
				driver supports
* pwm_pulse()		Tell the PWM to emit a pre-configured number of pulses
* pwm_pulse_done()	an internal function for drivers to call when
			they have completed their pre-configured number
			of pulses
* pwm_is_pulsing()	tells the callers if the pwm is busy pulsing,
			yielding a little more information than just
			pwm_is_enabled()

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/pwm/core.c      | 30 +++++++++++++++++++----
 drivers/pwm/pwm-gpio.c  |  3 ++-
 drivers/pwm/pwm-sun4i.c |  3 ++-
 drivers/pwm/sysfs.c     | 58 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pwm.h     | 64 ++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 147 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3f9df3e..e2c1c0a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -432,22 +432,29 @@ EXPORT_SYMBOL_GPL(pwm_free);
  * @pwm: PWM device
  * @duty_ns: "on" time (in nanoseconds)
  * @period_ns: duration (in nanoseconds) of one cycle
+ * @pulse_count: number of pulses (periods) to output on pwm_pulse
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns,
+	       unsigned int pulse_count)
 {
 	int err;
 
 	if (!pwm || duty_ns < 0 || period_ns <= 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
+	if (pulse_count > pwm->pulse_count_max)
+		return -EINVAL;
+
+	err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns,
+				     period_ns, pulse_count);
 	if (err)
 		return err;
 
 	pwm->duty_cycle = duty_ns;
 	pwm->period = period_ns;
+	pwm->pulse_count = pulse_count;
 
 	return 0;
 }
@@ -487,6 +494,18 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 EXPORT_SYMBOL_GPL(pwm_set_polarity);
 
 /**
+ * pwm_pulse_done() - notify the PWM framework that pulse_count pulses are done
+ * @pwm: PWM device
+ */
+void pwm_pulse_done(struct pwm_device *pwm)
+{
+	if (pwm && !test_and_clear_bit(PWMF_ENABLED | PWMF_PULSING,
+				       &pwm->flags))
+		return pwm->chip->ops->disable(pwm->chip, pwm);
+}
+EXPORT_SYMBOL_GPL(pwm_pulse_done);
+
+/**
  * pwm_enable() - start a PWM output toggling
  * @pwm: PWM device
  *
@@ -494,7 +513,9 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
  */
 int pwm_enable(struct pwm_device *pwm)
 {
-	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm && !test_and_set_bit(
+			PWMF_ENABLED | !pwm->pulse_count ? : PWMF_PULSING,
+			&pwm->flags))
 		return pwm->chip->ops->enable(pwm->chip, pwm);
 
 	return pwm ? 0 : -EINVAL;
@@ -507,7 +528,8 @@ EXPORT_SYMBOL_GPL(pwm_enable);
  */
 void pwm_disable(struct pwm_device *pwm)
 {
-	if (pwm && test_and_clear_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm && test_and_clear_bit(PWMF_ENABLED | PWMF_PULSING,
+				      &pwm->flags))
 		pwm->chip->ops->disable(pwm->chip, pwm);
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
index 8b588fb..cf4b170 100644
--- a/drivers/pwm/pwm-gpio.c
+++ b/drivers/pwm/pwm-gpio.c
@@ -84,7 +84,7 @@ enum hrtimer_restart gpio_pwm_timer(struct hrtimer *timer)
 }
 
 static int gpio_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+			    int duty_ns, int period_ns, unsigned int count)
 {
 	struct gpio_pwm_data *gpio_data = pwm_get_chip_data(pwm);
 
@@ -202,6 +202,7 @@ static int gpio_pwm_probe(struct platform_device *pdev)
 			hrtimer++;
 
 		pwm_set_chip_data(&gpio_chip->chip.pwms[i], gpio_data);
+		pwm_set_pulse_count_max(&gpio_chip->chip.pwms[i], UINT_MAX);
 	}
 	if (!hrtimer)
 		dev_warn(&pdev->dev, "unable to use High-Resolution timer,");
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 4d84d9d..6347ca8 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -97,7 +97,8 @@ static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
 }
 
 static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+			    int duty_ns, int period_ns,
+			    unsigned int pulse_count)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	u32 prd, dty, val, clk_gate;
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9c90886..9b7413c 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -61,7 +61,8 @@ static ssize_t period_store(struct device *child,
 	if (ret)
 		return ret;
 
-	ret = pwm_config(pwm, pwm_get_duty_cycle(pwm), val);
+	ret = pwm_config(pwm, pwm_get_duty_cycle(pwm),
+			 val, pwm_get_pulse_count(pwm));
 
 	return ret ? : size;
 }
@@ -87,7 +88,8 @@ static ssize_t duty_cycle_store(struct device *child,
 	if (ret)
 		return ret;
 
-	ret = pwm_config(pwm, val, pwm_get_period(pwm));
+	ret = pwm_config(pwm, val, pwm_get_period(pwm),
+			 pwm_get_pulse_count(pwm));
 
 	return ret ? : size;
 }
@@ -167,16 +169,68 @@ static ssize_t polarity_store(struct device *child,
 	return ret ? : size;
 }
 
+static ssize_t pulse_count_show(struct device *child,
+				struct device_attribute *attr,
+				char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+
+	return sprintf(buf, "%u\n", pwm_get_pulse_count(pwm));
+}
+
+static ssize_t pulse_count_store(struct device *child,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = pwm_config(pwm, pwm_get_duty_cycle(pwm),
+			 pwm_get_period(pwm), val);
+
+	return ret ? : size;
+
+}
+
+static ssize_t pulse_count_max_show(struct device *child,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+
+	return sprintf(buf, "%u\n", pwm_get_pulse_count_max(pwm));
+}
+
+static ssize_t pulsing_show(struct device *child,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+
+	return sprintf(buf, "%d\n", pwm_is_pulsing(pwm));
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
+static DEVICE_ATTR_RW(pulse_count);
+static DEVICE_ATTR_RO(pulse_count_max);
+static DEVICE_ATTR_RO(pulsing);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
 	&dev_attr_duty_cycle.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
+	&dev_attr_pulse_count.attr,
+	&dev_attr_pulse_count_max.attr,
+	&dev_attr_pulsing.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 29315ad..c6042cf 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -22,7 +22,13 @@ void pwm_free(struct pwm_device *pwm);
 /*
  * pwm_config - change a PWM device configuration
  */
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
+int pwm_config(struct pwm_device *pwm, int duty_ns,
+	       int period_ns, unsigned int pulse_count);
+
+/*
+ * pwm_pulse_done - notify the PWM framework that pulse_count pulses are done
+ */
+void pwm_pulse_done(struct pwm_device *pwm);
 
 /*
  * pwm_enable - start a PWM output toggling
@@ -43,7 +49,8 @@ static inline void pwm_free(struct pwm_device *pwm)
 {
 }
 
-static inline int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
+			     int period_ns, unsigned int pulse_count)
 {
 	return -EINVAL;
 }
@@ -53,6 +60,11 @@ static inline int pwm_enable(struct pwm_device *pwm)
 	return -EINVAL;
 }
 
+static inline int pwm_pulse_done(struct pwm_device *pwm)
+{
+	return -EINVAL;
+}
+
 static inline void pwm_disable(struct pwm_device *pwm)
 {
 }
@@ -78,6 +90,7 @@ enum {
 	PWMF_REQUESTED = BIT(0),
 	PWMF_ENABLED = BIT(1),
 	PWMF_EXPORTED = BIT(2),
+	PWMF_PULSING = BIT(3),
 };
 
 /**
@@ -91,6 +104,8 @@ enum {
  * @period: period of the PWM signal (in nanoseconds)
  * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
  * @polarity: polarity of the PWM signal
+ * @pulse_count: number of PWM pulses to toggle
+ * @pulse_count_max: maximum number of pulses that can be set to pulse
  */
 struct pwm_device {
 	const char *label;
@@ -103,6 +118,8 @@ struct pwm_device {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	unsigned int pulse_count;
+	unsigned int pulse_count_max;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -110,6 +127,11 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 	return test_bit(PWMF_ENABLED, &pwm->flags);
 }
 
+static inline bool pwm_is_pulsing(const struct pwm_device *pwm)
+{
+	return test_bit(PWMF_ENABLED | PWMF_PULSING, &pwm->flags);
+}
+
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 {
 	if (pwm)
@@ -142,6 +164,42 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
 }
 
+/*
+ * pwm_set_pulse_count - configure the number of pulses of a pwm_pulse
+ */
+static inline void pwm_set_pulse_count(struct pwm_device *pwm,
+				       unsigned int pulse_count)
+{
+	if (pwm)
+		pwm->pulse_count = 0;
+}
+
+/*
+ * pwm_get_pulse_count - retrieve the number of pules to pulse of a pwm_pulse
+ */
+static inline unsigned int pwm_get_pulse_count(const struct pwm_device *pwm)
+{
+	return pwm ? pwm->pulse_count : 0;
+}
+
+/*
+ * pwm_get_pulse_count_max - retrieve the maximum number of pulses
+ */
+static inline unsigned int pwm_get_pulse_count_max(const struct pwm_device *pwm)
+{
+	return pwm ? pwm->pulse_count_max : 0;
+}
+
+/*
+ * pwm_set_pulse_count_max - set the maximum number of pulses
+ */
+static inline void pwm_set_pulse_count_max(struct pwm_device *pwm,
+					   unsigned int pulse_count_max)
+{
+	if (pwm)
+		pwm->pulse_count_max = pulse_count_max;
+}
+
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
@@ -157,7 +215,7 @@ struct pwm_ops {
 	int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*free)(struct pwm_chip *chip, struct pwm_device *pwm);
 	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
-		      int duty_ns, int period_ns);
+		      int duty_ns, int period_ns, unsigned int pulse_count);
 	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
-- 
2.6.1
