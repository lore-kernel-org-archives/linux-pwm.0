From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 11/15] pwm: add the core infrastructure to allow
 atomic update
Date: Mon, 20 Jul 2015 10:59:40 +0200
Message-ID: <20150720085939.GL29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-12-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435738921-25027-12-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>
List-Id: linux-pwm@vger.kernel.org


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:57AM +0200, Boris Brezillon wrote:
> Add an ->apply() method to the pwm_ops struct to allow PWM drivers to
> implement atomic update.
> This method will be prefered over the ->enable(), ->disable() and
> ->config() methods if available.
>=20
> Add the pwm_get_state(), pwm_get_default_state() and pwm_apply_state()
> functions for PWM users to be able to use the atomic update feature.
>=20
> Note that the pwm_apply_state() does not guarantee the atomicity of the
> update operation, it all depends on the availability and implementation
> of the ->apply() method.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/core.c  | 110 ++++++++++++++++++++++++++++++++++++++++++++++=
------
>  include/linux/pwm.h |  26 +++++++++++++
>  2 files changed, 124 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 30631f5..6dafd8e 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -238,8 +238,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  	unsigned int i;
>  	int ret;
> =20
> -	if (!chip || !chip->dev || !chip->ops || !chip->ops->config ||
> -	    !chip->ops->enable || !chip->ops->disable || !chip->npwm)
> +	if (!chip || !chip->dev || !chip->ops || (!chip->ops->apply &&
> +	    (!chip->ops->config || !chip->ops->enable ||
> +	     !chip->ops->disable)) || !chip->npwm)
>  		return -EINVAL;

This is becoming really unreadable, perhaps split it into two checks, or
even split out the sanity check on the ops into a separate function to
make the negations easier to read:

	static bool pwm_ops_check(const struct pwm_ops *ops)
	{
		/* driver supports legacy, non-atomic operation */
		if (ops->config && ops->enable && ops->disable)
			return true;

		/* driver supports atomic operation */
		if (ops->apply)
			return true;

		return false;
	}

and then use this:

	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
		return -EINVAL;

	if (!pwm_ops_check(chip->ops))
		return -EINVAL;

