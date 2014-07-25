From: Michael Olbrich <m.olbrich@pengutronix.de>
Subject: [PATCH] pwm-backlight: fix probing from device-tree without enable-gpios
Date: Fri, 25 Jul 2014 12:28:35 +0200
Message-ID: <1406284115-489-1-git-send-email-m.olbrich@pengutronix.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54272 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaGYK3E (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jul 2014 06:29:04 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Michael Olbrich <m.olbrich@pengutronix.de>

Since 257462dbf3ed ("pwm-backlight: switch to gpiod interface")
enable_gpio is no longer set and remains 0 when probing from
device-tree. This is a valid gpio number. With no enable-gpios
specified in the device-tree this is used and probing fails
with:

pwm-backlight lcd-backlight.3: failed to request GPIO#0: -16

Fix this by setting enable_gpio to -1 which is not a valid gpio
number.

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 38ca88b..5213d13 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -211,6 +211,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to find platform data\n");
 			return ret;
 		}
+		devdata.enable_gpio = -1;
 
 		data = &defdata;
 	}
-- 
2.0.1

