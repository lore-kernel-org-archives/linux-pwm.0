From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 1/2] pwm: atmel: Remove redundant of_match_ptr helper
Date: Thu, 23 Jan 2014 16:28:34 +0530
Message-ID: <1390474715-6587-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61913 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaAWLDG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jan 2014 06:03:06 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so1705111pab.5
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2014 03:03:05 -0800 (PST)
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
index bf4144a14661..45f0fb793528 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -381,7 +381,7 @@ static int atmel_pwm_remove(struct platform_device *pdev)
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

