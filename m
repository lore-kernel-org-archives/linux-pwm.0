From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] pwm: sysfs: Convert to use ATTRIBUTE_GROUPS macro
Date: Wed, 04 Dec 2013 14:52:50 +0800
Message-ID: <1386139970.9997.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:43103 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab3LDGxC (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2013 01:53:02 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so22878678pbc.12
        for <linux-pwm@vger.kernel.org>; Tue, 03 Dec 2013 22:53:01 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Rob Landley <rob@landley.net>, linux-pwm@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
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



