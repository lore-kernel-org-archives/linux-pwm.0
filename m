From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2] pwm_bl: Fix overflow condition
Date: Tue, 29 Aug 2017 13:40:02 -0700
Message-ID: <20170829204002.8663-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thierry.reding@gmail.com, jingoohan1@gmail.com, lee.jones@linaro.org, briannorris@chromium.org, linux-pwm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pwm@vger.kernel.org

This fixes an overflow condition that can happen with high max
brightness and period values in compute_duty_cycle. This fixes it by
using a 64 bit variable for computing the duty cycle.

Change-Id: I745c67c7a24740316d13eaf1be74248ea2249353
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/video/backlight/pwm_bl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 76311ec5e400..5ccc8e34b7a6 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -88,14 +88,17 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
 {
 	unsigned int lth = pb->lth_brightness;
-	int duty_cycle;
+	u64 duty_cycle;
 
 	if (pb->levels)
 		duty_cycle = pb->levels[brightness];
 	else
 		duty_cycle = brightness;
 
-	return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
+	duty_cycle *= pb->period - lth;
+	do_div(duty_cycle, pb->scale);
+
+	return duty_cycle + lth;
 }
 
 static int pwm_backlight_update_status(struct backlight_device *bl)
-- 
2.14.1.342.g6490525c54-goog
