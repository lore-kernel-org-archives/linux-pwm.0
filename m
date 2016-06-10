From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/13] pwm: Add new helpers to create/manipulate PWM
 states
Date: Fri, 10 Jun 2016 17:21:09 +0200
Message-ID: <20160610152109.GQ27142@ulmo.ba.sec>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465403688-17098-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oN4OvwWIcd1E23D1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465403688-17098-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pwm@vger.kernel.org


--oN4OvwWIcd1E23D1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 06:34:36PM +0200, Boris Brezillon wrote:
> The pwm_prepare_new_state() helper prepares a new state object
> containing the current PWM state except for the polarity and period
> fields which are set to the reference values.
> This is particurly useful for PWM users who want to apply a new
> duty-cycle expressed relatively to the reference period without
> changing the enable state.
>=20
> The PWM framework expect PWM users to configure the duty cycle in
> nanosecond, but most users just want to express this duty cycle
> relatively to the period value (i.e. duty_cycle =3D 33% of the period).
> Add pwm_{get,set}_relative_duty_cycle() helpers to ease this kind of
> conversion.

This looks pretty useful and good, though I think these could be two
separate patches. A couple of suggestions on wording and such below.

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/pwm.h | 81 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 81 insertions(+)
>=20
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 17018f3..e09babf 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -148,6 +148,87 @@ static inline void pwm_get_args(const struct pwm_dev=
ice *pwm,
>  }
> =20
>  /**
> + * pwm_prepare_new_state() - prepare a new state to be applied with
> + *			     pwm_apply_state()

This is weirdly indented.

> + * @pwm: PWM device
> + * @state: state to fill with the prepared PWM state
> + *
> + * This functions prepares a state that can later be tweaked and applied
> + * to the PWM device with pwm_apply_state(). This is a convenient functi=
on
> + * that first retrieves the current PWM state and the replaces the period
> + * and polarity fields with the reference values defined in pwm->args.
> + * Once the new state is created you can adjust the ->enable and ->duty_=
cycle

"created" has the connotation of allocating. Perhaps: "Once the function
returns, you can adjust the ->enabled and ->duty_cycle fields according
to your needs before calling pwm_apply_state()."?

Also note that the field is called ->enabled.

> + * according to your need before calling pwm_apply_state().

Maybe mention that the ->duty_cycle field is explicitly zeroed. Then
again, do we really need it? If users are going to overwrite it anyway,
do we even need to bother? I suppose it makes some sense because the
current duty cycle is stale when the ->period gets set to the value from
args. I think the documentation should mention this in some way.

> + */
> +static inline void pwm_prepare_new_state(const struct pwm_device *pwm,
> +					 struct pwm_state *state)

Perhaps choose a shorter name, such as: pwm_init_state()?

> +{
> +	struct pwm_args args;
> +
> +	/* First get the current state. */
> +	pwm_get_state(pwm, state);
> +
> +	/* Then fill it with the reference config */
> +	pwm_get_args(pwm, &args);
> +
> +	state->period =3D args.period;
> +	state->polarity =3D args.polarity;
> +	state->duty_cycle =3D 0;
> +}
> +
> +/**
> + * pwm_get_relative_duty_cycle() - Get a relative duty_cycle value
> + * @state: the PWM state to extract period and duty_cycle from
> + * @scale: the scale you want to use for you relative duty_cycle value

Other kerneldoc comments in this file don't prefix the description with
"the".

Also, perhaps the following descriptions would be slightly less
confusing:

	@state: PWM state to extract the duty cycle from

We don't extract (i.e. return) period from the state, so it's a little
confusing to mention it here.

	@scale: scale in which to return the relative duty cycle

This is slightly more explicit in that it says what the returned duty
cycle will be in. Perhaps as an alternative:

	@scale: target scale of the relative duty cycle

> + *
> + * This functions converts the absolute duty_cycle stored in @state
> + * (expressed in nanosecond) into a relative value.

Perhaps: "... into a value relative to the period."?

> + * For example if you want to get the duty_cycle expressed in nanosecond,

The example below would give you the duty cycle in percent, not
nanoseconds, right?

> + * call:
> + *
> + * pwm_get_state(pwm, &state);
> + * duty =3D pwm_get_relative_duty_cycle(&state, 100);
> + */
> +static inline unsigned int
> +pwm_get_relative_duty_cycle(const struct pwm_state *state, unsigned int =
scale)
> +{
> +	if (!state->period)
> +		return 0;
> +
> +	return DIV_ROUND_CLOSEST_ULL((u64)state->duty_cycle * scale,
> +				     state->period);
> +}
> +
> +/**
> + * pwm_set_relative_duty_cycle() - Set a relative duty_cycle value
> + * @state: the PWM state to fill
> + * @val: the relative duty_cycle value
> + * @scale: the scale you use for you relative duty_cycle value

"scale in which @duty_cycle is expressed"?

> + *
> + * This functions converts a relative duty_cycle stored into an absolute
> + * one (expressed in nanoseconds), and put the result in state->duty_cyc=
le.
> + * For example if you want to change configure a 50% duty_cycle, call:
> + *
> + * pwm_prepare_new_state(pwm, &state);
> + * pwm_set_relative_duty_cycle(&state, 50, 100);
> + * pwm_apply_state(pwm, &state);
> + */
> +static inline void
> +pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int val,

Any reason why we can't call "val" "duty_cycle"? That's what it is,
after all.

> +			    unsigned int scale)
> +{
> +	if (!scale)
> +		return;
> +
> +	/* Make sure we don't have duty_cycle > period */
> +	if (val > scale)
> +		val =3D scale;

Can we return -EINVAL for both of the above checks? I don't like
silently clamping the duty cycle that the user passed in.

Thierry

--oN4OvwWIcd1E23D1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWtriAAoJEN0jrNd/PrOhVakQAJ46vixDAco1vy98SBEiX0t8
YarDZyV3gQyM6muAxwOyErgFO/c71XIMELtQzKKjfoRTYmcGamVX7er5/ykS1l6/
T1tD1lkL5geObe5RKYsZQ9vc4ifljg49kAhWgtzCaMiOmpa6LOGDNDTTntqATKVP
C/QhO6dj3E4pASURNzh88dN0YRXf+vcxORf+xfW6PeTDS8gQ6u5w13UoXT71yM4/
JaSgUBCvZP+/sttrlXMplSOIYLumx6ywf/niB+tKrSgS0MTh2YXmWZ8bNGlo3bAK
HprkBwWIjWTD0em6JVYn7/iHr58aS1zDyArKbJluLNVsxW9z089K21/27j+zOsqz
qTp9zM73dsv9kU4v1UODaskd7D78YtXC+oDRQP7DNSl54Bu8ev2OhpLcuWV6aI4+
bqEnphuvDaHRVJm4mDduumFlpHU9Z/PpPYFeHS4VxZSam85ImGhFsY00hseedAii
DipBMomujvFU36DzCZv2Zu3Kb077aJlw90xnoRQq/25TNFbHepEt7AcAt2pM2B19
xtQka5F6NNXTKSjn0xttXEyenofGLfna9AZ8nmTxGE7pP3B3QQnJsVUV6La6FEli
o+q0jKY6T930dNdOnv0HcEGWXvAhStjc+lHclm8mu9i0UOfDs/8VeERpiuLxbJj4
U/Q81ioXy8AAAnDNyb1l
=MVbl
-----END PGP SIGNATURE-----

--oN4OvwWIcd1E23D1--
