From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness
 to 0
Date: Tue, 24 Feb 2015 19:56:52 +0100 (CET)
Message-ID: <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de> <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49459 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbbBXS5A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Feb 2015 13:57:00 -0500
In-Reply-To: <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-leds@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, =?UTF-8?Q?=22Uwe_Kleine-K=C3=B6nig=22?= <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

Hi Uwe,

> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> hat am 12. Feb=
ruar 2015 um
> 10:44 geschrieben:
>
>
> This fixes disabling the LED on i.MX28. The PWM hardware delays using
> the newly set pwm-config until the beginning of a new period. It's ve=
ry
> likely that pwm_disable is called before the current period ends. In
> case the LED was on brightness=3Dmax before the LED stays on because =
in
> the disabled PWM block the period never ends.
>
> Also only call pwm_enable only once in the probe call back and the
> matching pwm_disable in .remove(). Moreover the pwm is explicitly
> initialized to off.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> drivers/leds/leds-pwm.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index f668500a2157..5dae0d2dc3dc 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -44,11 +44,6 @@ static void __led_pwm_set(struct led_pwm_data *led=
_dat)
> int new_duty =3D led_dat->duty;
>
> pwm_config(led_dat->pwm, new_duty, led_dat->period);
> -
> - if (new_duty =3D=3D 0)
> - pwm_disable(led_dat->pwm);
> - else
> - pwm_enable(led_dat->pwm);
> }
>
> static void led_pwm_work(struct work_struct *work)
> @@ -93,6 +88,7 @@ static void led_pwm_cleanup(struct led_pwm_priv *pr=
iv)
> led_classdev_unregister(&priv->leds[priv->num_leds].cdev);
> if (priv->leds[priv->num_leds].can_sleep)
> cancel_work_sync(&priv->leds[priv->num_leds].work);
> + pwm_disable(priv->leds[i].pwm);
> }
> }
>

After replacing "i" with "priv->num_leds" in this patch we are able to =
use pwm
led with trigger heartbeat.

This is the functional part of this issue, since the warning has been f=
ixed [1]

Thanks Stefan

[1] -
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244925=
=2Ehtml
