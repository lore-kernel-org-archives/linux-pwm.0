From: Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH 1/3] leds: pwm: simplify if condition
Date: Sun, 26 Jan 2020 18:55:11 +0000
Message-ID: <20200126185501.GA2569@labundy.com>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-2-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:30592
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgAZSzP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Jan 2020 13:55:15 -0500
In-Reply-To: <20200124165409.12422-2-uwe@kleine-koenig.org>
Content-Language: en-US
Content-ID: <9F02039CBBDAAC4BA741B63454FEF5DC@namprd08.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hi Uwe,

On Fri, Jan 24, 2020 at 05:54:07PM +0100, Uwe Kleine-K=F6nig wrote:
> .pwm_period_ns is an unsigned integer. So when led->pwm_period_ns > 0
> is false, we now assign 0 to a value that is already 0, so it doesn't
> hurt and we can skip checking the actual value.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
>  drivers/leds/leds-pwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 8b6965a563e9..b72fd89ff390 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -102,7 +102,7 @@ static int led_pwm_add(struct device *dev, struct led=
_pwm_priv *priv,
>  	pwm_get_args(led_data->pwm, &pargs);
> =20
>  	led_data->period =3D pargs.period;
> -	if (!led_data->period && (led->pwm_period_ns > 0))
> +	if (!led_data->period)
>  		led_data->period =3D led->pwm_period_ns;
> =20
>  	ret =3D devm_led_classdev_register(dev, &led_data->cdev);
> --=20
> 2.24.0
>=20

Having tested this series with the pwm-iqs620a driver in development
(v5) and some actual hardware (IQS620AEV04 connected to an n-channel
MOSFET and an LED), let me add:

Tested-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
