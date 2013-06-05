Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 10/15] ARM: SAMSUNG: Modify board files to use new PWM platform device
Date: Wed,  5 Jun 2013 23:18:15 +0200
Message-Id: <1370467100-10820-11-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>

This patch modifies any board files using the legacy PWM device to use
the new device instead.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/mach-nuri.c      |  4 ++--
 arch/arm/mach-exynos/mach-origen.c    |  3 ++-
 arch/arm/mach-exynos/mach-smdk4x12.c  |  3 ++-
 arch/arm/mach-exynos/mach-smdkv310.c  |  3 ++-
 arch/arm/mach-s3c24xx/mach-h1940.c    |  4 ++--
 arch/arm/mach-s3c24xx/mach-rx1950.c   |  5 ++---
 arch/arm/mach-s3c64xx/mach-crag6410.c |  4 ++--
 arch/arm/mach-s3c64xx/mach-hmt.c      |  4 ++--
 arch/arm/mach-s3c64xx/mach-smartq.c   |  4 ++--
 arch/arm/mach-s3c64xx/mach-smdk6410.c |  1 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c |  1 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c |  1 +
 arch/arm/mach-s5pc100/mach-smdkc100.c |  1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c |  1 +
 arch/arm/plat-samsung/dev-backlight.c | 10 ----------
 15 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 5c8b287..a5193ed 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -310,7 +310,7 @@ static struct platform_device nuri_backlight_device = {
 	.name			= "pwm-backlight",
 	.id			= -1,
 	.dev			= {
-		.parent		= &s3c_device_timer[0].dev,
+		.parent		= &samsung_device_pwm.dev,
 		.platform_data	= &nuri_backlight_data,
 	},
 };
@@ -1302,7 +1302,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s3c_device_hsmmc2,
 	&s3c_device_hsmmc3,
 	&s3c_device_wdt,
-	&s3c_device_timer[0],
+	&samsung_device_pwm,
 	&s5p_device_ehci,
 	&s3c_device_i2c3,
 	&i2c9_gpio,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 27f03ed..d84274c 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -618,7 +618,7 @@ static struct platform_device origen_lcd_hv070wsa = {
 };
 
 static struct pwm_lookup origen_pwm_lookup[] = {
-	PWM_LOOKUP("s3c24xx-pwm.0", 0, "pwm-backlight.0", NULL),
+	PWM_LOOKUP("samsung-pwm", 0, "pwm-backlight.0", NULL),
 };
 
 #ifdef CONFIG_DRM_EXYNOS_FIMD
