Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 02/18] ARM: SAMSUNG: Add new PWM platform device
Date: Fri, 21 Jun 2013 00:12:47 +0200
Message-Id: <1371766383-29077-3-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

This patch adds new samsung_device_pwm platform device that represents
the whole PWM/timer block and includes memory and IRQ resources.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/devs.c                  | 17 +++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h     |  1 +
 arch/arm/plat-samsung/include/plat/pwm-core.h | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 arch/arm/plat-samsung/include/plat/pwm-core.h

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 0f9c3f4..bba6d78 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -58,6 +58,7 @@
 #include <plat/keypad.h>
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
+#include <plat/pwm-core.h>
 #include <plat/sdhci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
@@ -1127,6 +1128,22 @@ struct platform_device s3c_device_timer[] = {
 	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3) },
 	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
 };
+
+static struct resource samsung_pwm_resource[] = {
+	DEFINE_RES_MEM(SAMSUNG_PA_TIMER, SZ_4K),
+};
+
+struct platform_device samsung_device_pwm = {
+	.name		= "samsung-pwm",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(samsung_pwm_resource),
+	.resource	= samsung_pwm_resource,
+};
+
+void __init samsung_pwm_set_platdata(struct samsung_pwm_variant *pd)
+{
+	samsung_device_pwm.dev.platform_data = pd;
+}
 #endif /* CONFIG_SAMSUNG_DEV_PWM */
 
 /* RTC */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 87d501f..0dc4ac4 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -134,6 +134,7 @@ extern struct platform_device exynos4_device_spdif;
 
 extern struct platform_device samsung_asoc_idma;
 extern struct platform_device samsung_device_keypad;
+extern struct platform_device samsung_device_pwm;
 
 /* s3c2440 specific devices */
 
diff --git a/arch/arm/plat-samsung/include/plat/pwm-core.h b/arch/arm/plat-samsung/include/plat/pwm-core.h
new file mode 100644
index 0000000..df50f5c
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/pwm-core.h
@@ -0,0 +1,24 @@
+/*
+ * linux/arch/arm/plat-samsung/onenand-core.h
+ *
+ *  Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Samsung PWM Controller core functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_PWM_CORE_H
+#define __ASM_ARCH_PWM_CORE_H __FILE__
+
+#include <clocksource/samsung_pwm.h>
+
+#ifdef CONFIG_SAMSUNG_DEV_PWM
+extern void samsung_pwm_set_platdata(struct samsung_pwm_variant *pd);
+#else
+static inline void samsung_pwm_set_platdata(struct samsung_pwm_variant *pd) { }
+#endif
+
+#endif /* __ASM_ARCH_PWM_CORE_H */
-- 
1.8.2.1
