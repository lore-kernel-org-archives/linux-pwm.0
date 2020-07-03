From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 15/20] backlight: gpio_backlight: simplify update_status()
Date: Fri,  3 Jul 2020 20:45:41 +0200
Message-ID: <20200703184546.144664-16-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.v>
List-Id: linux-pwm@vger.kernel.org

Introduce the use of backlight_get_brightness() to simplify
the update_status() operation.
With the simpler implementation drop the gpio_backlight_get_next_brightness()
helper as it was now a one-liner.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/gpio_backlight.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 75409ddfba3e..6f78d928f054 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -21,24 +21,11 @@ struct gpio_backlight {
 	struct gpio_desc *gpiod;
 };
 
-static int gpio_backlight_get_next_brightness(struct backlight_device *bl)
-{
-	int brightness = bl->props.brightness;
-
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		brightness = 0;
-
-	return brightness;
-}
-
 static int gpio_backlight_update_status(struct backlight_device *bl)
 {
 	struct gpio_backlight *gbl = bl_get_data(bl);
-	int brightness = gpio_backlight_get_next_brightness(bl);
 
-	gpiod_set_value_cansleep(gbl->gpiod, brightness);
+	gpiod_set_value_cansleep(gbl->gpiod, backlight_get_brightness(bl));
 
 	return 0;
 }
@@ -108,7 +95,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 
 	bl->props.brightness = 1;
 
-	init_brightness = gpio_backlight_get_next_brightness(bl);
+	init_brightness = backlight_get_brightness(bl);
 	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
 	if (ret) {
 		dev_err(dev, "failed to set initial brightness\n");
-- 
2.25.1
