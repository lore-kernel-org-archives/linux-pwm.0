Return-path: <kernel-bounces@pengutronix.de>
From: Jeff LaBundy <jeff@labundy.com>
Date: Sun, 15 Dec 2019 20:36:12 +0000
Message-ID: <20191215203607.GA31390@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
In-Reply-To: <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <52ADE1996F704F4A9392668FF35EBED6@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>
List-ID: <linux-pwm.vger.kernel.org>

Hi Uwe,

On Tue, Dec 10, 2019 at 08:22:27AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Jeff,
>=20
> On Tue, Dec 10, 2019 at 12:03:02AM +0000, Jeff LaBundy wrote:
> > On Mon, Dec 09, 2019 at 08:32:06AM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Dec 09, 2019 at 12:38:36AM +0000, Jeff LaBundy wrote:
> > > > This patch adds support for the Azoteq IQS620A, capable of generati=
ng
> > > > a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive=
).
> > > >=20
> > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Merged 'Copyright' and 'Author' lines into one in introductory =
comments
> > > >   - Added 'Limitations' section to introductory comments
> > > >   - Replaced 'error' with 'ret' throughout
> > > >   - Added const qualifier to state argument of iqs620_pwm_apply and=
 removed all
> > > >     modifications to the variable's contents
> > > >   - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the =
requested
> > > >     polarity is inverted or the requested period is below 1 ms, res=
pectively
> > > >   - Updated iqs620_pwm_apply to disable the PWM output if duty cycl=
e is zero
> > > >   - Added iqs620_pwm_get_state
> > > >   - Eliminated tabbed alignment of pwm_ops and platform_driver stru=
ct members
> > > >   - Moved notifier unregistration to already present iqs620_pwm_rem=
ove, which
> > > >     eliminated the need for a device-managed action and ready flag
> > > >   - Added a comment in iqs620_pwm_probe to explain the order of ope=
rations
> > > >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TES=
T
> > > >=20
> > > >  drivers/pwm/Kconfig       |  10 +++
> > > >  drivers/pwm/Makefile      |   1 +
> > > >  drivers/pwm/pwm-iqs620a.c | 206 ++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 217 insertions(+)
> > > >  create mode 100644 drivers/pwm/pwm-iqs620a.c
> > > >=20
> > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > index bd21655..60bcf6c 100644
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -222,6 +222,16 @@ config PWM_IMX_TPM
> > > >  	  To compile this driver as a module, choose M here: the module
> > > >  	  will be called pwm-imx-tpm.
> > > >=20
> > > > +config PWM_IQS620A
> > > > +	tristate "Azoteq IQS620A PWM support"
> > > > +	depends on MFD_IQS62X || COMPILE_TEST
> > > > +	help
> > > > +	  Generic PWM framework driver for the Azoteq IQS620A multi-funct=
ion
> > > > +	  sensor.
> > > > +
> > > > +	  To compile this driver as a module, choose M here: the module w=
ill
> > > > +	  be called pwm-iqs620a.
> > > > +
> > > >  config PWM_JZ4740
> > > >  	tristate "Ingenic JZ47xx PWM support"
> > > >  	depends on MACH_INGENIC
> > > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > > index 9a47507..a59c710 100644
> > > > --- a/drivers/pwm/Makefile
> > > > +++ b/drivers/pwm/Makefile
> > > > @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
> > > >  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
> > > >  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
> > > >  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> > > > +obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
> > > >  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> > > >  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> > > >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> > > > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > > > new file mode 100644
> > > > index 0000000..1ea11b9
> > > > --- /dev/null
> > > > +++ b/drivers/pwm/pwm-iqs620a.c
> > > > @@ -0,0 +1,206 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Azoteq IQS620A PWM Generator
> > > > + *
> > > > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > > > + *
> > > > + * Limitations:
> > > > + * - The period is not guaranteed to run to completion when the du=
ty cycle is
> > > > + *   changed or the output is disabled.
> > >=20
> > > Do you know more details here? "not guaranteed" means that the new
> > > period starts immediately when duty_cycle or the enabled bit is writt=
en?
> > >=20
> >=20
> > Increasing the duty cycle on-the-fly (e.g. 25% to 75%) results in the
> > following behavior (depending on where the I2C write falls):
> >=20
> >                        I2C write
> >    __        __        __  V_    ______    ______    ______    __
> > __|  |______|  |______|  |_|x|__|      |__|      |__|      |__|
> >   ^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^
> >=20
> > The PWM continues to tick at 1 ms, but the currently running period suf=
fers
> > an extraneous pulse as the output is abruptly set high to "catch up" to=
 the
