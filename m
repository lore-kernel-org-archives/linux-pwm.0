Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 13/18] ARM: SAMSUNG: Modify board files to use new PWM platform device
Date: Fri, 21 Jun 2013 00:12:58 +0200
Message-Id: <1371766383-29077-14-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

This patch modifies any board files using the legacy PWM device to use
the new device instead.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c24xx/mach-h1940.c    |  4 ++--
 arch/arm/mach-s3c24xx/mach-rx1950.c   |  5 ++---
 arch/arm/mach-s3c64xx/mach-crag6410.c |  4 ++--
 arch/arm/mach-s3c64xx/mach-hmt.c      |  4 ++--
 arch/arm/mach-s3c64xx/mach-smartq.c   |  4 ++--
 arch/arm/mach-s3c64xx/mach-smdk6410.c |  5 +++--
 arch/arm/mach-s5p64x0/mach-smdk6440.c |  5 +++--
 arch/arm/mach-s5p64x0/mach-smdk6450.c |  5 +++--
 arch/arm/mach-s5pc100/mach-smdkc100.c |  5 +++--
 arch/arm/mach-s5pv210/mach-smdkv210.c |  5 +++--
 arch/arm/plat-samsung/dev-backlight.c | 10 ----------
 11 files changed, 25 insertions(+), 31 deletions(-)

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
index bd3295a..d90b450 100644
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
@@ -691,9 +692,9 @@ static void __init smdk6410_machine_init(void)
 
 	s3c_ide_set_platdata(&smdk6410_ide_pdata);
 
-	samsung_bl_set(&smdk6410_bl_gpio_info, &smdk6410_bl_data);
-
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
+
+	samsung_bl_set(&smdk6410_bl_gpio_info, &smdk6410_bl_data);
 }
 
 MACHINE_START(SMDK6410, "SMDK6410")
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 73f71a6..0b00304 100644
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
@@ -254,8 +255,6 @@ static void __init smdk6440_machine_init(void)
 	i2c_register_board_info(1, smdk6440_i2c_devs1,
 			ARRAY_SIZE(smdk6440_i2c_devs1));
 
-	samsung_bl_set(&smdk6440_bl_gpio_info, &smdk6440_bl_data);
-
 	s5p6440_set_lcd_interface();
 	s3c_fb_set_platdata(&smdk6440_lcd_pdata);
 
@@ -264,6 +263,8 @@ static void __init smdk6440_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdk6440_hsmmc2_pdata);
 
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
+
+	samsung_bl_set(&smdk6440_bl_gpio_info, &smdk6440_bl_data);
 }
 
 MACHINE_START(SMDK6440, "SMDK6440")
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 18303e1..5949296 100644
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
@@ -273,8 +274,6 @@ static void __init smdk6450_machine_init(void)
 	i2c_register_board_info(1, smdk6450_i2c_devs1,
 			ARRAY_SIZE(smdk6450_i2c_devs1));
 
-	samsung_bl_set(&smdk6450_bl_gpio_info, &smdk6450_bl_data);
-
 	s5p6450_set_lcd_interface();
 	s3c_fb_set_platdata(&smdk6450_lcd_pdata);
 
@@ -283,6 +282,8 @@ static void __init smdk6450_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdk6450_hsmmc2_pdata);
 
 	platform_add_devices(smdk6450_devices, ARRAY_SIZE(smdk6450_devices));
+
+	samsung_bl_set(&smdk6450_bl_gpio_info, &smdk6450_bl_data);
 }
 
 MACHINE_START(SMDK6450, "SMDK6450")
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 8c880f7..7c57a22 100644
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
@@ -246,9 +247,9 @@ static void __init smdkc100_machine_init(void)
 	gpio_request(S5PC100_GPH0(6), "GPH0");
 	smdkc100_lcd_power_set(&smdkc100_lcd_power_data, 0);
 
-	samsung_bl_set(&smdkc100_bl_gpio_info, &smdkc100_bl_data);
-
 	platform_add_devices(smdkc100_devices, ARRAY_SIZE(smdkc100_devices));
+
+	samsung_bl_set(&smdkc100_bl_gpio_info, &smdkc100_bl_data);
 }
 
 MACHINE_START(SMDKC100, "SMDKC100")
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index d50b6f1..6d72bb99 100644
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
@@ -316,11 +317,11 @@ static void __init smdkv210_machine_init(void)
 
 	s3c_fb_set_platdata(&smdkv210_lcd0_pdata);
 
-	samsung_bl_set(&smdkv210_bl_gpio_info, &smdkv210_bl_data);
-
 	s3c_hsotg_set_platdata(&smdkv210_hsotg_pdata);
 
 	platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
+
+	samsung_bl_set(&smdkv210_bl_gpio_info, &smdkv210_bl_data);
 }
 
 MACHINE_START(SMDKV210, "SMDKV210")
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
