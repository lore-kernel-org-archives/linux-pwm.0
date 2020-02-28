From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
Date: Fri, 28 Feb 2020 15:26:49 +0530
Message-ID: <20200228095651.32464-5-lokeshvutla@ti.com>
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

pwm_omap_dmtimer_disable() calls .stop callback which abruptly stops the
timer counter. This doesn't complete the current pwm cycle and
immediately disables the pwm. Instead disable the auto reload
functionality which allows to complete the current pwm cycle and then
disables the timer.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index bc338619232d..89b3c25d02b8 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -93,8 +93,16 @@ static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
+	/*
+	 * Disable auto reload so that the current cycle gets completed and
+	 * then the counter stops.
+	 */
 	mutex_lock(&omap->mutex);
-	omap->pdata->stop(omap->dm_timer);
+	omap->pdata->set_pwm(omap->dm_timer,
+			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			     false);
+
 	mutex_unlock(&omap->mutex);
 }
 
-- 
2.23.0