>  	mutex_lock(&pwm_lock);
> @@ -430,7 +431,17 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, =
int period_ns)
>  	if (!pwm || duty_ns < 0 || period_ns <=3D 0 || duty_ns > period_ns)
>  		return -EINVAL;
> =20
> -	err =3D pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
> +	if (pwm->chip->ops->apply) {
> +		struct pwm_state state =3D pwm->state;

Shouldn't this use pwm_get_state()?

> +
> +		state.period =3D period_ns;
> +		state.duty_cycle =3D duty_ns;
> +
> +		err =3D pwm->chip->ops->apply(pwm->chip, pwm, &state);
> +	} else {
> +		err =3D pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
> +	}
> +
>  	if (err)
>  		return err;
> =20
> @@ -455,6 +466,17 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pw=
m_polarity polarity)
>  	if (!pwm || !pwm->chip->ops)
>  		return -EINVAL;
> =20
> +	if (pwm->chip->ops->apply) {
> +		struct pwm_state state =3D pwm->state;

Same here.

> +
> +		state.polarity =3D polarity;
> +		err =3D pwm->chip->ops->apply(pwm->chip, pwm, &state);
> +		if (!err)
> +			pwm->state.polarity =3D polarity;
> +
> +		return err;
> +	}
> +
>  	if (!pwm->chip->ops->set_polarity)
>  		return -ENOSYS;
> =20
> @@ -477,17 +499,27 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
>   */
>  int pwm_enable(struct pwm_device *pwm)
>  {
> -	if (pwm && !pwm_is_enabled(pwm)) {
> -		int err;
> +	int err;
> =20
> -		err =3D pwm->chip->ops->enable(pwm->chip, pwm);
> -		if (!err)
> -			pwm->state.enabled =3D true;
> +	if (!pwm)
> +		return -EINVAL;
> =20
> -		return err;
> +	if (pwm_is_enabled(pwm))
> +		return 0;
> +
> +	if (pwm->chip->ops->apply) {
> +		struct pwm_state state =3D pwm->state;

And here.

> +
> +		state.enabled =3D true;
> +		err =3D pwm->chip->ops->apply(pwm->chip, pwm, &state);

There should be a space between the above two lines.

> +	} else {
> +		err =3D pwm->chip->ops->enable(pwm->chip, pwm);
>  	}
> =20
> -	return pwm ? 0 : -EINVAL;
> +	if (!err)
> +		pwm->state.enabled =3D true;
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(pwm_enable);
> =20
> @@ -497,13 +529,67 @@ EXPORT_SYMBOL_GPL(pwm_enable);
>   */
>  void pwm_disable(struct pwm_device *pwm)
>  {
> -	if (pwm && pwm_is_enabled(pwm)) {
> +	if (!pwm || !pwm_is_enabled(pwm))
> +		return;
> +
> +	if (pwm->chip->ops->apply) {
> +		struct pwm_state state =3D pwm->state;
> +
> +		state.enabled =3D false;
> +		pwm->chip->ops->apply(pwm->chip, pwm, &state);
> +	} else {
>  		pwm->chip->ops->disable(pwm->chip, pwm);
> -		pwm->state.enabled =3D false;
>  	}
> +
> +	pwm->state.enabled =3D false;
>  }
>  EXPORT_SYMBOL_GPL(pwm_disable);

Same comments as for pwm_enable().

> =20
> +int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *stat=
e)
> +{
> +	int err =3D 0;
> +
> +	if (!pwm)
> +		return -EINVAL;
> +
> +	if (!memcmp(state, &pwm->state, sizeof(*state)))
> +		return 0;
> +
> +	if (pwm->chip->ops->apply) {
> +		err =3D pwm->chip->ops->apply(pwm->chip, pwm, state);
> +		if (!err)
> +			pwm->state =3D *state;

Maybe we want pwm_set_state() for this?

> +	} else {
> +		/*
> +		 * FIXME: restore the initial state in case of error.
> +		 */
> +		if (state->polarity !=3D pwm->state.polarity) {
> +			pwm_disable(pwm);
> +			err =3D pwm_set_polarity(pwm, state->polarity);
> +			if (err)
> +				goto out;
> +		}
> +
> +		if (state->period !=3D pwm->state.period ||
> +		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> +			err =3D pwm_config(pwm, state->period, state->duty_cycle);
> +			if (err)
> +				goto out;
> +		}
> +
> +		if (state->enabled !=3D pwm->state.enabled) {
> +			if (state->enabled)
> +				err =3D pwm_enable(pwm);
> +			else
> +				pwm_disable(pwm);
> +		}
> +	}
> +
> +out:
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(pwm_apply_state);
> +
>  static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>  {
>  	struct pwm_chip *chip;
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b47244a..7e99679 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -151,6 +151,29 @@ static inline enum pwm_polarity pwm_get_polarity(con=
st struct pwm_device *pwm)
>  	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
>  }
> =20
> +/*
> + * pwm_apply_state - apply a new state to the PWM device
> + */
> +int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *stat=
e);

If you add kerneldoc, please add it properly. It should start with /**
and you need to list at least the parameters and return value.

Thierry

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrLh4AAoJEN0jrNd/PrOhebYP/iXzDlF8FpCj/mFRDHkmYJ/Z
/XznWFvb5KqmcP3lFLsqIdCk78aUHW4cvSYmlv9rKkh9825T8bT/IA6CvthEEEzk
Pl1XIh50R9hrPMzkdS72fTfP/fjeGRgHpAc1y+5g0n7HnPu1X63QBwmHLlLVD3tr
WiWN3WZb+g7ZY6nl8IEd9pJFpl6eWVmmB6fgFHo9+t05PEyjpOPKfuxJmOd1SMaY
MnIBgkyFRPEcFU8ChgJPTQQ3OZNwPot/MWJmYfim/ZvG4WTZNzrYUsZdv0/PDgf8
c/HPLAH3uhnj3SWtOpi5g56F6fla8XOXLFW0YEA18k3M9m4pemLTo30lBo+5PNM6
OVeQ6lQVspNRLZOiyvKspx3fa39Uoz5q3Zxaxm+LjcE9CpAt6U14E2o1Th+SIAqB
bHTC+nod45kyQVYt1VjMGYQRQq+dyCfy2HbtaTymlfZI7cj3n5bpvjDIKvgw35ev
hLWQJ1fZwpghkhxhLoc7aNrPveNP333/u+AeUuAyv5FhB7hjmt+CH9Xjhu+Gck+d
kyGE9c5mHr+JzmxhI16dY90BbDYF5pIVhKiWqF16cqkWWT1ktG3uVHKByxVV3+Dd
FcMc8trK+JeHFyVEZ7SQxP1s+3oaw5DZgXasIa3VMm4l8WebwAQqGbbZsdF3FYSW
WDOkUpGaD9E7MgbruhvN
=ofxb
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--
