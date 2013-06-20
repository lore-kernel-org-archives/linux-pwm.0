Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 09/18] ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
Date: Fri, 21 Jun 2013 00:12:54 +0200
Message-Id: <1371766383-29077-10-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

From: Tomasz Figa <t.figa@samsung.com>

As the need for an IRQ chip handling PWM timer interrupt chaining is
gone now, this patch removes all the code made unnecessary.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig                                   |  1 -
 arch/arm/mach-s3c64xx/common.c                     |  4 -
 arch/arm/mach-s3c64xx/include/mach/irqs.h          |  8 --
 arch/arm/mach-s5p64x0/include/mach/irqs.h          |  2 -
 arch/arm/mach-s5pc100/include/mach/irqs.h          |  2 -
 arch/arm/mach-s5pv210/include/mach/irqs.h          |  2 -
 arch/arm/plat-samsung/Kconfig                      |  6 --
 arch/arm/plat-samsung/Makefile                     |  1 -
 arch/arm/plat-samsung/devs.c                       | 25 ++----
 arch/arm/plat-samsung/include/plat/irq-vic-timer.h | 13 ---
 arch/arm/plat-samsung/include/plat/irqs.h          |  9 --
 arch/arm/plat-samsung/irq-vic-timer.c              | 98 ----------------------
 arch/arm/plat-samsung/s5p-irq.c                    |  3 -
 13 files changed, 6 insertions(+), 168 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
 delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ddf2667..b5fdce1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -732,7 +732,6 @@ config ARCH_S3C64XX
 	select SAMSUNG_ATAGS
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_GPIOLIB_4BIT
-	select SAMSUNG_IRQ_VIC_TIMER
 	select SAMSUNG_WDT_RESET
 	select USB_ARCH_HAS_OHCI
 	help
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 91df45a..0b33683 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -42,7 +42,6 @@
 #include <plat/pm.h>
 #include <plat/gpio-cfg.h>
 #include <plat/irq-uart.h>
-#include <plat/irq-vic-timer.h>
 #include <plat/pwm-core.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
@@ -222,9 +221,6 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 	/* initialise the pair of VICs */
 	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
 	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
-
-	/* add the timer sub-irqs */
-	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
 }
 
 #define eint_offset(irq)	((irq) - IRQ_EINT(0))
diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
index 96d60e0..67bbd1d 100644
--- a/arch/arm/mach-s3c64xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c64xx/include/mach/irqs.h
@@ -107,14 +107,6 @@
 #define IRQ_TC			IRQ_PENDN
 #define IRQ_ADC			S3C64XX_IRQ_VIC1(31)
 
-#define S3C64XX_TIMER_IRQ(x)	S3C_IRQ(64 + (x))
-
-#define IRQ_TIMER0		S3C64XX_TIMER_IRQ(0)
-#define IRQ_TIMER1		S3C64XX_TIMER_IRQ(1)
-#define IRQ_TIMER2		S3C64XX_TIMER_IRQ(2)
-#define IRQ_TIMER3		S3C64XX_TIMER_IRQ(3)
-#define IRQ_TIMER4		S3C64XX_TIMER_IRQ(4)
-
 /* compatibility for device defines */
 
 #define IRQ_IIC1		IRQ_S3C6410_IIC1
diff --git a/arch/arm/mach-s5p64x0/include/mach/irqs.h b/arch/arm/mach-s5p64x0/include/mach/irqs.h
index 5b845e8..53982db 100644
--- a/arch/arm/mach-s5p64x0/include/mach/irqs.h
+++ b/arch/arm/mach-s5p64x0/include/mach/irqs.h
@@ -141,8 +141,6 @@
 
 #define IRQ_EINT_GROUP(grp, x)	(IRQ_EINT_GROUP##grp##_BASE + (x))
 
-#define IRQ_TIMER_BASE		(11)
-
 /* Set the default NR_IRQS */
 
 #define NR_IRQS			(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR + 1)
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index 2870f12..d2eb475 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -97,8 +97,6 @@
 #define IRQ_SDMFIQ		S5P_IRQ_VIC2(31)
 #define IRQ_VIC_END		S5P_IRQ_VIC2(31)
 
-#define IRQ_TIMER_BASE		(11)
-
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index e777e01..5e0de3a 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -118,8 +118,6 @@
 #define IRQ_MDNIE3		S5P_IRQ_VIC3(8)
 #define IRQ_VIC_END		S5P_IRQ_VIC3(31)
 
