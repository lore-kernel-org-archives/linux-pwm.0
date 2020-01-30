From: Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
Date: Thu, 30 Jan 2020 12:31:01 -0800
Message-ID: <20200130203106.201894-14-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39878 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgA3Uf2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jan 2020 15:35:28 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so1839952pjr.4
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jan 2020 12:35:28 -0800 (PST)
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prashant Malani <pmalani@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>

Convert one existing usage of cros_ec_cmd_xfer_status() to
cros_ec_send_cmd_msg(), which accomplishes the same thing but also does
the EC message struct setup,and is defined in platform/chrome and is
accessible by other modules.

For the other usage, switch it to using cros_ec_cmd_xfer(), since the
calling functions rely on the result field of the struct cros_ec_command
struct that is used.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/pwm/pwm-cros-ec.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d21775..8bf610a6529e7e 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -32,25 +32,14 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 
 static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 {
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_pwm_set_duty params;
-	} __packed buf;
-	struct ec_params_pwm_set_duty *params = &buf.params;
-	struct cros_ec_command *msg = &buf.msg;
-
-	memset(&buf, 0, sizeof(buf));
+	struct ec_params_pwm_set_duty params = {0};
 
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_SET_DUTY;
-	msg->insize = 0;
-	msg->outsize = sizeof(*params);
-
-	params->duty = duty;
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
+	params.duty = duty;
+	params.pwm_type = EC_PWM_TYPE_GENERIC;
+	params.index = index;
 
-	return cros_ec_cmd_xfer_status(ec, msg);
+	return cros_ec_send_cmd_msg(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
+				    sizeof(params), NULL, 0);
 }
 
 static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
@@ -78,11 +67,13 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 	params->pwm_type = EC_PWM_TYPE_GENERIC;
 	params->index = index;
 
-	ret = cros_ec_cmd_xfer_status(ec, msg);
+	ret = cros_ec_cmd_xfer(ec, msg);
 	if (result)
 		*result = msg->result;
 	if (ret < 0)
 		return ret;
+	else if (msg->result != EC_RES_SUCCESS)
+		return -EPROTO;
 
 	return resp->duty;
 }
-- 
2.25.0.341.g760bfbb309-goog
