Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 04/15] ARM: SAMSUNG: Move all platforms to new clocksource driver
Date: Wed,  5 Jun 2013 23:18:09 +0200
Message-Id: <1370467100-10820-5-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>

This patch moves all Samsung platforms using PWM clocksource from legacy
samsung-time to new samsung-pwm-timer driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c24xx/Kconfig  | 12 ++++++------
 arch/arm/mach-s3c24xx/common.c | 16 ++++++++++++++++
 arch/arm/mach-s3c64xx/Kconfig  |  4 ++--
 arch/arm/mach-s3c64xx/common.c | 17 +++++++++++++++++
 arch/arm/mach-s5p64x0/Kconfig  |  4 ++--
 arch/arm/mach-s5p64x0/common.c | 17 +++++++++++++++++
 arch/arm/mach-s5pc100/Kconfig  |  2 +-
 arch/arm/mach-s5pc100/common.c | 17 +++++++++++++++++
 arch/arm/mach-s5pv210/Kconfig  |  2 +-
 arch/arm/mach-s5pv210/common.c | 17 +++++++++++++++++
 10 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 7ef7119..97a9b90 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -30,7 +30,7 @@ config CPU_S3C2410
 	select S3C2410_CLOCK
 	select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
 	select S3C2410_PM if PM
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	help
 	  Support for S3C2410 and S3C2410A family from the S3C24XX line
 	  of Samsung Mobile CPUs.
@@ -41,7 +41,7 @@ config CPU_S3C2412
 	select CPU_LLSERIAL_S3C2440
 	select S3C2412_DMA if S3C24XX_DMA
 	select S3C2412_PM if PM
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	help
 	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
 
@@ -53,7 +53,7 @@ config CPU_S3C2416
 	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
 	select SAMSUNG_CLKSRC
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
 
@@ -64,7 +64,7 @@ config CPU_S3C2440
 	select S3C2410_CLOCK
 	select S3C2410_PM if PM
 	select S3C2440_DMA if S3C24XX_DMA
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	help
 	  Support for S3C2440 Samsung Mobile CPU based systems.
 
@@ -74,7 +74,7 @@ config CPU_S3C2442
 	select CPU_LLSERIAL_S3C2440
 	select S3C2410_CLOCK
 	select S3C2410_PM if PM
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	help
 	  Support for S3C2442 Samsung Mobile CPU based systems.
 
@@ -89,7 +89,7 @@ config CPU_S3C2443
 	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
 	select SAMSUNG_CLKSRC
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index e5e7d7d..457261c 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -245,6 +245,22 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	samsung_pwm_set_platdata(&s3c24xx_pwm_variant);
 }
 
+void __init samsung_set_timer_source(unsigned int event, unsigned int source)
+{
+	s3c24xx_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
+	s3c24xx_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
+}
+
+void __init samsung_timer_init(void)
+{
+	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
+		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2, IRQ_TIMER3, IRQ_TIMER4,
+	};
+
+	samsung_pwm_clocksource_init(S3C_VA_TIMER,
+					timer_irqs, &s3c24xx_pwm_variant);
+}
+
 /* Serial port registrations */
 
 #define S3C2410_PA_UART0      (S3C24XX_PA_UART)
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 2057853..f78a6a0 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -17,13 +17,13 @@ config PLAT_S3C64XX
 # Configuration options for the S3C6410 CPU
 
 config CPU_S3C6400
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	bool
 	help
 	  Enable S3C6400 CPU support
 
 config CPU_S3C6410
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	bool
 	help
 	  Enable S3C6410 CPU support
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 5f3530e..add8451 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -157,6 +157,23 @@ static struct samsung_pwm_variant s3c64xx_pwm_variant = {
 	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
 };
 
+void __init samsung_set_timer_source(unsigned int event, unsigned int source)
+{
+	s3c64xx_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
+	s3c64xx_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
+}
+
+void __init samsung_timer_init(void)
+{
+	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC,
+	};
+
+	samsung_pwm_clocksource_init(S3C_VA_TIMER,
+					timer_irqs, &s3c64xx_pwm_variant);
+}
+
 /* read cpu identification code */
 
 void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 5a707bd..a39cd9e 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -11,14 +11,14 @@ config CPU_S5P6440
 	bool
 	select S5P_SLEEP if PM
 	select SAMSUNG_DMADEV
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	select SAMSUNG_WAKEMASK if PM
 	help
 	  Enable S5P6440 CPU support
 
 config CPU_S5P6450
 	bool
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	select S5P_SLEEP if PM
 	select SAMSUNG_DMADEV
 	select SAMSUNG_WAKEMASK if PM
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 50edd3c..5b1ce58 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -165,6 +165,23 @@ static struct samsung_pwm_variant s5p64x0_pwm_variant = {
 	.tclk_mask	= 0,
 };
 
+void __init samsung_set_timer_source(unsigned int event, unsigned int source)
+{
+	s5p64x0_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
+	s5p64x0_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
+}
+
+void __init samsung_timer_init(void)
+{
+	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC,
+	};
+
+	samsung_pwm_clocksource_init(S3C_VA_TIMER,
+					timer_irqs, &s5p64x0_pwm_variant);
+}
+
 /*
  * s5p64x0_map_io
  *
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 2f456a4..2094a9b 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -11,7 +11,7 @@ config CPU_S5PC100
 	bool
 	select S5P_EXT_INT
 	select SAMSUNG_DMADEV
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	help
 	  Enable S5PC100 CPU support
 
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index e56a4d8..1db8356 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -140,6 +140,23 @@ static struct samsung_pwm_variant s5pc100_pwm_variant = {
 	.tclk_mask	= (1 << 5),
 };
 
+void __init samsung_set_timer_source(unsigned int event, unsigned int source)
+{
+	s5pc100_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
+	s5pc100_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
+}
+
+void __init samsung_timer_init(void)
+{
+	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC,
+	};
+
+	samsung_pwm_clocksource_init(S3C_VA_TIMER,
+					timer_irqs, &s5pc100_pwm_variant);
+}
+
 /*
  * s5pc100_map_io
  *
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 0963283..07cdff7 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -15,7 +15,7 @@ config CPU_S5PV210
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
 	select SAMSUNG_DMADEV
-	select SAMSUNG_HRT
+	select CLKSRC_SAMSUNG_PWM
 	help
 	  Enable S5PV210 CPU support
 
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 4eba33d..d28affb 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -157,6 +157,23 @@ static struct samsung_pwm_variant s5pv210_pwm_variant = {
 	.tclk_mask	= (1 << 5),
 };
 
+void __init samsung_set_timer_source(unsigned int event, unsigned int source)
+{
+	s5pv210_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
+	s5pv210_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
+}
+
+void __init samsung_timer_init(void)
+{
+	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC,
+	};
+
+	samsung_pwm_clocksource_init(S3C_VA_TIMER,
+					timer_irqs, &s5pv210_pwm_variant);
+}
+
 /*
  * s5pv210_map_io
  *
-- 
1.8.2.1
