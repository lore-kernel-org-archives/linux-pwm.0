From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-samsung: switch to new atomic PWM API
Date: Mon, 21 Aug 2017 10:29:48 +0200
Message-ID: <20170821082948.GR18996@ulmo>
References: <1493039598-25881-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170424131346epcas1p4584c5e78edfe5055beaba0ce0f5e5ae7@epcas1p4.samsung.com>
 <1493039598-25881-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1GSL5ZULXUIqbbH1"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493039598-25881-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--1GSL5ZULXUIqbbH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2017 at 03:13:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Switch pwm-samsung driver to new atomic PWM API.
>=20
> This is an initial conversion (based on the PWM core's
> pwm_apply_state() implementation) which can be improved
> later.
>=20
> There should be no functional changes caused by this
> patch.
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Depends on "[PATCH v2 0/3] pwm: pwm-samsung: fix suspend/resume support"
> patchset (https://www.spinics.net/lists/kernel/msg2495209.html).
>=20
>  drivers/pwm/pwm-samsung.c | 59 ++++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 45 insertions(+), 14 deletions(-)

Sorry, it looks like I never reviewed this.

> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index 062f2cf..09868a9 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -241,7 +241,7 @@ static void pwm_samsung_free(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	pwm_set_chip_data(pwm, NULL);
>  }
> =20
> -static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> +static void pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device =
*pwm)
>  {
>  	struct samsung_pwm_chip *our_chip =3D to_samsung_pwm_chip(chip);
>  	unsigned int tcon_chan =3D to_tcon_channel(pwm->hwpwm);
> @@ -263,8 +263,6 @@ static int pwm_samsung_enable(struct pwm_chip *chip, =
struct pwm_device *pwm)
>  	our_chip->disabled_mask &=3D ~BIT(pwm->hwpwm);
> =20
>  	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> -
> -	return 0;
>  }
> =20
>  static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> @@ -385,12 +383,6 @@ static int __pwm_samsung_config(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>  	return 0;
>  }
> =20
> -static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> -			      int duty_ns, int period_ns)
> -{
> -	return __pwm_samsung_config(chip, pwm, duty_ns, period_ns, false);
> -}
> -
>  static void pwm_samsung_set_invert(struct samsung_pwm_chip *chip,
>  				   unsigned int channel, bool invert)
>  {
> @@ -415,7 +407,7 @@ static void pwm_samsung_set_invert(struct samsung_pwm=
_chip *chip,
>  	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
>  }
> =20
> -static int pwm_samsung_set_polarity(struct pwm_chip *chip,
> +static void pwm_samsung_set_polarity(struct pwm_chip *chip,
>  				    struct pwm_device *pwm,
>  				    enum pwm_polarity polarity)
>  {
> @@ -424,6 +416,48 @@ static int pwm_samsung_set_polarity(struct pwm_chip =
*chip,
> =20
>  	/* Inverted means normal in the hardware. */
>  	pwm_samsung_set_invert(our_chip, pwm->hwpwm, invert);
> +}
> +
> +static int pwm_samsung_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     struct pwm_state *state)
> +{
> +	int err;
> +
> +	/*
> +	 * FIXME: restore the initial state in case of error.
> +	 */
> +	if (state->polarity !=3D pwm->state.polarity) {
> +		if (pwm->state.enabled) {
> +			pwm_samsung_disable(pwm->chip, pwm);
> +			pwm->state.enabled =3D false;
> +		}
> +
> +		pwm_samsung_set_polarity(pwm->chip, pwm,
> +					 state->polarity);
> +
> +		pwm->state.polarity =3D state->polarity;
> +	}

The whole point, or at least much of it, of the atomic API is that you
can perform all computations before writing any registers, exactly so
that you can avoid having to restore the initial state. Otherwise we're
no better than the legacy API, really.

> +	if (state->period !=3D pwm->state.period ||
> +	    state->duty_cycle !=3D pwm->state.duty_cycle) {
> +		err =3D __pwm_samsung_config(pwm->chip, pwm,
> +					   state->duty_cycle,
> +					   state->period, false);
> +		if (err)
> +			return err;
> +
> +		pwm->state.duty_cycle =3D state->duty_cycle;
> +		pwm->state.period =3D state->period;
> +	}
> +
> +	if (state->enabled !=3D pwm->state.enabled) {
> +		if (state->enabled)
> +			pwm_samsung_enable(pwm->chip, pwm);
> +		else
> +			pwm_samsung_disable(pwm->chip, pwm);
> +
> +		pwm->state.enabled =3D state->enabled;
> +	}
> =20
>  	return 0;
>  }
> @@ -431,10 +465,7 @@ static int pwm_samsung_set_polarity(struct pwm_chip =
*chip,
>  static const struct pwm_ops pwm_samsung_ops =3D {
>  	.request	=3D pwm_samsung_request,
>  	.free		=3D pwm_samsung_free,
> -	.enable		=3D pwm_samsung_enable,
> -	.disable	=3D pwm_samsung_disable,
> -	.config		=3D pwm_samsung_config,
> -	.set_polarity	=3D pwm_samsung_set_polarity,
> +	.apply		=3D pwm_samsung_apply,

You should always provide a .get_state() implementation as well to go
along with .apply().

Thierry

--1GSL5ZULXUIqbbH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmamfwACgkQ3SOs138+
s6FXGxAAsUE+eGORYATsiDq8fdmYVm0geEtSi8O+ozQHEFrE9jJrqLq8ed/GUUTo
CD5f/y3G5mVMpSZ6rDkIILhg8jJRtPJbRf+JXCIM3mvIuW6hrLf36ABAGgHfTDK1
9w+idegNzFNQ4uGyslVPEXwFNevpRE+qucR49entufoCG2JWynWtv0zDi2tEVEL6
yV8w16EyPoF0/zeo1q+z73XiRclTu62PoKIlVWiB54R1W9vYzIjTDDx2CDK8Vhp0
Q/iy6F5er1EOVFWoP1emQZA+9ODD3ONbMibwTfw1LXErLxQCtPwS9zwxzGbr/l7t
jEEjtEoTpavqY7iHF5Jd0wvMogfl/J5aKThWaofiylk+yaWBySe2lAmtwhF3ZuVz
BI015OQLv8MATKe4LutdwiXXwYXq9R62v5AfgRtWn2ToO/pwmVIYV3jhRB1FqwEw
vUSWdjWOKJlf3AMxnKWs/OEEupEYWkTxfMZXj1mB9V1fsp3i6weDczxKiQBHHvJe
j8qa9x8detDe8QoyeQQ/oGptZUig4hFrH4c79XSca3GhUDq0IvYDDiJj2PvfN0p5
JELpxO7hVdpLcsq0Xx5nS0XTfq6nHx7jIM1XcCuDQcXUeXFyHVSnsdBCzzy82zGD
i0ixz1A51qBGLfjEO/dHDLkCCyhFgyUEivqBXQvglNAgk8xMGtM=
=8KYE
-----END PGP SIGNATURE-----

--1GSL5ZULXUIqbbH1--
