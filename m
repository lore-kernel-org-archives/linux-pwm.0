From: Lee Jones <lee.jones@linaro.org>
Subject: [[PATCH v2] 01/11] pwm: Add PWM Capture support
Date: Fri, 22 Apr 2016 11:18:05 +0100
Message-ID: <1461320295-20414-2-git-send-email-lee.jones@linaro.org>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, kernel@stlinux.com, ajitpal.singh@st.com, thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>, maxime.coquelin@st.com
List-Id: linux-pwm@vger.kernel.org

Supply a PWM Capture call-back Op in order to pass back
information obtained by running analysis on PWM a signal.
This would normally (at least during testing) be called from
the Sysfs routines with a view to printing out PWM Capture
data which has been encoded into a string.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/core.c  | 27 +++++++++++++++++++++++++++
 include/linux/pwm.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7831bc6..160784d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -494,6 +494,33 @@ unlock:
 EXPORT_SYMBOL_GPL(pwm_set_polarity);
 
 /**
+ * pwm_capture() - capture and report a PWM signal
+ * @pwm: PWM device
+ * @result: struct to fill with capture result
+ * @timeout_ms: time to wait, in milliseconds, before giving up on capture
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
+		unsigned int timeout_ms)
+{
+	int err;
+
+	if (!pwm || !pwm->chip->ops)
+		return -EINVAL;
+
+	if (!pwm->chip->ops->capture)
+		return -ENOSYS;
+
+	mutex_lock(&pwm->lock);
+	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout_ms);
+	mutex_unlock(&pwm->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(pwm_capture);
+
+/**
  * pwm_enable() - start a PWM output toggling
  * @pwm: PWM device
  *
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index cfc3ed4..49f9648 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 
 struct pwm_device;
+struct pwm_capture;
 struct seq_file;
 
 #if IS_ENABLED(CONFIG_PWM)
@@ -33,6 +34,13 @@ int pwm_enable(struct pwm_device *pwm);
  * pwm_disable - stop a PWM output toggling
  */
 void pwm_disable(struct pwm_device *pwm);
+
+/*
+ * pwm_capture - capture and report a PWM signal
+ */
+int pwm_capture(struct pwm_device *pwm,
+		struct pwm_capture *result,
+		unsigned int timeout_ms);
 #else
 static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
 {
@@ -56,6 +64,13 @@ static inline int pwm_enable(struct pwm_device *pwm)
 static inline void pwm_disable(struct pwm_device *pwm)
 {
 }
+
+static inline int pwm_capture(struct pwm_device *pwm,
+			      struct pwm_capture *result,
+			      unsigned int timeout_ms)
+{
+	return -EINVAL;
+}
 #endif
 
 struct pwm_chip;
@@ -107,6 +122,16 @@ struct pwm_device {
 	enum pwm_polarity polarity;
 };
 
+/**
+ * struct pwm_capture - PWM capture data
+ * @period: period of the PWM signal (in nanoseconds)
+ * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
+ */
+struct pwm_capture {
+	unsigned long long period;
+	unsigned long long duty_cycle;
+};
+
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 {
 	return test_bit(PWMF_ENABLED, &pwm->flags);
@@ -150,6 +175,7 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
  * @free: optional hook for freeing a PWM
  * @config: configure duty cycles and period length for this PWM
  * @set_polarity: configure the polarity of this PWM
+ * @capture: capture and report PWM signal
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
  * @dbg_show: optional routine to show contents in debugfs
@@ -162,6 +188,8 @@ struct pwm_ops {
 		      int duty_ns, int period_ns);
 	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
 			    enum pwm_polarity polarity);
+	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
+		       struct pwm_capture *result, unsigned int timeout_ms);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
 #ifdef CONFIG_DEBUG_FS
-- 
2.8.0
