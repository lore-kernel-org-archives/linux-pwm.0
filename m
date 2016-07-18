From: David Hsu <davidhsu@google.com>
Subject: [PATCH v2] pwm: Create device class for pwm channels
Date: Mon, 18 Jul 2016 15:14:50 -0700
Message-ID: <1468880090-46076-1-git-send-email-davidhsu@google.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34675 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcGRWOz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jul 2016 18:14:55 -0400
Received: by mail-pa0-f45.google.com with SMTP id fi15so146079pac.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 Jul 2016 15:14:55 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: gregkh@linuxfoundation.org, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, davidhsu@google.com

Pwm channels don't send uevents when exported, this change adds the
channels to a pwm class and set their device type to pwm_channel so
uevents are sent.

To do this properly, the device names need to change to uniquely
identify a channel.  This change is from pwmN to pwmchipM:N

Signed-off-by: David Hsu <davidhsu@google.com>
---
v2: Use parent name instead of chip->base for channel naming.

 Documentation/pwm.txt |  6 ++++--
 drivers/pwm/sysfs.c   | 18 +++++++++++++-----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 789b27c..8453435 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -80,9 +80,11 @@ unexport - Unexports a PWM channel from sysfs (write-only).
 
 The PWM channels are numbered using a per-chip index from 0 to npwm-1.
 
-When a PWM channel is exported a pwmX directory will be created in the
+When a PWM channel is exported a pwmchipN:X directory will be created in the
 pwmchipN directory it is associated with, where X is the number of the
-channel that was exported. The following properties will then be available:
+channel that was exported. It will also be exposed at /sys/class/pwm/ and
+can be identified by the pwm_channel device type.
+The following properties will then be available:
 
 period - The total period of the PWM signal (read/write).
 	Value is in nanoseconds and is the sum of the active and inactive
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 01695d4..cb2b376 100644
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
@@ -248,9 +254,11 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
+	export->child.type = &pwm_channel_type;
 	export->child.devt = MKDEV(0, 0);
+	export->child.class = &pwm_class;
 	export->child.groups = pwm_groups;
-	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+	dev_set_name(&export->child, "%s:%u", dev_name(parent), pwm->hwpwm);
 
 	ret = device_register(&export->child);
 	if (ret) {
@@ -355,7 +363,6 @@ ATTRIBUTE_GROUPS(pwm_chip);
 static struct class pwm_class = {
 	.name = "pwm",
 	.owner = THIS_MODULE,
-	.dev_groups = pwm_chip_groups,
 };
 
 static int pwmchip_sysfs_match(struct device *parent, const void *data)
@@ -368,14 +375,15 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
 	struct device *parent;
 
 	/*
-	 * If device_create() fails the pwm_chip is still usable by
+	 * If device_create_with_groups() fails the pwm_chip is still usable by
 	 * the kernel its just not exported.
 	 */
-	parent = device_create(&pwm_class, chip->dev, MKDEV(0, 0), chip,
+	parent = device_create_with_groups(&pwm_class, chip->dev, MKDEV(0, 0),
+			       chip, pwm_chip_groups,
 			       "pwmchip%d", chip->base);
 	if (IS_ERR(parent)) {
 		dev_warn(chip->dev,
-			 "device_create failed for pwm_chip sysfs export\n");
+			 "device_create_with_groups failed for pwm_chip sysfs export\n");
 	}
 }
 
-- 
2.8.0.rc3.226.g39d4020
