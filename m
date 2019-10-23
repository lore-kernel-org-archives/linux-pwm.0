Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from p3plsmtpa11-10.prod.phx3.secureserver.net ([68.178.252.111]:49013
        "EHLO p3plsmtpa11-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389384AbfJWCwr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 22:52:47 -0400
Date: Tue, 22 Oct 2019 21:45:25 -0500
From: Jeff LaBundy <jeff@labundy.com>
Message-ID: <20191023024525.GC3233@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-6-git-send-email-jeff@labundy.com>
 <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
 <20191022043649.GB2091@labundy.com>
 <20191022065415.2zxmpbsmogvgul7x@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191022065415.2zxmpbsmogvgul7x@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 5/8] pwm: Add support for Azoteq IQS620A PWM generator
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

Hi Uwe,

On Tue, Oct 22, 2019 at 08:54:15AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Jeff,
>=20
> On Mon, Oct 21, 2019 at 11:36:49PM -0500, Jeff LaBundy wrote:
> > On Mon, Oct 21, 2019 at 09:34:19AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > +struct iqs620_pwm_private {
> > > > +	struct iqs62x_core *iqs62x;
> > > > +	struct pwm_chip chip;
> > > > +	struct notifier_block notifier;
> > > > +	bool ready;
> > >=20
> > > This is always true, so you can drop it.
> > >=20
> >=20
> > This is here because iqs620_pwm_notifier references chip.pwms, which is
> > not allocated until after the notifier is registered and pwmchip_add is
> > called. So it protects against this (albeit unlikely) race condition:
> >=20
> > 1. iqs620_pwm_notifier is registered
> > 2. Device immediately suffers an asynchronous reset and notifier chain
> >    is called (more on that in a bit)
> > 3. iqs620_pwm_notifier evaluates chips.pwms (NULL)
> >=20
> > I felt this was simpler than calling pwmchip_add before registering the
> > notifier and adding an error/tear-down path in iqs620_pwm_probe in case
> > of failure. I would be happy to add a comment or two to explain the not-
> > so-obvious purpose of this flag.
>=20
> Ah, understood. A comment is definitively necessary here.
>=20

Sure thing; will do.

> > > > +};
> > > > +
> > > > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > > > +			    struct pwm_state *state)
> > >=20
> > > Since
> > >=20
> > > 	71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the stat=
e argument")
> > >=20
> > > this isn't the right prototype.
> > >=20
> >=20
> > Sure thing; I will add the 'const' qualifier and remove the two changes
> > to the state argument.
> >=20
> > > > +{
> > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > +	struct iqs62x_core *iqs62x;
> > > > +	int error;
> > > > +	int duty_calc =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS =
- 1;
> > > > +	u8 duty_clamp =3D clamp(duty_calc, 0, 0xFF);
>=20
> Another problem that we have here is that the period is fixed to 1 ms
> and if a consumer requests for example:
>=20
> 	.period =3D 5000000,
> 	.duty_cycle =3D 1000000,
>=20
> the hardware is actually configured for
>=20
> 	.period =3D 1000000,
> 	.duty_cycle =3D 1000000,
>=20
> . I don't have a good suggestion how to fix this. We'd need to
> draw a line somewhere and decline a request that is too far from the
> result. But where this line should be is not obvious, it should
> definitively not be implemented in the driver itself IMHO.
>=20
> (The only halfway sane approach would be to let lowlevel drivers
> implement a .round_state callback and then let the framework judge. But
> we're a long way from having that, so that's not a solution for today.)
>=20

Agreed on all counts. For now, I will mention in the 'Limitations' heading =
that
the period cannot be adjusted.

> > > > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip=
);
> > > > +	iqs62x =3D iqs620_pwm->iqs62x;
> > > > +
> > > > +	error =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE, duty_c=
lamp);
> > > > +	if (error)
> > > > +		return error;
> > > > +
> > > > +	state->period =3D IQS620_PWM_PERIOD_NS;
> > > > +	state->duty_cycle =3D (duty_clamp + 1) * IQS620_PWM_PERIOD_NS / 2=
56;
> > >=20
> > > This suggests that if the value in the IQS620_PWM_DUTY_CYCLE is 0 the
> > > duty cycle is 1/256 ms with a period of 1 ms and the output cannot be
> > > constant inactive. If this is right please add a paragraph in the
> > > driver's comment at the top:
> > >=20
> > > 	* Limitations:
> > > 	* - The hardware cannot generate a 0% duty cycle
> > >=20
> > > (Please stick to this format, other drivers use it, too.)
> >=20
> > That's correct; the lowest duty cycle that can be achieved using only t=
he
> > IQS620_PWM_DUTY_CYCLE register is 0.4%. We can, however, generate 0% du=
ty
> > cycle by disabling the output altogether using a separate register. Wou=
ld
> > that be better than flat-out saying it's impossible?
>=20
> There is (maybe) a small difference between disabled and 0% duty cycle,
> at least from the framework's POV: If you do:
>=20
> 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cyc=
le =3D 1000000, });
> 	pwm_apply_state(pwm, { .enabled =3D false, .period =3D $DC, .duty_cycle =
=3D $DC, });
> 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cyc=
le =3D 1000000, });
>=20
> and compare it to the expected result of
>=20
> 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cyc=
le =3D 1000000, });
> 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cyc=
le =3D 0, });
> 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_cyc=
le =3D 1000000, });
>=20
> the difference is that the duration of the inactive phase in the latter
> case is a multiple of 1 ms.
>=20
> There is no policy for lowlevel drivers what to do, but disabling when
> 0% is requested is at least not unseen and probably more what consumers
> expect.
>=20

