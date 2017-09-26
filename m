From: gohai@sukzessiv.net
Subject: [RESEND][PATCH] pwm: Set class for exported channels in sysfs
Date: Tue, 26 Sep 2017 11:59:51 +0000
Message-ID: <20170926115951.GA29367@sukzessiv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from habibi.sukzessiv.net ([192.34.62.119]:36804 "EHLO
        habibi.sukzessiv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdIZMKi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Sep 2017 08:10:38 -0400
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Gottfried Haider <gottfried.haider@gmail.com>

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

+       export->child.class = parent->class;
        export->child.release = pwm_export_release;
        export->child.parent = parent;
        export->child.devt = MKDEV(0, 0);
