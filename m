From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered down
Date: Wed, 22 May 2019 18:34:28 +0200
Message-ID: <20190522163428.7078-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

When the driver probes, the PWM pin is automatically configured to its
default state, which should be the "pwm" function. However, at this
point we don't know the actual level of the pin, which may be active or
inactive. As a result, if the driver probes without enabling the
backlight, the PWM pin might be active, and the backlight would be
lit way before being officially enabled.

To work around this, if the probe function doesn't enable the backlight,
the pin is set to its sleep state instead of the default one, until the
backlight is enabled. When the backlight is disabled, the pin is reset
to its sleep state.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/video/backlight/pwm_bl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fb45f866b923..422f7903b382 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/fb.h>
 #include <linux/backlight.h>
@@ -50,6 +51,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 	struct pwm_state state;
 	int err;
 
+	pinctrl_pm_select_default_state(pb->dev);
+
 	pwm_get_state(pb->pwm, &state);
 	if (pb->enabled)
 		return;
@@ -90,6 +93,8 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
+
+	pinctrl_pm_select_sleep_state(pb->dev);
 }
 
 static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
@@ -626,6 +631,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
+
+	if (bl->props.power == FB_BLANK_POWERDOWN)
+		pinctrl_pm_select_sleep_state(&pdev->dev);
+
 	return 0;
 
 err_alloc:
-- 
2.21.0.593.g511ec345e18
