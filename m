From: YH Huang <yh.huang@mediatek.com>
Subject: The default value of enable_gpio in pwm-backlight driver?
Date: Thu, 3 Sep 2015 21:08:24 +0800
Message-ID: <1441285704.27600.26.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:44656 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753160AbbICNI2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2015 09:08:28 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org, djkurtz@chromium.org, yingjoe.chen@mediatek.com, yh.huang@mediatek.com

Hi all,

I have a problem while using the pwm-backlight driver.
I want to match the panel power sequence timing but fail in the probe
function. I think it is right to set the gpio "inactive" at
initialization. For now, the probe function always pulls high
enable_gpio although I set it as GPIO_ACTIVE_HIGH in dts.
I find the change and excerpt part of it. I am not sure if it is right.
If I misunderstanding something, please let me know.

Regards,
YH Huang


From	Alexandre Courbot <>
Subject	[PATCH 2/2] pwm-backlight: switch to gpiod interface
Date	Thu, 27 Feb 2014 14:53:34 +0900

Switch to the new gpiod interface, which allows to handle GPIO
properties such as active low transparently and removes a whole bunch of
code.

There are still a couple of users of this driver that rely on passing
the enable GPIO number through platform data, so a fallback mechanism
using a GPIO number is still available to avoid breaking them. It will
be removed once current users have switched to the GPIO lookup tables
provided by the gpiod interface.

--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c

@@ -265,26 +245,39 @@ static int pwm_backlight_probe(struct
platform_device *pdev)
 	pb->dev = &pdev->dev;
 	pb->enabled = false;
 
-	if (gpio_is_valid(pb->enable_gpio)) {
-		unsigned long flags;
-
-		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
-			flags = GPIOF_OUT_INIT_HIGH;
-		else
-			flags = GPIOF_OUT_INIT_LOW;
+	pb->enable_gpio = devm_gpiod_get(&pdev->dev, "enable");
+	if (IS_ERR(pb->enable_gpio)) {
+		ret = PTR_ERR(pb->enable_gpio);
+		if (ret == -ENOENT) {
+			pb->enable_gpio = NULL;
+			ret = 0;
+		} else {
+			goto err_alloc;
+		}
+	}
 
-		ret = gpio_request_one(pb->enable_gpio, flags, "enable");
+	/*
+	 * Compatibility fallback for drivers still using the integer GPIO
+	 * platform data. Must go away soon.
+	 */
+	if (pb->enable_gpio == NULL && gpio_is_valid(data->enable_gpio)) {
+		ret = devm_gpio_request_one(&pdev->dev, data->enable_gpio,
+					    GPIOF_OUT_INIT_HIGH, "enable");
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to request GPIO#%d: %d\n",
-				pb->enable_gpio, ret);
+				data->enable_gpio, ret);
 			goto err_alloc;
 		}
+		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
 	}
 
+	if (pb->enable_gpio)
+		gpiod_direction_output(pb->enable_gpio, 1);
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	Is here right?
