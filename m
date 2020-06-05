From: "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2/3] pwm: Add PWM driver for Intel Keem Bay
Date: Fri, 5 Jun 2020 13:48:56 +0000
Message-ID: <SN6PR11MB2575BEDD7154E4827A7F9B07F6860@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200523214031.xpbenusp2i44w237@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200523214031.xpbenusp2i44w237-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wan Mohamad, Wan Ahmad Zainie" <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Shevchenko, Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Uwe,

Thank you for taking the time to review this patch set.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Sent: Sunday, May 24, 2020 5:41 AM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; linux-
> pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Shevchenko,
> Andriy <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Subject: Re: [PATCH 2/3] pwm: Add PWM driver for Intel Keem Bay
>=20
> Hello,
>=20
> On Sun, May 17, 2020 at 09:52:39PM +0800,
> vineetha.g.jaya.kumaran-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> > From: "Lai, Poey Seng" <poey.seng.lai-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > Enable PWM support for the Intel Keem Bay SoC.
> >
> > Signed-off-by: Lai, Poey Seng <poey.seng.lai-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Vineetha G. Jaya Kumaran
> > <vineetha.g.jaya.kumaran-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/pwm/Kconfig       |   9 ++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-keembay.c | 308
> > ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 318 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-keembay.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > c13d146..5311975 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -569,4 +569,13 @@ config PWM_ZX
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-zx.
> >
> > +config PWM_KEEMBAY
> > +	tristate "Intel Keem Bay PWM driver"
> > +	depends on ARM64
>=20
> Support for COMPILE_TEST would be nice here.
>=20

I will add this in v2.

> > +	help
> > +	  The platform driver for Intel Keem Bay PWM controller.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-keembay.
> > +
> >  endif
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> > a59c710..0c84ff2 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -55,3 +55,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
> >  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
> >  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> >  obj-$(CONFIG_PWM_ZX)		+=3D pwm-zx.o
> > +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> > diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c new
> > file mode 100644 index 0000000..39c7310
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-keembay.c
> > @@ -0,0 +1,308 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Keem Bay PWM driver
> > + *
> > + * Copyright (C) 2020 Intel Corporation
> > + * Authors: Lai Poey Seng <poey.seng.lai-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran-ral2JQCrhuE@public.gmane.org=
m>
>=20
> Is there publically available documentation? If so, please add a link her=
e.
>=20

Will check, and add it here if any are available.

> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define TOTAL_PWM_CHANNELS		6
> > +#define LEAD_IN_DEFAULT			0
> > +#define PWM_COUNT_MAX			65535
>=20
> please use a unique prefix for all defines in your driver. The names as t=
hey are
> are too generic.
>=20

I'll update the naming in v2, to match the mask defines.

