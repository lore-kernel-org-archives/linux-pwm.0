From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] pwm: pxa: Use of_match_ptr helper
Date: Sat, 21 Dec 2013 13:20:50 +0530
Message-ID: <1387612250-7704-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:56853 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3LUHyJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Dec 2013 02:54:09 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so3456697pdj.1
        for <linux-pwm@vger.kernel.org>; Fri, 20 Dec 2013 23:54:09 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, sachin.kamat@linaro.org

Use the helper instead of defining NULL for CONFIG_OF
disabled case.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pwm/pwm-pxa.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 3dc7c10bb7a0..5d25e4217542 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pwm.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 
 #include <asm/div64.h>
@@ -140,13 +141,12 @@ static struct of_device_id pwm_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_of_match);
-#else
-#define pwm_of_match NULL
 #endif
 
 static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
 {
-	const struct of_device_id *id = of_match_device(pwm_of_match, dev);
+	const struct of_device_id *id;
+	id = of_match_device(of_match_ptr(pwm_of_match), dev);
 
 	return id ? id->data : NULL;
 }
@@ -228,7 +228,7 @@ static struct platform_driver pwm_driver = {
 	.driver		= {
 		.name	= "pxa25x-pwm",
 		.owner	= THIS_MODULE,
-		.of_match_table = pwm_of_match,
+		.of_match_table = of_match_ptr(pwm_of_match),
 	},
 	.probe		= pwm_probe,
 	.remove		= pwm_remove,
-- 
1.7.9.5