> > new duty cycle.
> >=20
> > A similar behavior can occur if the duty cycle is decreased, meaning th=
e
> > output is abruptly set low if the I2C transaction completes in what has
> > suddenly become the inactive region of the currently running period.
> >=20
> > The PWM seems to be a simple counter that rolls over at a period of 1 m=
s.
> > Both the counter and the IQS620_PWM_DUTY_CYCLE register effectively go =
to
> > a comparator whose output is ANDed with IQS620_PWR_SETTINGS_PWM_OUT whi=
ch
> > then drives the PWM output.
> >=20
> > As such, if either IQS620_PWM_DUTY_CYCLE or IQS620_PWR_SETTINGS_PWM_OUT
> > change, so may the PWM output state depending on the counter's value at
> > the time the I2C write is completed within the 1-ms continuous loop.
> >=20
> > For v3 I will update the note as follows:
> >=20
> > - Changes in duty cycle or enable/disable state are immediately reflect=
ed
> >   by the PWM output and are not aligned to the start of any period.
>=20
> I'd like to see a bit more information in the driver. Something about
> the 1ms rhythm being unaffected by the duty_cycle and enable setting.
> Maybe:
>=20
>  - The periods run continuously with a fixed length of 1 ms which is
>    unaffected by register updates. Writing duty cycle or enable
>    registers gets active immediately which might result in glitches.
>=20
> ?
>=20

I adjusted the wording a bit as per my preference and settled on the
following:

  - The period is fixed to 1 ms and is generated continuously despite chang=
es
    to the duty cycle or enable/disable state.
  - Changes to the duty cycle or enable/disable state take effect immediate=
ly
    and may result in a glitch during the period in which the change is mad=
e.

I believe these capture the spirit of your message; please let me know if
you have any concerns.

Upon further experimentation, I found that disabling the output (which v2
does so as to simulate a 0% duty cycle) does not actively drive zero, but
rather places the output in a high-impedance state with only the device's
own internal leakage eventually discharging the pin.

This is fundamentally different than actively driving the pin low to make
a 0% duty cycle, which does not appear to be possible at all. Therefore I
have removed the control of IQS620_PWR_SETTINGS_PWM_OUT based on the duty
cycle requested by the user and reverted to the behavior of v1, where the
duty cycle requested by the user is mapped only to IQS620_PWM_DUTY_CYCLE.

As such, I have also added a third bullet point similar to what you first
suggested following v1:

  - The device cannot generate a 0% duty cycle.

