From: Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v2 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
Date: Wed,  5 Feb 2020 11:00:20 -0800
Message-ID: <20200205190028.183069-14-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38152 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBETRC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Feb 2020 14:17:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so1430538pgm.5
        for <linux-pwm@vger.kernel.org>; Wed, 05 Feb 2020 11:17:02 -0800 (PST)
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prashant Malani <pmalani@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>

Convert existing usages of cros_ec_cmd_xfer_status() to cros_ec_cmd(),
which accomplishes the same thing but also does the EC message struct
setup, is defined in platform/chrome and is accessible by other
modules.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.
- Use C99 element setting for struct initialization.

 drivers/pwm/pwm-cros-ec.c | 59 +++++++++++----------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d21775..57a1cab4cfacad 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -32,59 +32,32 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 
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
-
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_SET_DUTY;
-	msg->insize = 0;
-	msg->outsize = sizeof(*params);
-
-	params->duty = duty;
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
-
-	return cros_ec_cmd_xfer_status(ec, msg);
+	struct ec_params_pwm_set_duty params = {
+		.duty = duty,
+		.pwm_type = EC_PWM_TYPE_GENERIC,
+		.index = index,
+	};
+
+	return cros_ec_cmd(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
+			   sizeof(params), NULL, 0, NULL);
 }
 
 static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 				  u32 *result)
 {
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_params_pwm_get_duty params;
-			struct ec_response_pwm_get_duty resp;
-		};
-	} __packed buf;
-	struct ec_params_pwm_get_duty *params = &buf.params;
-	struct ec_response_pwm_get_duty *resp = &buf.resp;
-	struct cros_ec_command *msg = &buf.msg;
+	struct ec_params_pwm_get_duty params = {
+		.pwm_type = EC_PWM_TYPE_GENERIC,
+		.index = index,
+	};
+	struct ec_response_pwm_get_duty resp = {0};
 	int ret;
 
-	memset(&buf, 0, sizeof(buf));
-
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_GET_DUTY;
-	msg->insize = sizeof(*resp);
-	msg->outsize = sizeof(*params);
-
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
-
-	ret = cros_ec_cmd_xfer_status(ec, msg);
-	if (result)
-		*result = msg->result;
+	ret = cros_ec_cmd(ec, 0, EC_CMD_PWM_GET_DUTY, &params, sizeof(params),
+			  &resp, sizeof(resp), result);
 	if (ret < 0)
 		return ret;
 
-	return resp->duty;
+	return resp.duty;
 }
 
 static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
-- 
2.25.0.341.g760bfbb309-goog
