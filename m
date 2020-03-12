From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 3/5] pwm: omap-dmtimer: Fix pwm enabling sequence
Date: Thu, 12 Mar 2020 09:52:08 +0530
Message-ID: <20200312042210.17344-4-lokeshvutla@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200312042210.17344-1-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pwm@vger.kernel.org

To configure DM timer is pwm mode the following needs to be set in
OMAP_TIMER_CTRL_REG using set_pwm callback:
- Set toggle mode on PORTIMERPWM output pin
- Set trigger on overflow and match on PORTIMERPWM output pin.
- Set auto reload

This is a one time configuration and needs to be set before the start of
the dm timer. But the current driver tries to set the same configuration
for every period/duty cycle update, which is not needed. So move the pwm
setup before enabling timer and do not update it in pwm_omap_dmtimer_config.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 92aac6c86b95..85b17b49980b 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -81,6 +81,11 @@ static int pwm_omap_dmtimer_enable(struct pwm_chip *chip,
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
 	mutex_lock(&omap->mutex);
+	omap->pdata->set_pwm(omap->dm_timer,
+			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			     true);
+
 	pwm_omap_dmtimer_start(omap);
 	mutex_unlock(&omap->mutex);
 
@@ -197,11 +202,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
-	omap->pdata->set_pwm(omap->dm_timer,
-			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
-			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
-			     true);
-
 	/* If config was called while timer was running it must be reenabled. */
 	if (timer_active)
 		pwm_omap_dmtimer_start(omap);
-- 
2.23.0
