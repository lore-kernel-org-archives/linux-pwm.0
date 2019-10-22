Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43059 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387614AbfJVGyj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 02:54:39 -0400
Date: Tue, 22 Oct 2019 08:54:15 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191022065415.2zxmpbsmogvgul7x@pengutronix.de>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-6-git-send-email-jeff@labundy.com>
 <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
 <20191022043649.GB2091@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191022043649.GB2091@labundy.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 5/8] pwm: Add support for Azoteq IQS620A PWM generator
To: Jeff LaBundy <jeff@labundy.com>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

Hello Jeff,

On Mon, Oct 21, 2019 at 11:36:49PM -0500, Jeff LaBundy wrote:
> On Mon, Oct 21, 2019 at 09:34:19AM +0200, Uwe Kleine-K=F6nig wrote:
> > > +struct iqs620_pwm_private {
> > > +	struct iqs62x_core *iqs62x;
> > > +	struct pwm_chip chip;
> > > +	struct notifier_block notifier;
> > > +	bool ready;
> >=20
> > This is always true, so you can drop it.
> >=20
>=20
> This is here because iqs620_pwm_notifier references chip.pwms, which is
> not allocated until after the notifier is registered and pwmchip_add is
> called. So it protects against this (albeit unlikely) race condition:
>=20
> 1. iqs620_pwm_notifier is registered
> 2. Device immediately suffers an asynchronous reset and notifier chain
>    is called (more on that in a bit)
> 3. iqs620_pwm_notifier evaluates chips.pwms (NULL)
>=20
> I felt this was simpler than calling pwmchip_add before registering the
> notifier and adding an error/tear-down path in iqs620_pwm_probe in case
> of failure. I would be happy to add a comment or two to explain the not-
> so-obvious purpose of this flag.

Ah, understood. A comment is definitively necessary here.

> > > +};
> > > +
> > > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > > +			    struct pwm_state *state)
> >=20
> > Since
> >=20
> > 	71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state =
argument")
> >=20
> > this isn't the right prototype.
> >=20
>=20
> Sure thing; I will add the 'const' qualifier and remove the two changes
> to the state argument.
>=20
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +	struct iqs62x_core *iqs62x;
> > > +	int error;
> > > +	int duty_calc =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - =
1;
> > > +	u8 duty_clamp =3D clamp(duty_calc, 0, 0xFF);

Another problem that we have here is that the period is fixed to 1 ms
and if a consumer requests for example:

	.period =3D 5000000,
	.duty_cycle =3D 1000000,

the hardware is actually configured for

	.period =3D 1000000,
	.duty_cycle =3D 1000000,

. I don't have a good suggestion how to fix this. We'd need to
draw a line somewhere and decline a request that is too far from the
result. But where this line should be is not obvious, it should
definitively not be implemented in the driver itself IMHO.

(The only halfway sane approach would be to let lowlevel drivers
implement a .round_state callback and then let the framework judge. But
we're a long way from having that, so that's not a solution for today.)

> > > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> > > +	iqs62x =3D iqs620_pwm->iqs62x;
> > > +
> > > +	error =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE, duty_cla=
mp);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	state->period =3D IQS620_PWM_PERIOD_NS;
> > > +	state->duty_cycle =3D (duty_clamp + 1) * IQS620_PWM_PERIOD_NS / 256;
> >=20
> > This suggests that if the value in the IQS620_PWM_DUTY_CYCLE is 0 the
> > duty cycle is 1/256 ms with a period of 1 ms and the output cannot be
> > constant inactive. If this is right please add a paragraph in the
> > driver's comment at the top:
> >=20
> > 	* Limitations:
> > 	* - The hardware cannot generate a 0% duty cycle
> >=20
> > (Please stick to this format, other drivers use it, too.)
>=20
> That's correct; the lowest duty cycle that can be achieved using only the
> IQS620_PWM_DUTY_CYCLE register is 0.4%. We can, however, generate 0% duty
> cycle by disabling the output altogether using a separate register. Would
> that be better than flat-out saying it's impossible?

There is (maybe) a small difference between disabled and 0% duty cycle,
at least from the framework's POV: If you do:

	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cycle=
 =3D 1000000, });
	pwm_apply_state(pwm, { .enabled =3D false, .period =3D $DC, .duty_cycle =
=3D $DC, });
	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cycle=
 =3D 1000000, });

