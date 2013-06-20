Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 04/18] clocksource: samsung_pwm_timer: Cache clocksource register address
Date: Fri, 21 Jun 2013 00:12:49 +0200
Message-Id: <1371766383-29077-5-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

Instead of calculating register every time the timer should be read,
we can just do it one time at initialization and store the address in
driver data.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 553115b..d361b5e 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -54,6 +54,7 @@ EXPORT_SYMBOL(samsung_pwm_lock);
 
 struct samsung_pwm_clocksource {
 	void __iomem *base;
+	void __iomem *source_reg;
 	unsigned int irq[SAMSUNG_PWM_NUM];
 	struct samsung_pwm_variant variant;
 
@@ -286,23 +287,6 @@ static void __init samsung_clockevent_init(void)
 	}
 }
 
-static void __iomem *samsung_timer_reg(void)
-{
-	switch (pwm.source_id) {
-	case 0:
-	case 1:
-	case 2:
-	case 3:
-		return pwm.base + pwm.source_id * 0x0c + 0x14;
-
-	case 4:
-		return pwm.base + 0x40;
-
-	default:
-		BUG();
-	}
-}
-
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -312,17 +296,11 @@ static void __iomem *samsung_timer_reg(void)
  */
 static u32 notrace samsung_read_sched_clock(void)
 {
-	void __iomem *reg = samsung_timer_reg();
-
-	if (!reg)
-		return 0;
-
-	return ~__raw_readl(reg);
+	return ~__raw_readl(pwm.source_reg);
 }
 
 static void __init samsung_clocksource_init(void)
 {
-	void __iomem *reg = samsung_timer_reg();
 	unsigned long pclk;
 	unsigned long clock_rate;
 	int ret;
@@ -337,10 +315,15 @@ static void __init samsung_clocksource_init(void)
 	samsung_time_setup(pwm.source_id, pwm.tcnt_max);
 	samsung_time_start(pwm.source_id, true);
 
+	if (pwm.source_id == 4)
+		pwm.source_reg = pwm.base + 0x40;
+	else
+		pwm.source_reg = pwm.base + pwm.source_id * 0x0c + 0x14;
+
 	setup_sched_clock(samsung_read_sched_clock,
 						pwm.variant.bits, clock_rate);
 
-	ret = clocksource_mmio_init(reg, "samsung_clocksource_timer",
+	ret = clocksource_mmio_init(pwm.source_reg, "samsung_clocksource_timer",
 					clock_rate, 250, pwm.variant.bits,
 					clocksource_mmio_readl_down);
 	if (ret)
-- 
1.8.2.1