With the change I am proposing, the output will be driven to zero if enable=
d =3D false
OR duty_cycle < 4000 ns. Stated another way:

enable duty_cycle IQS620_PWR_SETTINGS[7] IQS620_PWM_DUTY_CYCLE
------ ---------- ---------------------- ---------------------
  0    don't care           0                  don't care
  1    0 ... 3999           0                  don't care
  1    4000 ... x           1                      0
  1    x+1  ... y           1                      1

...and so on. For context, if IQS620_PWR_SETTINGS[7] =3D 0 then the output =
is held to
zero. If IQS620_PWR_SETTINGS[7] =3D 1 then the output toggles at a duty cyc=
le between
0.4% and 100% as a function of IQS620_PWM_DUTY_CYCLE.

Based on how the device behaves in response to its two available registers,=
 I think
your two examples will appear equal, but please let me know if I have under=
stood.

> > > How does the hardware behave on changes? For example you're first
> > > committing the duty cycle and then on/off. Can it happen that between
> > >=20
> > > 	pwm_apply_state(pwm, { .duty_cycle =3D 3900, .period =3D 1000000, .e=
nabled =3D true)
> > > 	...
> > > 	pwm_apply_state(pwm, { .duty_cycle =3D 1000000, .period =3D 1000000,=
 .enabled =3D false)
> > >=20
> > > the output is active for longer than 4 =B5s because the iqs620_pwm_ap=
ply
> > > function is preempted between the two register writes and so we alrea=
dy
> > > have .duty_cycle =3D 1000000 but still .enabled =3D true in the hardw=
are?
> > >=20
> >=20
> > My results show that it is possible to generate up to two irregular per=
iods
> > by changing the duty cycle while the output is active.
> >=20
> > Depending on the ratio of old-to-new duty cycle and the position of the=
 I2C
> > write relative to the asynchronous output, the device may produce one p=
ulse
> > for which the width represents neither the old nor the new duty cycle.
> >=20
> > > Does a change complete the currently running period? Does disabling
> > > complete the currently running period? If so, does regmap_update_bits
> > > block until the new setting is active?
> > >=20
> >=20
> > A quick test reveals the following:
> >=20
> > * Duty cycle changes may interrupt a running period, i.e., the output m=
ay
> >   transition in the middle of the period to accommodate the new duty cy=
cle.
> > * Disabling the output drives it to zero immediately, i.e., the period =
does
> >   does not run to completion.
> >=20
> > I will add a 'Limitations' section at the top as other drivers do, and =
call
> > these points out specifically.
>=20
> Great. Thanks.
>=20
> > > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > > +			       unsigned long event_flags, void *context)
> > > > +{
> > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > +	struct pwm_state state;
> > > > +	int error;
> > > > +
> > > > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
> > > > +				  notifier);
> > > > +
> > > > +	if (!iqs620_pwm->ready || !(event_flags & BIT(IQS62X_EVENT_SYS_RE=
SET)))
> > > > +		return NOTIFY_DONE;
> > > > +
> > > > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > > > +
> > > > +	error =3D iqs620_pwm_apply(&iqs620_pwm->chip,
> > > > +				 &iqs620_pwm->chip.pwms[0], &state);
> > > > +	if (error) {
> > > > +		dev_err(iqs620_pwm->chip.dev,
> > > > +			"Failed to re-initialize device: %d\n", error);
> > > > +		return NOTIFY_BAD;
> > > > +	}
> > > > +
> > > > +	return NOTIFY_OK;
> > >=20
> > > So the PWM can loose it's state sometimes? When does that happen?
> >=20
> > That's correct. The device performs an internal soft reset in the prese=
nce
> > of what it considers to be an I2C timeout error; in this case all regis=
ters
> > are restored to their default values.
>=20
> Is this a theoretic problem or does that happen from time to time?
> =20

This event can occur if the I2C master stalls a transaction for 10's of ms.=
 It's
not a theoretical problem, but it should not happen during normal circumsta=
nces.

> > The data sheet goes so far as to recommend monitoring for this interrup=
t and
> > restoring the device on-the-fly. I have added some comments in iqs62x_i=
rq in
> > patch [2/8] which provides some further detail.
>=20
> Monitoring that interrupt seems reasonable.
> =20
> > > > +	error =3D devm_add_action_or_reset(&pdev->dev,
> > > > +					 iqs620_pwm_notifier_unregister,
> > > > +					 iqs620_pwm);
> > >=20
> > > I wonder if this is safe. If in iqs620_pwm_notifier_unregister()
> > > unregistering of the notifier goes wrong (not sure when this can happ=
en)
> > > the memory behind iqs620_pwm goes away. Then later iqs620_pwm_notifier
> > > might be called trying to use *iqs620_pwm ...
> >=20
> > I think this is purely theoretical, as blocking_notifier_chain_unregist=
er
> > only fails if the notifier is not found in the chain. If for some reason
> > blocking_notifier_chain_register fails (which currently cannot happen, =
as
> > it always returns zero), the driver will fail to probe before the action
> > could be added.
> >=20
> > This of course means the error message in iqs620_pwm_notifier_unregister
> > is unnecessary; it is simply provided for debug/visibility.
>=20
> I'd suggest to do the unregister call in the remove callback which you
> have for pwm unregistration anyhow. Or alternatively implement a devm_
> variant of the notifier registration that explains in the comments that
> it is safe.

Sure thing; I'll unregister the notifier in iqs620_pwm_remove.

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>=20

Kind regards,
Jeff LaBundy
