Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 13/15] ARM: SAMSUNG: Remove pwm-clock infrastructure
Date: Wed,  5 Jun 2013 23:18:18 +0200
Message-Id: <1370467100-10820-14-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>

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
index ae2a0fd..be0a4e8 100644
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
diff --git a/arch/arm/plat-samsung/pwm-clock.c b/arch/arm/plat-samsung/pwm-clock.c
deleted file mode 100644
index a35ff3b..0000000
-- 
1.8.2.1
