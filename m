From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] backlight: pwm: handle EPROBE_DEFER while requesting the PWM
Date: Thu, 19 Feb 2015 10:30:14 +0100
Message-ID: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:53835 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbBSJaG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Feb 2015 04:30:06 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org, jg1.han@samsung.com
Cc: linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>

When trying to request the PWM device with devm_pwm_get(), the EPROBE_DEFER
flag is not handled properly. It can lead to the PWM not being found.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/video/backlight/pwm_bl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 3a145a643e0d..6897f1c1bc73 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -274,6 +274,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm)) {
+		ret = PTR_ERR(pb->pwm);
+		if (ret == -EPROBE_DEFER)
+			goto err_alloc;
+
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
 		pb->legacy = true;
 		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
-- 
2.1.3

