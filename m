From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 05/15] ARM: at91: at91sam9rl: switch to generic PWM framework
Date: Thu, 29 May 2014 01:20:08 +0200
Message-ID: <1401319218-16772-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Switch to the pwm/pwm-atmel driver instead of misc/atmel_pwm

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9rl.c         |  1 +
 arch/arm/mach-at91/at91sam9rl_devices.c | 11 ++---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index a79960f57e6a..878d5015daab 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -200,6 +200,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "fffc4000.ssc", &ssc1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20.0", &twi0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20.1", &twi1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9rl-pwm", &pwm_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
 	CLKDEV_CON_ID("pioB", &pioB_clk),
 	CLKDEV_CON_ID("pioC", &pioC_clk),
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 044ad8bc6963..76b3dbd13921 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -799,9 +799,7 @@ static void __init at91_add_device_watchdog(void) {}
  *  PWM
  * --------------------------------------------------------------------*/
 
-#if defined(CONFIG_ATMEL_PWM)
-static u32 pwm_mask;
-
+#if IS_ENABLED(CONFIG_PWM_ATMEL)
 static struct resource pwm_resources[] = {
 	[0] = {
 		.start	= AT91SAM9RL_BASE_PWMC,
@@ -816,11 +814,8 @@ static struct resource pwm_resources[] = {
 };
 
 static struct platform_device at91sam9rl_pwm0_device = {
-	.name	= "atmel_pwm",
+	.name	= "at91sam9rl-pwm",
 	.id	= -1,
-	.dev	= {
-		.platform_data		= &pwm_mask,
-	},
 	.resource	= pwm_resources,
 	.num_resources	= ARRAY_SIZE(pwm_resources),
 };
@@ -839,8 +834,6 @@ void __init at91_add_device_pwm(u32 mask)
 	if (mask & (1 << AT91_PWM3))
 		at91_set_B_periph(AT91_PIN_PD8, 1);	/* enable PWM3 */
 
-	pwm_mask = mask;
-
 	platform_device_register(&at91sam9rl_pwm0_device);
 }
 #else
-- 
1.9.1
