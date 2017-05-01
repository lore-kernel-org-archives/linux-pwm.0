From: Gottfried Haider <gottfried.haider@gmail.com>
Subject: [PATCH] pwm: Set class for exported channels in sysfs
Date: Mon,  1 May 2017 06:59:58 +0000
Message-ID: <1493621998-4982-1-git-send-email-gottfried.haider@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35736 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S642757AbdEAHAf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 May 2017 03:00:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id g12so13091600wrg.2
        for <linux-pwm@vger.kernel.org>; Mon, 01 May 2017 00:00:34 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gottfried Haider <gottfried.haider@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: hsweeten@visionengravers.com, linux-pwm@vger.kernel.org

Notifications for devices without bus or class set get dropped by
dev_uevent_filter. Adding the class to the exported child matches
what the gpio subsystem is doing.

With this change exporting a channel triggers a udev event, which
gives userspace a chance to fixup permissions and makes it possible
for non-root users to make use of the pwm subsystem.

Signed-off-by: Gottfried Haider <gottfried.haider@gmail.com>
---
 drivers/pwm/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index a813239..83f2b0b 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -263,6 +263,7 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	export->pwm = pwm;
 	mutex_init(&export->lock);
 
+	export->child.class = parent->class;
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
 	export->child.devt = MKDEV(0, 0);
-- 
2.1.4
