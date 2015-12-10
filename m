From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] backlight: pwm_bl: Fix broken PWM backlight for non-dt platforms
Date: Thu, 10 Dec 2015 10:09:06 +0100
Message-ID: <1449738546-10279-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54431 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751048AbbLJJI5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2015 04:08:57 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

Commit ee65ad0e2a9e ("backlight: pwm_bl: Avoid backlight flicker when
probed from DT") tries to dereference the device of_node pointer
unconditionally, causing a NULL pointer dereference on non-dt platforms.
Fix it by replacing the phandle variable with a node variable and
by checking that for NULL before dereferencing it.

Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 3daf9cc..a22c1ec 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -198,8 +198,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct platform_pwm_backlight_data defdata;
 	struct backlight_properties props;
 	struct backlight_device *bl;
+	struct device_node *node = pdev->dev.of_node;
 	struct pwm_bl_data *pb;
-	phandle phandle = pdev->dev.of_node->phandle;
 	int initial_blank = FB_BLANK_UNBLANK;
 	int ret;
 
@@ -273,7 +273,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		 * assume that another driver will enable the backlight at the
 		 * appropriate time. Therefore, if it is disabled, keep it so.
 		 */
-		if (phandle &&
+		if (node && node->phandle &&
 		    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
 		    gpiod_get_value(pb->enable_gpio) == 0)
 			initial_blank = FB_BLANK_POWERDOWN;
@@ -287,12 +287,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	if (phandle && !regulator_is_enabled(pb->power_supply))
+	if (node && node->phandle && !regulator_is_enabled(pb->power_supply))
 		initial_blank = FB_BLANK_POWERDOWN;
 
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
-	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) != -EPROBE_DEFER
-	    && !pdev->dev.of_node) {
+	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) != -EPROBE_DEFER && !node) {
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
 		pb->legacy = true;
 		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
-- 
2.6.2
