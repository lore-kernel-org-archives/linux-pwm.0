From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] pwm-backlight: add support for pwm-delay-us
 property
Date: Thu, 6 Jul 2017 10:13:22 +0200
Message-ID: <20170706081322.GM16144@ulmo.fritz.box>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <20170630112109.13785-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9186330071457301368=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170630112109.13785-2-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--===============9186330071457301368==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Content-Disposition: inline


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 01:21:07PM +0200, Enric Balletbo i Serra wrote:
> From: huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>=20
> Some panels (i.e. N116BGE-L41), in their power sequence specifications,
> request a delay between set the PWM signal and enable the backlight and
> between clear the PWM signal and disable the backlight. Add support for
> the new pwm-delay-us property to meet the timing.
>=20
> Note that this patch inverts current sequence. Before this patch the
> enable signal was set before the PWM signal and vice-versa on power off.
>=20
> I assumed that this sequence was wrong, at least it is on different panel
> datasheets that I checked, so I inverted the sequence to follow:
>=20
>   On power on, set the PWM signal, wait, and set the LED_EN signal.
>   On power off, clear the LED_EN signal, wait, and stop the PWM signal.
>=20
> Signed-off-by: huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v1:
>  - As suggested by Daniel Thompson
>    - Do not assume power-on delay and power-off delay will be the same
>  - Move the check of dt property to the parse dt function.
>=20
> v1: https://lkml.org/lkml/2017/6/28/219
>=20
>  drivers/video/backlight/pwm_bl.c | 24 ++++++++++++++++++++----
>  include/linux/pwm_backlight.h    |  1 +
>  2 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 002f1ce..0f5470e 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -10,6 +10,7 @@
>   * published by the Free Software Foundation.
>   */
> =20
> +#include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio.h>
>  #include <linux/module.h>
> @@ -35,6 +36,7 @@ struct pwm_bl_data {
>  	struct gpio_desc	*enable_gpio;
>  	unsigned int		scale;
>  	bool			legacy;
> +	unsigned int		pwm_delay[2];
>  	int			(*notify)(struct device *,
>  					  int brightness);
>  	void			(*notify_after)(struct device *,
> @@ -54,10 +56,14 @@ static void pwm_backlight_power_on(struct pwm_bl_data=
 *pb, int brightness)
>  	if (err < 0)
>  		dev_err(pb->dev, "failed to enable power supply\n");
> =20
> +	pwm_enable(pb->pwm);
> +
> +	if (pb->pwm_delay[0])
> +		usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] + 2000);
> +
>  	if (pb->enable_gpio)
>  		gpiod_set_value_cansleep(pb->enable_gpio, 1);
> =20
> -	pwm_enable(pb->pwm);
>  	pb->enabled =3D true;
>  }
> =20
> @@ -66,12 +72,15 @@ static void pwm_backlight_power_off(struct pwm_bl_dat=
a *pb)
>  	if (!pb->enabled)
>  		return;
> =20
> -	pwm_config(pb->pwm, 0, pb->period);
> -	pwm_disable(pb->pwm);
> -
>  	if (pb->enable_gpio)
>  		gpiod_set_value_cansleep(pb->enable_gpio, 0);
> =20
> +	if (pb->pwm_delay[1])
> +		usleep_range(pb->pwm_delay[1], pb->pwm_delay[1] + 2000);
> +
> +	pwm_config(pb->pwm, 0, pb->period);
> +	pwm_disable(pb->pwm);
> +
>  	regulator_disable(pb->power_supply);
>  	pb->enabled =3D false;
>  }
> @@ -174,6 +183,12 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		data->max_brightness--;
>  	}
> =20
> +	/* read pwm to enable pre/post delays from DT property */
> +	ret =3D of_property_read_u32_array(node, "pwm-delay-us", data->pwm_dela=
y,
> +					 ARRAY_SIZE(data->pwm_delay));
> +	if (ret < 0)
> +		return ret;

Also I think you need to make sure you have a fallback in place in case
that this fails, otherwise the property is no longer optional.

Ignoring -EINVAL should do the trick since data->pwm_delay should be
zeroed out by the memset() earlier in this function.

Thierry

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld8R8ACgkQ3SOs138+
s6G+VA/9Gqujd96+fWUYXmZPtX2B/+Cjblg8U273lulvd8KmAkXoUsZvchfG3+8s
dxxzb/hDn6OuEYBXgiaQo1EwTluycNWvRaATE82i90kRxkF7ZXy5grcBaj/kUFYt
caWWSyihUR8BUZtLT2urg/66Bm8Xcgeo9+gjJfGEPrAUhOdgSLdcSvg1X3enIi3Y
DXN/T5gGj2O0sRL2GxFZAisS/s9QwSk5XAurw1yMFLFgjttj7avA37kU/lmmKkQt
iX+69P0LryhS+U3+rHpLFYb6rdP9u7QRTqwdh5lgx0DOwZW3zInDk243CMy0aNza
v7Y+Tnji1NnH5Th+SUyTdQ6bBSUgwBvxii+SKhTnPyDsCcYRJL6RVGCJCGjvil3T
vBba2nqNvJeGsD4Qvc3wlJ1tNk0h4GG3G2wqzhXBapRSU5hnmFUvxH9AGL+ebOXs
qs4kyKM4vuEwpQOW6RInSvTdKCDdb3/Qqn/hlIu3XgP5id8VYsFIK/KKmDFCZCwu
9EAr0Rce/UzPUm+E1ST2Y7tdAPheWt64grlVOUF87rnGQbYKFcpIqotuDw0muFJs
IUMjlvNKewgVHfw2o7YVbR4pW3wMXhyzjuDh0vdRjkqomDHbl/+MTpV5Rp1R3bi+
PxHZECJRQu5mB7EEhng9B9o46OAZrOh0EUkabpMwhABRSzInMPM=
=QPOy
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--


--===============9186330071457301368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============9186330071457301368==--
