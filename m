From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: [PATCH 06/10] pwm: sysfs: make use of the DEVICE_ATTR_[RW][WO] macro's
Date: Mon, 26 Oct 2015 22:32:37 +0100
Message-ID: <1445895161-2317-7-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

For the npwm property the pwm sysfs interface already made use of the
DEVICE_ATTR_RO macro. This patch expands this to the other sysfs
properties so that the code base is concise and makes use of this
helpful macro.

This has the advantage of slightly reducing the code size, improving
readability and no longer using magic values for permissions.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/pwm/sysfs.c | 72 ++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index ba67845..9c90886 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -40,18 +40,18 @@ static struct pwm_device *child_to_pwm_device(struct device *child)
 	return export->pwm;
 }
 
-static ssize_t pwm_period_show(struct device *child,
-			       struct device_attribute *attr,
-			       char *buf)
+static ssize_t period_show(struct device *child,
+			   struct device_attribute *attr,
+			   char *buf)
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 
 	return sprintf(buf, "%u\n", pwm_get_period(pwm));
 }
 
-static ssize_t pwm_period_store(struct device *child,
-				struct device_attribute *attr,
-				const char *buf, size_t size)
+static ssize_t period_store(struct device *child,
+			    struct device_attribute *attr,
+			    const char *buf, size_t size)
 {
 	struct pwm_device *pwm = child_to_pwm_device(child);
 	unsigned int val;
@@ -66,18 +66,18 @@ static ssize_t pwm_period_store(struct device *child,
 	return ret ? : size;
 }
 
-static ssize_t pwm_duty_cycle_show(struct device *child,
-				   struct device_attribute *attr,
-				   char *buf)
+static ssize_t duty_cycle_show(struct device *child,
+			       struct device_attribute *attr,
+			       char *buf)
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 
 	return sprintf(buf, "%u\n", pwm_get_duty_cycle(pwm));
 }
 
-static ssize_t pwm_duty_cycle_store(struct device *child,
-				    struct device_attribute *attr,
-				    const char *buf, size_t size)
+static ssize_t duty_cycle_store(struct device *child,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
 {
 	struct pwm_device *pwm = child_to_pwm_device(child);
 	unsigned int val;
@@ -92,18 +92,18 @@ static ssize_t pwm_duty_cycle_store(struct device *child,
 	return ret ? : size;
 }
 
-static ssize_t pwm_enable_show(struct device *child,
-			       struct device_attribute *attr,
-			       char *buf)
+static ssize_t enable_show(struct device *child,
+			   struct device_attribute *attr,
+			   char *buf)
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 
 	return sprintf(buf, "%d\n", pwm_is_enabled(pwm));
 }
 
-static ssize_t pwm_enable_store(struct device *child,
-				struct device_attribute *attr,
-				const char *buf, size_t size)
+static ssize_t enable_store(struct device *child,
+			    struct device_attribute *attr,
+			    const char *buf, size_t size)
 {
 	struct pwm_device *pwm = child_to_pwm_device(child);
 	int val, ret;
@@ -127,9 +127,9 @@ static ssize_t pwm_enable_store(struct device *child,
 	return ret ? : size;
 }
 
-static ssize_t pwm_polarity_show(struct device *child,
-				 struct device_attribute *attr,
-				 char *buf)
+static ssize_t polarity_show(struct device *child,
+			     struct device_attribute *attr,
+			     char *buf)
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 	const char *polarity = "unknown";
@@ -147,9 +147,9 @@ static ssize_t pwm_polarity_show(struct device *child,
 	return sprintf(buf, "%s\n", polarity);
 }
 
-static ssize_t pwm_polarity_store(struct device *child,
-				  struct device_attribute *attr,
-				  const char *buf, size_t size)
+static ssize_t polarity_store(struct device *child,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
 {
 	struct pwm_device *pwm = child_to_pwm_device(child);
 	enum pwm_polarity polarity;
@@ -167,10 +167,10 @@ static ssize_t pwm_polarity_store(struct device *child,
 	return ret ? : size;
 }
 
-static DEVICE_ATTR(period, 0644, pwm_period_show, pwm_period_store);
-static DEVICE_ATTR(duty_cycle, 0644, pwm_duty_cycle_show, pwm_duty_cycle_store);
-static DEVICE_ATTR(enable, 0644, pwm_enable_show, pwm_enable_store);
-static DEVICE_ATTR(polarity, 0644, pwm_polarity_show, pwm_polarity_store);
+static DEVICE_ATTR_RW(period);
+static DEVICE_ATTR_RW(duty_cycle);
+static DEVICE_ATTR_RW(enable);
+static DEVICE_ATTR_RW(polarity);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
@@ -244,9 +244,9 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
 	return 0;
 }
 
-static ssize_t pwm_export_store(struct device *parent,
-				struct device_attribute *attr,
-				const char *buf, size_t len)
+static ssize_t export_store(struct device *parent,
+			    struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct pwm_chip *chip = dev_get_drvdata(parent);
 	struct pwm_device *pwm;
@@ -270,11 +270,11 @@ static ssize_t pwm_export_store(struct device *parent,
 
 	return ret ? : len;
 }
-static DEVICE_ATTR(export, 0200, NULL, pwm_export_store);
+static DEVICE_ATTR_WO(export);
 
-static ssize_t pwm_unexport_store(struct device *parent,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
+static ssize_t unexport_store(struct device *parent,
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
 {
 	struct pwm_chip *chip = dev_get_drvdata(parent);
 	unsigned int hwpwm;
@@ -291,7 +291,7 @@ static ssize_t pwm_unexport_store(struct device *parent,
 
 	return ret ? : len;
 }
-static DEVICE_ATTR(unexport, 0200, NULL, pwm_unexport_store);
+static DEVICE_ATTR_WO(unexport);
 
 static ssize_t npwm_show(struct device *parent, struct device_attribute *attr,
 			 char *buf)
-- 
2.6.1