> >=20
> > > > + * - The period is fixed to 1 ms.
> > > > + */
> > > > +
> > > > +#include <linux/device.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/mfd/iqs62x.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/pwm.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +#define IQS620_PWR_SETTINGS			0xD2
> > > > +#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
> > > > +
> > > > +#define IQS620_PWM_DUTY_CYCLE			0xD8
> > > > +
> > > > +#define IQS620_PWM_PERIOD_NS			1000000
> > > > +
> > > > +struct iqs620_pwm_private {
> > > > +	struct iqs62x_core *iqs62x;
> > > > +	struct pwm_chip chip;
> > > > +	struct notifier_block notifier;
> > > > +};
> > > > +
> > > > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > > > +			    const struct pwm_state *state)
> > > > +{
> > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > +	struct iqs62x_core *iqs62x;
> > > > +	unsigned int pwm_out =3D 0;
> > > > +	int duty_scale, ret;
> > > > +
> > > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > > +		return -ENOTSUPP;
> > > > +
> > > > +	if (state->period < IQS620_PWM_PERIOD_NS)
> > > > +		return -EINVAL;
> > > > +
> > > > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip=
);
> > > > +	iqs62x =3D iqs620_pwm->iqs62x;
> > > > +
> > > > +	duty_scale =3D DIV_ROUND_CLOSEST(state->duty_cycle * 256,
> > > > +				       IQS620_PWM_PERIOD_NS);
> > > > +
> > > > +	if (duty_scale) {
> > > > +		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> > > > +				   min(duty_scale - 1, 0xFF));
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		if (state->enabled)
> > > > +			pwm_out =3D IQS620_PWR_SETTINGS_PWM_OUT;
> > > > +	}
> > > > +
> > > > +	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > > > +				  IQS620_PWR_SETTINGS_PWM_OUT, pwm_out);
> > >=20
> > > A comment explaining the semantic here would be good. I assume
> > > IQS620_PWM_DUTY_CYCLE takes a value between 0 and 255 and the resulti=
ng
> > > duty cycle is:
> > >=20
> > > 	(IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> > >=20
> > > .
> > >=20
> > > If this is right, please use:
> > >=20
> > > 	duty_scale =3D (state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS
> > >=20
> >=20
> > Sure thing, will do. I'll add a comment and round down. Your assumption=
 is
> > correct as well.
> >=20
> > > Also, when the hardware is running at
> > >=20
> > > 	.enabled =3D 1, .duty_cycle =3D 1/256 ms, .period =3D 1ms
> > >=20
> > > and you reconfigure to
> > >=20
> > > 	.enabled =3D 0, .duty_cycle =3D 1ms, .period =3D 1ms
> > >=20
> > > the output might be active for > 1/256 ms if the process is preempted
> > > between writing IQS620_PWM_DUTY_CYCLE and IQS620_PWR_SETTINGS_PWM_OUT=
.
> > >=20
> >=20
> > Good catch. I think we can solve this by writing IQS620_PWM_DUTY_CYCLE
> > first followed by IQS620_PWR_SETTINGS_PWM_OUT when the PWM is going to
> > be enabled, and the reverse when the PWM is going to be disabled (i.e.
> > turn OFF to prevent a stale duty cycle from being temporarily driven).
>=20
> Sounds like a plan. After disabling you even don't need to write the
> duty cycle register. (But there might be a discussion ahead that
> .get_state should return the duty cycle.)
> =20

For v3, I've opted to write IQS620_PWM_DUTY_CYCLE regardless of whether the=
 PWM
is enabled as a matter of principle (i.e. faithfully pass the entire state =
down
to the hardware without making assumptions).

And since some consumers (e.g. leds-pwm, the primary use-case for this PWM)=
 may
pre-configure the duty cycle while the PWM is disabled, this method ensures=
 the
driver is already compliant in case 01ccf903edd6 returns.

Also, as mentioned above, I have dropped the automatic disabling of the PWM=
 to
simulate a 0% duty cycle if the requested duty cycle is < 1 / 256 ms since =
the
device does not actively drive a zero with IQS620_PWR_SETTINGS_PWM_OUT =3D =
0. In
the interest of transparency, here is what I currently have for v3:

static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
			    const struct pwm_state *state)
{
	struct iqs620_pwm_private *iqs620_pwm;
	struct iqs62x_core *iqs62x;
	int duty_scale, ret;

	if (state->polarity !=3D PWM_POLARITY_NORMAL)
		return -ENOTSUPP;

	if (state->period < IQS620_PWM_PERIOD_NS)
		return -EINVAL;

	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
	iqs62x =3D iqs620_pwm->iqs62x;

	if (!state->enabled) {
		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
		if (ret)
			return ret;
	}

	/*
	 * The duty cycle generated by the device is calculated as follows:
	 *
	 * duty_cycle =3D (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
	 *
	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 255
	 * (inclusive). Therefore the lowest duty cycle the device can generate
	 * while the output is enabled is 1 / 256 ms.
	 */
	duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;

	ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
			   clamp(duty_scale, 0, 0xFF));
	if (ret)
		return ret;

	if (state->enabled)
		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);

	return ret;
}

