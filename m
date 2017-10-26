From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 1/2] backlight: pwm_bl: Enable PWM before switching regulator on
Date: Thu, 26 Oct 2017 14:49:45 +0200
Message-ID: <1509022186-19636-3-git-send-email-LW@KARO-electronics.de>
References: <1509022186-19636-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509022186-19636-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

When the PWM is re-enabled after being switched off, the backlight may
flicker due to the backlight power being switched on while the PWM is
still unconfigured. This is especially true if the PWM output is
active low (assuming that the PWM output is low when the PWM is not
enabled).
Configure the PWM before switching backlight power on to prevent this.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 002f1ce..921f322 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -50,6 +50,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (pb->enabled)
 		return;
 
+	pwm_enable(pb->pwm);
+
 	err = regulator_enable(pb->power_supply);
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
@@ -57,7 +59,6 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
 	pb->enabled = true;
 }
 
-- 
2.1.4
