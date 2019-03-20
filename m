Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36389 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTOsa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Mar 2019 10:48:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id e4so2235449edi.3
        for <linux-pwm@vger.kernel.org>; Wed, 20 Mar 2019 07:48:29 -0700 (PDT)
Reply-To: bdv.integrator@gmail.com
From: Bart De Vos <bdv.integrator@gmail.com>
Message-ID: <9e1828a2-e3ae-853b-6a1c-010d1aa2f670@gmail.com>
Date: Wed, 20 Mar 2019 15:48:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: issue with (parent)class for exported channels in sysfs
To: gottfried.haider@gmail.com
Cc: thierry.reding@gmail.com, hsweeten@visionengravers.com, linux-pwm@vger.kernel.org

Hi,

The commit below causes the following side-effect:

symlinks are created for each individual pwm, as follows (conceptually):

/sys/class/pwm/pwm0 -> /sys/class/pwm/pwmchip0/pwm0

This fails for exporting the next pwmchip, since pwmchips enumerate 
their channels from 0 ... <npwm>.

I can work around it by putting the assignment of the class around a 
CONFIG_PWM_PARENT_CLASS, since I don't use uevents on my embedded system 
for pwms.

Yet I believe both use-cases should be possible,
i.e. set the right properties to support proper uevents
_AND_
export multiple channels from multiple chips over sysfs.

What are your thoughts on a good way forward?

Thanks in advance for your feedback.

Kr,
Bart.

commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00
Author: Gottfried Haider <gottfried.haider@gmail.com>
Date:   Tue Sep 26 11:59:51 2017 +0000

     pwm: Set class for exported channels in sysfs

     Notifications for devices without bus or class set get dropped by
     dev_uevent_filter(). Adding the class to the exported child matches
     what the GPIO subsystem is doing.

     With this change exporting a channel triggers a udev event, which
     gives userspace a chance to fixup permissions and makes it possible
     for non-root users to make use of the PWM subsystem.

     Signed-off-by: Gottfried Haider <gottfried.haider@gmail.com>
     CC: Thierry Reding <thierry.reding@gmail.com>
     CC: H Hartley Sweeten <hsweeten@visionengravers.com>
     CC: linux-pwm@vger.kernel.org
     CC: linux-arm-kernel@lists.infradead.org
     CC: linux-rpi-kernel@lists.infradead.org
     Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index a813239300c3..83f2b0b15712 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -263,6 +263,7 @@ static int pwm_export_child(struct device *parent, 
struct pwm_device *pwm)
         export->pwm = pwm;
         mutex_init(&export->lock);

+       export->child.class = parent->class;
         export->child.release = pwm_export_release;
         export->child.parent = parent;
         export->child.devt = MKDEV(0, 0);