and compare it to the expected result of

	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cycle=
 =3D 1000000, });
	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cycle=
 =3D 0, });
	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cycle=
 =3D 1000000, });

the difference is that the duration of the inactive phase in the latter
case is a multiple of 1 ms.

There is no policy for lowlevel drivers what to do, but disabling when
0% is requested is at least not unseen and probably more what consumers
expect.

> > How does the hardware behave on changes? For example you're first
> > committing the duty cycle and then on/off. Can it happen that between
> >=20
> > 	pwm_apply_state(pwm, { .duty_cycle =3D 3900, .period =3D 1000000, .ena=
bled =3D true)
> > 	...
> > 	pwm_apply_state(pwm, { .duty_cycle =3D 1000000, .period =3D 1000000, .=
enabled =3D false)
> >=20
> > the output is active for longer than 4 =B5s because the iqs620_pwm_apply
> > function is preempted between the two register writes and so we already
> > have .duty_cycle =3D 1000000 but still .enabled =3D true in the hardwar=
e?
> >=20
>=20
> My results show that it is possible to generate up to two irregular perio=
ds
> by changing the duty cycle while the output is active.
>=20
> Depending on the ratio of old-to-new duty cycle and the position of the I=
2C
> write relative to the asynchronous output, the device may produce one pul=
se
> for which the width represents neither the old nor the new duty cycle.
>=20
> > Does a change complete the currently running period? Does disabling
> > complete the currently running period? If so, does regmap_update_bits
> > block until the new setting is active?
> >=20
>=20
> A quick test reveals the following:
>=20
> * Duty cycle changes may interrupt a running period, i.e., the output may
>   transition in the middle of the period to accommodate the new duty cycl=
e.
> * Disabling the output drives it to zero immediately, i.e., the period do=
es
>   does not run to completion.
>=20
> I will add a 'Limitations' section at the top as other drivers do, and ca=
ll
> these points out specifically.

Great. Thanks.

> > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > +			       unsigned long event_flags, void *context)
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +	struct pwm_state state;
> > > +	int error;
> > > +
> > > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
> > > +				  notifier);
> > > +
> > > +	if (!iqs620_pwm->ready || !(event_flags & BIT(IQS62X_EVENT_SYS_RESE=
T)))
> > > +		return NOTIFY_DONE;
> > > +
> > > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > > +
> > > +	error =3D iqs620_pwm_apply(&iqs620_pwm->chip,
> > > +				 &iqs620_pwm->chip.pwms[0], &state);
> > > +	if (error) {
> > > +		dev_err(iqs620_pwm->chip.dev,
> > > +			"Failed to re-initialize device: %d\n", error);
> > > +		return NOTIFY_BAD;
> > > +	}
> > > +
> > > +	return NOTIFY_OK;
> >=20
> > So the PWM can loose it's state sometimes? When does that happen?
>=20
> That's correct. The device performs an internal soft reset in the presence
> of what it considers to be an I2C timeout error; in this case all registe=
rs
> are restored to their default values.

Is this a theoretic problem or does that happen from time to time?
=20
> The data sheet goes so far as to recommend monitoring for this interrupt =
and
> restoring the device on-the-fly. I have added some comments in iqs62x_irq=
 in
> patch [2/8] which provides some further detail.

Monitoring that interrupt seems reasonable.
=20
> > > +	error =3D devm_add_action_or_reset(&pdev->dev,
> > > +					 iqs620_pwm_notifier_unregister,
> > > +					 iqs620_pwm);
> >=20
> > I wonder if this is safe. If in iqs620_pwm_notifier_unregister()
> > unregistering of the notifier goes wrong (not sure when this can happen)
> > the memory behind iqs620_pwm goes away. Then later iqs620_pwm_notifier
> > might be called trying to use *iqs620_pwm ...
>=20
> I think this is purely theoretical, as blocking_notifier_chain_unregister
> only fails if the notifier is not found in the chain. If for some reason
> blocking_notifier_chain_register fails (which currently cannot happen, as
> it always returns zero), the driver will fail to probe before the action
> could be added.
>=20
> This of course means the error message in iqs620_pwm_notifier_unregister
> is unnecessary; it is simply provided for debug/visibility.

I'd suggest to do the unregister call in the remove callback which you
have for pwm unregistration anyhow. Or alternatively implement a devm_
variant of the notifier registration that explains in the comments that
it is safe.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
