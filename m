Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 12/18] ARM: SAMSUNG: Rework private data handling in dev-backlight
Date: Fri, 21 Jun 2013 00:12:57 +0200
Message-Id: <1371766383-29077-13-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

This patch modifies dev-backlight helpers to get private data using
container_of instead of abusing platform_data field of PWM device.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/dev-backlight.c | 51 ++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
index 5f197dc..e467a01 100644
--- a/arch/arm/plat-samsung/dev-backlight.c
+++ b/arch/arm/plat-samsung/dev-backlight.c
@@ -20,13 +20,18 @@
 #include <plat/gpio-cfg.h>
 #include <plat/backlight.h>
 
+struct samsung_bl_drvdata {
+	struct platform_pwm_backlight_data plat_data;
+	struct samsung_bl_gpio_info *gpio_info;
+};
+
 static int samsung_bl_init(struct device *dev)
 {
 	int ret = 0;
-	struct platform_device *timer_dev =
-			container_of(dev->parent, struct platform_device, dev);
-	struct samsung_bl_gpio_info *bl_gpio_info =
-			timer_dev->dev.platform_data;
+	struct platform_pwm_backlight_data *pdata = dev->platform_data;
+	struct samsung_bl_drvdata *drvdata = container_of(pdata,
+					struct samsung_bl_drvdata, plat_data);
+	struct samsung_bl_gpio_info *bl_gpio_info = drvdata->gpio_info;
 
 	ret = gpio_request(bl_gpio_info->no, "Backlight");
 	if (ret) {
@@ -42,10 +47,10 @@ static int samsung_bl_init(struct device *dev)
 
 static void samsung_bl_exit(struct device *dev)
 {
-	struct platform_device *timer_dev =
-			container_of(dev->parent, struct platform_device, dev);
-	struct samsung_bl_gpio_info *bl_gpio_info =
-			timer_dev->dev.platform_data;
+	struct platform_pwm_backlight_data *pdata = dev->platform_data;
+	struct samsung_bl_drvdata *drvdata = container_of(pdata,
+					struct samsung_bl_drvdata, plat_data);
+	struct samsung_bl_gpio_info *bl_gpio_info = drvdata->gpio_info;
 
 	s3c_gpio_cfgpin(bl_gpio_info->no, S3C_GPIO_OUTPUT);
 	gpio_free(bl_gpio_info->no);
@@ -60,12 +65,14 @@ static void samsung_bl_exit(struct device *dev)
  * for their specific boards
  */
 
-static struct platform_pwm_backlight_data samsung_dfl_bl_data __initdata = {
-	.max_brightness = 255,
-	.dft_brightness = 255,
-	.pwm_period_ns  = 78770,
-	.init           = samsung_bl_init,
-	.exit           = samsung_bl_exit,
+static struct samsung_bl_drvdata samsung_dfl_bl_data __initdata = {
+	.plat_data = {
+		.max_brightness = 255,
+		.dft_brightness = 255,
+		.pwm_period_ns  = 78770,
+		.init           = samsung_bl_init,
+		.exit           = samsung_bl_exit,
+	},
 };
 
 static struct platform_device samsung_dfl_bl_device __initdata = {
@@ -82,6 +89,7 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 {
 	int ret = 0;
 	struct platform_device *samsung_bl_device;
+	struct samsung_bl_drvdata *samsung_bl_drvdata;
 	struct platform_pwm_backlight_data *samsung_bl_data;
 
 	samsung_bl_device = kmemdup(&samsung_dfl_bl_device,
@@ -91,17 +99,19 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 		return;
 	}
 
-	samsung_bl_data = s3c_set_platdata(&samsung_dfl_bl_data,
-		sizeof(struct platform_pwm_backlight_data), samsung_bl_device);
-	if (!samsung_bl_data) {
+	samsung_bl_drvdata = kmemdup(&samsung_dfl_bl_data,
+				sizeof(samsung_dfl_bl_data), GFP_KERNEL);
+	if (!samsung_bl_drvdata) {
 		printk(KERN_ERR "%s: no memory for platform dev\n", __func__);
 		goto err_data;
 	}
+	samsung_bl_device->dev.platform_data = &samsung_bl_drvdata->plat_data;
+	samsung_bl_drvdata->gpio_info = gpio_info;
+	samsung_bl_data = &samsung_bl_drvdata->plat_data;
 
 	/* Copy board specific data provided by user */
 	samsung_bl_data->pwm_id = bl_data->pwm_id;
-	samsung_bl_device->dev.parent =
-			&s3c_device_timer[samsung_bl_data->pwm_id].dev;
+	samsung_bl_device->dev.parent = &samsung_device_pwm.dev;
 
 	if (bl_data->max_brightness)
 		samsung_bl_data->max_brightness = bl_data->max_brightness;
@@ -122,9 +132,6 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 	if (bl_data->check_fb)
 		samsung_bl_data->check_fb = bl_data->check_fb;
 
-	/* Keep the GPIO info for future use */
-	s3c_device_timer[samsung_bl_data->pwm_id].dev.platform_data = gpio_info;
-
 	/* Register the specific PWM timer dev for Backlight control */
 	ret = platform_device_register(
 			&s3c_device_timer[samsung_bl_data->pwm_id]);
-- 
1.8.2.1
