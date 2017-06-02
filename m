From: Gottfried Haider <gottfried.haider@gmail.com>
Subject: [RESEND][PATCH] pwm: Set class for exported channels in sysfs
Date: Fri,  2 Jun 2017 10:05:21 +0000
Message-ID: <1496397921-1713-1-git-send-email-gottfried.haider@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33506 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdFBKFd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Jun 2017 06:05:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id b84so17797555wmh.0
        for <linux-pwm@vger.kernel.org>; Fri, 02 Jun 2017 03:05:33 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gottfried Haider <gottfried.haider@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org

Notifications for devices without bus or class set get dropped by
dev_uevent_filter. Adding the class to the exported child matches
what the gpio subsystem is doing.

With this change exporting a channel triggers a udev event, which
gives userspace a chance to fixup permissions and makes it possible
for non-root users to make use of the pwm subsystem.

Signed-off-by: Gottfried Haider <gottfried.haider@gmail.com>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: H Hartley Sweeten <hsweeten@visionengravers.com>
CC: linux-pwm@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-rpi-kernel@lists.infradead.org
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
