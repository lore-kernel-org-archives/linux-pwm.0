Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v4 17/20] ARM: SAMSUNG: Remove old PWM timer platform devices
Date: Sat, 20 Jul 2013 02:04:30 +0200
Message-Id: <1374278673-25615-19-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

This patch removes old Samsung PWM timer platform devices that are not
used any more.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/devs.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 290f63a..8ce0ac0 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1098,24 +1098,6 @@ arch_initcall(s5p_pmu_init);
 /* PWM Timer */
 
 #ifdef CONFIG_SAMSUNG_DEV_PWM
-
-#define DEFINE_S3C_TIMER(_tmr_no)			\
-	.name		= "s3c24xx-pwm",		\
-	.id		= _tmr_no,			\
-
-/*
- * since we already have an static mapping for the timer,
- * we do not bother setting any IO resource for the base.
- */
-
-struct platform_device s3c_device_timer[] = {
-	[0] = { DEFINE_S3C_TIMER(0) },
-	[1] = { DEFINE_S3C_TIMER(1) },
-	[2] = { DEFINE_S3C_TIMER(2) },
-	[3] = { DEFINE_S3C_TIMER(3) },
-	[4] = { DEFINE_S3C_TIMER(4) },
-};
-
 static struct resource samsung_pwm_resource[] = {
 	DEFINE_RES_MEM(SAMSUNG_PA_TIMER, SZ_4K),
 };
-- 
1.8.3.2
