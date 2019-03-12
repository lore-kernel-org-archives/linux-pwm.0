From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Tue, 12 Mar 2019 13:12:18 +0100
Message-ID: <20190312121218.GM31026@ulmo>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
 <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yash Shah <yash.shah@sifive.com>, palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 10:17:39AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> there are just a few minor things left I commented below.
>=20
> On Tue, Mar 12, 2019 at 01:41:29PM +0530, Yash Shah wrote:
> > +#define div_u64_round(a, b) \
> > +	({typeof(b) __b =3D b; div_u64((a) + __b / 2, __b); })
>=20
> Parenthesis around b please. I guess I didn't had them in my suggestion
> either, sorry for that.

We don't really need the parentheses here, do we? The only operator that
has lower priority than the assignment is the comma operator, and that's
not going to work in the macro anyway, unless you put it inside a pair
of parentheses, in which case, well, you have the parentheses already.

> > +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> > +{
> > +	struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +	int ret;
> > +
> > +	if (enable) {
> > +		ret =3D clk_enable(pwm->clk);
> > +		if (ret) {
> > +			dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (!enable)
> > +		clk_disable(pwm->clk);
> > +
> > +	return 0;
> > +}
>=20
> There is only a single caller for this function. I wonder if it is
> trivial enough to fold it into pwm_sifive_apply.

I think this is fine. pwm_sifive_apply() is already fairly long at this
point, so might as well split things up a little.

> > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *=
dev,
> > +			    struct pwm_state *state)
> > +{
> > +	struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +	unsigned int duty_cycle;
> > +	u32 frac;
> > +	struct pwm_state cur_state;
> > +	bool enabled;
> > +	int ret =3D 0;
> > +	unsigned long num;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +		return -EINVAL;
> > +
> > +	ret =3D clk_enable(pwm->clk);
> > +	if (ret) {
> > +		dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	mutex_lock(&pwm->lock);
> > +	pwm_get_state(dev, &cur_state);
> > +
> > +	enabled =3D cur_state.enabled;
> > +
> > +	if (state->period !=3D pwm->approx_period) {
> > +		if (pwm->user_count !=3D 1) {
> > +			ret =3D -EBUSY;
> > +			goto exit;
> > +		}
> > +		pwm->approx_period =3D state->period;
> > +		pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> > +	}
> > +
> > +	duty_cycle =3D state->duty_cycle;
> > +	if (!state->enabled)
> > +		duty_cycle =3D 0;
> > +
> > +	num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> > +	frac =3D div_u64_round(num, state->period);
> > +	/* The hardware cannot generate a 100% duty cycle */
> > +	frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > +
> > +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 +
> > +	       dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +	if (state->enabled !=3D enabled) {
> > +		ret =3D pwm_sifive_enable(chip, state->enabled);
> > +		if (ret)
> > +			goto exit;
>=20
> This goto is a noop.
>=20
> > +	}
> > +
> > +exit:
> > +	clk_disable(pwm->clk);
> > +	mutex_unlock(&pwm->lock);
> > +	return ret;
> > +}
>=20
> There are a few other things that could be improved, but I think they
> could be addressed later. For some of these I don't even know what to
> suggest, for some Thierry might not agree it is worth fixing:
>=20
>  - rounding
>    how to round? When should a request declined, when is rounding ok?
>    There is still "if (state->period !=3D pwm->approx_period) return -EBU=
SY"
>    in this driver. This is better than before, but if state-period =3D=3D
>    pwm->approx_period + 1 the result (if accepted) might be the same as
>    without the +1 and so returning -EBUSY for one case and accepting the
>    other is strange.

Perhaps a good idea would be to reject a configuration only after we've
determined that it is incompatible? If we're really going to end up with
the same configuration within a given margin of period or duty cycle and
we can't do much about it, there's little point in rejecting such
configurations.

>  - don't call PWM API functions designed for consumers (here: pwm_get_sta=
te)

Agreed. The driver can just access pwm_device.state directly.

>  - Move div_u64_round to include/linux/math64.h

Looks to me like DIV_ROUND_CLOSEST_ULL() is already pretty much this.
The only difference that I can see is that the divisor is 32-bit, but
since we pass in state->period, that already works fine.

Thierry

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHoh8ACgkQ3SOs138+
s6E7lw/8CwEa+SQ6iOIiC0QTSowiTzEaVGxw+bbwyxGkg7BXfvg6iLEzK+ZhsIU4
NyA0Q2/u8dP6lFawnP5kzMcjzYeKDbBq5hpfjv+JVGaLOo4KdCfVI5rNyrtv68Cz
Gp0J8SxekNcqGwXp19oYLy5HyaIxZupDAPGkdKmVQn4Khxj2wee4kBj3BoSDRCyh
/deUWdxme4U5RurMMiDTeS6MMiXubCZjS/ITjzDCvrroVlWzC10ATPZObZ1jJPI4
UljScKJgZwCHLfuZN8X+dXQGCHHJ25kLmnXpouPM84JsypKqKqhmN3ngwdVdg9Vn
YOrGOXoemgKXMpuKAKDg3Oc+Ys+1kmODm7PnrxAOX8Q6Vb+C7H9KMIKVBZpIcbfX
jJwYrXcDxwW+5bA+mPDUBLQxUdxcEq0FheOLDjHQefnQGWu1NZoyLeHGITIS72/D
KcKVqijEMR5SoGyIFLdq1Ua03YFfYl2b4WOuWRFd3KxcqZ+rdenC9uzCw57JFF28
n35rUWNpTbuQYdhTzkNcdP2Tf2joG0cPvN8+5adW7SwAHSUQgAipFFOt/2ldL0+c
tay4eC7LxSZ5sBqxPdIbH3P1iAsVtbxlpL/640lg5U5eBawVH5ewpOe7hVBtEoKn
Rn2nfqndVJHWZg1YxZsC8RIx0ylD1/YhnP+tRJhvZOEwjf4dq2Q=
=iW8+
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--
