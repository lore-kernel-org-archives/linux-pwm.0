From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] pwm-backlight: Add support for pwm-delay-us property
Date: Wed, 28 Jun 2017 13:16:32 +0200
Message-ID: <20170628111632.22582-2-enric.balletbo@collabora.com>
References: <20170628111632.22582-1-enric.balletbo@collabora.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59052 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdF1LQu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Jun 2017 07:16:50 -0400
In-Reply-To: <20170628111632.22582-1-enric.balletbo@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, huang lin <hl@rock-chips.com>

From: huang lin <hl@rock-chips.com>

Some panel backlight (i.e. N116BGE-L41), in their power sequence
specifications, request a delay between PWM signal and the backlight
enable signal, so use the pwm-delay-us property to meet the timing.

Signed-off-by: huang lin <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/video/backlight/pwm_bl.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 002f1ce..c5c4ef0 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
@@ -30,6 +31,7 @@ struct pwm_bl_data {
 	unsigned int		period;
 	unsigned int		lth_brightness;
 	unsigned int		*levels;
+	unsigned int		pwm_delay;
 	bool			enabled;
 	struct regulator	*power_supply;
 	struct gpio_desc	*enable_gpio;
@@ -54,10 +56,14 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
+	pwm_enable(pb->pwm);
+
+	if (pb->pwm_delay)
+		usleep_range(pb->pwm_delay, pb->pwm_delay + 2000);
+
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
 	pb->enabled = true;
 }
 
@@ -66,12 +72,15 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
-
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
+	if (pb->pwm_delay)
+		usleep_range(pb->pwm_delay, pb->pwm_delay + 2000);
+
+	pwm_config(pb->pwm, 0, pb->period);
+	pwm_disable(pb->pwm);
+
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
 }
@@ -273,6 +282,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->dev = &pdev->dev;
 	pb->enabled = false;
 
+	of_property_read_u32(pdev->dev.of_node, "pwm-delay-us", &pb->pwm_delay);
 	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
 						  GPIOD_ASIS);
 	if (IS_ERR(pb->enable_gpio)) {
-- 
2.9.3
