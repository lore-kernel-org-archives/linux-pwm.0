Return-path: <kernel-bounces@pengutronix.de>
Date: Fri, 20 Dec 2019 09:59:48 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20191220085948.iagsdpjqd6ixdo7j@pengutronix.de>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
 <20191220031924.GA2658@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191220031924.GA2658@labundy.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>
List-ID: <linux-pwm.vger.kernel.org>

Hello Jeff,

On Fri, Dec 20, 2019 at 03:19:31AM +0000, Jeff LaBundy wrote:
> I apologize for my delayed replies as I have been traveling.

No problem, I didn't hold my breath :-)

> On Mon, Dec 16, 2019 at 10:19:12AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sun, Dec 15, 2019 at 08:36:12PM +0000, Jeff LaBundy wrote:
> > > On Tue, Dec 10, 2019 at 08:22:27AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Tue, Dec 10, 2019 at 12:03:02AM +0000, Jeff LaBundy wrote:
> > > > > On Mon, Dec 09, 2019 at 08:32:06AM +0100, Uwe Kleine-K=F6nig wrot=
e:
> > > > > > On Mon, Dec 09, 2019 at 12:38:36AM +0000, Jeff LaBundy wrote:
> > > > > > > This patch adds support for the Azoteq IQS620A, capable of ge=
nerating
> > > > > > > a 1-kHz PWM output with duty cycle between 0.4% and 100% (inc=
lusive).
> > > > > > >=20
> > > > > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > > > > > ---
> > > > > > > Changes in v2:
> > > > > > >   - Merged 'Copyright' and 'Author' lines into one in introdu=
ctory comments
> > > > > > >   - Added 'Limitations' section to introductory comments
> > > > > > >   - Replaced 'error' with 'ret' throughout
> > > > > > >   - Added const qualifier to state argument of iqs620_pwm_app=
ly and removed all
> > > > > > >     modifications to the variable's contents
> > > > > > >   - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL i=
f the requested
> > > > > > >     polarity is inverted or the requested period is below 1 m=
s, respectively
> > > > > > >   - Updated iqs620_pwm_apply to disable the PWM output if dut=
y cycle is zero
> > > > > > >   - Added iqs620_pwm_get_state
> > > > > > >   - Eliminated tabbed alignment of pwm_ops and platform_drive=
r struct members
> > > > > > >   - Moved notifier unregistration to already present iqs620_p=
wm_remove, which
> > > > > > >     eliminated the need for a device-managed action and ready=
 flag
