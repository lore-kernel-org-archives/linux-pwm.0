From: ryang <hachyang@gmail.com>
Subject: [PATCH 1/1] PWM Backlight: Fix a bug which could cause the PWM backlight driver use the wrong PWM chip and fail the driver probing if multiple PWM chips exist. This defect could also cause the unintended PWM chip  used and unaccessable by other drivers. The patch will check the error state first and allow a deferral PWM backlight probing if the intended PWM driver is not loaded at the probing moment.
Date: Wed,  3 Sep 2014 13:00:37 -0700
Message-ID: <1409774437-39530-1-git-send-email-ryang@hach.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35060 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbaICUAr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Sep 2014 16:00:47 -0400
Received: by mail-yk0-f169.google.com with SMTP id q200so5441233ykb.14
        for <linux-pwm@vger.kernel.org>; Wed, 03 Sep 2014 13:00:46 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, jg1.han@samsung.com, lee.jones@linaro.org
Cc: linux-pwm@vger.kernel.org, ryang <ryang@hach.com>

Signed-off-by: ryang <ryang@hach.com>
---
 drivers/video/backlight/pwm_bl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index b85983e..e0014a5 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -273,6 +273,9 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm)) {
+		ret = PTR_ERR(pb->pwm);
+		if (ret == -EPROBE_DEFER)
+			goto err_alloc;
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
 
 		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
-- 
1.9.1

