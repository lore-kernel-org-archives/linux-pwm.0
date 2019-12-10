Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 10 Dec 2019 08:22:27 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191210000252.GA6361@labundy.com>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Jeff LaBundy <jeff@labundy.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>
List-ID: <linux-pwm.vger.kernel.org>

Hello Jeff,

On Tue, Dec 10, 2019 at 12:03:02AM +0000, Jeff LaBundy wrote:
> On Mon, Dec 09, 2019 at 08:32:06AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Dec 09, 2019 at 12:38:36AM +0000, Jeff LaBundy wrote:
> > > This patch adds support for the Azoteq IQS620A, capable of generating
> > > a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive).
> > >=20
> > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > ---
> > > Changes in v2:
> > >   - Merged 'Copyright' and 'Author' lines into one in introductory co=
mments
> > >   - Added 'Limitations' section to introductory comments
> > >   - Replaced 'error' with 'ret' throughout
> > >   - Added const qualifier to state argument of iqs620_pwm_apply and r=
emoved all
> > >     modifications to the variable's contents
> > >   - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the re=
quested
> > >     polarity is inverted or the requested period is below 1 ms, respe=
ctively
> > >   - Updated iqs620_pwm_apply to disable the PWM output if duty cycle =
is zero
> > >   - Added iqs620_pwm_get_state
> > >   - Eliminated tabbed alignment of pwm_ops and platform_driver struct=
 members
> > >   - Moved notifier unregistration to already present iqs620_pwm_remov=
e, which
> > >     eliminated the need for a device-managed action and ready flag
> > >   - Added a comment in iqs620_pwm_probe to explain the order of opera=
tions
> > >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> > >=20
> > >  drivers/pwm/Kconfig       |  10 +++
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-iqs620a.c | 206 ++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 217 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-iqs620a.c
> > >=20
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index bd21655..60bcf6c 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -222,6 +222,16 @@ config PWM_IMX_TPM
> > >  	  To compile this driver as a module, choose M here: the module
> > >  	  will be called pwm-imx-tpm.
> > >=20
> > > +config PWM_IQS620A
> > > +	tristate "Azoteq IQS620A PWM support"
> > > +	depends on MFD_IQS62X || COMPILE_TEST
> > > +	help
> > > +	  Generic PWM framework driver for the Azoteq IQS620A multi-function
> > > +	  sensor.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module will
> > > +	  be called pwm-iqs620a.
> > > +
> > >  config PWM_JZ4740
> > >  	tristate "Ingenic JZ47xx PWM support"
> > >  	depends on MACH_INGENIC
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 9a47507..a59c710 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
> > >  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
> > >  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
> > >  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> > > +obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
> > >  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> > >  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> > >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> > > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > > new file mode 100644
> > > index 0000000..1ea11b9
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-iqs620a.c
> > > @@ -0,0 +1,206 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Azoteq IQS620A PWM Generator
> > > + *
> > > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > > + *
> > > + * Limitations:
> > > + * - The period is not guaranteed to run to completion when the duty=
 cycle is
> > > + *   changed or the output is disabled.
> >=20
> > Do you know more details here? "not guaranteed" means that the new
> > period starts immediately when duty_cycle or the enabled bit is written?
> >=20
>=20
> Increasing the duty cycle on-the-fly (e.g. 25% to 75%) results in the
> following behavior (depending on where the I2C write falls):
>=20
>                        I2C write
>    __        __        __  V_    ______    ______    ______    __
> __|  |______|  |______|  |_|x|__|      |__|      |__|      |__|
>   ^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^
>=20
> The PWM continues to tick at 1 ms, but the currently running period suffe=
rs
> an extraneous pulse as the output is abruptly set high to "catch up" to t=
he
> new duty cycle.
>=20
> A similar behavior can occur if the duty cycle is decreased, meaning the
> output is abruptly set low if the I2C transaction completes in what has
> suddenly become the inactive region of the currently running period.
>=20
> The PWM seems to be a simple counter that rolls over at a period of 1 ms.
> Both the counter and the IQS620_PWM_DUTY_CYCLE register effectively go to
> a comparator whose output is ANDed with IQS620_PWR_SETTINGS_PWM_OUT which
> then drives the PWM output.
>=20
> As such, if either IQS620_PWM_DUTY_CYCLE or IQS620_PWR_SETTINGS_PWM_OUT
> change, so may the PWM output state depending on the counter's value at
> the time the I2C write is completed within the 1-ms continuous loop.
>=20
> For v3 I will update the note as follows:
>=20
> - Changes in duty cycle or enable/disable state are immediately reflected
>   by the PWM output and are not aligned to the start of any period.

I'd like to see a bit more information in the driver. Something about
the 1ms rhythm being unaffected by the duty_cycle and enable setting.
Maybe:

 - The periods run continuously with a fixed length of 1 ms which is
   unaffected by register updates. Writing duty cycle or enable
   registers gets active immediately which might result in glitches.

