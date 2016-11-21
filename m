From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/2] backlight: pwm_bl: Move the checks for initial
 power state to a separate function
Date: Mon, 21 Nov 2016 09:10:05 +0100
Message-ID: <20161121081005.GA25171@ulmo.ba.sec>
References: <20161101125933.11168-1-peter.ujfalusi@ti.com>
 <20161101125933.11168-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161101125933.11168-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: lee.jones@linaro.org, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2016 at 02:59:32PM +0200, Peter Ujfalusi wrote:
> Move the checks to select the initial state for the backlight to a new
> function and document the checks we are doing.
>=20
> With the separate function it is going to be easier to fix or improve the
> initial power state configuration later and it is easier to read the code.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 53 ++++++++++++++++++++++++++--------=
------
>  1 file changed, 34 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 12614006211e..4b07da278b4f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -192,6 +192,32 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  }
>  #endif
> =20
> +static int pwm_backlight_initial_power_state(const struct pwm_bl_data *p=
b)
> +{
> +	struct device_node *node =3D pb->dev->of_node;
> +
> +	/* Not booted with device tree or no phandle link to the node */
> +	if (!node || !node->phandle)
> +		return FB_BLANK_UNBLANK;
> +
> +	/*
> +	 * If the driver is probed from the device tree and there is a
> +	 * phandle link pointing to the backlight node, it is safe to
> +	 * assume that another driver will enable the backlight at the
> +	 * appropriate time. Therefore, if it is disabled, keep it so.
> +	 */
> +
> +	/* if the enable GPIO is disabled, do not enable the backlight */
> +	if (pb->enable_gpio && gpiod_get_value(pb->enable_gpio) =3D=3D 0)
> +		return FB_BLANK_POWERDOWN;
> +
> +	/* The regulator is disabled, do not enable the backlight */
> +	if (!regulator_is_enabled(pb->power_supply))
> +		return FB_BLANK_POWERDOWN;
> +
> +	return FB_BLANK_UNBLANK;
> +}
> +
>  static int pwm_backlight_probe(struct platform_device *pdev)
>  {
>  	struct platform_pwm_backlight_data *data =3D dev_get_platdata(&pdev->de=
v);
> @@ -200,7 +226,6 @@ static int pwm_backlight_probe(struct platform_device=
 *pdev)
>  	struct backlight_device *bl;
>  	struct device_node *node =3D pdev->dev.of_node;
>  	struct pwm_bl_data *pb;
> -	int initial_blank =3D FB_BLANK_UNBLANK;
>  	struct pwm_args pargs;
>  	int ret;
> =20
> @@ -267,20 +292,13 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
>  		pb->enable_gpio =3D gpio_to_desc(data->enable_gpio);
>  	}
> =20
> -	if (pb->enable_gpio) {
> -		/*
> -		 * If the driver is probed from the device tree and there is a
> -		 * phandle link pointing to the backlight node, it is safe to
> -		 * assume that another driver will enable the backlight at the
> -		 * appropriate time. Therefore, if it is disabled, keep it so.
> -		 */
> -		if (node && node->phandle &&
> -		    gpiod_get_direction(pb->enable_gpio) =3D=3D GPIOF_DIR_OUT &&
> -		    gpiod_get_value(pb->enable_gpio) =3D=3D 0)
> -			initial_blank =3D FB_BLANK_POWERDOWN;
> -		else
> -			gpiod_direction_output(pb->enable_gpio, 1);
> -	}
> +	/*
> +	 * If the GPIO is configured as input, change the direction to output
> +	 * and set the GPIO as active.
> +	 */
> +	if (pb->enable_gpio &&
> +	    gpiod_get_direction(pb->enable_gpio) =3D=3D GPIOF_DIR_IN)
> +		gpiod_direction_output(pb->enable_gpio, 1);

I'm confused about this. Isn't it redundant to check for the direction
if you're going to configure it as output either way? Why not just set
it as output unconditionally?

Also, is this not counterproductive? pwm_backlight_initial_power_state()
will check the value of the GPIO to determine whether or not to mark the
backlight as enabled. If we're setting this to active, then the check in
the initial state retrieval will only be false if the GPIO is an output
and inactive.

Oh wait... I guess that's exactly why you're doing this. =3D) Perhaps this
could be made somewhat clearer by beefing up the comment. As it is, the
comment /seems/ rather useless because it restates what the code does. I
think it'd be better to explain more verbosely what's going on, to avoid
confusing people like me.

Either way, though, the patch looks correct now that I understand it
properly, I'll leave it up to Lee if he wants to insist on a clarifying
comment.

Reviewed-by: Thierry Reding <treding@nvidia.com>

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYMqvXAAoJEN0jrNd/PrOhYREP/3tbbAOC7RJp4KEdmwmF8ZfI
z7oJkrI6ttSB++vjUSrXLpe3Fb+b1qa1HNYEKYlBvnugGjUhox/wJ5llpmE40myh
5tbRdKveMMw03mYVqX6zl9cU9iM4c69quMzBTQ/x9qzEgWtPdMcPYai4jp4+KW7Y
AkaZaQMnvMOZCipPmbTHs8+pgbO2x9zRnwFq02doP3tEhr+D50qGh5gs5cVWSY1Z
T4OTTyeK3p85WoB/JkLyIAHrbfoT7vlXtP3nKrOSTFOXx3vXlSgMHDbffAYCU4Hw
wspYlFrW51sf/K3x3mxkr7lYFH5HXePk3GNwSTZ16Pplncj0APYVIoAO98Y1aZMJ
rGM9jf1ZHDbb8loW1kx+8WN5Buio0XWbYPbFjjtKCUp+m2xayvTJMWna7KUOXT1c
xMi9rn6PhSSb1psX3ww6QcrAFCJSyxfIRcs+rgvO03kF2/mJyOtgMaSC9ypiYWlT
/Me23P0WVFj1gz9hHkysEk6j6FklpG2WXZ0/MlKQNO2SSBiEtok/eSM+klTS42Uj
Nwi02TOQrQhwxufau/nTj1onT98WK5ilPPm6Lk0ZDEBprhHYAjHcEqP/cxjou81k
BbaKn5EQy5gy0HKw3LFzz+50gOC6stdY/xbLSMhhMiKZR1jciBpPu6QRMXn8IQhq
BdaXMIs++Nl3NCgbGz7d
=A5CP
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
