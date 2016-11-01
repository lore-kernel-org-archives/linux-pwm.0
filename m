From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/2] backlight: pwm_bl: Check the pwm state for initial backlight power state
Date: Tue, 1 Nov 2016 14:59:33 +0200
Message-ID: <20161101125933.11168-3-peter.ujfalusi@ti.com>
References: <20161101125933.11168-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161101125933.11168-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, lee.jones@linaro.org
Cc: tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

If the pwm is not enabled the backlight initially should not be enabled
either if we have booted with DT and there is a phandle pointing to the
backlight node.

The patch extends the checks to decide if we should keep the backlight off
initially.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/video/backlight/pwm_bl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 4b07da278b4f..f680f7b033b2 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -215,6 +215,10 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 	if (!regulator_is_enabled(pb->power_supply))
 		return FB_BLANK_POWERDOWN;
 
+	/* The pwm is disabled, keep it like this */
+	if (!pwm_is_enabled(pb->pwm))
+		return FB_BLANK_POWERDOWN;
+
 	return FB_BLANK_UNBLANK;
 }
 
-- 
2.10.2