@@ -693,6 +693,7 @@ static struct platform_device *origen_devices[] __initdata = {
 	&s3c_device_hsmmc2,
 	&s3c_device_hsmmc0,
 	&s3c_device_i2c0,
+	&samsung_device_pwm,
 	&s3c_device_rtc,
 	&s3c_device_usb_hsotg,
 	&s3c_device_wdt,
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index 2c8af96..f854f22 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -224,7 +224,7 @@ static struct platform_pwm_backlight_data smdk4x12_bl_data = {
 };
 
 static struct pwm_lookup smdk4x12_pwm_lookup[] = {
-	PWM_LOOKUP("s3c24xx-pwm.1", 0, "pwm-backlight.0", NULL),
+	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", NULL),
 };
 
 static uint32_t smdk4x12_keymap[] __initdata = {
@@ -305,6 +305,7 @@ static struct platform_device *smdk4x12_devices[] __initdata = {
 	&s3c_device_i2c1,
 	&s3c_device_i2c3,
 	&s3c_device_i2c7,
+	&samsung_device_pwm,
 	&s3c_device_rtc,
 	&s3c_device_usb_hsotg,
 	&s3c_device_wdt,
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index d95b8cf..f0c47b5 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -289,6 +289,7 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_hsmmc3,
 	&s3c_device_i2c1,
 	&s5p_device_i2c_hdmiphy,
+	&samsung_device_pwm,
 	&s3c_device_rtc,
 	&s3c_device_usb_hsotg,
 	&s3c_device_wdt,
@@ -358,7 +359,7 @@ static struct i2c_board_info hdmiphy_info = {
 };
 
 static struct pwm_lookup smdkv310_pwm_lookup[] = {
-	PWM_LOOKUP("s3c24xx-pwm.1", 0, "pwm-backlight.0", NULL),
+	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", NULL),
 };
 
 static void s5p_tv_setup(void)
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index af4334d..74dd479 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -512,7 +512,7 @@ static struct platform_pwm_backlight_data backlight_data = {
 static struct platform_device h1940_backlight = {
 	.name = "pwm-backlight",
 	.dev  = {
-		.parent = &s3c_device_timer[0].dev,
+		.parent = &samsung_device_pwm.dev,
 		.platform_data = &backlight_data,
 	},
 	.id   = -1,
@@ -632,7 +632,7 @@ static struct platform_device *h1940_devices[] __initdata = {
 	&h1940_device_bluetooth,
 	&s3c_device_sdi,
 	&s3c_device_rtc,
-	&s3c_device_timer[0],
+	&samsung_device_pwm,
 	&h1940_backlight,
 	&h1940_lcd_powerdev,
 	&s3c_device_adc,
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 44ca018..206b1f7 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -530,7 +530,7 @@ static struct platform_pwm_backlight_data rx1950_backlight_data = {
 static struct platform_device rx1950_backlight = {
 	.name = "pwm-backlight",
 	.dev = {
-		.parent = &s3c_device_timer[0].dev,
+		.parent = &samsung_device_pwm.dev,
 		.platform_data = &rx1950_backlight_data,
 	},
 };
@@ -717,8 +717,7 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&s3c_device_sdi,
 	&s3c_device_adc,
 	&s3c_device_ts,
-	&s3c_device_timer[0],
-	&s3c_device_timer[1],
+	&samsung_device_pwm,
 	&rx1950_backlight,
 	&rx1950_device_gpiokeys,
 	&power_supply,
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 8ad88ac..28889cc 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -120,7 +120,7 @@ static struct platform_device crag6410_backlight_device = {
 	.name		= "pwm-backlight",
 	.id		= -1,
 	.dev		= {
-		.parent	= &s3c_device_timer[0].dev,
+		.parent	= &samsung_device_pwm.dev,
 		.platform_data = &crag6410_backlight_data,
 	},
 };
@@ -375,7 +375,7 @@ static struct platform_device *crag6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_ohci,
 	&s3c_device_usb_hsotg,
-	&s3c_device_timer[0],
+	&samsung_device_pwm,
 	&s3c64xx_device_iis0,
 	&s3c64xx_device_iis1,
 	&samsung_device_keypad,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 5b7f357..f39569e 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -123,7 +123,7 @@ static struct platform_pwm_backlight_data hmt_backlight_data = {
 static struct platform_device hmt_backlight_device = {
 	.name		= "pwm-backlight",
 	.dev		= {
-		.parent	= &s3c_device_timer[1].dev,
+		.parent	= &samsung_device_pwm.dev,
 		.platform_data = &hmt_backlight_data,
 	},
 };
@@ -239,7 +239,7 @@ static struct platform_device *hmt_devices[] __initdata = {
 	&s3c_device_nand,
 	&s3c_device_fb,
 	&s3c_device_ohci,
-	&s3c_device_timer[1],
+	&samsung_device_pwm,
 	&hmt_backlight_device,
 	&hmt_leds_device,
 };
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 58ac990..86d980b 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -157,7 +157,7 @@ static struct platform_pwm_backlight_data smartq_backlight_data = {
 static struct platform_device smartq_backlight_device = {
 	.name		= "pwm-backlight",
 	.dev		= {
-		.parent	= &s3c_device_timer[1].dev,
+		.parent	= &samsung_device_pwm.dev,
 		.platform_data = &smartq_backlight_data,
 	},
 };
@@ -246,7 +246,7 @@ static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_ohci,
 	&s3c_device_rtc,
-	&s3c_device_timer[1],
+	&samsung_device_pwm,
 	&s3c_device_ts,
 	&s3c_device_usb_hsotg,
 	&s3c64xx_device_iis0,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index bd3295a..2b54ba0 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -274,6 +274,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_i2c1,
 	&s3c_device_fb,
 	&s3c_device_ohci,
+	&samsung_device_pwm,
 	&s3c_device_usb_hsotg,
 	&s3c64xx_device_iisv4,
 	&samsung_device_keypad,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 73f71a6..db4de76 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -162,6 +162,7 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
+	&samsung_device_pwm,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 	&s5p6440_device_iis,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 18303e1..840bddd 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -180,6 +180,7 @@ static struct platform_device *smdk6450_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
+	&samsung_device_pwm,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 	&s5p6450_device_iis0,
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 8c880f7..dd639ad 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -194,6 +194,7 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
+	&samsung_device_pwm,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 	&smdkc100_lcd_powerdev,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index d50b6f1..c642280 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -218,6 +218,7 @@ static struct platform_device *smdkv210_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
 	&s3c_device_i2c2,
+	&samsung_device_pwm,
 	&s3c_device_rtc,
 	&s3c_device_ts,
 	&s3c_device_usb_hsotg,
diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
index e467a01..d51f956 100644
--- a/arch/arm/plat-samsung/dev-backlight.c
+++ b/arch/arm/plat-samsung/dev-backlight.c
@@ -132,14 +132,6 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 	if (bl_data->check_fb)
 		samsung_bl_data->check_fb = bl_data->check_fb;
 
-	/* Register the specific PWM timer dev for Backlight control */
-	ret = platform_device_register(
-			&s3c_device_timer[samsung_bl_data->pwm_id]);
-	if (ret) {
-		printk(KERN_ERR "failed to register pwm timer for backlight: %d\n", ret);
-		goto err_plat_reg1;
-	}
-
 	/* Register the Backlight dev */
 	ret = platform_device_register(samsung_bl_device);
 	if (ret) {
@@ -150,8 +142,6 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 	return;
 
 err_plat_reg2:
-	platform_device_unregister(&s3c_device_timer[samsung_bl_data->pwm_id]);
-err_plat_reg1:
 	kfree(samsung_bl_data);
 err_data:
 	kfree(samsung_bl_device);
-- 
1.8.2.1