> > +
> > +#define KEEMBAY_PWM_EN_BIT		31
> > +
> > +/* Mask */
> > +#define KEEMBAY_PWM_RPT_CNT_MASK	GENMASK(15, 0)
> > +#define KEEMBAY_PWM_LEAD_IN_MASK	GENMASK(30, 16)
> > +#define KEEMBAY_PWM_HIGH_MASK		GENMASK(31, 16)
> > +#define KEEMBAY_PWM_LOW_MASK		GENMASK(15, 0)
> > +
> > +/* PWM Register offset */
> > +#define PWM_LEADIN0_OFFSET		0x00
> > +#define PWM_LEADIN1_OFFSET		0x04
> > +#define PWM_LEADIN2_OFFSET		0x08
> > +#define PWM_LEADIN3_OFFSET		0x0c
> > +#define PWM_LEADIN4_OFFSET		0x10
> > +#define PWM_LEADIN5_OFFSET		0x14
> > +
> > +#define PWM_HIGHLOW0_OFFSET		0x20
> > +#define PWM_HIGHLOW1_OFFSET		0x24
> > +#define PWM_HIGHLOW2_OFFSET		0x28
> > +#define PWM_HIGHLOW3_OFFSET		0x2c
> > +#define PWM_HIGHLOW4_OFFSET		0x30
> > +#define PWM_HIGHLOW5_OFFSET		0x34
> > +
> > +struct keembay_pwm {
> > +	struct pwm_chip chip;
> > +	struct device *dev;
> > +	struct clk *clk;
> > +	void __iomem *regmap;
>=20
> I'd call this member "base" instead of "regmap" as the latter has a diffe=
rent
> meaning in the kernel.
>=20

OK, will update the naming.

> > +};
> > +
> > +static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip
> > +*chip) {
> > +	return container_of(chip, struct keembay_pwm, chip); }
> > +
> > +static inline void keembay_pwm_enable_channel(struct keembay_pwm
> > +*priv, int ch) {
> > +	u32 buff, offset;
> > +	void __iomem *address;
> > +
> > +	offset =3D PWM_LEADIN0_OFFSET + ch * 4;
> > +	address =3D priv->regmap + offset;
> > +	buff =3D readl(address);
> > +	buff |=3D BIT(KEEMBAY_PWM_EN_BIT);
> > +	writel(buff, address);
> > +}
> > +
> > +static inline void keembay_pwm_disable_channel(struct keembay_pwm
> > +*priv, int ch) {
> > +	u32 buff, offset;
> > +	void __iomem *address;
> > +
> > +	offset =3D PWM_LEADIN0_OFFSET + ch * 4;
> > +	address =3D priv->regmap + offset;
> > +	buff =3D readl(address);
> > +	buff &=3D ~BIT(KEEMBAY_PWM_EN_BIT);
> > +	writel(buff, address);
> > +}
>=20
> The two functions above could make use of keembay_pwm_update_bits().
>=20

Agreed, will update them to reflect this.

> > +
> > +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u=
32
> mask,
> > +					   u32 val, u32 reg, int ch)
> > +{
> > +	u32 buff, offset, tmp;
> > +	void __iomem *address;
> > +
> > +	offset =3D reg + ch * 4;
> > +	address =3D priv->regmap + offset;
> > +	buff =3D readl(address);
> > +	tmp =3D buff & ~mask;
> > +	tmp |=3D FIELD_PREP(mask, val);
> > +	writel(tmp, address);
> > +}
> > +
> > +static inline u32 keembay_pwm_config_min(struct keembay_pwm *priv) {
> > +	unsigned long long divd, divs;
> > +
> > +	divd =3D NSEC_PER_SEC;
> > +	divs =3D clk_get_rate(priv->clk);
> > +	do_div(divd, divs);
>=20
> Given that both NSEC_PER_SEC and the return value of clk_get_rate fit int=
o an
> unsigned long, this seems too much.
>=20

Noted, will modify to use a different data type.

> > +	return (u32)divd;
> > +}
> > +
> > +static inline u16 keembay_pwm_config_duty_cycle(struct keembay_pwm
> *priv,
> > +						int duty_ns, u32 ns_min)
> > +{
> > +	unsigned long long divd;
> > +
> > +	divd =3D duty_ns;
> > +	do_div(divd, ns_min);
> > +	if ((u16)divd =3D=3D 0)
> > +		return 0;
> > +
> > +	return (u16)divd - 1;
>=20
> missing range checking.
>=20

Will add this in.

> > +}
> > +
> > +static inline u16 keembay_pwm_config_period(struct keembay_pwm *priv,
> > +					    int period_ns,
> > +					    int duty_ns,
> > +					    u32 ns_min)
> > +{
> > +	unsigned long long divd;
> > +
> > +	divd =3D period_ns - duty_ns;
> > +	do_div(divd, ns_min);
> > +	if ((u16)divd =3D=3D 0)
> > +		return 0;
> > +
> > +	return (u16)divd - 1;
>=20
> I wonder if both keembay_pwm_config_duty_cycle() and
> keembay_pwm_config_period() would be easier to understand if they were no=
t
> separate functions but unrolled into their only user.
>=20
> As above there is no range checking.
>=20

OK - will move this into keembay_pwm_apply, and add the range check as well=
.

> > +}
> > +
> > +/*
> > + *	For calculating "high time" register value:
> > + *	High time (quotient only) =3D duty_cycle / ns_min
> > + *
> > + *	For calculating "low time" register value:
> > + *	Low time (quotient only) =3D (period - duty_cycle) / ns_min
> > + *
> > + *	All values used are in nanoseconds for calculation.
> > + */
> > +static int keembay_pwm_config(struct keembay_pwm *priv, int ch,
> > +			      int duty_ns, int period_ns, int count)
>=20
> this function is only called once, I wonder if it can better be folded in=
to its only
> user.
>=20

