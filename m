Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 05/15] ARM: SAMSUNG: Remove old samsung-time driver
Date: Wed,  5 Jun 2013 23:18:10 +0200
Message-Id: <1370467100-10820-6-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/Kconfig                     |   8 -
 arch/arm/plat-samsung/Makefile                    |   1 -
 arch/arm/plat-samsung/include/plat/samsung-time.h |  23 --
 arch/arm/plat-samsung/samsung-time.c              | 394 ----------------------
 4 files changed, 426 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/samsung-time.c

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index f8ed2de..e88adc0 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -60,14 +60,6 @@ config S3C_LOWLEVEL_UART_PORT
 	  this configuration should be between zero and two. The port
 	  must have been initialised by the boot-loader before use.
 
-# timer options
-
-config SAMSUNG_HRT
-	bool
-	select SAMSUNG_DEV_PWM
-	help
-	  Use the High Resolution timer support
-
 # clock options
 
 config SAMSUNG_CLOCK
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index a23c460..87494e1 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 # Objects we always build independent of SoC choice
 
 obj-y				+= init.o cpu.o
-obj-$(CONFIG_SAMSUNG_HRT) 	+= samsung-time.o
 
 obj-$(CONFIG_SAMSUNG_CLOCK)	+= clock.o
 obj-$(CONFIG_SAMSUNG_CLOCK)	+= pwm-clock.o
diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
index 4cc99bb..209464a 100644
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ b/arch/arm/plat-samsung/include/plat/samsung-time.h
@@ -22,29 +22,6 @@ enum samsung_timer_mode {
 	SAMSUNG_PWM4,
 };
 
-struct samsung_timer_source {
-	unsigned int event_id;
-	unsigned int source_id;
-};
-
-/* Be able to sleep for atleast 4 seconds (usually more) */
-#define SAMSUNG_TIMER_MIN_RANGE	4
-
-#if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S5PC100)
-#define TCNT_MAX		0xffff
-#define TSCALER_DIV		25
-#define TDIV			50
-#define TSIZE			16
-#else
-#define TCNT_MAX		0xffffffff
-#define TSCALER_DIV		2
-#define TDIV			2
-#define TSIZE			32
-#endif
-
-#define NON_PERIODIC		0
-#define PERIODIC		1
-
 extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
 					enum samsung_timer_mode source);
 
diff --git a/arch/arm/plat-samsung/samsung-time.c b/arch/arm/plat-samsung/samsung-time.c
deleted file mode 100644
index f899cbc..0000000
-- 
1.8.2.1