> > > > > > >   - Added a comment in iqs620_pwm_probe to explain the order =
of operations
> > > > > > >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPI=
LE_TEST
> > > > > > >=20
> > > > > > >  drivers/pwm/Kconfig       |  10 +++
> > > > > > >  drivers/pwm/Makefile      |   1 +
> > > > > > >  drivers/pwm/pwm-iqs620a.c | 206 ++++++++++++++++++++++++++++=
++++++++++++++++++
> > > > > > >  3 files changed, 217 insertions(+)
> > > > > > >  create mode 100644 drivers/pwm/pwm-iqs620a.c
> > > > > > >=20
> > > > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > > > index bd21655..60bcf6c 100644
> > > > > > > --- a/drivers/pwm/Kconfig
> > > > > > > +++ b/drivers/pwm/Kconfig
> > > > > > > @@ -222,6 +222,16 @@ config PWM_IMX_TPM
> > > > > > >  	  To compile this driver as a module, choose M here: the mo=
dule
> > > > > > >  	  will be called pwm-imx-tpm.
> > > > > > >=20
> > > > > > > +config PWM_IQS620A
> > > > > > > +	tristate "Azoteq IQS620A PWM support"
> > > > > > > +	depends on MFD_IQS62X || COMPILE_TEST
> > > > > > > +	help
> > > > > > > +	  Generic PWM framework driver for the Azoteq IQS620A multi=
-function
> > > > > > > +	  sensor.
> > > > > > > +
> > > > > > > +	  To compile this driver as a module, choose M here: the mo=
dule will
> > > > > > > +	  be called pwm-iqs620a.
> > > > > > > +
> > > > > > >  config PWM_JZ4740
> > > > > > >  	tristate "Ingenic JZ47xx PWM support"
> > > > > > >  	depends on MACH_INGENIC
> > > > > > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > > > > > index 9a47507..a59c710 100644
> > > > > > > --- a/drivers/pwm/Makefile
> > > > > > > +++ b/drivers/pwm/Makefile
> > > > > > > @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
> > > > > > >  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
> > > > > > >  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
> > > > > > >  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> > > > > > > +obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
> > > > > > >  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> > > > > > >  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> > > > > > >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> > > > > > > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs6=
20a.c
> > > > > > > new file mode 100644
> > > > > > > index 0000000..1ea11b9
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/pwm/pwm-iqs620a.c
> > > > > > > @@ -0,0 +1,206 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > > +/*
> > > > > > > + * Azoteq IQS620A PWM Generator
> > > > > > > + *
> > > > > > > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > > > > > > + *
> > > > > > > + * Limitations:
> > > > > > > + * - The period is not guaranteed to run to completion when =
the duty cycle is
> > > > > > > + *   changed or the output is disabled.
> > > > > >=20
> > > > > > Do you know more details here? "not guaranteed" means that the =
new
> > > > > > period starts immediately when duty_cycle or the enabled bit is=
 written?
> > > > > >=20
> > > > >=20
> > > > > Increasing the duty cycle on-the-fly (e.g. 25% to 75%) results in=
 the
> > > > > following behavior (depending on where the I2C write falls):
> > > > >=20
> > > > >                        I2C write
> > > > >    __        __        __  V_    ______    ______    ______    __
> > > > > __|  |______|  |______|  |_|x|__|      |__|      |__|      |__|
> > > > >   ^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^
> > > > >=20
> > > > > The PWM continues to tick at 1 ms, but the currently running peri=
od suffers
> > > > > an extraneous pulse as the output is abruptly set high to "catch =
up" to the
> > > > > new duty cycle.
> > > > >=20
> > > > > A similar behavior can occur if the duty cycle is decreased, mean=
ing the
> > > > > output is abruptly set low if the I2C transaction completes in wh=
at has
> > > > > suddenly become the inactive region of the currently running peri=
od.
> > > > >=20
> > > > > The PWM seems to be a simple counter that rolls over at a period =
of 1 ms.
> > > > > Both the counter and the IQS620_PWM_DUTY_CYCLE register effective=
ly go to
> > > > > a comparator whose output is ANDed with IQS620_PWR_SETTINGS_PWM_O=
UT which
> > > > > then drives the PWM output.
> > > > >=20
> > > > > As such, if either IQS620_PWM_DUTY_CYCLE or IQS620_PWR_SETTINGS_P=
WM_OUT
> > > > > change, so may the PWM output state depending on the counter's va=
lue at
> > > > > the time the I2C write is completed within the 1-ms continuous lo=
op.
> > > > >=20
> > > > > For v3 I will update the note as follows:
> > > > >=20
> > > > > - Changes in duty cycle or enable/disable state are immediately r=
eflected
> > > > >   by the PWM output and are not aligned to the start of any perio=
d.
> > > >=20
> > > > I'd like to see a bit more information in the driver. Something abo=
ut
> > > > the 1ms rhythm being unaffected by the duty_cycle and enable settin=
g.
> > > > Maybe:
> > > >=20
> > > >  - The periods run continuously with a fixed length of 1 ms which is
> > > >    unaffected by register updates. Writing duty cycle or enable
> > > >    registers gets active immediately which might result in glitches.
> > > >=20
> > > > ?
> > > >=20
> > >=20
> > > I adjusted the wording a bit as per my preference and settled on the
> > > following:
> > >=20
> > >   - The period is fixed to 1 ms and is generated continuously despite=
 changes
> > >     to the duty cycle or enable/disable state.
> > >   - Changes to the duty cycle or enable/disable state take effect imm=
ediately
> > >     and may result in a glitch during the period in which the change =
is made.
> > >=20
> > > I believe these capture the spirit of your message; please let me kno=
w if
> > > you have any concerns.
> >=20
> > That's fine.
> >=20
> > > Upon further experimentation, I found that disabling the output (whic=
h v2
> > > does so as to simulate a 0% duty cycle) does not actively drive zero,=
 but
> > > rather places the output in a high-impedance state with only the devi=
ce's
> > > own internal leakage eventually discharging the pin.
> >=20
> > But maybe this is still the best you can do in this case. @Thierry, what
> > do you think?
> >=20
> > > This is fundamentally different than actively driving the pin low to =
make
> > > a 0% duty cycle, which does not appear to be possible at all. Therefo=
re I
> > > have removed the control of IQS620_PWR_SETTINGS_PWM_OUT based on the =
duty
> > > cycle requested by the user and reverted to the behavior of v1, where=
 the
> > > duty cycle requested by the user is mapped only to IQS620_PWM_DUTY_CY=
CLE.
> > >=20
> > > As such, I have also added a third bullet point similar to what you f=
irst
> > > suggested following v1:
> > >=20
> > >   - The device cannot generate a 0% duty cycle.
> >=20
> > Then this would be:
> >=20
> >   - The device cannot actively drive a 0% duty cycle. The driver is
> >     disabled for small duty_cycles relying on a pull down on the board.
> >=20
> > But maybe it would be more prudent to do this only if the board
> > configuration suggests this is save?!
> >=20
>=20
> Given the policy for the actual duty cycle generated by the hardware not =
to
> exceed that which is requested by the user, it seems there are ultimately=
 3
> options for duty_cycle below 1 / 256 ms:
>=20
> 1. Return -EINVAL.
> 2. Disable the output as in v2.
> 3. Add an optional boolean in the dts that identifies whether a pull-down=
 is
>    present; default to option (1) but use option (2) if the boolean is th=
ere.
>=20
> I don't like option (1) because consumers (including leds-pwm) do in fact=
 ask
> for a 0% duty cycle which would make iqs620_pwm_apply return an error. Th=
ings
> happen to still work since leds-pwm does not check pwm_config's return va=
lue,
> but I don't want to rely on this coincidence.

People implementing PWM drivers seems to mostly care about leds-pwm :-)
With that only nearly hitting the requested state isn't that bad. But if
you control a step motor that positions a laser, you want to be sure
that the request to stop moving it actually worked.

> Option (2) is better, but I know from experience that board designers do =
not
> consult driver comments and the requirement to add a pull-down may be eas=
ily
> missed as it is not discussed in the data sheet (which is where that sort=
 of
> information belongs, in my opinion).

Hmm, well, actually I think the problem happened earlier when the
hardware designer considered providing 0% to be not important.

> Option (3) seems like overkill for such a simple PWM, and ultimately does=
n't
> add any value because I don't want to allow option (1) behavior in any ca=
se.
> Whether the PWM is disabled because it is truly disabled or to simulate a=
 0%
> duty cycle as in option (2), the pull-down is ultimately required regardl=
ess
> of whether or not the data sheet happens to go into such detail.

Actually I like option 3 best.
=20
> Therefore I have opted to carry forward option (2) from v2 to v3. I rewor=
ded
> the third limitation a bit as follows:
>=20
> - The device cannot generate a 0% duty cycle. For duty cycles below 1 / 2=
56
>   ms, the output is disabled and relies upon an external pull-down resist=
or
>   to hold the GPIO3/LTX pin low.
>=20
> I did reach out to the vendor and asked them to consider recommending a p=
ull-
> down resistor in a future revision of the data sheet, although at the tim=
e of
> this writing I have not heard back.

Good.

> > > 	/*
> > > 	 * The duty cycle generated by the device is calculated as follows:
> > > 	 *
> > > 	 * duty_cycle =3D (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> > > 	 *
> > > 	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and =
255
> > > 	 * (inclusive). Therefore the lowest duty cycle the device can gener=
ate
> > > 	 * while the output is enabled is 1 / 256 ms.
> > > 	 */
> > > 	duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;
> >=20
> > Hmm, this is violating the policy to implement a value not bigger than
> > requested with state->duty_cycle =3D=3D 0. I see this has downsides to =
not
> > simply cheat here, but only claiming to have implemented 0% can hurt,
> > too. pwm-rcar returns -EINVAL in this case.
> >=20
>=20
> That's a great point and is addressed by sticking with option (2) describ=
ed
> above. Here is what I've got for v3:
>=20
> static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> 			    const struct pwm_state *state)
> {
> 	struct iqs620_pwm_private *iqs620_pwm;
> 	struct iqs62x_core *iqs62x;
> 	int duty_scale, ret;
>=20
> 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> 		return -ENOTSUPP;
>=20
> 	if (state->period < IQS620_PWM_PERIOD_NS)
> 		return -EINVAL;
>=20
> 	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> 	iqs62x =3D iqs620_pwm->iqs62x;
>=20
> 	mutex_lock(&iqs620_pwm->lock);
>=20
> 	/*
> 	 * The duty cycle generated by the device is calculated as follows:
> 	 *
> 	 * duty_cycle =3D (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> 	 *
> 	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 255
> 	 * (inclusive). Therefore the lowest duty cycle the device can generate
> 	 * while the output is enabled is 1 / 256 ms.
> 	 *
> 	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
> 	 * allow an on-board pull-down resistor to hold the GPIO3/LTX pin low.
> 	 */
> 	duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
>=20
> 	if (!state->enabled || !duty_scale) {
> 		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> 					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> 		if (ret)
> 			goto err_mutex;
> 	}
>=20
> 	if (duty_scale) {
> 		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> 				   min(duty_scale - 1, 0xFF));
> 		if (ret)
> 			goto err_mutex;
> 	}
>=20
> 	if (state->enabled && duty_scale)
> 		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> 					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);
>=20
> err_mutex:
> 	mutex_unlock(&iqs620_pwm->lock);
>=20
> 	return ret;
> }

