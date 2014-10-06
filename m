From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] pwm-backlight: Turn off pwm backlight in probe
Date: Mon,  6 Oct 2014 21:22:44 +0200
Message-ID: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40513 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaJFTXG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Oct 2014 15:23:06 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

The backlight will be enabled by the panel again if it is used. So we
can save the default brightness and disable the pwm backlight when
probing.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 336b83be7e2d..b4f433a6f106 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -317,9 +317,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		data->dft_brightness = data->max_brightness;
 	}
 
-	bl->props.brightness = data->dft_brightness;
+	bl->props.brightness = 0;
 	backlight_update_status(bl);
 
+	bl->props.brightness = data->dft_brightness;
+
 	platform_set_drvdata(pdev, bl);
 	return 0;
 
-- 
2.1.0

