From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 4/5] clocksource: timer-ti-dm: Add support to get pwm current status
Date: Fri, 28 Feb 2020 15:23:45 +0530
Message-ID: <20200228095346.32177-5-lokeshvutla@ti.com>
References: <20200228095346.32177-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228095346.32177-1-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pwm@vger.kernel.org

omap_dm_timer_ops provide support to configure the pwm but there is no
support to get the current status. For configuring pwm it is advised to
check the current hw status instead of relying on pwm framework. So
implement a new timer ops to get the current status of pwm.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clocksource/timer-ti-dm.c          | 15 +++++++++++++++
 include/linux/platform_data/dmtimer-omap.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4c32ee41339a..b776ad3ee924 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -592,6 +592,20 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	return 0;
 }
 
+static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
+{
+	u32 l;
+
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	omap_dm_timer_enable(timer);
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	omap_dm_timer_disable(timer);
+
+	return l;
+}
+
 static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 					int prescaler)
 {
@@ -859,6 +873,7 @@ static const struct omap_dm_timer_ops dmtimer_ops = {
 	.set_load = omap_dm_timer_set_load,
 	.set_match = omap_dm_timer_set_match,
 	.set_pwm = omap_dm_timer_set_pwm,
+	.get_pwm_status = omap_dm_timer_get_pwm_status,
 	.set_prescaler = omap_dm_timer_set_prescaler,
 	.read_counter = omap_dm_timer_read_counter,
 	.write_counter = omap_dm_timer_write_counter,
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
index bdaaf537604a..3173b7b6ff6f 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -36,6 +36,7 @@ struct omap_dm_timer_ops {
 			     unsigned int match);
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger);
+	int	(*get_pwm_status)(struct omap_dm_timer *timer);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
 
 	unsigned int (*read_counter)(struct omap_dm_timer *timer);
-- 
2.23.0