Will move this into keembay_pwm_apply.

> > +{
> > +	u32 ns_min;
> > +	u16 pwm_h_count, pwm_l_count;
> > +
> > +	/* Write to lead in */
> > +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_LEAD_IN_MASK,
> > +				LEAD_IN_DEFAULT,
> > +				PWM_LEADIN0_OFFSET, ch);
>=20
> What is the effect of this "lead in"?
>=20

It is used to specify a low period between the trigger(enable bit set) and =
start of the waveform.
So the PWM output remains low for the number of clock cycles specified by t=
his LEAD_IN value.

> > +	/* Write the number of PWM pulse repetition */
> > +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_RPT_CNT_MASK,
> count,
> > +				PWM_LEADIN0_OFFSET, ch);
>=20
> Is this racy? E.g. if the PWM is already running and just after you updat=
e the
> repetition count completes a period?
>=20

The repetition count will only take effect once the channel is disabled and=
 reenabled again.
So, it will not affect the currently running waveform.

> This writes to the same register as the lead in above. Can this be done i=
n a single
> register access?
>=20

Yes -- will change this to single access instead.=20

> > +	/* Calculate min */
> > +	ns_min =3D keembay_pwm_config_min(priv);
>=20
> What is "min"?
>=20

This refers to the ns equivalent of 1 clock cycle.
However, since the calculation for the high/low time will be changed in v2 =
(based on further comments below),=20
I will remove this.

> > +	/* For duty cycle */
> > +	pwm_h_count =3D keembay_pwm_config_duty_cycle(priv, duty_ns,
> ns_min);
>=20
> this is ineffective and less exact as possible. ns_min is the result of a=
 division and
> in keembay_pwm_config_duty_cycle you divide by it.
>=20

Understood - will change the formula used to get the high time/low time to =
something like below instead:
value =3D clk_rate * state->duty_cycle;
pwm_h_count =3D do_div(value, NSEC_PER_SEC);


> > +	/* Write to high registers */
> > +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_HIGH_MASK,
> pwm_h_count,
> > +				PWM_HIGHLOW0_OFFSET, ch);
> > +
> > +	/* For period */
> > +	pwm_l_count =3D keembay_pwm_config_period(priv, period_ns, duty_ns,
> > +						ns_min);
> > +
> > +	/* Write to low registers */
> > +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_LOW_MASK,
> pwm_l_count,
> > +				PWM_HIGHLOW0_OFFSET, ch);
>=20
> Can you please explain in a comment what's the resulting wave form for a =
given
> value of this register?
>=20

Okay, I will add a comment in the driver explaining this.
In summary, the upper/lower 16 bits of the register represent the waveform'=
s high/low time in number of clock cycles - 1.
e.g. for a period of 70000ns, duty cycle of 35000ns and clock rate of 500MH=
z:
The resulting register value would be 0x445B445B.

> Can writing h_count and l_count be combined in a single register access?
> (And if not, what happens if a period completes between the two
> updates?)
>=20
> How does the hardware behave on a change here? Is the currently running
> period completed before the new values take effect?
>=20

The write can be combined, I will make this change for v2.=20
As for the HW behaviour, yes, the current period will
be completed before the new configuration takes effect.

