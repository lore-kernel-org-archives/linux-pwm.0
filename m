From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] pwm-backlight: Avoid backlight flicker when probed from DT
Date: Thu, 29 Oct 2015 16:51:46 +0100
Message-ID: <1446133906-3076-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbJ2Pvy (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Oct 2015 11:51:54 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Ajay Kumar <ajaykumar.rs@samsung.com>, YH Huang <yh.huang@mediatek.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

If the driver is probed from the device tree, and there is a phandle
property set on it, and the enable GPIO is already configured as output,
and the backlight is currently disabled, keep it disabled.
If all these conditions are met, assume there will be some other driver
that can enable the backlight at the appropriate time.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
Changes since v2:
 - Leave GPIO configuration as is (GPIOD_ASIS) when requesting,
   so we can actually check the initial state.
---
 drivers/video/backlight/pwm_bl.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index ae3c6b6..8e9c261 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -199,6 +199,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct pwm_bl_data *pb;
+	int initial_blank = FB_BLANK_UNBLANK;
+	bool phandle;
 	int ret;
 
 	if (!data) {
@@ -242,7 +244,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->enabled = false;
 
 	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
-						  GPIOD_OUT_HIGH);
+						  GPIOD_ASIS);
 	if (IS_ERR(pb->enable_gpio)) {
 		ret = PTR_ERR(pb->enable_gpio);
 		goto err_alloc;
@@ -264,12 +266,32 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
 	}
 
+	phandle = of_find_property(pdev->dev.of_node, "phandle", NULL) != NULL;
+
+	if (pb->enable_gpio) {
+		/*
+		 * If the driver is probed from the device tree and there is a
+		 * phandle link pointing to the backlight node, it is safe to
+		 * assume that another driver will enable the backlight at the
+		 * appropriate time. Therefore, if it is disabled, keep it so.
+		 */
+		if (phandle &&
+		    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
+		    gpiod_get_value(pb->enable_gpio) == 0)
+			initial_blank = FB_BLANK_POWERDOWN;
+		else
+			gpiod_direction_output(pb->enable_gpio, 1);
+	}
+
 	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
 	if (IS_ERR(pb->power_supply)) {
 		ret = PTR_ERR(pb->power_supply);
 		goto err_alloc;
 	}
 
+	if (phandle && !regulator_is_enabled(pb->power_supply))
+		initial_blank = FB_BLANK_POWERDOWN;
+
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) != -EPROBE_DEFER
 	    && !pdev->dev.of_node) {
@@ -320,6 +342,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	bl->props.brightness = data->dft_brightness;
+	bl->props.power = initial_blank;
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.6.1
