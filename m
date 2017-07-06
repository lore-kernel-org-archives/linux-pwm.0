From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/4] pwm-backlight: add support for pwm-delay-us
 property
Date: Thu, 6 Jul 2017 10:01:32 +0200
Message-ID: <20170706080132.GL16144@ulmo.fritz.box>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <20170630112109.13785-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34550 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbdGFIBh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 04:01:37 -0400
Content-Disposition: inline
In-Reply-To: <20170630112109.13785-2-enric.balletbo@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org, huang lin <hl@rock-chips.com>


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 01:21:07PM +0200, Enric Balletbo i Serra wrote:
> From: huang lin <hl@rock-chips.com>
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

I think this should be two separate patches to make it easier to revert
the inverted sequence should it prove to regress on other panels.

Two more comments below.

> Signed-off-by: huang lin <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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

2000 us is kind of arbitrary. What if pwm_delay[0] is on the order of 20
us? Making the delay 2 ms longer (in the worst case) seems somewhat
excessive. Why not something like:

	usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] * 2);

?

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

This comment is confusing. This isn't reading anything from the PWM.

Thierry

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld7lkACgkQ3SOs138+
s6ESkQ//Q9KgkEjoCjIx+nZN0oSuEYZOEXCTlP+NNNwuklxz8mVnvf1lwsIGKtjG
UI1U+ukCT+aky88yVfLYMCZ7+OQUQ2m9FWPIPPSG3tzGpwYdfQ4l3dD73Bm7Xp3l
hGOf9n8YzzoObSeYabi7O/JsWj0cSumcSz30uiiv+wRffXrPKF6qHTK7pm0+DKC3
dGUKvbh+HmZ2N8xvBizIYNOJn5BRLjUzpVmeE+Zg9sL7SO3GHXxMpc1xvhNejnu2
Q4OmEIbGoTIxdwuQc87IBpqUU0/IEdC+eMH1OugQW9Jyah2dD5Vsirw+enWMv5r9
zSrDetASIDQIafXhiXUC8rtjJDnH3+tPeRDHd4UDeCXUMTlnG541vO+ziL4rOO7z
rf6AXWlDnG+LQCpmy5YD8tqFPxSQj7NfYQQ1CwCwYCuGPrlulQJ4x8r0jO/HkQ6B
PhxMiun8zjRKj7itzJeZII7gJT1rLvDLUfwCFzbMz6gfnPzwD34A2a/EQrbBNI6G
P8gBGp9cuGaKeSF7mjcHGPRk8LuRSUVtNxOOwNrCF/fykinaGnFfsx0eF9vcFWFd
ol9Y+lE8UsYmMZvJp0NBDXUMrNbAX+UfsDKLTUdvwvzTb6v687m+0TkaXyju062R
iFw259hcgEHu+FHKqA3J0nKeWYppvQosq8HJwKlGcObVVpkoqhc=
=C0A3
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--
