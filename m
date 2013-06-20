Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 17/18] ARM: SAMSUNG: Remove remaining uses of plat/regs-timer.h header
Date: Fri, 21 Jun 2013 00:13:02 +0200
Message-Id: <1371766383-29077-18-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

This patch removes remaining inclusions of plat/regs-timer.h as
a preparation to remove the header.

As a part of this, things like save and restore of PWM registers are
removed from SoC-specific code, because it is handled in appropriate
drivers now.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/irq-pm.c  |  2 --
 arch/arm/mach-s5p64x0/pm.c      |  3 ---
 arch/arm/mach-s5pv210/pm.c      | 10 ----------
 arch/arm/plat-samsung/s5p-irq.c |  1 -
 4 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/irq-pm.c b/arch/arm/mach-s3c64xx/irq-pm.c
index 0c7e1d9..c3da1b6 100644
--- a/arch/arm/mach-s3c64xx/irq-pm.c
+++ b/arch/arm/mach-s3c64xx/irq-pm.c
@@ -22,7 +22,6 @@
 #include <mach/map.h>
 
 #include <plat/regs-serial.h>
-#include <plat/regs-timer.h>
 #include <mach/regs-gpio.h>
 #include <plat/cpu.h>
 #include <plat/pm.h>
@@ -43,7 +42,6 @@ static struct sleep_save irq_save[] = {
 	SAVE_ITEM(S3C64XX_EINT0FLTCON2),
 	SAVE_ITEM(S3C64XX_EINT0FLTCON3),
 	SAVE_ITEM(S3C64XX_EINT0MASK),
-	SAVE_ITEM(S3C64XX_TINT_CSTAT),
 };
 
 static struct irq_grp_save {
diff --git a/arch/arm/mach-s5p64x0/pm.c b/arch/arm/mach-s5p64x0/pm.c
index 97c2a08a..861e15c 100644
--- a/arch/arm/mach-s5p64x0/pm.c
+++ b/arch/arm/mach-s5p64x0/pm.c
@@ -18,7 +18,6 @@
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
-#include <plat/regs-timer.h>
 #include <plat/wakeup-mask.h>
 
 #include <mach/regs-clock.h>
@@ -48,8 +47,6 @@ static struct sleep_save s5p64x0_misc_save[] = {
 	SAVE_ITEM(S5P64X0_MEM0CONSLP1),
 	SAVE_ITEM(S5P64X0_MEM0DRVCON),
 	SAVE_ITEM(S5P64X0_MEM1DRVCON),
-
-	SAVE_ITEM(S3C64XX_TINT_CSTAT),
 };
 
 /* DPLL is present only in S5P6450 */
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 2b68a67..3cf3f9c 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -21,7 +21,6 @@
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
-#include <plat/regs-timer.h>
 
 #include <mach/regs-irq.h>
 #include <mach/regs-clock.h>
@@ -77,15 +76,6 @@ static struct sleep_save s5pv210_core_save[] = {
 	/* Clock ETC */
 	SAVE_ITEM(S5P_CLK_OUT),
 	SAVE_ITEM(S5P_MDNIE_SEL),
-
-	/* PWM Register */
-	SAVE_ITEM(S3C2410_TCFG0),
-	SAVE_ITEM(S3C2410_TCFG1),
-	SAVE_ITEM(S3C64XX_TINT_CSTAT),
-	SAVE_ITEM(S3C2410_TCON),
-	SAVE_ITEM(S3C2410_TCNTB(0)),
-	SAVE_ITEM(S3C2410_TCMPB(0)),
-	SAVE_ITEM(S3C2410_TCNTO(0)),
 };
 
 static int s5pv210_cpu_suspend(unsigned long arg)
diff --git a/arch/arm/plat-samsung/s5p-irq.c b/arch/arm/plat-samsung/s5p-irq.c
index 6729cb2..ddfaca9 100644
--- a/arch/arm/plat-samsung/s5p-irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -17,7 +17,6 @@
 
 #include <mach/irqs.h>
 #include <mach/map.h>
-#include <plat/regs-timer.h>
 #include <plat/cpu.h>
 
 void __init s5p_init_irq(u32 *vic, u32 num_vic)
-- 
1.8.2.1
