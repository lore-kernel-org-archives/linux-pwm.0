Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 01/15] ARM: SAMSUNG: Unify base address definitions of timer block
Date: Wed,  5 Jun 2013 23:18:06 +0200
Message-Id: <1370467100-10820-2-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

From: Tomasz Figa <t.figa@samsung.com>

This patch makes all defintions of timer block base address use the same
prefix to allow using the common name to define platform device
resource.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/include/mach/map.h  | 1 +
 arch/arm/mach-s3c24xx/include/mach/map.h | 2 ++
 arch/arm/mach-s3c64xx/include/mach/map.h | 1 +
 arch/arm/mach-s5p64x0/include/mach/map.h | 1 +
 arch/arm/mach-s5pc100/include/mach/map.h | 1 +
 arch/arm/mach-s5pv210/include/mach/map.h | 1 +
 6 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 92b29bb..5135dce 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -271,6 +271,7 @@
 #define SAMSUNG_PA_ADC			EXYNOS4_PA_ADC
 #define SAMSUNG_PA_ADC1			EXYNOS4_PA_ADC1
 #define SAMSUNG_PA_KEYPAD		EXYNOS4_PA_KEYPAD
+#define SAMSUNG_PA_TIMER		EXYNOS4_PA_TIMER
 
 /* Compatibility UART */
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/map.h b/arch/arm/mach-s3c24xx/include/mach/map.h
index 8ba381f..444793f 100644
--- a/arch/arm/mach-s3c24xx/include/mach/map.h
+++ b/arch/arm/mach-s3c24xx/include/mach/map.h
@@ -167,4 +167,6 @@
 #define S3C_PA_SPI0		S3C2443_PA_SPI0
 #define S3C_PA_SPI1		S3C2443_PA_SPI1
 
+#define SAMSUNG_PA_TIMER	S3C2410_PA_TIMER
+
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index 8e2097b..f55ccb1 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -121,5 +121,6 @@
 #define SAMSUNG_PA_ADC		S3C64XX_PA_ADC
 #define SAMSUNG_PA_CFCON	S3C64XX_PA_CFCON
 #define SAMSUNG_PA_KEYPAD	S3C64XX_PA_KEYPAD
+#define SAMSUNG_PA_TIMER	S3C64XX_PA_TIMER
 
 #endif /* __ASM_ARCH_6400_MAP_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-s5p64x0/include/mach/map.h
index 0c0175d..50a6e96 100644
--- a/arch/arm/mach-s5p64x0/include/mach/map.h
+++ b/arch/arm/mach-s5p64x0/include/mach/map.h
@@ -76,6 +76,7 @@
 #define S5P_PA_TIMER		S5P64X0_PA_TIMER
 
 #define SAMSUNG_PA_ADC		S5P64X0_PA_ADC
+#define SAMSUNG_PA_TIMER	S5P64X0_PA_TIMER
 
 /* UART */
 
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index 54bc4f8..2550b61 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -116,6 +116,7 @@
 #define SAMSUNG_PA_ADC			S5PC100_PA_TSADC
 #define SAMSUNG_PA_CFCON		S5PC100_PA_CFCON
 #define SAMSUNG_PA_KEYPAD		S5PC100_PA_KEYPAD
+#define SAMSUNG_PA_TIMER		S5PC100_PA_TIMER
 
 #define S5PC100_VA_OTHERS		(S3C_VA_SYS + 0x10000)
 
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index b7c8a19..763929a 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -139,6 +139,7 @@
 #define SAMSUNG_PA_ADC			S5PV210_PA_ADC
 #define SAMSUNG_PA_CFCON		S5PV210_PA_CFCON
 #define SAMSUNG_PA_KEYPAD		S5PV210_PA_KEYPAD
+#define SAMSUNG_PA_TIMER		S5PV210_PA_TIMER
 
 /* UART */
 
-- 
1.8.2.1
