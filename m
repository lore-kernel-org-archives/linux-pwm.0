From: Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] pwm: Create device class for pwm channels
Date: Tue, 14 Jun 2016 19:12:04 -0700
Message-ID: <20160615021204.GA11507@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60545 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbcFOCMG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jun 2016 22:12:06 -0400
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, David Hsu <davidhsu@google.com>

From: David Hsu <davidhsu@google.com>

Pwm channels don't send uevents when exported, this change adds the
channels to a pwm class and set their device type to pwm_channel so
uevents are sent.

To do this properly, the device names need to change to uniquely
identify a channel.  This change is from pwmN to pwm-(chip->base):N

Signed-off-by: David Hsu <davidhsu@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/pwm.txt |    6 ++++--
 drivers/pwm/sysfs.c   |   15 ++++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

Note, this patch came from David with his work on a system that has
dynamic PWM devices and channels, and we needed some way to tell
userspace what is going on when they are added or removed.  If anyone
knows any other way of doing this that does not involve changing the pwm
names, please let us know.


diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 789b27c6ec99..7c24826691c0 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -80,9 +80,11 @@ unexport - Unexports a PWM channel from sysfs (write-only).
 
 The PWM channels are numbered using a per-chip index from 0 to npwm-1.
 
-When a PWM channel is exported a pwmX directory will be created in the
+When a PWM channel is exported a pwm-N:X directory will be created in the
 pwmchipN directory it is associated with, where X is the number of the
-channel that was exported. The following properties will then be available:
+channel that was exported. It will also be exposed at /sys/class/pwm/ and
+can be identified by the pwm_channel device type.
+The following properties will then be available:
 
 period - The total period of the PWM signal (read/write).
 	Value is in nanoseconds and is the sum of the active and inactive
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index d98599249a05..33122355ec55 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -23,6 +23,8 @@
 #include <linux/kdev_t.h>
 #include <linux/pwm.h>
 
+static struct class pwm_class;
+
 struct pwm_export {
 	struct device child;
 	struct pwm_device *pwm;
@@ -222,6 +224,10 @@ static struct attribute *pwm_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pwm);
 
+static const struct device_type pwm_channel_type = {
+	.name		= "pwm_channel",
+};
+
 static void pwm_export_release(struct device *child)
 {
 	struct pwm_export *export = child_to_pwm_export(child);
@@ -231,6 +237,7 @@ static void pwm_export_release(struct device *child)
 
 static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 {
+	struct pwm_chip *chip = dev_get_drvdata(parent);
 	struct pwm_export *export;
 	int ret;
 
@@ -248,9 +255,11 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
+	export->child.type = &pwm_channel_type;
 	export->child.devt = MKDEV(0, 0);
+	export->child.class = &pwm_class;
 	export->child.groups = pwm_groups;
-	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+	dev_set_name(&export->child, "pwm-%d:%u", chip->base, pwm->hwpwm);
 
 	ret = device_register(&export->child);
 	if (ret) {
@@ -355,7 +364,6 @@ ATTRIBUTE_GROUPS(pwm_chip);
 static struct class pwm_class = {
 	.name = "pwm",
 	.owner = THIS_MODULE,
-	.dev_groups = pwm_chip_groups,
 };
 
 static int pwmchip_sysfs_match(struct device *parent, const void *data)
@@ -371,7 +379,8 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
 	 * If device_create() fails the pwm_chip is still usable by
 	 * the kernel its just not exported.
 	 */
-	parent = device_create(&pwm_class, chip->dev, MKDEV(0, 0), chip,
+	parent = device_create_with_groups(&pwm_class, chip->dev, MKDEV(0, 0),
+			       chip, pwm_chip_groups,
 			       "pwmchip%d", chip->base);
 	if (IS_ERR(parent)) {
 		dev_warn(chip->dev,