Looks ok. (Even though it implements (2) which isn't my favorite :-)

> And for the get_state callback:
>=20
> static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> 				 struct pwm_state *state)
> {
> 	struct iqs620_pwm_private *iqs620_pwm;
> 	struct iqs62x_core *iqs62x;
> 	unsigned int val;
> 	int ret;
>=20
> 	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> 	iqs62x =3D iqs620_pwm->iqs62x;
>=20
> 	mutex_lock(&iqs620_pwm->lock);
>=20
> 	ret =3D regmap_read(iqs62x->map, IQS620_PWR_SETTINGS, &val);
> 	if (ret)
> 		goto err_mutex;
> 	state->enabled =3D val & IQS620_PWR_SETTINGS_PWM_OUT;
>=20
> 	ret =3D regmap_read(iqs62x->map, IQS620_PWM_DUTY_CYCLE, &val);
> 	if (ret)
> 		goto err_mutex;
> 	state->duty_cycle =3D DIV_ROUND_UP((val + 1) * IQS620_PWM_PERIOD_NS, 256=
);
> 	state->period =3D IQS620_PWM_PERIOD_NS;
>=20
> err_mutex:
> 	mutex_unlock(&iqs620_pwm->lock);
>=20
> 	if (ret)
> 		dev_err(iqs620_pwm->chip.dev, "Failed to get state: %d\n", ret);
> }
>=20
> If you and/or Thierry have any concerns, please let me know.

