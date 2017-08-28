From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] pwm_bl: Fix overflow condition
Date: Mon, 28 Aug 2017 13:00:33 -0700
Message-ID: <20170828200033.40673-1-dbasehore@chromium.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34617 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdH1UAj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Aug 2017 16:00:39 -0400
Received: by mail-pg0-f44.google.com with SMTP id y15so4396616pgc.1
        for <linux-pwm@vger.kernel.org>; Mon, 28 Aug 2017 13:00:39 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thierry.reding@gmail.com, jingoohan1@gmail.com, lee.jones@linaro.org, linux-pwm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>

This fixes and overflow condition that happens with a high value of
brightness-levels-scale by using a 64-bit variable. The issue would
prevent a range of higher brightness levels from being set.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/video/backlight/pwm_bl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 76311ec5e400..e7ffd2108acf 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -88,14 +88,17 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
 {
 	unsigned int lth = pb->lth_brightness;
-	int duty_cycle;
+	s64 duty_cycle;
 
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
