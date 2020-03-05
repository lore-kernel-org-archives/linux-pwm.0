From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 4/6] clocksource: timer-ti-dm: Do not update counter on updating the period
Date: Thu, 5 Mar 2020 13:57:13 +0530
Message-ID: <20200305082715.15861-5-lokeshvutla@ti.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200305082715.15861-1-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pwm@vger.kernel.org

Write to trigger register(OMAP_TIMER_TRIGGER_REG) will load the value
in Load register(OMAP_TIMER_LOAD_REG) into Counter register
(OMAP_TIMER_COUNTER_REG).

omap_dm_timer_set_load() writes into trigger register every time load
register is updated. When timer is configured in pwm mode, this causes
disruption in current pwm cycle, which is not expected especially when
pwm is used as PPS signal for synchronized PTP clocks. So do not write
into trigger register on updating the period.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index e6b6123ec567..8f6d477d2078 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -548,7 +548,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-- 
2.23.0
