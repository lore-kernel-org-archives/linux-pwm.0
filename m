From: Nick Vaccaro <nvaccaro@google.com>
Subject: [PATCH] pwm: cros-ec: fix transposed param settings
Date: Fri, 23 Jun 2017 14:52:47 -0700
Message-ID: <20170623215247.114305-1-nvaccaro@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ThierryRediny.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The __cros_ec_pwm_get_duty() routine was transposing the insize and
outsize fields when calling cros_ec_cmd_xfer_status().

The original code worked without error due to size of the two particular
parameter blocks passed to cros_ec_cmd_xfer_status(), so this change is
not fixing an actual runtime problem, just correcting the calling usage.

Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
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
2.13.1.518.g3df882009-goog