> > +
> > +	return 0;
> > +}
> > +
> > +static int keembay_pwm_enable(struct keembay_pwm *priv, int ch) {
> > +	int ret;
> > +
> > +	ret =3D clk_enable(priv->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable channel */
> > +	keembay_pwm_enable_channel(priv, ch);
> > +
> > +	return 0;
> > +}
> > +
> > +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch) {
> > +	/* Disable channel */
> > +	keembay_pwm_disable_channel(priv, ch);
> > +
> > +	clk_disable(priv->clk);
> > +}
> > +
> > +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			     const struct pwm_state *state) {
> > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > +
> > +	if (!state->enabled && pwm_is_enabled(pwm)) {
>=20
> Please don't call API functions in the driver.
>=20

Noted, will change this in v2.

> > +		keembay_pwm_disable(priv, pwm->hwpwm);
>=20
> Is a currently running period completed here? How does the output behave =
on
> disable? (i.e. does it go in its inactive state?)
>=20

Upon disable (the "enable" bit is cleared), the output signal is stopped/in=
active.
The currently running period will not be completed.

> > +		return 0;
> > +	}
> > +
> > +	if (state->count > PWM_COUNT_MAX)
> > +		return -EINVAL;
> > +
> > +	if (state->polarity !=3D pwm_get_polarity(pwm))
>=20
> Using:
>=20
> 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
>=20
> seems both more robust and easier to understand.
>=20

Will update this.

> > +		return -ENOSYS;
> > +
> > +	keembay_pwm_config(priv, pwm->hwpwm, state->duty_cycle,
> > +			   state->period, state->count);
> > +
> > +	if (state->enabled && !pwm_is_enabled(pwm))
> > +		return keembay_pwm_enable(priv, pwm->hwpwm);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops keembay_pwm_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.apply =3D keembay_pwm_apply,
>=20
> Please implement .get_state().
>=20

Will add this in v2.

> > +};
> > +
> > +static int keembay_pwm_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct keembay_pwm *priv;
> > +	int ret;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->clk))
>=20
> Error message please. (Something like:
>=20
> 		int ret =3D PTR_ERR(ret);
>=20
> 		if (ret !=3D -EPROBE_DEFER)
> 			dev_err(pdev->dev, "Failed to get clk: %pE\n", priv-
> >clk);
>=20
> 		return ret;
> )
>=20

Noted, I will add this in.

> > +		return PTR_ERR(priv->clk);
> > +
> > +	/*
> > +	 * Prepare clock here, and carry out clock enabling/disabling
> > +	 * during channel enablement/disablement.
> > +	 * The clock will not be unprepared due to shared usage with GPIO.
>=20
> What has this clock to do with GPIO? If the GPIO drivers gets and enables=
 this
> clock itself there should be no problem.
>=20

The PWM outputs are actually part of the GPIO block, hence use the same clo=
ck as it.
The current behaviour is unpreparing causes the system to hang - I will cro=
ss-check regarding this.

> > +	 */
> > +	ret =3D clk_prepare(priv->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to prepare PWM clock\n");
>=20
> Please include the error code in the message (preferably using %pE as abo=
ve).
>=20

Noted, will update.

> > +		return ret;
> > +	}
> > +
> > +	priv->regmap =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->regmap))
> > +		return PTR_ERR(priv->regmap);
> > +
> > +	priv->chip.base =3D -1;
> > +	priv->chip.dev =3D dev;
> > +	priv->chip.ops =3D &keembay_pwm_ops;
> > +	priv->chip.npwm =3D TOTAL_PWM_CHANNELS;
> > +
> > +	ret =3D pwmchip_add(&priv->chip);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to add PWM chip: %d\n", ret);
>=20
> %pE please.
>=20

Will update.

> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static int keembay_pwm_remove(struct platform_device *pdev) {
> > +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < priv->chip.npwm; i++)
> > +		pwm_disable(&priv->chip.pwms[i]);
>=20
> That's wrong. It's the responsibility of the consumer to disable the cloc=
k.
>=20

Noted, will remove this.

> > +
> > +	pwmchip_remove(&priv->chip);
>=20
> clk_unprepare missing here.
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id keembay_pwm_of_match[] =3D {
> > +	{ .compatible =3D "intel,keembay-pwm" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, keembay_pwm_of_match);
> > +
> > +static struct platform_driver keembay_pwm_driver =3D {
> > +	.probe	=3D keembay_pwm_probe,
> > +	.remove	=3D keembay_pwm_remove,
> > +	.driver	=3D {
> > +		.name =3D "pwm-keembay",
> > +		.of_match_table =3D keembay_pwm_of_match,
> > +	},
> > +};
> > +module_platform_driver(keembay_pwm_driver);
> > +
> > +MODULE_ALIAS("platform:keembay");
> > +MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
> MODULE_LICENSE("GPL
> > +v2");
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
