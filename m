From: Lee Jones <lee.jones@linaro.org>
Subject: [[PATCH v2] 03/11] pwm: sysfs: Add PWM Capture support
Date: Fri, 22 Apr 2016 11:18:07 +0100
Message-ID: <1461320295-20414-4-git-send-email-lee.jones@linaro.org>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Allow a user to read PWM Capture results from /sysfs.

To start a capture and read the result, simply read the file:

  $ cat $PWMCHIP/capture

The output format is "<period>:<duty_cycle>".

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9c90886..ca0d886 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -167,16 +167,33 @@ static ssize_t polarity_store(struct device *child,
 	return ret ? : size;
 }
 
+static ssize_t capture_show(struct device *child,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_capture result;
+	int ret;
+
+	ret = pwm_capture(pwm, &result, jiffies_to_msecs(HZ));
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%llu %llu\n", result.period, result.duty_cycle);
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
+static DEVICE_ATTR_RO(capture);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
 	&dev_attr_duty_cycle.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
+	&dev_attr_capture.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
-- 
2.8.0
