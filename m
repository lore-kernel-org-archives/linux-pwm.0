From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
Date: Fri, 6 Nov 2015 16:18:16 +0100
Message-ID: <20151106151816.GD8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 10:32:39PM +0100, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> Some hardware PWM's have the possibility to only send out one (or more)
> pulses. This can be quite a useful feature in case one wants or needs
> only a single pulse, but at the exact width.
>=20
> Additionally, if multiple pulses are possible, outputting a fixed amount
> of pulses can be useful for various timing specific purposes.

I see how theoretically this would be nice to have. But I'm reluctant to
merge this feature if there aren't any users. What drivers in the kernel
would want to use this feature? Are there new drivers being worked on
that will need this?

> A few new functions have been expanded or added for this new behavior.
>=20
> * pwm_config()	now takes an additional parameter to setup the number of
> 		pulses to output. The driver may force this to 0 or 1
> 		for if example if this feature is not or only partially
> 		supported

This is problematic because you need to atomically update all drivers
and users (the kbuild robot already told you that you didn't do this).
To make things easier I suggest you wait with this change until the
atomic PWM patches have been merged, at which point it should become a
lot easier to deal with this kind of extension.

> * pwm_[sg]et_pulse_count()	get or set the number of pulses the pwm
> 				framework is configured for
> * pwm_get_pulse_count_max()	get the maximum number of pulses the pwm
> 				driver supports
> * pwm_pulse()		Tell the PWM to emit a pre-configured number of pulses

Isn't this essentially the same as pwm_enable()? I'd think that if the
PWM is configured to output pulses, then pwm_enable() would simply do
what it's been configured to do (emit the pulses). Why the need for an
additional function?

> * pwm_pulse_done()	an internal function for drivers to call when
> 			they have completed their pre-configured number
> 			of pulses
> * pwm_is_pulsing()	tells the callers if the pwm is busy pulsing,
> 			yielding a little more information than just
> 			pwm_is_enabled()

Similarily, I'd think that once the PWM is done executing the series of
pulses that it was configured for it would be automatically disabled. A
consumer could then simply use pwm_is_enabled() and drivers could call
pwm_disable() on their PWM to mark them as disabled when they're done
pulsing.

> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/core.c      | 30 +++++++++++++++++++----
>  drivers/pwm/pwm-gpio.c  |  3 ++-
>  drivers/pwm/pwm-sun4i.c |  3 ++-
>  drivers/pwm/sysfs.c     | 58 ++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/pwm.h     | 64 +++++++++++++++++++++++++++++++++++++++++++=
+++---
>  5 files changed, 147 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3f9df3e..e2c1c0a 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -432,22 +432,29 @@ EXPORT_SYMBOL_GPL(pwm_free);
>   * @pwm: PWM device
>   * @duty_ns: "on" time (in nanoseconds)
>   * @period_ns: duration (in nanoseconds) of one cycle
> + * @pulse_count: number of pulses (periods) to output on pwm_pulse
>   *
>   * Returns: 0 on success or a negative error code on failure.
>   */
> -int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns,
> +	       unsigned int pulse_count)

Like I said, this is problematic because every driver and every consumer
now needs to be aware of pulsing. Once the PWM atomic patches are merged
this will become easier to do because the pulse configuration would be a
part of the atomic state, and hence can be conveniently ignored by users
and driver alike.

Thierry

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPMS1AAoJEN0jrNd/PrOheT8P/0ahk2hZVEkfUYTKgupp9rJq
yMVEjNCdP690C4zIjFxrungsXTJkKZzRL0GH+mciOtL2+xeIN7x+SRxbbYbnVx1m
AvCJnRBf2JfKHupRFYc9Bw7hcSdCiZ3477vLmBafrNiDtCHaF5xi2h+i6Gm4MIYV
GNmyEaN9Cp7+xusT7qQ6ax2dgItE/8+aS9aWZRbWFEsJASwoR+XSR2WEPIXQm9EB
Kr5txE3kuWAs6WWPxpfV8ojIsu1mQ5KELUq+TnUwN9Fic31u+IAZ8i693QzlYYys
+roa0zRqCUIpwHl9wvpP5iSR0NTyLybxd61J6BC2lLTHFDvLNsVMrpiBLTDB68uo
6cLqNAu0zSh0jtoOb4EuHLI6NT8yGIGIjlZMpFX/02VwOhzCbOX12nQeYp8mU/Oc
RSaKF5q2mQWK41f5ioz4jTQsbuay18iVQgJfE8lXZdwKKLO+WTyoeAGN9UQ5cDkW
h/CRexmpiEQRZiPiP4Oxbt701HAenFQ+kZ8huRbVgmOTX1y8yFMOjMTYpFOrht6B
xEeEjCHx/dsuLEhpAT0ktX5filvT0ChDN06QEt77VB+n4medUz0IVq2tG5xn2lmy
+POV4fJUlRUcEslUP0B0576dgoRftlM54v1Q/RDr9s9v3SNTHxykX4Otz77ypB3m
g2fmdMv3lMPUKXMoOUc+
=Zyp0
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