Looks good, too. Maybe add a comment like:

	/*
	 * As the hardware cannot implement "enabled with
	 * duty_cycle =3D=3D 0", we're reporting "disabled with
	 * duty_cycle =3D 1/256 ms" after 0% was requested. This is ugly
	 * but the best we can achieve.
	 */

> > > 	ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> > > 			   clamp(duty_scale, 0, 0xFF));
> > > 	if (ret)
> > > 		return ret;
> >=20
> > I understand your motivation to configure the duty cycle also when the
> > the request has enabled=3Dfalse, but a strange side effect is that a
> > failure to configure the dutycycle with .enabled=3Dfalse isn't really a
> > problem, is it?
> > (This is not a request to change anything, it's only expression of my
> > frustration that we cannot get away without strange effects.)
> >=20
>=20
> True, but it would definitely be a problem in case 01ccf903edd6 returns a=
nd
> we're relying on the device's own registers to hold the PWM state.

You can assume it won't come back as is. There are too many drivers that
suffer the same problem. My goal is to let the core not depend on the
lowlevel drivers to memorize a duty-cycle for disabled PWMs. The details
are not yet thought out. Obvious options are:

 - cache the value in the core
 - make consumers not depend on that

> Thinking about this more, I agree with your earlier comment that a means =
to
> get the actual (quantized) state needs to be a new API function (of integ=
er
> type). Since chip->ops->get_state is void, there is no way for the callba=
ck
> to warn the core that a register read failed and the PWM state may be jun=
k.

Yeah, this is something I intend to change, too. .get_state should
return a status code in the long run.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
