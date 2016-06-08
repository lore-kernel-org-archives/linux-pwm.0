From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 10/20] pwm: sysfs: Add PWM Capture support
Date: Wed,  8 Jun 2016 10:21:25 +0100
Message-ID: <20160608092135.21184-11-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
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
Cc: linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, patrice.chotard@st.com, robh+dt@kernel.org, thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>, maxime.coquelin@st.com
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
index d985992..901e647 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -208,16 +208,33 @@ static ssize_t polarity_store(struct device *child,
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
2.8.3
