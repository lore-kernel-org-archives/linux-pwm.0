Return-Path: <thierry.reding@gmail.com>
Date: Thu, 9 Aug 2018 13:02:32 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Add tracepoint for apply state
Message-ID: <20180809110232.GE21639@ulmo>
References: <20180803140029.29810-1-matthieu.castet@parrot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <20180803140029.29810-1-matthieu.castet@parrot.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: linux-pwm@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 04:00:29PM +0200, Matthieu CASTET wrote:
> This allows to trace pwm with ftrace
>=20
> Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
> ---
>  drivers/pwm/core.c         |  5 ++++
>  include/trace/events/pwm.h | 48 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 include/trace/events/pwm.h

I like this. A couple of comments below.

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6ab1b1f..4342974af31a 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -32,6 +32,9 @@
> =20
>  #include <dt-bindings/pwm/pwm.h>
> =20
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/pwm.h>
> +
>  #define MAX_PWMS 1024
> =20
>  static DEFINE_MUTEX(pwm_lookup_lock);
> @@ -475,6 +478,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pw=
m_state *state)
>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
>  		return 0;
> =20
> +	trace_pwm_apply_state(pwm, state);
> +
>  	if (pwm->chip->ops->apply) {
>  		err =3D pwm->chip->ops->apply(pwm->chip, pwm, state);
>  		if (err)
> diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
> new file mode 100644
> index 000000000000..0c28a76b1f60
> --- /dev/null
> +++ b/include/trace/events/pwm.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pwm
> +
> +#if !defined(_TRACE_PWM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PWM_H
> +
> +#include <linux/pwm.h>
> +#include <linux/tracepoint.h>
> +
> +
> +TRACE_EVENT(pwm_apply_state,
> +
> +	TP_PROTO(struct pwm_device *pwm, struct pwm_state *state),
> +
> +	TP_ARGS(pwm, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name,			pwm->label)
> +		__field(struct pwm_device *,	pwm)
> +		__field(unsigned int,			num)

If we already carry a pointer to the struct pwm_device, why store
separate copies of the name and number?

> +		__field(unsigned int,			period)
> +		__field(unsigned int,			duty_cycle)
> +		__field(enum pwm_polarity,		polarity)
> +		__field(bool,					enabled)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, pwm->label);
> +		__entry->pwm =3D pwm;
> +		__entry->num =3D pwm->pwm;
> +		__entry->period =3D state->period;
> +		__entry->duty_cycle =3D state->duty_cycle;
> +		__entry->polarity =3D state->polarity;
> +		__entry->enabled =3D state->enabled;
> +	),
> +
> +	TP_printk("%s: apply state struct pwm[%p]: pwm%u "
> +		"enabled=3D%d polarity=3D%u period_ns=3D%u duty_ns=3D%u",
> +		  __get_str(name), __entry->pwm, __entry->num,
> +		  __entry->enabled, __entry->polarity,
> +		  __entry->period, __entry->duty_cycle)

Note that not all PWMs have a label assigned to them. Output will look
rather messy if the label is NULL. Also, printing the pointer value
seems somewhat unnecessary to me. There's not really anything we can
derive from that value. Perhaps a better identifier could be derived
=66rom the chip's name and the PWM index concatenated. Something along
these lines:

	TP_printk("applying state to PWM %s.%u: ...",
		  dev_name(__entry->pwm->chip->dev), __entry->pwm->hwpwm,
		  ...);

?

Thierry

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsH0gACgkQ3SOs138+
s6FhVRAAiSzr56ObIEseJQThPwxumt4bhwctn/uLY16pbstFpM9uvNLWpc23W2+E
6xpTHOtvXxWh1rF6KxPCugSTsZC+W4wViEKc3nAQ1LehOsFbUlQyHcAsPMjf+a+r
O8pijsV8Sv9l/M2j7oGS+oXN9q1SZBK3zgLWM5iLXwdwCEFWKXr7DdrOG32PpWY2
SlkENfspUgfywv3dzhhd5gbmZFTc2tB42yNbPhKmx8mCFsyzHbB6kpmo8sZjwC87
8ImPTiw744ZLzMn/1M3xQdx/voB+HF6ov3KN7Rygq6kAfuywKYS2/wB8Qff2dmH/
gTUrsYORsF1DeCRbJbgqLJKtgHO4UYfX3h7eXlWC7c/XJoZOeF2NqACCB5M22zQH
5Bam2pXnbM7js8CXHmBiQk/roH2pMtiZ2tpIU5jEHe/0U2baXRMV+AE+4pE6grKs
AgPcVmtwmnCahNcvlnnz1e3tZpKHhsIO+cbp4vcqyCiz7gW+boFmdTb1ttB9H+BN
lndhmvDxhWxiD9JOCN0BsyMBQ4fXLC9cPYOT8LFH3uDATJhPsvHkjEQTtgw/fsqh
KwKeAZty6KjVph9Rn/jVG8fCFBBxNknmm/ZWTxVd1xTnXNJdO1oLRHLlXBxJTkmW
WvQ+TJoNeuSm2oJ/xJvZFkf3258k9qXU7LZC4h7Fd1dA0EZX/d0=
=fH9z
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
