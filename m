From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 1/2] backlight: pwm_bl: Move the checks for initial power state to a separate function
Date: Tue, 22 Nov 2016 15:41:22 +0200
Message-ID: <20161122134123.1209-2-peter.ujfalusi@ti.com>
References: <20161122134123.1209-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122134123.1209-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, lee.jones@linaro.org
Cc: tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Move the checks to select the initial state for the backlight to a new
function and document the checks we are doing.

With the separate function it is going to be easier to fix or improve the
initial power state configuration later and it is easier to read the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 56 ++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 12614006211e..5712ddd053dd 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -192,6 +192,32 @@ static int pwm_backlight_parse_dt(struct device *dev,
 }
 #endif
 
+static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
+{
+	struct device_node *node = pb->dev->of_node;
+
+	/* Not booted with device tree or no phandle link to the node */
+	if (!node || !node->phandle)
+		return FB_BLANK_UNBLANK;
+
+	/*
+	 * If the driver is probed from the device tree and there is a
+	 * phandle link pointing to the backlight node, it is safe to
+	 * assume that another driver will enable the backlight at the
+	 * appropriate time. Therefore, if it is disabled, keep it so.
+	 */
+
+	/* if the enable GPIO is disabled, do not enable the backlight */
+	if (pb->enable_gpio && gpiod_get_value(pb->enable_gpio) == 0)
+		return FB_BLANK_POWERDOWN;
+
+	/* The regulator is disabled, do not enable the backlight */
+	if (!regulator_is_enabled(pb->power_supply))
+		return FB_BLANK_POWERDOWN;
+
+	return FB_BLANK_UNBLANK;
+}
+
 static int pwm_backlight_probe(struct platform_device *pdev)
 {
 	struct platform_pwm_backlight_data *data = dev_get_platdata(&pdev->dev);
@@ -200,7 +226,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct backlight_device *bl;
 	struct device_node *node = pdev->dev.of_node;
 	struct pwm_bl_data *pb;
-	int initial_blank = FB_BLANK_UNBLANK;
 	struct pwm_args pargs;
 	int ret;
 
@@ -267,20 +292,16 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
 	}
 
-	if (pb->enable_gpio) {
-		/*
-		 * If the driver is probed from the device tree and there is a
-		 * phandle link pointing to the backlight node, it is safe to
-		 * assume that another driver will enable the backlight at the
-		 * appropriate time. Therefore, if it is disabled, keep it so.
-		 */
-		if (node && node->phandle &&
-		    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
-		    gpiod_get_value(pb->enable_gpio) == 0)
-			initial_blank = FB_BLANK_POWERDOWN;
-		else
-			gpiod_direction_output(pb->enable_gpio, 1);
-	}
+	/*
+	 * If the GPIO is configured as input, change the direction to output
+	 * and set the GPIO as active.
+	 * Do not force the GPIO to active when it was already output as it
+	 * could cause backlight flickering or we would enable the backlight too
+	 * early. Leave the decision of the initial backlight state for later.
+	 */
+	if (pb->enable_gpio &&
+	    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_IN)
+		gpiod_direction_output(pb->enable_gpio, 1);
 
 	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
 	if (IS_ERR(pb->power_supply)) {
@@ -288,9 +309,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	if (node && node->phandle && !regulator_is_enabled(pb->power_supply))
-		initial_blank = FB_BLANK_POWERDOWN;
-
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) != -EPROBE_DEFER && !node) {
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
@@ -347,7 +365,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	bl->props.brightness = data->dft_brightness;
-	bl->props.power = initial_blank;
+	bl->props.power = pwm_backlight_initial_power_state(pb);
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.11.0.rc2
