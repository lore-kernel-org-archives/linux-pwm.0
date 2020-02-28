From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 5/6] pwm: omap-dmtimer: Do not disable pwm before changing period/duty_cycle
Date: Fri, 28 Feb 2020 15:26:50 +0530
Message-ID: <20200228095651.32464-6-lokeshvutla@ti.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228095651.32464-1-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pwm@vger.kernel.org

Only the Timer control register(TCLR) cannot be updated when the timer
is running. Registers like Counter register(TCRR), loader register(TLDR),
match register(TMAR) can be updated when the counter is running. Since
TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
timer for period/duty_cycle update.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 89b3c25d02b8..e7487ceed0a3 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -15,6 +15,15 @@
  *   reloaded with the load value and the pwm output goes up.
  *   When counter matches with match register, the output goes down.
  *   Reference Manual: http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
+ *
+ * Limitations:
+ * - When PWM is running and changing both duty cycle and period,
+ *   we cannot prevent in software that the output might produce
+ *   a period with mixed settings. Especially when period/duty_cyle
+ *   is updated while the pwm pin is high, current pwm period/duty_cycle
+ *   can get updated as below based on the current timer counter:
+ *   	- period for current cycle =  current_period + new period
+ *   	- duty_cycle for current period = current period + new duty_cycle.
  */
 
 #include <linux/clk.h>
@@ -115,7 +124,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	u32 load_value, match_value;
 	struct clk *fclk;
 	unsigned long clk_rate;
-	bool timer_active;
 
 	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
 		duty_ns, period_ns);
@@ -191,25 +199,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	load_value = (DM_TIMER_MAX - period_cycles) + 1;
 	match_value = load_value + duty_cycles - 1;
 
-	/*
-	 * We MUST stop the associated dual-mode timer before attempting to
-	 * write its registers, but calls to omap_dm_timer_start/stop must
-	 * be balanced so check if timer is active before calling timer_stop.
-	 */
-	timer_active = pm_runtime_active(&omap->dm_timer_pdev->dev);
-	if (timer_active)
-		omap->pdata->stop(omap->dm_timer);
-
 	omap->pdata->set_load(omap->dm_timer, load_value);
 	omap->pdata->set_match(omap->dm_timer, true, match_value);
 
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
-	/* If config was called while timer was running it must be reenabled. */
-	if (timer_active)
-		pwm_omap_dmtimer_start(omap);
-
 	mutex_unlock(&omap->mutex);
 
 	return 0;
-- 
2.23.0
