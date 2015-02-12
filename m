From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness to 0
Date: Thu, 12 Feb 2015 10:44:50 +0100
Message-ID: <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

This fixes disabling the LED on i.MX28. The PWM hardware delays using
the newly set pwm-config until the beginning of a new period. It's very
likely that pwm_disable is called before the current period ends. In
case the LED was on brightness=3Dmax before the LED stays on because in
the disabled PWM block the period never ends.

Also only call pwm_enable only once in the probe call back and the
matching pwm_disable in .remove(). Moreover the pwm is explicitly
initialized to off.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/leds-pwm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index f668500a2157..5dae0d2dc3dc 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -44,11 +44,6 @@ static void __led_pwm_set(struct led_pwm_data *led_d=
at)
 	int new_duty =3D led_dat->duty;
=20
 	pwm_config(led_dat->pwm, new_duty, led_dat->period);
-
-	if (new_duty =3D=3D 0)
-		pwm_disable(led_dat->pwm);
-	else
-		pwm_enable(led_dat->pwm);
 }
=20
 static void led_pwm_work(struct work_struct *work)
@@ -93,6 +88,7 @@ static void led_pwm_cleanup(struct led_pwm_priv *priv=
)
 		led_classdev_unregister(&priv->leds[priv->num_leds].cdev);
 		if (priv->leds[priv->num_leds].can_sleep)
 			cancel_work_sync(&priv->leds[priv->num_leds].work);
+		pwm_disable(priv->leds[i].pwm);
 	}
 }
=20
@@ -132,6 +128,10 @@ static int led_pwm_add(struct device *dev, struct =
led_pwm_priv *priv,
 	if (!led_data->period && (led->pwm_period_ns > 0))
 		led_data->period =3D led->pwm_period_ns;
=20
+	pwm_config(led_data->pwm, led_data->active_low ? led_data->period: 0,
+		   led_data->period);
+	pwm_enable(led_data->pwm);
+
 	ret =3D led_classdev_register(dev, &led_data->cdev);
 	if (ret =3D=3D 0) {
 		priv->num_leds++;
--=20
2.1.4
