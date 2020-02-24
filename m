From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/4] pwm: omap-dmtimer: Fix pwm enabling sequence
Date: Mon, 24 Feb 2020 10:51:33 +0530
Message-ID: <20200224052135.17278-3-lokeshvutla@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38618 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgBXFWm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 00:22:42 -0500
In-Reply-To: <20200224052135.17278-1-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

To configure DM timer is pwm mode the following needs to be set in
OMAP_TIMER_CTRL_REG using set_pwm callback:
- Set toggle mode on PORTIMERPWM output pin
- Set trigger on overflow and match on PORTIMERPWM output pin.
- Set auto reload

This is a one time configuration and needs to be set before the start of
the dm timer. But the current driver tries to set the same configuration
for every period/duty cycle update, which is not needed. So move the pwm
setup before enabling timer and do not update it in pwm_omap_dmtimer_config.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 2e35bf9a7936..f13be7216847 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -73,6 +73,10 @@ static int pwm_omap_dmtimer_enable(struct pwm_chip *chip,
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
 	mutex_lock(&omap->mutex);
+	omap->pdata->set_pwm(omap->dm_timer,
+			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+
 	pwm_omap_dmtimer_start(omap);
 	mutex_unlock(&omap->mutex);
 
@@ -189,10 +193,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
-	omap->pdata->set_pwm(omap->dm_timer,
-			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
-			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
-
 	/* If config was called while timer was running it must be reenabled. */
 	if (timer_active)
 		pwm_omap_dmtimer_start(omap);
-- 
2.23.0
