From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 01/11] pwm: Add PWM Capture support
Date: Wed, 10 Feb 2016 13:02:18 +0000
Message-ID: <1455109348-32767-2-git-send-email-lee.jones@linaro.org>
References: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
Cc: Lee Jones <lee.jones@linaro.org>, kernel@stlinux.com, maxime.coquelin@st.com
List-Id: linux-pwm@vger.kernel.org

Supply a PWM Capture call-back Op in order to pass back
information obtained by running analysis on PWM a signal.
This would normally (at least during testing) be called from
the Sysfs routines with a view to printing out PWM Capture
data which has been encoded into a string.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/core.c  | 26 ++++++++++++++++++++++++++
 include/linux/pwm.h | 13 +++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d24ca5f..8f4a8a9 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -494,6 +494,32 @@ unlock:
 EXPORT_SYMBOL_GPL(pwm_set_polarity);
 
 /**
+ * pwm_capture() - capture and report a PWM signal
+ * @pwm: PWM device
+ * @channel: PWM capture channel to use
+ * @buf: buffer to place output message into
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int pwm_capture(struct pwm_device *pwm, int channel, char *buf)
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
+	err = pwm->chip->ops->capture(pwm->chip, pwm, channel, buf);
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
index cfc3ed4..7bcff6b 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -33,6 +33,11 @@ int pwm_enable(struct pwm_device *pwm);
  * pwm_disable - stop a PWM output toggling
  */
 void pwm_disable(struct pwm_device *pwm);
+
+/*
+ * pwm_capture - capture and report a PWM signal
+ */
+int pwm_capture(struct pwm_device *pwm, int channel, char *buf);
 #else
 static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
 {
@@ -56,6 +61,11 @@ static inline int pwm_enable(struct pwm_device *pwm)
 static inline void pwm_disable(struct pwm_device *pwm)
 {
 }
+
+static inline int pwm_capture(struct pwm_device *pwm, int channel, char *buf)
+{
+	return -EINVAL;
+}
 #endif
 
 struct pwm_chip;
@@ -150,6 +160,7 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
  * @free: optional hook for freeing a PWM
  * @config: configure duty cycles and period length for this PWM
  * @set_polarity: configure the polarity of this PWM
+ * @capture: capture and report PWM signal
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
  * @dbg_show: optional routine to show contents in debugfs
@@ -162,6 +173,8 @@ struct pwm_ops {
 		      int duty_ns, int period_ns);
 	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
 			    enum pwm_polarity polarity);
+	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
+		       int channel, char *buf);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
 #ifdef CONFIG_DEBUG_FS
-- 
1.9.1
