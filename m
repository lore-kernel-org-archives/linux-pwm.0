From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] backlight: pwm_bl: Remove error message upon devm_kzalloc() failure
Date: Sun,  1 Dec 2013 13:04:03 -0200
Message-ID: <1385910243-4625-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:62731 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab3LAPES (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 1 Dec 2013 10:04:18 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so7910806yha.26
        for <linux-pwm@vger.kernel.org>; Sun, 01 Dec 2013 07:04:17 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: jg1.han@samsung.com, linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

No need to have a specific OOM message, since there is generic MM out of memory
message in place.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/backlight/pwm_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fb80d68..b75201f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -241,7 +241,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb = devm_kzalloc(&pdev->dev, sizeof(*pb), GFP_KERNEL);
 	if (!pb) {
-		dev_err(&pdev->dev, "no memory for state\n");
 		ret = -ENOMEM;
 		goto err_alloc;
 	}
-- 
1.8.1.2

