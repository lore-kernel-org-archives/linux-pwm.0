From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 2/2] pwm: pxa: Use of_match_ptr helper
Date: Thu, 23 Jan 2014 16:28:35 +0530
Message-ID: <1390474715-6587-2-git-send-email-sachin.kamat@linaro.org>
References: <1390474715-6587-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:58543 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaAWLDI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jan 2014 06:03:08 -0500
Received: by mail-pb0-f52.google.com with SMTP id jt11so1698380pbb.39
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2014 03:03:07 -0800 (PST)
In-Reply-To: <1390474715-6587-1-git-send-email-sachin.kamat@linaro.org>
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
index 8d995731cef8..685ae2c96b77 100644
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

