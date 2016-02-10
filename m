From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/11] pwm: sysfs: Add PWM Capture support
Date: Wed, 10 Feb 2016 13:02:19 +0000
Message-ID: <1455109348-32767-3-git-send-email-lee.jones@linaro.org>
References: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
Cc: kernel@stlinux.com, maxime.coquelin@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Allow a user to read PWM Capture results from /sysfs. First,
the user must tell PWM Capture which channel they wish to
read from:

  $ echo 2 > $PWMCHIP/capture

To start a capture and read the result, simply read the file:

  $ cat $PWMCHIP/capture

The output format is left to the device.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9c90886..3572ef4 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -23,6 +23,8 @@
 #include <linux/kdev_t.h>
 #include <linux/pwm.h>
 
+static int capture_channel;
+
 struct pwm_export {
 	struct device child;
 	struct pwm_device *pwm;
@@ -167,16 +169,42 @@ static ssize_t polarity_store(struct device *child,
 	return ret ? : size;
 }
 
+static ssize_t capture_show(struct device *child,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+
+	return pwm_capture(pwm, capture_channel, buf);
+}
+
+static ssize_t capture_store(struct device *child,
+			     struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	capture_channel = val;
+
+	return size;
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
+static DEVICE_ATTR_RW(capture);
 
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
1.9.1
