From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] pwm: atmel: Remove redundant of_match_ptr helper
Date: Sat, 21 Dec 2013 15:27:46 +0530
Message-ID: <1387619866-21492-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:35866 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3LUKBE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Dec 2013 05:01:04 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so3586727pbc.40
        for <linux-pwm@vger.kernel.org>; Sat, 21 Dec 2013 02:01:03 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, sachin.kamat@linaro.org

'atmel_pwm_dt_ids' is always compiled in. Hence the
helper macro is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pwm/pwm-atmel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 657e90ab6e0a..cd6459e80690 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -379,7 +379,7 @@ static int atmel_pwm_remove(struct platform_device *pdev)
 static struct platform_driver atmel_pwm_driver = {
 	.driver = {
 		.name = "atmel-pwm",
-		.of_match_table = of_match_ptr(atmel_pwm_dt_ids),
+		.of_match_table = atmel_pwm_dt_ids,
 	},
 	.id_table = atmel_pwm_devtypes,
 	.probe = atmel_pwm_probe,
-- 
1.7.9.5

