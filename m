Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 16/18] ARM: SAMSUNG: Remove pwm-clock infrastructure
Date: Fri, 21 Jun 2013 00:13:01 +0200
Message-Id: <1371766383-29077-17-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

Since all the used PWM prescalers and dividers configuration has been
moved to appropriate drivers, the pwm-clock infrastructure is now
unused and so this patch removes it.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c24xx/clock-s3c2410.c          |   1 -
 arch/arm/mach-s3c24xx/clock-s3c2412.c          |   1 -
 arch/arm/mach-s3c24xx/clock-s3c2416.c          |   2 -
 arch/arm/mach-s3c24xx/clock-s3c2443.c          |   2 -
 arch/arm/mach-s3c64xx/clock.c                  |   2 -
 arch/arm/mach-s5p64x0/clock-s5p6440.c          |   2 -
 arch/arm/mach-s5p64x0/clock-s5p6450.c          |   2 -
 arch/arm/mach-s5pc100/clock.c                  |   2 -
 arch/arm/mach-s5pv210/clock.c                  |   1 -
 arch/arm/plat-samsung/Makefile                 |   1 -
 arch/arm/plat-samsung/include/plat/clock.h     |   4 -
 arch/arm/plat-samsung/include/plat/pwm-clock.h |  81 -----
 arch/arm/plat-samsung/pwm-clock.c              | 474 -------------------------
 13 files changed, 575 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/pwm-clock.h
 delete mode 100644 arch/arm/plat-samsung/pwm-clock.c

diff --git a/arch/arm/mach-s3c24xx/clock-s3c2410.c b/arch/arm/mach-s3c24xx/clock-s3c2410.c
index 34fffdf..afa0267 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2410.c
@@ -246,6 +246,5 @@ int __init s3c2410_baseclk_add(void)
 	       (clkslow & S3C2410_CLKSLOW_MPLL_OFF) ? "off" : "on",
 	       (clkslow & S3C2410_CLKSLOW_UCLK_OFF) ? "off" : "on");
 
-	s3c_pwmclk_init();
 	return 0;
 }
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2412.c b/arch/arm/mach-s3c24xx/clock-s3c2412.c
index 2cc017d..d8f253f 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2412.c
@@ -757,6 +757,5 @@ int __init s3c2412_baseclk_add(void)
 	}
 
 	clkdev_add_table(s3c2412_clk_lookup, ARRAY_SIZE(s3c2412_clk_lookup));
-	s3c_pwmclk_init();
 	return 0;
 }
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-s3c24xx/clock-s3c2416.c
index 036056ce..d421a72 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2416.c
@@ -168,6 +168,4 @@ void __init s3c2416_init_clocks(int xtal)
 	s3c24xx_register_clock(&hsmmc0_clk);
 	clkdev_add_table(s3c2416_clk_lookup, ARRAY_SIZE(s3c2416_clk_lookup));
 
-	s3c_pwmclk_init();
-
 }
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
index 0a53051..76cd31f 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2443.c
@@ -209,6 +209,4 @@ void __init s3c2443_init_clocks(int xtal)
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	clkdev_add_table(s3c2443_clk_lookup, ARRAY_SIZE(s3c2443_clk_lookup));
-
-	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 8499415..c1bcc4a 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -1004,6 +1004,4 @@ void __init s3c64xx_register_clocks(unsigned long xtal,
 	for (cnt = 0; cnt < ARRAY_SIZE(clksrc_cdev); cnt++)
 		s3c_register_clksrc(clksrc_cdev[cnt], 1);
 	clkdev_add_table(s3c64xx_clk_lookup, ARRAY_SIZE(s3c64xx_clk_lookup));
-
-	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index 35378152..ae34a1d 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -629,6 +629,4 @@ void __init s5p6440_register_clocks(void)
 	clkdev_add_table(s5p6440_clk_lookup, ARRAY_SIZE(s5p6440_clk_lookup));
 
 	s3c24xx_register_clock(&dummy_apb_pclk);
-
-	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index af384dd..0b3ca2e 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -698,6 +698,4 @@ void __init s5p6450_register_clocks(void)
 	clkdev_add_table(s5p6450_clk_lookup, ARRAY_SIZE(s5p6450_clk_lookup));
 
 	s3c24xx_register_clock(&dummy_apb_pclk);
-
-	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index a206dc3..d0dc10e 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -1358,6 +1358,4 @@ void __init s5pc100_register_clocks(void)
 		s3c_disable_clocks(clk_cdev[ptr], 1);
 
 	s3c24xx_register_clock(&dummy_apb_pclk);
-
-	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index f051f53..ca46372 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -1362,5 +1362,4 @@ void __init s5pv210_register_clocks(void)
 	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
 		s3c_disable_clocks(clk_cdev[ptr], 1);
 
-	s3c_pwmclk_init();
 }
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index aafbe56..5d7f839 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -14,7 +14,6 @@ obj-				:=
 obj-y				+= init.o cpu.o
 
 obj-$(CONFIG_SAMSUNG_CLOCK)	+= clock.o
