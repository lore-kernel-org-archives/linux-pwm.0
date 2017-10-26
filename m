From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH 2/2] backlight: pwm_bl: add configurable delay between re-enabling PWM and switching backlight power on
Date: Thu, 26 Oct 2017 14:49:46 +0200
Message-ID: <1509022186-19636-4-git-send-email-LW@KARO-electronics.de>
References: <1509022186-19636-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1509022186-19636-1-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

When switching the backlight on, the LCD may need some time to adjust
to the configured PWM duty cycle. Add a configurable delay between
configuring the PWM and enabling the backlight regulator to account
for this.

Signed-off-by: Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
---
 .../bindings/leds/backlight/pwm-backlight.txt      |  4 ++++
 drivers/video/backlight/pwm_bl.c                   | 22 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 764db86..95594c3 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -17,6 +17,10 @@ Optional properties:
                "pwms" property (see PWM binding[0])
   - enable-gpios: contains a single GPIO specifier for the GPIO which enables
                   and disables the backlight (see GPIO binding[1])
+  - turn-on-delay-ms: delay in milliseconds between configuring the PWM
+		  and switching PWM on. This may be required to eliminate
+		  flicker when switching the PWM on after it has been
+		  disabled.
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 921f322..9578f65 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -23,6 +23,7 @@
 #include <linux/pwm_backlight.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 struct pwm_bl_data {
 	struct pwm_device	*pwm;
@@ -35,6 +36,7 @@ struct pwm_bl_data {
 	struct gpio_desc	*enable_gpio;
 	unsigned int		scale;
 	bool			legacy;
+	int			turn_on_delay_ms;
 	int			(*notify)(struct device *,
 					  int brightness);
 	void			(*notify_after)(struct device *,
@@ -52,6 +54,17 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 
 	pwm_enable(pb->pwm);
 
+	if (pb->turn_on_delay_ms > 0) {
+		dev_dbg(pb->dev, "Sleeping %u..%uµs\n",
+			pb->turn_on_delay_ms * 1000,
+			pb->turn_on_delay_ms * 1100);
+		if (pb->turn_on_delay_ms > 20)
+			msleep(pb->turn_on_delay_ms);
+		else
+			usleep_range(pb->turn_on_delay_ms * 1000,
+			     pb->turn_on_delay_ms * 1100);
+	}
+
 	err = regulator_enable(pb->power_supply);
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
@@ -108,8 +121,9 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		duty_cycle = compute_duty_cycle(pb, brightness);
 		pwm_config(pb->pwm, duty_cycle, pb->period);
 		pwm_backlight_power_on(pb, brightness);
-	} else
+	} else {
 		pwm_backlight_power_off(pb);
+	}
 
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
@@ -264,9 +278,9 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 				pb->scale = data->levels[i];
 
 		pb->levels = data->levels;
-	} else
+	} else {
 		pb->scale = data->max_brightness;
-
+	}
 	pb->notify = data->notify;
 	pb->notify_after = data->notify_after;
 	pb->check_fb = data->check_fb;
@@ -329,6 +343,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	of_property_read_u32(node, "turn-on-delay-ms", &pb->turn_on_delay_ms);
+
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
 
 	/*
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
