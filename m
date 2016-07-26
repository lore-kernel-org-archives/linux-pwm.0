From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH] pwm: cros_ec: add __packed to prevent padding
Date: Tue, 26 Jul 2016 11:22:13 -0700
Message-ID: <1469557333-9497-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35215 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757785AbcGZSWk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Jul 2016 14:22:40 -0400
Received: by mail-pa0-f41.google.com with SMTP id iw10so2020665pac.2
        for <linux-pwm@vger.kernel.org>; Tue, 26 Jul 2016 11:22:40 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Gwendal Grignou <gwendal@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>

While the particular usage in question is likely safe (struct
cros_ec_command is 32-bit aligned, followed by <=32-bit fields), it's
been suggested this is not a great pattern to follow for the general
case -- for example, if we follow a 'struct cros_ec_command' (which is
32-bit- but not 64-bit-aligned) with a struct that starts with a 64-bit
type (e.g., u64), the compiler may add padding.

Let's add __packed, to inform the compiler of our true intention -- to
have no padding between these struct elements -- and to future proof for
any refactorings that might occur.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Hi Thierry,

I don't know of any bugs directly resolved by this patch, so take it for
v4.8/v4.9 at your discretion.

 drivers/pwm/pwm-cros-ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 99b9acc1a420..f6ca4e8c6253 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -38,7 +38,7 @@ static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 	struct {
 		struct cros_ec_command msg;
 		struct ec_params_pwm_set_duty params;
-	} buf;
+	} __packed buf;
 	struct ec_params_pwm_set_duty *params = &buf.params;
 	struct cros_ec_command *msg = &buf.msg;
 
@@ -65,7 +65,7 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 			struct ec_params_pwm_get_duty params;
 			struct ec_response_pwm_get_duty resp;
 		};
-	} buf;
+	} __packed buf;
 	struct ec_params_pwm_get_duty *params = &buf.params;
 	struct ec_response_pwm_get_duty *resp = &buf.resp;
 	struct cros_ec_command *msg = &buf.msg;
-- 
2.8.0.rc3.226.g39d4020
