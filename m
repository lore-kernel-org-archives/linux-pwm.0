Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:60311
        "EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfJVEgx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 00:36:53 -0400
Date: Mon, 21 Oct 2019 23:36:49 -0500
From: Jeff LaBundy <jeff@labundy.com>
Message-ID: <20191022043649.GB2091@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-6-git-send-email-jeff@labundy.com>
 <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 5/8] pwm: Add support for Azoteq IQS620A PWM generator
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

Hi Uwe,

Thank you for your prompt review.

On Mon, Oct 21, 2019 at 09:34:19AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Jeff,
>=20
> On Sun, Oct 20, 2019 at 11:11:20PM -0500, Jeff LaBundy wrote:
> > This patch adds support for the Azoteq IQS620A, capable of generating
> > a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive).
> >=20
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> >  drivers/pwm/Kconfig       |  10 +++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-iqs620a.c | 167 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 178 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-iqs620a.c
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index e3a2518..712445e 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -222,6 +222,16 @@ config PWM_IMX_TPM
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-imx-tpm.
> > =20
> > +config PWM_IQS620A
> > +	tristate "Azoteq IQS620A PWM support"
> > +	depends on MFD_IQS62X
>=20
> This is only a runtime dependency if I'm not mistaken, so it would be
> great to have
>=20
> 	depends on MFD_IQS62X || COMPILE_TEST
> 	depends on REGMAP
>=20
> here.
>=20

Sure thing; will do. Actually, it seems I can add this to all but the input
driver, as that one relies on iqs62x_events exported from the MFD.

> > +	help
> > +	  Generic PWM framework driver for the Azoteq IQS620A multi-function
> > +	  sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called pwm-iqs620a.
> > +
> >  config PWM_JZ4740
> >  	tristate "Ingenic JZ47xx PWM support"
> >  	depends on MACH_INGENIC
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 26326ad..27c9bfa 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
> >  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
> >  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
> >  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> > +obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
> >  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> >  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > new file mode 100644
> > index 0000000..6451eb1
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-iqs620a.c
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620A PWM Generator
> > + *
> > + * Copyright (C) 2019
> > + * Author: Jeff LaBundy <jeff@labundy.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/iqs62x.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define IQS620_PWR_SETTINGS			0xD2
> > +#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
> > +
> > +#define IQS620_PWM_DUTY_CYCLE			0xD8
> > +
> > +#define IQS620_PWM_PERIOD_NS			1000000
> > +
> > +struct iqs620_pwm_private {
> > +	struct iqs62x_core *iqs62x;
> > +	struct pwm_chip chip;
> > +	struct notifier_block notifier;
> > +	bool ready;
>=20
> This is always true, so you can drop it.
>=20

This is here because iqs620_pwm_notifier references chip.pwms, which is
not allocated until after the notifier is registered and pwmchip_add is
called. So it protects against this (albeit unlikely) race condition:

1. iqs620_pwm_notifier is registered
2. Device immediately suffers an asynchronous reset and notifier chain
   is called (more on that in a bit)
3. iqs620_pwm_notifier evaluates chips.pwms (NULL)

I felt this was simpler than calling pwmchip_add before registering the
notifier and adding an error/tear-down path in iqs620_pwm_probe in case
of failure. I would be happy to add a comment or two to explain the not-
so-obvious purpose of this flag.

> > +};
> > +
> > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +			    struct pwm_state *state)
>=20
> Since
>=20
> 	71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state ar=
gument")
>=20
> this isn't the right prototype.
>=20

Sure thing; I will add the 'const' qualifier and remove the two changes
to the state argument.

> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	struct iqs62x_core *iqs62x;
> > +	int error;
> > +	int duty_calc =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;
> > +	u8 duty_clamp =3D clamp(duty_calc, 0, 0xFF);
> > +
> > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> > +	iqs62x =3D iqs620_pwm->iqs62x;
> > +
> > +	error =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE, duty_clamp=
);
> > +	if (error)
> > +		return error;
> > +
> > +	state->period =3D IQS620_PWM_PERIOD_NS;
> > +	state->duty_cycle =3D (duty_clamp + 1) * IQS620_PWM_PERIOD_NS / 256;
>=20
> This suggests that if the value in the IQS620_PWM_DUTY_CYCLE is 0 the
> duty cycle is 1/256 ms with a period of 1 ms and the output cannot be
> constant inactive. If this is right please add a paragraph in the
> driver's comment at the top:
>=20
> 	* Limitations:
> 	* - The hardware cannot generate a 0% duty cycle
>=20
> (Please stick to this format, other drivers use it, too.)
>=20

That's correct; the lowest duty cycle that can be achieved using only the
IQS620_PWM_DUTY_CYCLE register is 0.4%. We can, however, generate 0% duty
cycle by disabling the output altogether using a separate register. Would
that be better than flat-out saying it's impossible?

