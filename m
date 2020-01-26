From: Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH 3/3] leds: pwm: don't set the brightness during .probe
Date: Sun, 26 Jan 2020 19:42:39 +0000
Message-ID: <20200126194236.GC2569@labundy.com>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-4-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20200124165409.12422-4-uwe@kleine-koenig.org>
Content-Language: en-US
Content-ID: <5CBE401259C81749A5F29E46CB1DD7AE@namprd08.prod.outlook.com>
Sender: linux-leds-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your work on this series.

On Fri, Jan 24, 2020 at 05:54:09PM +0100, Uwe Kleine-K=F6nig wrote:
> The explicit call to led_pwm_set() prevents that the led's state can
> stay as configured by the bootloader.
>=20
> Note that brightness is always 0 here as the led_pwm driver doesn't
> provide a .brightness_get() callback and so the LED was disabled
> unconditionally.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
>  drivers/leds/leds-pwm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 9111cdede0ee..de74e1c8d234 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -83,13 +83,11 @@ static int led_pwm_add(struct device *dev, struct led=
_pwm_priv *priv,
>  		led_data->pwmstate.period =3D led->pwm_period_ns;
> =20
>  	ret =3D devm_led_classdev_register(dev, &led_data->cdev);
> -	if (ret =3D=3D 0) {
> +	if (ret =3D=3D 0)
>  		priv->num_leds++;
> -		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
> -	} else {
> +	else
>  		dev_err(dev, "failed to register PWM led for %s: %d\n",
>  			led->name, ret);
> -	}
> =20
>  	return ret;
>  }
> --=20
> 2.24.0
>=20

My only concern here is whether or not there happen to be some hardware
out in the world whose PWM-related registers power on to a random state
and unknowingly depended on brightness being forced to zero.

The other folks on the thread probably have some better view into this,
but I wonder if the safest option would be to adopt the "default-state"
property from leds/common.txt, and only forgo the call to led_pwm_set()
if the property is set to "keep".

I did test this and can confirm that the LED's state prior to the driver
being loaded is preserved. However as you've warned, the brightness read
back from user space is zero and does not match the actual brightness of
the LED.

Understanding that it's more work, I wonder if this patch is not safe if
we don't also add a brightness_get callback in case there were any cases
where user space makes some decisions based on brightness =3D=3D 0?

At any rate this patch does what is advertised, and so:

Tested-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
