From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 3/3] leds: pwm: don't set the brightness during .probe
Date: Fri, 24 Jan 2020 17:54:09 +0100
Message-ID: <20200124165409.12422-4-uwe@kleine-koenig.org>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:38354 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbgAXQyS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2020 11:54:18 -0500
In-Reply-To: <20200124165409.12422-1-uwe@kleine-koenig.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Jeff LaBundy <jeff@labundy.com>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org

The explicit call to led_pwm_set() prevents that the led's state can
stay as configured by the bootloader.

Note that brightness is always 0 here as the led_pwm driver doesn't
provide a .brightness_get() callback and so the LED was disabled
unconditionally.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/leds/leds-pwm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 9111cdede0ee..de74e1c8d234 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -83,13 +83,11 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		led_data->pwmstate.period = led->pwm_period_ns;
 
 	ret = devm_led_classdev_register(dev, &led_data->cdev);
-	if (ret == 0) {
+	if (ret == 0)
 		priv->num_leds++;
-		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
-	} else {
+	else
 		dev_err(dev, "failed to register PWM led for %s: %d\n",
 			led->name, ret);
-	}
 
 	return ret;
 }
-- 
2.24.0
