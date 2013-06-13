Return-Path: <laurent.pinchart+renesas@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 2/5] ARM: mach-shmobile: armadillo800eva: Add backlight support
Date: Thu, 13 Jun 2013 18:54:45 +0200
Message-Id: <1371142488-2514-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-sh@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

The flat panel backlight on the Armadillo 800 EVA board is driven by the
TPU PWM output.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 54 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7740.c         |  2 +-
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 44a6215..5377204 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -31,6 +31,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/regulator/driver.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/pwm-renesas-tpu.h>
+#include <linux/pwm_backlight.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
@@ -386,7 +388,50 @@ static struct platform_device sh_eth_device = {
 	.num_resources = ARRAY_SIZE(sh_eth_resources),
 };
 
-/* LCDC */
+/* PWM */
+static struct resource pwm_resources[] = {
+	[0] = {
+		.start = 0xe6600000,
+		.end = 0xe66000ff,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct tpu_pwm_platform_data pwm_device_data = {
+	.channels[2] = {
+		.polarity = PWM_POLARITY_INVERSED,
+	}
+};
+
+static struct platform_device pwm_device = {
+	.name = "renesas-tpu-pwm",
+	.id = -1,
+	.dev = {
+		.platform_data = &pwm_device_data,
+	},
+	.num_resources = ARRAY_SIZE(pwm_resources),
+	.resource = pwm_resources,
+};
+
+static struct pwm_lookup pwm_lookup[] = {
+	PWM_LOOKUP("renesas-tpu-pwm", 2, "pwm-backlight.0", NULL),
+};
+
+/* LCDC and backlight */
+static struct platform_pwm_backlight_data pwm_backlight_data = {
+	.lth_brightness = 50,
+	.max_brightness = 255,
+	.dft_brightness = 255,
+	.pwm_period_ns = 33333, /* 30kHz */
+};
+
+static struct platform_device pwm_backlight_device = {
+	.name = "pwm-backlight",
+	.dev = {
+		.platform_data = &pwm_backlight_data,
+	},
+};
+
 static struct fb_videomode lcdc0_mode = {
 	.name		= "AMPIER/AM-800480",
 	.xres		= 800,
@@ -1029,6 +1074,8 @@ static struct i2c_board_info i2c2_devices[] = {
  */
 static struct platform_device *eva_devices[] __initdata = {
 	&lcdc0_device,
+	&pwm_device,
+	&pwm_backlight_device,
 	&gpio_keys_device,
 	&sh_eth_device,
 	&vcc_sdhi0,
@@ -1100,6 +1147,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 	/* ST1232 */
 	PIN_MAP_MUX_GROUP_DEFAULT("0-0055", "pfc-r8a7740",
 				  "intc_irq10", "intc"),
+	/* TPU0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas-tpu-pwm", "pfc-r8a7740",
+				  "tpu0_to2_1", "tpu0"),
 	/* USBHS */
 	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7740",
 				  "intc_irq7_1", "intc"),
@@ -1153,13 +1203,13 @@ static void __init eva_init(void)
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 
 	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
+	pwm_add_table(pwm_lookup, ARRAY_SIZE(pwm_lookup));
 
 	r8a7740_pinmux_init();
 	r8a7740_meram_workaround();
 
 	/* LCDC0 */
 	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
-	gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
 
 	/* Touchscreen */
 	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 7fd32d6..f5b7bbe 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -596,7 +596,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
-	CLKDEV_DEV_ID("renesas_tpu_pwm",	&mstp_clks[MSTP304]),
+	CLKDEV_DEV_ID("renesas-tpu-pwm",	&mstp_clks[MSTP304]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),
-- 
1.8.1.5
