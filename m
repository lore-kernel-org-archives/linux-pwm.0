Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v4 05/20] clocksource: samsung_pwm_timer: Handle suspend/resume correctly
Date: Sat, 20 Jul 2013 02:04:18 +0200
Message-Id: <1374278673-25615-7-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

Current suspend/resume handling of the driver was broken, because:
 - periodic timer was being enabled in CLOCK_EVT_MODE_RESUME mode, which
   does not seem to be correct behavior looking at other platforms,
 - PWM divisors need to be restored, but they were not,
 - clockevent interrupt mask needs to be restored, but it was not,
 - clocksource was being restored in clockevent resume callback.

This patch fixes issues mentioned above, making suspend/resume handling
in the driver correct.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 42 ++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 753ffec..282e0e2 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -197,17 +197,6 @@ static int samsung_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void samsung_timer_resume(void)
-{
-	/* event timer restart */
-	samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick - 1);
-	samsung_time_start(pwm.event_id, true);
-
-	/* source timer restart */
-	samsung_time_setup(pwm.source_id, pwm.tcnt_max);
-	samsung_time_start(pwm.source_id, true);
-}
-
 static void samsung_set_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
@@ -224,20 +213,29 @@ static void samsung_set_mode(enum clock_event_mode mode,
 
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
-		break;
-
 	case CLOCK_EVT_MODE_RESUME:
-		samsung_timer_resume();
 		break;
 	}
 }
 
+static void samsung_clockevent_resume(struct clock_event_device *cev)
+{
+	samsung_timer_set_prescale(pwm.event_id, pwm.tscaler_div);
+	samsung_timer_set_divisor(pwm.event_id, pwm.tdiv);
+
+	if (pwm.variant.has_tint_cstat) {
+		u32 mask = (1 << pwm.event_id);
+		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
+	}
+}
+
 static struct clock_event_device time_event_device = {
 	.name		= "samsung_event_timer",
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 200,
 	.set_next_event	= samsung_set_next_event,
 	.set_mode	= samsung_set_mode,
+	.resume		= samsung_clockevent_resume,
 };
 
 static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
@@ -288,6 +286,20 @@ static void __init samsung_clockevent_init(void)
 	}
 }
 
+static void samsung_clocksource_suspend(struct clocksource *cs)
+{
+	samsung_time_stop(pwm.source_id);
+}
+
+static void samsung_clocksource_resume(struct clocksource *cs)
+{
+	samsung_timer_set_prescale(pwm.source_id, pwm.tscaler_div);
+	samsung_timer_set_divisor(pwm.source_id, pwm.tdiv);
+
+	samsung_time_setup(pwm.source_id, pwm.tcnt_max);
+	samsung_time_start(pwm.source_id, true);
+}
+
 static cycle_t samsung_clocksource_read(struct clocksource *c)
 {
 	return ~readl_relaxed(pwm.source_reg);
@@ -297,6 +309,8 @@ static struct clocksource samsung_clocksource = {
 	.name		= "samsung_clocksource_timer",
 	.rating		= 250,
 	.read		= samsung_clocksource_read,
+	.suspend	= samsung_clocksource_suspend,
+	.resume		= samsung_clocksource_resume,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-- 
1.8.3.2