> How does the hardware behave on changes? For example you're first
> committing the duty cycle and then on/off. Can it happen that between
>=20
> 	pwm_apply_state(pwm, { .duty_cycle =3D 3900, .period =3D 1000000, .enabl=
ed =3D true)
> 	...
> 	pwm_apply_state(pwm, { .duty_cycle =3D 1000000, .period =3D 1000000, .en=
abled =3D false)
>=20
> the output is active for longer than 4 =B5s because the iqs620_pwm_apply
> function is preempted between the two register writes and so we already
> have .duty_cycle =3D 1000000 but still .enabled =3D true in the hardware?
>=20

My results show that it is possible to generate up to two irregular periods
by changing the duty cycle while the output is active.

Depending on the ratio of old-to-new duty cycle and the position of the I2C
write relative to the asynchronous output, the device may produce one pulse
for which the width represents neither the old nor the new duty cycle.

> Does a change complete the currently running period? Does disabling
> complete the currently running period? If so, does regmap_update_bits
> block until the new setting is active?
>=20

A quick test reveals the following:

* Duty cycle changes may interrupt a running period, i.e., the output may
  transition in the middle of the period to accommodate the new duty cycle.
* Disabling the output drives it to zero immediately, i.e., the period does
  does not run to completion.

I will add a 'Limitations' section at the top as other drivers do, and call
these points out specifically.

> The .apply function fails to check for .pwm_polarity. You want something
> like:
>=20
> 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> 		return -ENOTSUPP;
>=20
> (That's what pwm-rcar and the core (in the absence of .set_polarity for
> old-style drivers) are using. @Thierry: It would be great to fix the
> vaule that should be returned in this case. pwm-lpss and sifive use
> -EINVAL.)
>=20

Sure thing; I'll return -ENOTSUPP in this case.

> > +	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > +				  IQS620_PWR_SETTINGS_PWM_OUT,
> > +				  state->enabled ? 0xFF : 0);
> > +}
> > +
> > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > +			       unsigned long event_flags, void *context)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	struct pwm_state state;
> > +	int error;
> > +
> > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
> > +				  notifier);
> > +
> > +	if (!iqs620_pwm->ready || !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)=
))
> > +		return NOTIFY_DONE;
> > +
> > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > +
> > +	error =3D iqs620_pwm_apply(&iqs620_pwm->chip,
> > +				 &iqs620_pwm->chip.pwms[0], &state);
> > +	if (error) {
> > +		dev_err(iqs620_pwm->chip.dev,
> > +			"Failed to re-initialize device: %d\n", error);
> > +		return NOTIFY_BAD;
> > +	}
> > +
> > +	return NOTIFY_OK;
>=20
> So the PWM can loose it's state sometimes? When does that happen?
>=20

That's correct. The device performs an internal soft reset in the presence
of what it considers to be an I2C timeout error; in this case all registers
are restored to their default values.

The data sheet goes so far as to recommend monitoring for this interrupt and
restoring the device on-the-fly. I have added some comments in iqs62x_irq in
patch [2/8] which provides some further detail.

> > +}
> > +
> > +static void iqs620_pwm_notifier_unregister(void *context)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm =3D context;
> > +	int error;
> > +
> > +	error =3D blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
> > +						   &iqs620_pwm->notifier);
> > +	if (error)
> > +		dev_err(iqs620_pwm->chip.dev,
> > +			"Failed to unregister notifier: %d\n", error);
> > +}
> > +
> > +static const struct pwm_ops iqs620_pwm_ops =3D {
> > +	.apply	=3D iqs620_pwm_apply,
>=20
> Please implement a .get_state callback.
>=20

Sure thing; will do.

> > +	.owner	=3D THIS_MODULE,
> > +};
> > +
> > +static int iqs620_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	int error;
> > +
> > +	iqs620_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERN=
EL);
> > +	if (!iqs620_pwm)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, iqs620_pwm);
> > +	iqs620_pwm->iqs62x =3D dev_get_drvdata(pdev->dev.parent);
> > +
> > +	iqs620_pwm->chip.dev =3D &pdev->dev;
> > +	iqs620_pwm->chip.ops =3D &iqs620_pwm_ops;
> > +	iqs620_pwm->chip.base =3D -1;
> > +	iqs620_pwm->chip.npwm =3D 1;
> > +
> > +	iqs620_pwm->notifier.notifier_call =3D iqs620_pwm_notifier;
> > +	error =3D blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
> > +						 &iqs620_pwm->notifier);
> > +	if (error) {
> > +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	error =3D devm_add_action_or_reset(&pdev->dev,
> > +					 iqs620_pwm_notifier_unregister,
> > +					 iqs620_pwm);
>=20
> I wonder if this is safe. If in iqs620_pwm_notifier_unregister()
> unregistering of the notifier goes wrong (not sure when this can happen)
> the memory behind iqs620_pwm goes away. Then later iqs620_pwm_notifier
> might be called trying to use *iqs620_pwm ...

I think this is purely theoretical, as blocking_notifier_chain_unregister
only fails if the notifier is not found in the chain. If for some reason
blocking_notifier_chain_register fails (which currently cannot happen, as
it always returns zero), the driver will fail to probe before the action
could be added.

This of course means the error message in iqs620_pwm_notifier_unregister
is unnecessary; it is simply provided for debug/visibility.

>=20
> > +	if (error) {
> > +		dev_err(&pdev->dev, "Failed to add action: %d\n", error);
> > +		return error;
> > [...]
> >=20
> > +static struct platform_driver iqs620_pwm_platform_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D IQS620_DRV_NAME_PWM,
> > +	},
> > +	.probe		=3D iqs620_pwm_probe,
> > +	.remove		=3D iqs620_pwm_remove,
> > +};
>=20
> I'm not a big fan of aligning the =3D in struct initializers. The downside
> is that if you later add
>=20
> 	.prevent_deferred_probe =3D true,
>=20
> you either have to touch all (otherwise unrelated) lines to realign
> which adds churn, or the structure is only partially aligned which looks
> ugly. That's why I stick to a single space before the =3D.
>=20

Sure thing; your argument is valid and I will reduce to a single space.

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
