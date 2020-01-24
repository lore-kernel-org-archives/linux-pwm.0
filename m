From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 1/3] leds: pwm: simplify if condition
Date: Fri, 24 Jan 2020 17:54:07 +0100
Message-ID: <20200124165409.12422-2-uwe@kleine-koenig.org>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:38340 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbgAXQyQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2020 11:54:16 -0500
In-Reply-To: <20200124165409.12422-1-uwe@kleine-koenig.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Jeff LaBundy <jeff@labundy.com>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org

.pwm_period_ns is an unsigned integer. So when led->pwm_period_ns > 0
is false, we now assign 0 to a value that is already 0, so it doesn't
hurt and we can skip checking the actual value.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 8b6965a563e9..b72fd89ff390 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -102,7 +102,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	pwm_get_args(led_data->pwm, &pargs);
 
 	led_data->period = pargs.period;
-	if (!led_data->period && (led->pwm_period_ns > 0))
+	if (!led_data->period)
 		led_data->period = led->pwm_period_ns;
 
 	ret = devm_led_classdev_register(dev, &led_data->cdev);
-- 
2.24.0
