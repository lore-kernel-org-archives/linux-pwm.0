From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] pwm: sysfs: Convert to use ATTRIBUTE_GROUPS macro
Date: Wed, 04 Dec 2013 18:29:53 +0800
Message-ID: <1386152993.22135.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:50745 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab3LDK37 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2013 05:29:59 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so22029589pde.20
        for <linux-pwm@vger.kernel.org>; Wed, 04 Dec 2013 02:29:58 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Rob Landley <rob@landley.net>, linux-pwm@vger.kernel.org

Use new ATTRIBUTE_GROUPS macro to reduce the number of lines of code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: update commit log
 drivers/pwm/sysfs.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 8c20332..4bd0c63 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -169,15 +169,7 @@ static struct attribute *pwm_attrs[] = {
 	&dev_attr_polarity.attr,
 	NULL
 };
-
-static const struct attribute_group pwm_attr_group = {
-	.attrs		= pwm_attrs,
-};
-
-static const struct attribute_group *pwm_attr_groups[] = {
-	&pwm_attr_group,
-	NULL,
-};
+ATTRIBUTE_GROUPS(pwm);
 
 static void pwm_export_release(struct device *child)
 {
@@ -205,7 +197,7 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
 	export->child.devt = MKDEV(0, 0);
-	export->child.groups = pwm_attr_groups;
+	export->child.groups = pwm_groups;
 	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
 
 	ret = device_register(&export->child);
-- 
1.8.1.2



