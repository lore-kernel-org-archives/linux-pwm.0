From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while requesting the PWM"
Date: Sat, 26 Sep 2015 21:24:42 +0200
Message-ID: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:42353 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbbIZTaA (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Sep 2015 15:30:00 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

This reverts commit 68feaca0b13e453aa14ee064c1736202b48b342f.
This commit breaks legacy platforms, for which :
 (a) no pwm table is added (legacy platforms)
 (b) in this case, in pwm_get(), pmw_lookup_list is empty, and therefore
     chosen == NULL, and therefore pwm_get() returns NULL, and pwm_get()
     returns -EPROBE_DEFER
 (c) as a consequence, this code is unreachable in pwm_bl.c :
     if (IS_ERR(pb->pwm)) {
	ret = PTR_ERR(pb->pwm);
 	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret);
 	if (ret == -EPROBE_DEFER)
 		goto err_alloc;

 	dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
 	pb->legacy = true;
 	pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");

As this code is unreachable, all legacy platforms relying on pwm_id are
broken, amongst which pxa have been tested as broken.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/video/backlight/pwm_bl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index eff379b234cc..57cb9ec8be43 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -272,10 +272,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm)) {
-		ret = PTR_ERR(pb->pwm);
-		if (ret == -EPROBE_DEFER)
-			goto err_alloc;
-
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
 		pb->legacy = true;
 		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
-- 
2.1.4
