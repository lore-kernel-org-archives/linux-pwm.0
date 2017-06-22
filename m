From: Nick Vaccaro <nvaccaro@google.com>
Subject: [PATCH] FIXUP: CHROMIUM: fix transposed param settings
Date: Thu, 22 Jun 2017 10:54:39 -0700
Message-ID: <20170622175439.81256-1-nvaccaro@chromium.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35801 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdFVRyp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Jun 2017 13:54:45 -0400
Received: by mail-pg0-f50.google.com with SMTP id 132so10829449pgb.2
        for <linux-pwm@vger.kernel.org>; Thu, 22 Jun 2017 10:54:45 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

The __cros_ec_pwm_get_duty() routine was transposing the insize and
outsize fields when calling cros_ec_cmd_xfer_status().

The original code worked without error due to size of the two particular
parameter blocks passed to cros_ec_cmd_xfer_status(), so this change is
not fixing an actual runtime problem, just correcting the calling usage.

Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
---
 drivers/pwm/pwm-cros-ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 2e4ab20cfb83..de5b7c9860b6 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -75,8 +75,8 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 
 	msg->version = 0;
 	msg->command = EC_CMD_PWM_GET_DUTY;
-	msg->insize = sizeof(*params);
-	msg->outsize = sizeof(*resp);
+	msg->insize = sizeof(*resp);
+	msg->outsize = sizeof(*params);
 
 	params->pwm_type = EC_PWM_TYPE_GENERIC;
 	params->index = index;
-- 
2.12.2
