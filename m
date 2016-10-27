Return-Path: <peter.ujfalusi@ti.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/2] backlight: pwm_bl: Check the pwm state for initial backlight power state
Date: Thu, 27 Oct 2016 13:01:57 +0300
Message-ID: <20161027100157.2231-3-peter.ujfalusi@ti.com>
In-Reply-To: <20161027100157.2231-1-peter.ujfalusi@ti.com>
References: <20161027100157.2231-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, lee.jones@linaro.org
Cc: tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de

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
index 74083d880144..aeedf2d7bbb2 100644
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
2.10.1
