Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v4 04/20] clocksource: samsung_pwm_timer: Do not use clocksource_mmio
Date: Sat, 20 Jul 2013 02:04:17 +0200
Message-Id: <1374278673-25615-6-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

In case of Samsung PWM timer, clocksource MMIO can not be used, because
custom suspend/resume callbacks are required.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clocksource/Kconfig             |  1 -
 drivers/clocksource/samsung_pwm_timer.c | 19 +++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b7b9b04..41c6946 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -99,7 +99,6 @@ config CLKSRC_EXYNOS_MCT
 
 config CLKSRC_SAMSUNG_PWM
 	bool
-	select CLKSRC_MMIO
 	help
 	  This is a new clocksource driver for the PWM timer found in
 	  Samsung S3C, S5P and Exynos SoCs, replacing an earlier driver
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 823279b..753ffec 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -288,6 +288,18 @@ static void __init samsung_clockevent_init(void)
 	}
 }
 
+static cycle_t samsung_clocksource_read(struct clocksource *c)
+{
+	return ~readl_relaxed(pwm.source_reg);
+}
+
+static struct clocksource samsung_clocksource = {
+	.name		= "samsung_clocksource_timer",
+	.rating		= 250,
+	.read		= samsung_clocksource_read,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -297,7 +309,7 @@ static void __init samsung_clockevent_init(void)
  */
 static u32 notrace samsung_read_sched_clock(void)
 {
-	return ~__raw_readl(pwm.source_reg);
+	return samsung_clocksource_read(NULL);
 }
 
 static void __init samsung_clocksource_init(void)
@@ -324,9 +336,8 @@ static void __init samsung_clocksource_init(void)
 	setup_sched_clock(samsung_read_sched_clock,
 						pwm.variant.bits, clock_rate);
 
-	ret = clocksource_mmio_init(pwm.source_reg, "samsung_clocksource_timer",
-					clock_rate, 250, pwm.variant.bits,
-					clocksource_mmio_readl_down);
+	samsung_clocksource.mask = CLOCKSOURCE_MASK(pwm.variant.bits);
+	ret = clocksource_register_hz(&samsung_clocksource, clock_rate);
 	if (ret)
 		panic("samsung_clocksource_timer: can't register clocksource\n");
 }
-- 
1.8.3.2