-#define IRQ_TIMER_BASE		(11)
-
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 3e880b7..b21d9d5 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -25,7 +25,6 @@ config PLAT_S5P
 	select S5P_GPIO_DRVSTR
 	select SAMSUNG_CLKSRC if !COMMON_CLK
 	select SAMSUNG_GPIOLIB_4BIT
-	select SAMSUNG_IRQ_VIC_TIMER
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
@@ -91,11 +90,6 @@ config S5P_CLOCK
 
 # options for IRQ support
 
-config SAMSUNG_IRQ_VIC_TIMER
-       bool
-       help
-         Internal configuration to build the VIC timer interrupt code.
-
 config S5P_IRQ
 	def_bool (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index cf41bf9..aafbe56 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_SAMSUNG_CLOCK)	+= pwm-clock.o
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 obj-$(CONFIG_S5P_CLOCK)		+= s5p-clock.o
 
-obj-$(CONFIG_SAMSUNG_IRQ_VIC_TIMER) += irq-vic-timer.o
 obj-$(CONFIG_S5P_IRQ)		+= s5p-irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= s5p-irq-eint.o
 obj-$(CONFIG_S5P_GPIO_INT)	+= s5p-irq-gpioint.o
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index bba6d78..290f63a 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1099,22 +1099,9 @@ arch_initcall(s5p_pmu_init);
 
 #ifdef CONFIG_SAMSUNG_DEV_PWM
 
-#define TIMER_RESOURCE_SIZE (1)
-
-#define TIMER_RESOURCE(_tmr, _irq)			\
-	(struct resource [TIMER_RESOURCE_SIZE]) {	\
-		[0] = {					\
-			.start	= _irq,			\
-			.end	= _irq,			\
-			.flags	= IORESOURCE_IRQ	\
-		}					\
-	}
-
-#define DEFINE_S3C_TIMER(_tmr_no, _irq)			\
+#define DEFINE_S3C_TIMER(_tmr_no)			\
 	.name		= "s3c24xx-pwm",		\
 	.id		= _tmr_no,			\
-	.num_resources	= TIMER_RESOURCE_SIZE,		\
-	.resource	= TIMER_RESOURCE(_tmr_no, _irq),	\
 
 /*
  * since we already have an static mapping for the timer,
@@ -1122,11 +1109,11 @@ arch_initcall(s5p_pmu_init);
  */
 
 struct platform_device s3c_device_timer[] = {
-	[0] = { DEFINE_S3C_TIMER(0, IRQ_TIMER0) },
-	[1] = { DEFINE_S3C_TIMER(1, IRQ_TIMER1) },
-	[2] = { DEFINE_S3C_TIMER(2, IRQ_TIMER2) },
-	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3) },
-	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
+	[0] = { DEFINE_S3C_TIMER(0) },
+	[1] = { DEFINE_S3C_TIMER(1) },
+	[2] = { DEFINE_S3C_TIMER(2) },
+	[3] = { DEFINE_S3C_TIMER(3) },
+	[4] = { DEFINE_S3C_TIMER(4) },
 };
 
 static struct resource samsung_pwm_resource[] = {
diff --git a/arch/arm/plat-samsung/include/plat/irq-vic-timer.h b/arch/arm/plat-samsung/include/plat/irq-vic-timer.h
deleted file mode 100644
index 5b9c42f..0000000
--- a/arch/arm/plat-samsung/include/plat/irq-vic-timer.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* arch/arm/plat-samsung/include/plat/irq-vic-timer.h
- *
- * Copyright (c) 2010 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for Samsung SoC IRQ VIC timer
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-extern void s3c_init_vic_timer_irq(unsigned int num, unsigned int timer_irq);
diff --git a/arch/arm/plat-samsung/include/plat/irqs.h b/arch/arm/plat-samsung/include/plat/irqs.h
index df46b77..039001c 100644
--- a/arch/arm/plat-samsung/include/plat/irqs.h
+++ b/arch/arm/plat-samsung/include/plat/irqs.h
@@ -44,15 +44,6 @@
 #define S5P_IRQ_VIC2(x)		(S5P_VIC2_BASE + (x))
 #define S5P_IRQ_VIC3(x)		(S5P_VIC3_BASE + (x))
 
-#define S5P_TIMER_IRQ(x)	(IRQ_TIMER_BASE + (x))
-
-#define IRQ_TIMER0		S5P_TIMER_IRQ(0)
-#define IRQ_TIMER1		S5P_TIMER_IRQ(1)
-#define IRQ_TIMER2		S5P_TIMER_IRQ(2)
-#define IRQ_TIMER3		S5P_TIMER_IRQ(3)
-#define IRQ_TIMER4		S5P_TIMER_IRQ(4)
-#define IRQ_TIMER_COUNT		(5)
-
 #define IRQ_EINT(x)		((x) < 16 ? ((x) + S5P_EINT_BASE1) \
 					: ((x) - 16 + S5P_EINT_BASE2))
 
diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
deleted file mode 100644
index 0fceb42..0000000
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ /dev/null
@@ -1,98 +0,0 @@
-/* arch/arm/plat-samsung/irq-vic-timer.c
- *	originally part of arch/arm/plat-s3c64xx/irq.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C64XX - Interrupt handling
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/io.h>
-
-#include <mach/map.h>
-#include <mach/irqs.h>
-#include <plat/cpu.h>
-#include <plat/irq-vic-timer.h>
-#include <plat/regs-timer.h>
-
-static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_get_chip(irq);
-	chained_irq_enter(chip, desc);
-	generic_handle_irq((int)desc->irq_data.handler_data);
-	chained_irq_exit(chip, desc);
-}
-
-/* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
-static void s3c_irq_timer_ack(struct irq_data *d)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	u32 mask = (1 << 5) << (d->irq - gc->irq_base);
-
-	irq_reg_writel(mask | gc->mask_cache, gc->reg_base);
-}
-
-/**
- * s3c_init_vic_timer_irq() - initialise timer irq chanined off VIC.\
- * @num: Number of timers to initialize
- * @timer_irq: Base IRQ number to be used for the timers.
- *
- * Register the necessary IRQ chaining and support for the timer IRQs
- * chained of the VIC.
- */
-void __init s3c_init_vic_timer_irq(unsigned int num, unsigned int timer_irq)
-{
-	unsigned int pirq[5] = { IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
-				 IRQ_TIMER3_VIC, IRQ_TIMER4_VIC };
-	struct irq_chip_generic *s3c_tgc;
-	struct irq_chip_type *ct;
-	unsigned int i;
-
-#ifdef CONFIG_ARCH_EXYNOS
-	if (soc_is_exynos5250()) {
-		pirq[0] = EXYNOS5_IRQ_TIMER0_VIC;
-		pirq[1] = EXYNOS5_IRQ_TIMER1_VIC;
-		pirq[2] = EXYNOS5_IRQ_TIMER2_VIC;
-		pirq[3] = EXYNOS5_IRQ_TIMER3_VIC;
-		pirq[4] = EXYNOS5_IRQ_TIMER4_VIC;
-	} else {
-		pirq[0] = EXYNOS4_IRQ_TIMER0_VIC;
-		pirq[1] = EXYNOS4_IRQ_TIMER1_VIC;
-		pirq[2] = EXYNOS4_IRQ_TIMER2_VIC;
-		pirq[3] = EXYNOS4_IRQ_TIMER3_VIC;
-		pirq[4] = EXYNOS4_IRQ_TIMER4_VIC;
-	}
-#endif
-	s3c_tgc = irq_alloc_generic_chip("s3c-timer", 1, timer_irq,
-					 S3C64XX_TINT_CSTAT, handle_level_irq);
-
-	if (!s3c_tgc) {
-		pr_err("%s: irq_alloc_generic_chip for IRQ %d failed\n",
-		       __func__, timer_irq);
-		return;
-	}
-
-	ct = s3c_tgc->chip_types;
-	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-	ct->chip.irq_unmask = irq_gc_mask_set_bit;
-	ct->chip.irq_ack = s3c_irq_timer_ack;
-	irq_setup_generic_chip(s3c_tgc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
-			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
-	/* Clear the upper bits of the mask_cache*/
-	s3c_tgc->mask_cache &= 0x1f;
-
-	for (i = 0; i < num; i++, timer_irq++) {
-		irq_set_chained_handler(pirq[i], s3c_irq_demux_vic_timer);
-		irq_set_handler_data(pirq[i], (void *)timer_irq);
-	}
-}
diff --git a/arch/arm/plat-samsung/s5p-irq.c b/arch/arm/plat-samsung/s5p-irq.c
index ff1a760..6729cb2 100644
--- a/arch/arm/plat-samsung/s5p-irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -19,7 +19,6 @@
 #include <mach/map.h>
 #include <plat/regs-timer.h>
 #include <plat/cpu.h>
-#include <plat/irq-vic-timer.h>
 
 void __init s5p_init_irq(u32 *vic, u32 num_vic)
 {
@@ -30,6 +29,4 @@ void __init s5p_init_irq(u32 *vic, u32 num_vic)
 	for (irq = 0; irq < num_vic; irq++)
 		vic_init(VA_VIC(irq), VIC_BASE(irq), vic[irq], 0);
 #endif
-
-	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
 }
-- 
1.8.2.1
