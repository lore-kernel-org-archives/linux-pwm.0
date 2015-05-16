From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] backlight: pwm_bl: Simplify usage of devm_gpiod_get_optional
Date: Sat, 16 May 2015 22:08:10 +0800
Message-ID: <1431785290.6638.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33889 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbbEPOIQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 16 May 2015 10:08:16 -0400
Received: by pabru16 with SMTP id ru16so68132032pab.1
        for <linux-pwm@vger.kernel.org>; Sat, 16 May 2015 07:08:15 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions),
the gpiod_get* functions take an additional parameter that allows to
specify direction and initial value for output.
Simplify the usage of devm_gpiod_get_optional accordingly.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/video/backlight/pwm_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 3a145a6..57cb9ec 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -241,7 +241,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->dev = &pdev->dev;
 	pb->enabled = false;
 
-	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
+	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						  GPIOD_OUT_HIGH);
 	if (IS_ERR(pb->enable_gpio)) {
 		ret = PTR_ERR(pb->enable_gpio);
 		goto err_alloc;
@@ -263,9 +264,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
 	}
 
-	if (pb->enable_gpio)
-		gpiod_direction_output(pb->enable_gpio, 1);
-
 	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
 	if (IS_ERR(pb->power_supply)) {
 		ret = PTR_ERR(pb->power_supply);
-- 
2.1.0
