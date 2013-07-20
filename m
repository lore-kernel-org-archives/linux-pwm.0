Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v4 08/20] ARM: SAMSUNG: Set PWM platform data
Date: Sat, 20 Jul 2013 02:04:21 +0200
Message-Id: <1374278673-25615-10-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

From: Tomasz Figa <t.figa@samsung.com>

This patch adds PWM platform data needed for legacy (non-DT) platforms
to handle SoC-specific bits of the PWM/timer block.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c24xx/common.c | 11 +++++++++++
 arch/arm/mach-s3c64xx/common.c | 11 +++++++++++
 arch/arm/mach-s5p64x0/common.c | 10 ++++++++++
 arch/arm/mach-s5pc100/common.c | 11 +++++++++++
 arch/arm/mach-s5pv210/common.c | 11 +++++++++++
 5 files changed, 54 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index c157103..e5e7d7d 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/serial_core.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -49,6 +50,7 @@
 #include <plat/clock.h>
 #include <plat/cpu-freq.h>
 #include <plat/pll.h>
+#include <plat/pwm-core.h>
 
 #include "common.h"
 
@@ -216,6 +218,13 @@ static void s3c24xx_default_idle(void)
 		     S3C2410_CLKCON);
 }
 
+static struct samsung_pwm_variant s3c24xx_pwm_variant = {
+	.bits		= 16,
+	.div_base	= 1,
+	.has_tint_cstat	= false,
+	.tclk_mask	= (1 << 4),
+};
+
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 {
 	arm_pm_idle = s3c24xx_default_idle;
@@ -232,6 +241,8 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	s3c24xx_init_cpu();
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_pwm_set_platdata(&s3c24xx_pwm_variant);
 }
 
 /* Serial port registrations */
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 3f62e46..ca05e61 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -27,6 +27,7 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/irqchip/arm-vic.h>
+#include <clocksource/samsung_pwm.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -43,6 +44,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/irq-uart.h>
 #include <plat/irq-vic-timer.h>
+#include <plat/pwm-core.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
 #include <plat/watchdog-reset.h>
@@ -149,6 +151,13 @@ static struct device s3c64xx_dev = {
 	.bus	= &s3c64xx_subsys,
 };
 
+static struct samsung_pwm_variant s3c64xx_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
+};
+
 /* read cpu identification code */
 
 void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
@@ -161,6 +170,8 @@ void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 	s3c64xx_init_cpu();
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_pwm_set_platdata(&s3c64xx_pwm_variant);
 }
 
 static __init int s3c64xx_dev_init(void)
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index dfdfdc3..49687f2 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/serial_core.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
@@ -47,6 +48,7 @@
 #include <plat/fb-core.h>
 #include <plat/spi-core.h>
 #include <plat/gpio-cfg.h>
+#include <plat/pwm-core.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
 #include <plat/watchdog-reset.h>
@@ -157,6 +159,13 @@ static void s5p64x0_idle(void)
 	cpu_do_idle();
 }
 
+static struct samsung_pwm_variant s5p64x0_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= 0,
+};
+
 /*
  * s5p64x0_map_io
  *
@@ -176,6 +185,7 @@ void __init s5p64x0_init_io(struct map_desc *mach_desc, int size)
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 	samsung_wdt_reset_init(S3C_VA_WATCHDOG);
 
+	samsung_pwm_set_platdata(&s5p64x0_pwm_variant);
 }
 
 void __init s5p6440_map_io(void)
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index 4bdfecf..e0600af 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/serial_core.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/reboot.h>
@@ -46,6 +47,7 @@
 #include <plat/fb-core.h>
 #include <plat/iic-core.h>
 #include <plat/onenand-core.h>
+#include <plat/pwm-core.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
 #include <plat/watchdog-reset.h>
@@ -132,6 +134,13 @@ static struct map_desc s5pc100_iodesc[] __initdata = {
 	}
 };
 
+static struct samsung_pwm_variant s5pc100_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 5),
+};
+
 /*
  * s5pc100_map_io
  *
@@ -149,6 +158,8 @@ void __init s5pc100_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P_VA_CHIPID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_pwm_set_platdata(&s5pc100_pwm_variant);
 }
 
 void __init s5pc100_map_io(void)
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 023f1a7..306b29a 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/device.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
@@ -42,6 +43,7 @@
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
 #include <plat/keypad-core.h>
+#include <plat/pwm-core.h>
 #include <plat/tv-core.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
@@ -148,6 +150,13 @@ void s5pv210_restart(enum reboot_mode mode, const char *cmd)
 	__raw_writel(0x1, S5P_SWRESET);
 }
 
+static struct samsung_pwm_variant s5pv210_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 5),
+};
+
 /*
  * s5pv210_map_io
  *
@@ -165,6 +174,8 @@ void __init s5pv210_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P_VA_CHIPID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_pwm_set_platdata(&s5pv210_pwm_variant);
 }
 
 void __init s5pv210_map_io(void)
-- 
1.8.3.2