I believe this captures all of the discussion thus far; please let me know =
if you
have any concerns.

> > > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > > +			       unsigned long event_flags, void *context)
> > > > +{
> > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > +	struct pwm_state state;
> > > > +	int ret;
> > > > +
> > > > +	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > > > +		return NOTIFY_DONE;
> > > > +
> > > > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
> > > > +				  notifier);
> > > > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > >=20
> > > Please don't call pwm API functions in callbacks. I assume you rely o=
n
> > > pwm_get_state returning the previously set state and that
> > > iqs620_pwm_get_state isn't called. Please use pwm->state for that.
> > >=20
> >=20
> > Sure thing, will do. Your assumption is correct. If pwm_get_state calle=
d
> > chip->ops->get_state instead of return pwm->state as it does today, thi=
s
> > function would break because it would restore the hardware using defaul=
t
> > register values (since this function follows a reset).
> >=20
> > Just for my own understanding, are you saying the PWM framework reserve=
s
> > the right to update pwm_get_state to call chip->ops->get_state some tim=
e
> > in the future? In any event I will refer to pwm->state as that is what =
I
> > ultimately need here.
>=20
> This already was the case for a short time before v5.4. See 01ccf903edd6
> and 40a6b9a00930. (And note that the lazyness mentioned above about not
> needing to write duty_cycle when the PWM is off is what made the
> approach break however.) I don't know yet how to proceed here. Being
> able to get the actually implemented setting would be nice, probably it
> is prudent to do this with another API function.
>=20
> Other than that I consider it a layer violation to call a function that
> is designed for consumers in a lowlevel driver. I don't know if we need
> locking at some time, but if the core holded a lock when .apply is
> called, .apply calls pwm_get_state which wanted to grab the lock again
> we get a dead-lock.
>=20

I think we may be imagining two different hazards (please correct me if I h=
ave
misunderstood). Originally I thought you were warning that pwm_get_state (w=
hich
simply returns pwm->state) may in the future call chip->ops->get_state inst=
ead,
which here would have caused iqs620_pwm_notifier to call iqs620_pwm_apply w=
ith
a reset-like state rather than the last state requested by the user (since =
this
notifier is called after the device resets itself).

The short-lived change during the 5.4-rc phase, however, was to fill pwm->s=
tate
in pwm_apply_state with the quantized state from the hardware instead of th=
e raw
state requested by the user. Whether pwm->state (accessed directly or by ca=
lling
pwm_get_state) gives the raw state or the quantized output of get_state fol=
lowing
the last call to pwm_apply_state does not change the outcome (for this part=
icular
driver) because iqs620_pwm_apply ultimately writes the same register values=
. Just
to be safe, I've been testing with and without 01ccf903edd6 applied locally=
 so as
to validate the behavior in both scenarios.

What I missed originally is that pwm_get_state is intended for consumers on=
ly, in
which case I agree it is fundamentally wrong to cannibalize it in the drive=
r. For
v3 I have changed iqs620_pwm_notifier to reference pwm->state directly sinc=
e that
is what is ultimately needed in the first place.

You're correct that a lock within the core would cause a deadlock; in this =
case I
was proposing a lock around the pair of reads/writes to IQS620_PWM_DUTY_CYC=
LE and
IQS620_PWR_SETTINGS_PWM_OUT since v2 introduced an implied relationship bet=
ween
the two. That would be safe since chip->ops->apply returns before pwm_apply=
_state
calls chip->ops->get_state.

However, even that is no longer necessary since IQS620_PWR_SETTINGS_PWM_OUT=
 is now
written independently of IQS620_PWM_DUTY_CYCLE due to withdrawing support f=
or a 0%
duty cycle starting in v3. In short, I didn't end up adding any locks as th=
ere was
no need.

> > FWIW, I borrowed the idea from the resume callback of [0] which possibl=
y
> > suffers the same fate if I have understood the concern correctly.
>=20
> Yeah, there are many drivers that are not up to date with my review
> requirements. The problem is a) missing time to update them and b) for
> some drivers it's hard to get test coverage for changes.
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Kind regards,
Jeff LaBundy
