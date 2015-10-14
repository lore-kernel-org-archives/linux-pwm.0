From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RESEND PATCH v2] pwm-backlight: Avoid backlight flicker when probed from DT
Date: Wed, 14 Oct 2015 15:25:19 +0200
Message-ID: <1444829119-4266-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44331 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbJNNZ3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Oct 2015 09:25:29 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Ajay Kumar <ajaykumar.rs@samsung.com>, YH Huang <yh.huang@mediatek.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

If the driver is probed from the device tree, and there is a phandle
property set on it, and the enable GPIO is already configured as output,
and the backlight is currently disabled, keep it disabled.
If all these conditions are met, assume there will be some other driver
that can enable the backlight at the appropriate time.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Also check if the regulator is enabled. If the power supply is disabled,
   and a phandle points to it, the backlight should stay powered down.
---
 drivers/video/backlight/pwm_bl.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index eff379b..31afd6d 100644
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
 	if (IS_ERR(pb->pwm)) {
 		ret = PTR_ERR(pb->pwm);
@@ -321,6 +343,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	bl->props.brightness = data->dft_brightness;
+	bl->props.power = initial_blank;
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.6.1