?

>=20
> > > + * - The period is fixed to 1 ms.
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mfd/iqs62x.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#define IQS620_PWR_SETTINGS			0xD2
> > > +#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
> > > +
> > > +#define IQS620_PWM_DUTY_CYCLE			0xD8
> > > +
> > > +#define IQS620_PWM_PERIOD_NS			1000000
> > > +
> > > +struct iqs620_pwm_private {
> > > +	struct iqs62x_core *iqs62x;
> > > +	struct pwm_chip chip;
> > > +	struct notifier_block notifier;
> > > +};
> > > +
> > > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > > +			    const struct pwm_state *state)
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +	struct iqs62x_core *iqs62x;
> > > +	unsigned int pwm_out =3D 0;
> > > +	int duty_scale, ret;
> > > +
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -ENOTSUPP;
> > > +
> > > +	if (state->period < IQS620_PWM_PERIOD_NS)
> > > +		return -EINVAL;
> > > +
> > > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> > > +	iqs62x =3D iqs620_pwm->iqs62x;
> > > +
> > > +	duty_scale =3D DIV_ROUND_CLOSEST(state->duty_cycle * 256,
> > > +				       IQS620_PWM_PERIOD_NS);
> > > +
> > > +	if (duty_scale) {
> > > +		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> > > +				   min(duty_scale - 1, 0xFF));
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		if (state->enabled)
> > > +			pwm_out =3D IQS620_PWR_SETTINGS_PWM_OUT;
> > > +	}
> > > +
> > > +	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > > +				  IQS620_PWR_SETTINGS_PWM_OUT, pwm_out);
> >=20
> > A comment explaining the semantic here would be good. I assume
> > IQS620_PWM_DUTY_CYCLE takes a value between 0 and 255 and the resulting
> > duty cycle is:
> >=20
> > 	(IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> >=20
> > .
> >=20
> > If this is right, please use:
> >=20
> > 	duty_scale =3D (state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS
> >=20
>=20
> Sure thing, will do. I'll add a comment and round down. Your assumption is
> correct as well.
>=20
> > Also, when the hardware is running at
> >=20
> > 	.enabled =3D 1, .duty_cycle =3D 1/256 ms, .period =3D 1ms
> >=20
> > and you reconfigure to
> >=20
> > 	.enabled =3D 0, .duty_cycle =3D 1ms, .period =3D 1ms
> >=20
> > the output might be active for > 1/256 ms if the process is preempted
> > between writing IQS620_PWM_DUTY_CYCLE and IQS620_PWR_SETTINGS_PWM_OUT.
> >=20
>=20
> Good catch. I think we can solve this by writing IQS620_PWM_DUTY_CYCLE
> first followed by IQS620_PWR_SETTINGS_PWM_OUT when the PWM is going to
> be enabled, and the reverse when the PWM is going to be disabled (i.e.
> turn OFF to prevent a stale duty cycle from being temporarily driven).

Sounds like a plan. After disabling you even don't need to write the
duty cycle register. (But there might be a discussion ahead that
.get_state should return the duty cycle.)
=20
> > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > +			       unsigned long event_flags, void *context)
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +	struct pwm_state state;
> > > +	int ret;
> > > +
> > > +	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > > +		return NOTIFY_DONE;
> > > +
> > > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
> > > +				  notifier);
> > > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> >=20
> > Please don't call pwm API functions in callbacks. I assume you rely on
> > pwm_get_state returning the previously set state and that
> > iqs620_pwm_get_state isn't called. Please use pwm->state for that.
> >=20
>=20
> Sure thing, will do. Your assumption is correct. If pwm_get_state called
> chip->ops->get_state instead of return pwm->state as it does today, this
> function would break because it would restore the hardware using default
> register values (since this function follows a reset).
>=20
> Just for my own understanding, are you saying the PWM framework reserves
> the right to update pwm_get_state to call chip->ops->get_state some time
> in the future? In any event I will refer to pwm->state as that is what I
> ultimately need here.

This already was the case for a short time before v5.4. See 01ccf903edd6
and 40a6b9a00930. (And note that the lazyness mentioned above about not
needing to write duty_cycle when the PWM is off is what made the
approach break however.) I don't know yet how to proceed here. Being
able to get the actually implemented setting would be nice, probably it
is prudent to do this with another API function.

Other than that I consider it a layer violation to call a function that
is designed for consumers in a lowlevel driver. I don't know if we need
locking at some time, but if the core holded a lock when .apply is
called, .apply calls pwm_get_state which wanted to grab the lock again
we get a dead-lock.

> FWIW, I borrowed the idea from the resume callback of [0] which possibly
> suffers the same fate if I have understood the concern correctly.

Yeah, there are many drivers that are not up to date with my review
requirements. The problem is a) missing time to update them and b) for
some drivers it's hard to get test coverage for changes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