-obj-$(CONFIG_SAMSUNG_CLOCK)	+= pwm-clock.o
 
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 obj-$(CONFIG_S5P_CLOCK)		+= s5p-clock.o
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index a62753d..254c3dd 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -140,10 +140,6 @@ extern int s3c2443_clkcon_enable_s(struct clk *clk, int enable);
 
 extern int s3c64xx_sclk_ctrl(struct clk *clk, int enable);
 
-/* Init for pwm clock code */
-
-extern void s3c_pwmclk_init(void);
-
 /* Global watchdog clock used by arch_wtd_reset() callback */
 
 extern struct clk *s3c2410_wdtclk;
diff --git a/arch/arm/plat-samsung/include/plat/pwm-clock.h b/arch/arm/plat-samsung/include/plat/pwm-clock.h
deleted file mode 100644
index bf6a60e..0000000
--- a/arch/arm/plat-samsung/include/plat/pwm-clock.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/pwm-clock.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * SAMSUNG - pwm clock and timer support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_PLAT_PWM_CLOCK_H
-#define __ASM_PLAT_PWM_CLOCK_H __FILE__
-
-/**
- * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @tcfg: The timer TCFG1 register bits shifted down to 0.
- *
- * Return true if the given configuration from TCFG1 is a TCLK instead
- * any of the TDIV clocks.
- */
-static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
-{
-	if (soc_is_s3c24xx())
-		return tcfg == S3C2410_TCFG1_MUX_TCLK;
-	else if (soc_is_s3c64xx() || soc_is_s5pc100())
-		return tcfg >= S3C64XX_TCFG1_MUX_TCLK;
-	else if (soc_is_s5p6440() || soc_is_s5p6450())
-		return 0;
-	else
-		return tcfg == S3C64XX_TCFG1_MUX_TCLK;
-}
-
-/**
- * tcfg_to_divisor() - convert tcfg1 setting to a divisor
- * @tcfg1: The tcfg1 setting, shifted down.
- *
- * Get the divisor value for the given tcfg1 setting. We assume the
- * caller has already checked to see if this is not a TCLK source.
- */
-static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
-{
-	if (soc_is_s3c24xx())
-		return 1 << (tcfg1 + 1);
-	else
-		return 1 << tcfg1;
-}
-
-/**
- * pwm_tdiv_has_div1() - does the tdiv setting have a /1
- *
- * Return true if we have a /1 in the tdiv setting.
- */
-static inline unsigned int pwm_tdiv_has_div1(void)
-{
-	if (soc_is_s3c24xx())
-		return 0;
-	else
-		return 1;
-}
-
-/**
- * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
- * @div: The divisor to calculate the bit information for.
- *
- * Turn a divisor into the necessary bit field for TCFG1.
- */
-static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
-{
-	if (soc_is_s3c24xx())
-		return ilog2(div) - 1;
-	else
-		return ilog2(div);
-}
-#endif /* __ASM_PLAT_PWM_CLOCK_H */
diff --git a/arch/arm/plat-samsung/pwm-clock.c b/arch/arm/plat-samsung/pwm-clock.c
deleted file mode 100644
index a35ff3b..0000000
--- a/arch/arm/plat-samsung/pwm-clock.c
+++ /dev/null
@@ -1,474 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/pwm-clock.c
- *
- * Copyright (c) 2007 Simtec Electronics
- * Copyright (c) 2007, 2008 Ben Dooks
- *	Ben Dooks <ben-linux@fluff.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/log2.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <asm/irq.h>
-
-#include <plat/clock.h>
-#include <plat/cpu.h>
-
-#include <plat/regs-timer.h>
-#include <plat/pwm-clock.h>
-
-/* Each of the timers 0 through 5 go through the following
- * clock tree, with the inputs depending on the timers.
- *
- * pclk ---- [ prescaler 0 ] -+---> timer 0
- *			      +---> timer 1
- *
- * pclk ---- [ prescaler 1 ] -+---> timer 2
- *			      +---> timer 3
- *			      \---> timer 4
- *
- * Which are fed into the timers as so:
- *
- * prescaled 0 ---- [ div 2,4,8,16 ] ---\
- *				       [mux] -> timer 0
- * tclk 0 ------------------------------/
- *
- * prescaled 0 ---- [ div 2,4,8,16 ] ---\
- *				       [mux] -> timer 1
- * tclk 0 ------------------------------/
- *
- *
- * prescaled 1 ---- [ div 2,4,8,16 ] ---\
- *				       [mux] -> timer 2
- * tclk 1 ------------------------------/
- *
- * prescaled 1 ---- [ div 2,4,8,16 ] ---\
- *				       [mux] -> timer 3
- * tclk 1 ------------------------------/
- *
- * prescaled 1 ---- [ div 2,4,8, 16 ] --\
- *				       [mux] -> timer 4
- * tclk 1 ------------------------------/
- *
- * Since the mux and the divider are tied together in the
- * same register space, it is impossible to set the parent
- * and the rate at the same time. To avoid this, we add an
- * intermediate 'prescaled-and-divided' clock to select
- * as the parent for the timer input clock called tdiv.
- *
- * prescaled clk --> pwm-tdiv ---\
- *                             [ mux ] --> timer X
- * tclk -------------------------/
-*/
-
-static struct clk clk_timer_scaler[];
-
-static unsigned long clk_pwm_scaler_get_rate(struct clk *clk)
-{
-	unsigned long tcfg0 = __raw_readl(S3C2410_TCFG0);
-
-	if (clk == &clk_timer_scaler[1]) {
-		tcfg0 &= S3C2410_TCFG_PRESCALER1_MASK;
-		tcfg0 >>= S3C2410_TCFG_PRESCALER1_SHIFT;
-	} else {
-		tcfg0 &= S3C2410_TCFG_PRESCALER0_MASK;
-	}
-
-	return clk_get_rate(clk->parent) / (tcfg0 + 1);
-}
-
-static unsigned long clk_pwm_scaler_round_rate(struct clk *clk,
-					       unsigned long rate)
-{
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	unsigned long divisor = parent_rate / rate;
-
-	if (divisor > 256)
-		divisor = 256;
-	else if (divisor < 2)
-		divisor = 2;
-
-	return parent_rate / divisor;
-}
-
-static int clk_pwm_scaler_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long round = clk_pwm_scaler_round_rate(clk, rate);
-	unsigned long tcfg0;
-	unsigned long divisor;
-	unsigned long flags;
-
-	divisor = clk_get_rate(clk->parent) / round;
-	divisor--;
-
-	local_irq_save(flags);
-	tcfg0 = __raw_readl(S3C2410_TCFG0);
-
-	if (clk == &clk_timer_scaler[1]) {
-		tcfg0 &= ~S3C2410_TCFG_PRESCALER1_MASK;
-		tcfg0 |= divisor << S3C2410_TCFG_PRESCALER1_SHIFT;
-	} else {
-		tcfg0 &= ~S3C2410_TCFG_PRESCALER0_MASK;
-		tcfg0 |= divisor;
-	}
-
-	__raw_writel(tcfg0, S3C2410_TCFG0);
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static struct clk_ops clk_pwm_scaler_ops = {
-	.get_rate	= clk_pwm_scaler_get_rate,
-	.set_rate	= clk_pwm_scaler_set_rate,
-	.round_rate	= clk_pwm_scaler_round_rate,
-};
-
-static struct clk clk_timer_scaler[] = {
-	[0]	= {
-		.name		= "pwm-scaler0",
-		.id		= -1,
-		.ops		= &clk_pwm_scaler_ops,
-	},
-	[1]	= {
-		.name		= "pwm-scaler1",
-		.id		= -1,
-		.ops		= &clk_pwm_scaler_ops,
-	},
-};
-
-static struct clk clk_timer_tclk[] = {
-	[0]	= {
-		.name		= "pwm-tclk0",
-		.id		= -1,
-	},
-	[1]	= {
-		.name		= "pwm-tclk1",
-		.id		= -1,
-	},
-};
-
-struct pwm_tdiv_clk {
-	struct clk	clk;
-	unsigned int	divisor;
-};
-
-static inline struct pwm_tdiv_clk *to_tdiv(struct clk *clk)
-{
-	return container_of(clk, struct pwm_tdiv_clk, clk);
-}
-
-static unsigned long clk_pwm_tdiv_get_rate(struct clk *clk)
-{
-	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
-	unsigned int divisor;
-
-	tcfg1 >>= S3C2410_TCFG1_SHIFT(clk->id);
-	tcfg1 &= S3C2410_TCFG1_MUX_MASK;
-
-	if (pwm_cfg_src_is_tclk(tcfg1))
-		divisor = to_tdiv(clk)->divisor;
-	else
-		divisor = tcfg_to_divisor(tcfg1);
-
-	return clk_get_rate(clk->parent) / divisor;
-}
-
-static unsigned long clk_pwm_tdiv_round_rate(struct clk *clk,
-					     unsigned long rate)
-{
-	unsigned long parent_rate;
-	unsigned long divisor;
-
-	parent_rate = clk_get_rate(clk->parent);
-	divisor = parent_rate / rate;
-
-	if (divisor <= 1 && pwm_tdiv_has_div1())
-		divisor = 1;
-	else if (divisor <= 2)
-		divisor = 2;
-	else if (divisor <= 4)
-		divisor = 4;
-	else if (divisor <= 8)
-		divisor = 8;
-	else
-		divisor = 16;
-
-	return parent_rate / divisor;
-}
-
-static unsigned long clk_pwm_tdiv_bits(struct pwm_tdiv_clk *divclk)
-{
-	return pwm_tdiv_div_bits(divclk->divisor);
-}
-
-static void clk_pwm_tdiv_update(struct pwm_tdiv_clk *divclk)
-{
-	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
-	unsigned long bits = clk_pwm_tdiv_bits(divclk);
-	unsigned long flags;
-	unsigned long shift =  S3C2410_TCFG1_SHIFT(divclk->clk.id);
-
-	local_irq_save(flags);
-
-	tcfg1 = __raw_readl(S3C2410_TCFG1);
-	tcfg1 &= ~(S3C2410_TCFG1_MUX_MASK << shift);
-	tcfg1 |= bits << shift;
-	__raw_writel(tcfg1, S3C2410_TCFG1);
-
-	local_irq_restore(flags);
-}
-
-static int clk_pwm_tdiv_set_rate(struct clk *clk, unsigned long rate)
-{
-	struct pwm_tdiv_clk *divclk = to_tdiv(clk);
-	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	unsigned long divisor;
-
-	tcfg1 >>= S3C2410_TCFG1_SHIFT(clk->id);
-	tcfg1 &= S3C2410_TCFG1_MUX_MASK;
-
-	rate = clk_round_rate(clk, rate);
-	divisor = parent_rate / rate;
-
-	if (divisor > 16)
-		return -EINVAL;
-
-	divclk->divisor = divisor;
-
-	/* Update the current MUX settings if we are currently
-	 * selected as the clock source for this clock. */
-
-	if (!pwm_cfg_src_is_tclk(tcfg1))
-		clk_pwm_tdiv_update(divclk);
-
-	return 0;
-}
-
-static struct clk_ops clk_tdiv_ops = {
-	.get_rate	= clk_pwm_tdiv_get_rate,
-	.set_rate	= clk_pwm_tdiv_set_rate,
-	.round_rate	= clk_pwm_tdiv_round_rate,
-};
-
-static struct pwm_tdiv_clk clk_timer_tdiv[] = {
-	[0]	= {
-		.clk	= {
-			.name	= "pwm-tdiv",
-			.devname	= "s3c24xx-pwm.0",
-			.ops	= &clk_tdiv_ops,
-			.parent	= &clk_timer_scaler[0],
-		},
-	},
-	[1]	= {
-		.clk	= {
-			.name	= "pwm-tdiv",
-			.devname	= "s3c24xx-pwm.1",
-			.ops	= &clk_tdiv_ops,
-			.parent	= &clk_timer_scaler[0],
-		}
-	},
-	[2]	= {
-		.clk	= {
-			.name	= "pwm-tdiv",
-			.devname	= "s3c24xx-pwm.2",
-			.ops	= &clk_tdiv_ops,
-			.parent	= &clk_timer_scaler[1],
-		},
-	},
-	[3]	= {
-		.clk	= {
-			.name	= "pwm-tdiv",
-			.devname	= "s3c24xx-pwm.3",
-			.ops	= &clk_tdiv_ops,
-			.parent	= &clk_timer_scaler[1],
-		},
-	},
-	[4]	= {
-		.clk	= {
-			.name	= "pwm-tdiv",
-			.devname	= "s3c24xx-pwm.4",
-			.ops	= &clk_tdiv_ops,
-			.parent	= &clk_timer_scaler[1],
-		},
-	},
-};
-
-static int __init clk_pwm_tdiv_register(unsigned int id)
-{
-	struct pwm_tdiv_clk *divclk = &clk_timer_tdiv[id];
-	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
-
-	tcfg1 >>= S3C2410_TCFG1_SHIFT(id);
-	tcfg1 &= S3C2410_TCFG1_MUX_MASK;
-
-	divclk->clk.id = id;
-	divclk->divisor = tcfg_to_divisor(tcfg1);
-
-	return s3c24xx_register_clock(&divclk->clk);
-}
-
-static inline struct clk *s3c24xx_pwmclk_tclk(unsigned int id)
-{
-	return (id >= 2) ? &clk_timer_tclk[1] : &clk_timer_tclk[0];
-}
-
-static inline struct clk *s3c24xx_pwmclk_tdiv(unsigned int id)
-{
-	return &clk_timer_tdiv[id].clk;
-}
-
-static int clk_pwm_tin_set_parent(struct clk *clk, struct clk *parent)
-{
-	unsigned int id = clk->id;
-	unsigned long tcfg1;
-	unsigned long flags;
-	unsigned long bits;
-	unsigned long shift = S3C2410_TCFG1_SHIFT(id);
-
-	unsigned long mux_tclk;
-
-	if (soc_is_s3c24xx())
-		mux_tclk = S3C2410_TCFG1_MUX_TCLK;
-	else if (soc_is_s5p6440() || soc_is_s5p6450())
-		mux_tclk = 0;
-	else
-		mux_tclk = S3C64XX_TCFG1_MUX_TCLK;
-
-	if (parent == s3c24xx_pwmclk_tclk(id))
-		bits = mux_tclk << shift;
-	else if (parent == s3c24xx_pwmclk_tdiv(id))
-		bits = clk_pwm_tdiv_bits(to_tdiv(parent)) << shift;
-	else
-		return -EINVAL;
-
-	clk->parent = parent;
-
-	local_irq_save(flags);
-
-	tcfg1 = __raw_readl(S3C2410_TCFG1);
-	tcfg1 &= ~(S3C2410_TCFG1_MUX_MASK << shift);
-	__raw_writel(tcfg1 | bits, S3C2410_TCFG1);
-
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static struct clk_ops clk_tin_ops = {
-	.set_parent	= clk_pwm_tin_set_parent,
-};
-
-static struct clk clk_tin[] = {
-	[0]	= {
-		.name	= "pwm-tin",
-		.devname	= "s3c24xx-pwm.0",
-		.id	= 0,
-		.ops	= &clk_tin_ops,
-	},
-	[1]	= {
-		.name	= "pwm-tin",
-		.devname	= "s3c24xx-pwm.1",
-		.id	= 1,
-		.ops	= &clk_tin_ops,
-	},
-	[2]	= {
-		.name	= "pwm-tin",
-		.devname	= "s3c24xx-pwm.2",
-		.id	= 2,
-		.ops	= &clk_tin_ops,
-	},
-	[3]	= {
-		.name	= "pwm-tin",
-		.devname	= "s3c24xx-pwm.3",
-		.id	= 3,
-		.ops	= &clk_tin_ops,
-	},
-	[4]	= {
-		.name	= "pwm-tin",
-		.devname	= "s3c24xx-pwm.4",
-		.id	= 4,
-		.ops	= &clk_tin_ops,
-	},
-};
-
-static __init int clk_pwm_tin_register(struct clk *pwm)
-{
-	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
-	unsigned int id = pwm->id;
-
-	struct clk *parent;
-	int ret;
-
-	ret = s3c24xx_register_clock(pwm);
-	if (ret < 0)
-		return ret;
-
-	tcfg1 >>= S3C2410_TCFG1_SHIFT(id);
-	tcfg1 &= S3C2410_TCFG1_MUX_MASK;
-
-	if (pwm_cfg_src_is_tclk(tcfg1))
-		parent = s3c24xx_pwmclk_tclk(id);
-	else
-		parent = s3c24xx_pwmclk_tdiv(id);
-
-	return clk_set_parent(pwm, parent);
-}
-
-/**
- * s3c_pwmclk_init() - initialise pwm clocks
- *
- * Initialise and register the clocks which provide the inputs for the
- * pwm timer blocks.
- *
- * Note, this call is required by the time core, so must be called after
- * the base clocks are added and before any of the initcalls are run.
- */
-__init void s3c_pwmclk_init(void)
-{
-	struct clk *clk_timers;
-	unsigned int clk;
-	int ret;
-
-	clk_timers = clk_get(NULL, "timers");
-	if (IS_ERR(clk_timers)) {
-		printk(KERN_ERR "%s: no parent clock\n", __func__);
-		return;
-	}
-
-	for (clk = 0; clk < ARRAY_SIZE(clk_timer_scaler); clk++)
-		clk_timer_scaler[clk].parent = clk_timers;
-
-	s3c_register_clocks(clk_timer_scaler, ARRAY_SIZE(clk_timer_scaler));
-	s3c_register_clocks(clk_timer_tclk, ARRAY_SIZE(clk_timer_tclk));
-
-	for (clk = 0; clk < ARRAY_SIZE(clk_timer_tdiv); clk++) {
-		ret = clk_pwm_tdiv_register(clk);
-
-		if (ret < 0) {
-			printk(KERN_ERR "error adding pwm%d tdiv clock\n", clk);
-			return;
-		}
-	}
-
-	for (clk = 0; clk < ARRAY_SIZE(clk_tin); clk++) {
-		ret = clk_pwm_tin_register(&clk_tin[clk]);
-		if (ret < 0) {
-			printk(KERN_ERR "error adding pwm%d tin clock\n", clk);
-			return;
-		}
-	}
-}
-- 
1.8.2.1
