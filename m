From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH] video: pwm backlight: power off when necessary
Date: Wed, 26 Feb 2014 19:39:12 +0800
Message-ID: <1393414752-8861-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:18682
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751200AbaBZLhh (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 06:37:37 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, jg1.han@samsung.com
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The pwm backlight should be powered off only in two cases:
1) pwm polarity is normal and brightness is zero.
2) pwm polarity is inversed and brightness is maximal,
   that is, 100% duty.

This patch implements this logic in the pwm backlight driver
and actually fixes the issue that backlight is on when we
intend to set the brightness to be zero for an inversed pwm
signal.  The root cause of the issue is that power is off
in that case.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 drivers/video/backlight/pwm_bl.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index b75201f..e61e66a 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -100,6 +100,8 @@ static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
 static int pwm_backlight_update_status(struct backlight_device *bl)
 {
 	struct pwm_bl_data *pb = bl_get_data(bl);
+	enum pwm_polarity polarity = pb->pwm->polarity;
+	int max = bl->props.max_brightness;
 	int brightness = bl->props.brightness;
 	int duty_cycle;
 
@@ -111,12 +113,14 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 	if (pb->notify)
 		brightness = pb->notify(pb->dev, brightness);
 
-	if (brightness > 0) {
+	if ((polarity == PWM_POLARITY_NORMAL && brightness == 0) ||
+	    (polarity == PWM_POLARITY_INVERSED && brightness == max)) {
+		pwm_backlight_power_off(pb);
+	} else {
 		duty_cycle = compute_duty_cycle(pb, brightness);
 		pwm_config(pb->pwm, duty_cycle, pb->period);
 		pwm_backlight_power_on(pb, brightness);
-	} else
-		pwm_backlight_power_off(pb);
+	}
 
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
-- 
1.7.9.5


