From: Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH 2/3] leds: pwm: convert to atomic PWM API
Date: Sun, 26 Jan 2020 19:15:00 +0000
Message-ID: <20200126191457.GB2569@labundy.com>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-3-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:14177
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbgAZTPE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Jan 2020 14:15:04 -0500
In-Reply-To: <20200124165409.12422-3-uwe@kleine-koenig.org>
Content-Language: en-US
Content-ID: <FF585192A2BC4944ABF2154D874CD0B0@namprd08.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hi Uwe,

On Fri, Jan 24, 2020 at 05:54:08PM +0100, Uwe Kleine-K=F6nig wrote:
> pwm_config(), pwm_enable() and pwm_disable() should get removed in the
> long run. So update the driver to use the atomic API that is here to
> stay.
>=20
> A few side effects:
>=20
>  - led_pwm_set() now returns an error when setting the PWM fails.
>  - During .probe() the PWM isn't disabled implicitly by pwm_apply_args()
>    any more.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
>  drivers/leds/leds-pwm.c | 41 +++++++++--------------------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index b72fd89ff390..9111cdede0ee 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -22,9 +22,8 @@
>  struct led_pwm_data {
>  	struct led_classdev	cdev;
>  	struct pwm_device	*pwm;
> +	struct pwm_state	pwmstate;
>  	unsigned int		active_low;
> -	unsigned int		period;
> -	int			duty;
>  };
> =20
>  struct led_pwm_priv {
> @@ -32,44 +31,29 @@ struct led_pwm_priv {
>  	struct led_pwm_data leds[0];
>  };
> =20
> -static void __led_pwm_set(struct led_pwm_data *led_dat)
> -{
> -	int new_duty =3D led_dat->duty;
> -
> -	pwm_config(led_dat->pwm, new_duty, led_dat->period);
> -
> -	if (new_duty =3D=3D 0)
> -		pwm_disable(led_dat->pwm);
> -	else
> -		pwm_enable(led_dat->pwm);
> -}
> -
>  static int led_pwm_set(struct led_classdev *led_cdev,
>  		       enum led_brightness brightness)
>  {
>  	struct led_pwm_data *led_dat =3D
>  		container_of(led_cdev, struct led_pwm_data, cdev);
>  	unsigned int max =3D led_dat->cdev.max_brightness;
> -	unsigned long long duty =3D  led_dat->period;
> +	unsigned long long duty =3D led_dat->pwmstate.period;
> =20
>  	duty *=3D brightness;
>  	do_div(duty, max);
> =20
>  	if (led_dat->active_low)
> -		duty =3D led_dat->period - duty;
> -
> -	led_dat->duty =3D duty;
> -
> -	__led_pwm_set(led_dat);
> +		duty =3D led_dat->pwmstate.period - duty;
> =20
> -	return 0;
> +	led_dat->pwmstate.duty_cycle =3D duty;
> +	led_dat->pwmstate.enabled =3D duty > 0;
> +	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
>  }
> =20
>  static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>  		       struct led_pwm *led, struct fwnode_handle *fwnode)
>  {
>  	struct led_pwm_data *led_data =3D &priv->leds[priv->num_leds];
> -	struct pwm_args pargs;
>  	int ret;
> =20
>  	led_data->active_low =3D led->active_low;
> @@ -93,17 +77,10 @@ static int led_pwm_add(struct device *dev, struct led=
_pwm_priv *priv,
> =20
>  	led_data->cdev.brightness_set_blocking =3D led_pwm_set;
> =20
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to the
> -	 * atomic PWM API.
> -	 */
> -	pwm_apply_args(led_data->pwm);
> -
> -	pwm_get_args(led_data->pwm, &pargs);
> +	pwm_init_state(led_data->pwm, &led_data->pwmstate);
> =20
> -	led_data->period =3D pargs.period;
> -	if (!led_data->period)
> -		led_data->period =3D led->pwm_period_ns;
> +	if (!led_data->pwmstate.period)
> +		led_data->pwmstate.period =3D led->pwm_period_ns;
> =20
>  	ret =3D devm_led_classdev_register(dev, &led_data->cdev);
>  	if (ret =3D=3D 0) {
> --=20
> 2.24.0
>=20

Using the same setup described in my response to patch [1/3], I checked
the following:

* LED appears as expected with brightness continuously swept between 0
  and 255 at fixed intervals
* I2C traffic appears as expected for random cases of brightness being
  changed between 0 and !0 and back to 0

And so:

Tested-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
