From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/7] pwm: st: Add new driver for ST's PWM IP
Date: Thu, 19 Jun 2014 09:44:04 +0100
Message-ID: <20140619084404.GA26560@lee--X1>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-6-git-send-email-lee.jones@linaro.org>
 <20140618231127.GF26514@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140618231127.GF26514@mithrandir>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

I'll comment on some of the more fluffy topics, I'll let Ajit reply to
the more technical details of the patch.

On Thu, 19 Jun 2014, Thierry Reding wrote:
> On Wed, Jun 18, 2014 at 03:52:51PM +0100, Lee Jones wrote:
> > This driver supports all current STi platforms' PWM IPs.
> >=20
> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/pwm/Kconfig  |   9 ++
> >  drivers/pwm/Makefile |   1 +
> >  drivers/pwm/pwm-st.c | 378 +++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  3 files changed, 388 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-st.c
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 4ad7b89..98a7bbc 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -292,4 +292,13 @@ config PWM_VT8500
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-vt8500.
> > =20
> > +config PWM_ST
>=20
> PWM_ST is awfully generic, perhaps PWM_STI would be a better choice?
> Even that's very generic. Maybe PWM_STI_H4XX? There's nothing wrong w=
ith
> supporting STiH{5,6,7,...}xx SoCs with such a driver. I'm just trying=
 to
> think ahead what will happen if at some point a new SoC family is
> released that requires a different driver.

I'm inclined to agree with you, but as it stands, this driver supports
all ST h/w, so it's correct for it to be generic.  If some new IP
comes into fuition, at worst we'll have to change the name of the
driver.  I'm happy to put myself on the line for that if the time
comes.

> > diff --git a/drivers/pwm/pwm-st.c b/drivers/pwm/pwm-st.c
> [...]
> > +/*
> > + * PWM device driver for ST SoCs.
> > + * Author: Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>
>=20
> Given this line, shouldn't the commit contain Ajit Pal Singh's
> Signed-off-by?

Absolutely, this is a failing on my part - will be applied in v2.

> > + *
> > + * Copyright (C) 2003-2014 STMicroelectronics (R&D) Limited
>=20
> Was this driver really developed over a period of 11 years?

Probably, in one incarnation or other, but I'll speak to Ajit and see
if we can narrow this down to just this version.

> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License, =
or
> > + * (at your option) any later version.
> > + *
>=20
> Nit: no need for this extra blank line at the end of the comment.

Very well.

> > + */
> > +#include <linux/bsearch.h>
>=20
> I prefer a blank line between the above two

Me too.  Will change.

> > +#include <linux/clk.h>
> > +#include <linux/math64.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/time.h>
>=20
> These should be sorted alphabetically.

Really? :)

> > +
> > +#define ST_PWMVAL(x)	(4 * (x))	/* Value used to define duty cycle =
*/
>=20
> "x" seems to designate the channel number, so perhaps make that clear=
er
> by naming the variable "ch"? Also in that case the comment is somewha=
t
> misleading.

Sure, will redefine.

> > +#define ST_PWMCR	0x50		/* Control/Config reg */
> > +#define ST_INTEN	0x54		/* Interrupt Enable/Disable reg */
> > +#define ST_CNT		0x60		/* PWMCounter */
>=20
> I'd prefer s/reg/register/ and also use it consistently for the ST_CN=
T
> as well.

Okay.

> > +
> > +#define MAX_PWM_CNT_DEFAULT	255
> > +#define MAX_PRESCALE_DEFAULT	0xff
> > +#define NUM_CHAN_DEFAULT	1
>=20
> These are only used in one place and their meaning is fairly obvious,=
 so
> I'd just drop them.

I _always_ prefer defines over magic numbers, but as you wish - will fi=
x.

> > +/* Regfield IDs */
> > +enum {
> > +	PWMCLK_PRESCALE =3D 0,
>=20
> No need for "=3D 0".

It's more for clarity rather than technical requirement, but will remov=
e.

> > +	PWM_EN,
> > +	PWM_INT_EN,
> > +	/* keep last */
> > +	MAX_REGFIELDS
> > +};
> > +
> > +struct st_pwm_chip {
> > +	struct device *dev;
> > +	struct clk *clk;
> > +	unsigned long clk_rate;
> > +	struct regmap *regmap;
> > +	struct st_pwm_compat_data *cdata;
>=20
> Doesn't this require a predeclaration of struct st_pwm_compat_data? O=
r
> maybe just move struct st_pwm_compat_data before this.

You're right, will fix.

I think I would have expected at least a compiler warning about that?

> > +	struct regmap_field *prescale;
> > +	struct regmap_field *pwm_en;
> > +	struct regmap_field *pwm_int_en;
> > +	unsigned long *pwm_periods;
> > +	struct pwm_chip chip;
> > +	void __iomem *mmio_base;
>=20
> mmio_base is somewhat long, maybe "mmio" or "base" would work equally
> well?

Okay.

> > +};
> > +
> > +struct st_pwm_compat_data {
> > +	const struct reg_field *reg_fields;
> > +	int num_chan;
> > +	int max_pwm_cnt;
> > +	int max_prescale;
>=20
> Can't these three be unsigned?

I see no reason why not.  They can also be signed. :)

> > +};
> > +
> > +static const struct reg_field st_pwm_regfields[MAX_REGFIELDS] =3D =
{
> > +	[PWMCLK_PRESCALE]	=3D REG_FIELD(ST_PWMCR, 0, 3),
> > +	[PWM_EN]		=3D REG_FIELD(ST_PWMCR, 9, 9),
> > +	[PWM_INT_EN]		=3D REG_FIELD(ST_INTEN, 0, 0),
> > +};
> > +
> > +static inline struct st_pwm_chip *to_st_pwmchip(struct pwm_chip *c=
hip)
> > +{
> > +	return container_of(chip, struct st_pwm_chip, chip);
> > +}
> > +
> > +/*
> > + * Calculate the period values supported by the PWM for the
> > + * current clock rate.
> > + */
> > +static void st_pwm_calc_periods(struct st_pwm_chip *pc)
> > +{
> > +	struct st_pwm_compat_data *cdata =3D pc->cdata;
> > +	struct device *dev =3D pc->dev;
> > +	unsigned long val;
> > +	int i;
>=20
> unsigned?

Why?

It's much more common this way:

$ git grep $'\t'"int i;" | wc -l
17018
$ git grep $'\t'"unsigned int i;" | wc -l
2033

> > +
> > +	/*
> > +	 * period_ns =3D (10^9 * (prescaler + 1) * (MAX_PWM_COUNT + 1)) /=
 CLK_RATE
> > +	 */
> > +	val =3D NSEC_PER_SEC / pc->clk_rate;
> > +	val *=3D cdata->max_pwm_cnt + 1;
> > +
> > +	dev_dbg(dev, "possible periods for clkrate[HZ]:%lu\n", pc->clk_ra=
te);
> > +
> > +	for (i =3D 0; i <=3D cdata->max_prescale; i++) {
> > +		pc->pwm_periods[i] =3D val * (i + 1);
> > +		dev_dbg(dev, "prescale:%d, period[ns]:%lu\n",
> > +			i, pc->pwm_periods[i]);
> > +	}
> > +}
> > +
> > +static int st_pwm_cmp_periods(const void *key, const void *elt)
> > +{
> > +	unsigned long i =3D *(unsigned long *)key;
> > +	unsigned long j =3D *(unsigned long *)elt;
> > +
> > +	if (i < j)
> > +		return -1;
> > +	else
> > +		return i =3D=3D j ? 0 : 1;
> > +}
> > +
> > +/*
> > + * For STiH4xx PWM IP, the pwm period is fixed to 256 local clock =
cycles.
>=20
> s/pwm/PWM/ in prose. There are probably other occurrences of this
> throughout the driver.

Will change.

> > + * The only way to change the period (apart from changing the pwm =
input clock)
> > + * is to change the pwm clock prescaler.
> > + * The prescaler is of 4 bits, so only 16 prescaler values and hen=
ce only
>=20
> I'm confused. This says there are 16 prescaler values, but at the sam=
e
> time the default maximum number of prescaler values is set to 255. Am=
 I
> missing something?

I'll let Ajit answer this one, as he holds the technical documentation.

> > + * 16 possible period values are supported (for a particular clock=
 rate).
> > + * The requested period will be applied only if it matches one of =
these
> > + * 16 values.
> > + */
> > +static int st_pwm_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +			 int duty_ns, int period_ns)
> > +{
> > +	struct st_pwm_chip *pc =3D to_st_pwmchip(chip);
> > +	struct device *dev =3D pc->dev;
> > +	struct st_pwm_compat_data *cdata =3D pc->cdata;
> > +	unsigned int prescale, pwmvalx;
> > +	unsigned long *found;
> > +	int ret;
> > +
> > +	/*
> > +	 * Search for matching period value. The corresponding index is o=
ur
> > +	 * prescale value
> > +	 */
> > +	found =3D bsearch(&period_ns, &pc->pwm_periods[0],
>=20
> Technically doesn't period_ns need to be converted to an unsigned lon=
g
> here? Otherwise this won't be compatible with 64-bit architectures.
> Admittedly that's maybe not something relevant for this family of SoC=
s,
> but you never know where this driver will be used eventually.

This driver depends on ARCH_STI which only supports 32bit.

> > +			cdata->max_prescale + 1, sizeof(unsigned long),
> > +			st_pwm_cmp_periods);
> > +	if (!found) {
> > +		dev_err(dev, "failed to find matching period\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	prescale =3D found - &pc->pwm_periods[0];
>=20
> This is somewhat unconventional. None of the other drivers precompute
> possible periods and I'm not convinced that it's an advantage. Settin=
g
> the period (and configuring the PWM in general) is a fairly uncommon
> operation.

Another one for Ajit I feel.

> > +	/*
> > +	 * When PWMVal =3D=3D 0, PWM pulse =3D 1 local clock cycle.
> > +	 * When PWMVal =3D=3D max_pwm_count,
> > +	 * PWM pulse =3D (max_pwm_count + 1) local cycles,
> > +	 * that is continuous pulse: signal never goes low.
> > +	 */
> > +	pwmvalx =3D cdata->max_pwm_cnt * duty_ns / period_ns;
> > +
> > +	dev_dbg(dev, "prescale:%u, period:%i, duty:%i, pwmvalx:%u\n",
> > +		prescale, period_ns, duty_ns, pwmvalx);
> > +
> > +	/* Enable clock before writing to PWM registers */
> > +	ret =3D clk_enable(pc->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_field_write(pc->prescale, prescale);
> > +	if (ret)
> > +		goto clk_dis;
>=20
> So the prescaler is shared between all channels? In that case I think
> you should check for conflicting settings to prevent one channel from
> stomping on the other.

Ajit, if you'd be so kind.

> > +
> > +	ret =3D regmap_write(pc->regmap, ST_PWMVAL(pwm->hwpwm), pwmvalx);
> > +	if (ret)
> > +		goto clk_dis;
> > +
> > +	ret =3D regmap_field_write(pc->pwm_int_en, 0);
>=20
> This seems to be never set to any other value, so perhaps it should b=
e
> set at .probe() time?

Unfortunately not, as the clk needs to be enabled whilst setting IRQ
state.  Moving it into .probe() would mean wrapping this command
between clk_enable() and clk_disable(), which I think it a waste.

> > +
> > +clk_dis:
> > +	clk_disable(pc->clk);
> > +	return ret;
> > +}
> > +
> > +static int st_pwm_enable(struct pwm_chip *chip, struct pwm_device =
*pwm)
> > +{
> > +	struct st_pwm_chip *pc =3D to_st_pwmchip(chip);
> > +	struct device *dev =3D pc->dev;
> > +	int ret;
> > +
> > +	ret =3D clk_enable(pc->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_field_write(pc->pwm_en, 1);
> > +	if (ret)
> > +		dev_err(dev, "%s,pwm_en write failed\n", __func__);
>=20
> This error message is somewhat cryptic, perhaps:
>=20
> 	"failed to enable PWM"

Agreed.  I also can't believe I missed that nasty __func__ too.

> ? Also what implications does this have on controllers with multiple
> channels?

I believe this enables both channels, but I'm sure Ajit will correct
me if I'm wrong.

> > +
> > +	return ret;
> > +}
> > +
> > +static void st_pwm_disable(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> > +{
> > +	struct st_pwm_chip *pc =3D to_st_pwmchip(chip);
> > +	struct device *dev =3D pc->dev;
> > +	unsigned int val;
> > +
> > +	regmap_field_write(pc->pwm_en, 0);
>=20
> Does this turn off the second channel as well?

Ajit, what happens if the other channel is still in use?

> > +
> > +	regmap_read(pc->regmap, ST_CNT, &val);
>=20
> Does this read have any other use beyond the debugging output below?

Doesn't look like it does it.  Ajit, can this be removed?

> > +	dev_dbg(dev, "pwm counter :%u\n", val);
> > +
> > +	clk_disable(pc->clk);
> > +}
> > +
> > +static const struct pwm_ops st_pwm_ops =3D {
> > +	.config =3D st_pwm_config,
> > +	.enable =3D st_pwm_enable,
> > +	.disable =3D st_pwm_disable,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static int st_pwm_probe_dt(struct st_pwm_chip *pc)
> > +{
> > +	struct device *dev =3D pc->dev;
> > +	const struct reg_field *reg_fields;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct st_pwm_compat_data *cdata =3D pc->cdata;
> > +	u32 num_chan;
> > +
> > +	of_property_read_u32(np, "st,pwm-num-chan", &num_chan);
> > +	if (num_chan)
> > +		cdata->num_chan =3D num_chan;
>=20
> I don't like this very much. What influences the number of channels? =
Is
> it that specific SoC revisions have one and others have two?

Ajit?

> > +	reg_fields =3D cdata->reg_fields;
> > +
> > +	pc->prescale =3D devm_regmap_field_alloc(dev, pc->regmap,
> > +					       reg_fields[PWMCLK_PRESCALE]);
> > +	pc->pwm_en =3D devm_regmap_field_alloc(dev, pc->regmap,
> > +					     reg_fields[PWM_EN]);
> > +	pc->pwm_int_en =3D devm_regmap_field_alloc(dev, pc->regmap,
> > +						 reg_fields[PWM_INT_EN]);
> > +
> > +	if (IS_ERR(pc->prescale) ||
> > +	    IS_ERR(pc->pwm_en)   ||
> > +	    IS_ERR(pc->pwm_int_en)) {
> > +		dev_err(dev, "unable to allocate reg_field(s)\n");
> > +		return -EINVAL;
> > +	}
>=20
> You're obfuscating error codes here. A better approach would be to ch=
eck
> each of these individually and return PTR_ERR(pc->...) to report the
> most accurate error code.

Agreed, will change.

> > +
> > +	return 0;
> > +}
> > +
> > +static struct regmap_config st_pwm_regmap_config =3D {
>=20
> static const

Good catch.

> > +	.reg_bits   =3D 32,
> > +	.val_bits   =3D 32,
> > +	.reg_stride =3D 4,
> > +};
>=20
> Please drop the artificial padding. A single space on each side of '=3D=
'
> will do just fine.

/me likes straight lines!

=2E.. but as you wish.

> > +static int st_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct st_pwm_compat_data *cdata;
> > +	struct st_pwm_chip *pc;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	if (!np) {
> > +		dev_err(dev, "failed to find device node\n");
> > +		return -EINVAL;
> > +	}
>=20
> I have difficulty imagining how this condition would ever happen. Can
> this check not simply be removed?

Although true, this check is very common.  I wonder if they can _all_
be removed from OF only drivers?  Probably something worth bringing up
with the DT guys.

> > +	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> > +	if (!pc)
> > +		return -ENOMEM;
> > +
> > +	cdata =3D devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
> > +	if (!cdata)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +	pc->mmio_base =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(pc->mmio_base)) {
> > +		dev_err(dev, "failed to find and map memory resources\n");
>=20
> No need for this error message. devm_ioremap_resource() will provide =
one
> for you.
>=20
> > +		return PTR_ERR(pc->mmio_base);
> > +	}
> > +
> > +	pc->regmap =3D devm_regmap_init_mmio(dev, pc->mmio_base,
> > +					   &st_pwm_regmap_config);
> > +	if (IS_ERR(pc->regmap))
> > +		return PTR_ERR(pc->regmap);
> > +
> > +	/*
> > +	 * Setup PWM data with default values: some values could be repla=
ced
> > +	 * with specific ones provided from device tree
>=20
> Nit: this is a sentence and therefore should be terminated with a ful=
l
> stop.

:)

> > +	 */
> > +	cdata->reg_fields   =3D &st_pwm_regfields[0];
>=20
> Why not simply "=3D st_pwm_regfields;"?

Although semantically the same, I think what we're trying to achieve
is more obvious at first glance in the current format.

But will fix if you are insistent.

> > +	cdata->max_pwm_cnt  =3D MAX_PWM_CNT_DEFAULT;
> > +	cdata->max_prescale =3D MAX_PRESCALE_DEFAULT;
> > +	cdata->num_chan     =3D NUM_CHAN_DEFAULT;

Look at those lovely straight lines.  Are you sure you want me to
unalign the regmap_config above?

> > +	pc->cdata =3D cdata;
> > +	pc->dev =3D dev;
> > +
> > +	ret =3D st_pwm_probe_dt(pc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pc->pwm_periods =3D devm_kzalloc(dev,
> > +			sizeof(unsigned long) * (pc->cdata->max_prescale + 1),
>=20
> This could use a temporary variable to make this shorter. I'd still u=
rge
> you to consider dropping the cache here, in which case you don't need
> this allocation in the first place.

Ajit, what would you like to do?

> > +			GFP_KERNEL);
> > +	if (!pc->pwm_periods)
> > +		return -ENOMEM;
> > +
> > +	pc->clk =3D of_clk_get_by_name(np, "pwm");
>=20
> devm_clk_get(&pdev->dev, "pwm")?

Sure.

> > +	if (IS_ERR(pc->clk)) {
> > +		dev_err(dev, "failed to get pwm clock\n");
> > +		return PTR_ERR(pc->clk);
> > +	}
> > +
> > +	pc->clk_rate =3D clk_get_rate(pc->clk);
> > +	if (!pc->clk_rate) {
> > +		dev_err(dev, "failed to get clk rate\n");
>=20
> "... clock rate\n"

clk is a well known synonym for clock in Linux and can be found
throughout many bootlogs, but again, happy to change if it's causing
issues.

> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D clk_prepare(pc->clk);
> > +	if (ret) {
> > +		dev_err(dev, "failed to prepare clk\n");
>=20
> "... prepare clock\n"

As above.

> > +		return ret;
> > +	}
> > +
> > +	st_pwm_calc_periods(pc);
> > +
> > +	pc->chip.dev =3D dev;
> > +	pc->chip.ops =3D &st_pwm_ops;
> > +	pc->chip.base =3D -1;
> > +	pc->chip.npwm =3D pc->cdata->num_chan;
> > +	pc->chip.can_sleep =3D true;
> > +
> > +	ret =3D pwmchip_add(&pc->chip);
> > +	if (ret < 0) {
> > +		clk_unprepare(pc->clk);
> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, pc);
> > +
> > +	return 0;
> > +}
> > +
> > +static int st_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct st_pwm_chip *pc =3D platform_get_drvdata(pdev);
> > +	int i;
>=20
> unsigned

As above.

> > +
> > +	for (i =3D 0; i < pc->cdata->num_chan; i++)
> > +		pwm_disable(&pc->chip.pwms[i]);
> > +
> > +	clk_unprepare(pc->clk);
> > +
> > +	return pwmchip_remove(&pc->chip);
> > +}
> > +
> > +static struct of_device_id st_pwm_of_match[] =3D {
>=20
> static const

Good catch.

> > +	{ .compatible =3D "st,sti-pwm", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, st_pwm_of_match);
> > +
> > +static struct platform_driver st_pwm_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "st-pwm",
> > +		.owner  =3D THIS_MODULE,
>=20
> No need for this, module_platform_driver() will set it for you. Also
> please drop the artificial padding above and below.

Will remove.

> > +		.of_match_table =3D st_pwm_of_match,
> > +	},
> > +	.probe		=3D st_pwm_probe,
> > +	.remove		=3D st_pwm_remove,
> > +};
> > +module_platform_driver(st_pwm_driver);
> > +
> > +MODULE_AUTHOR("STMicroelectronics (R&D) Limited <ajitpal.singh@st.=
com>");
>=20
> This doesn't look right. Shouldn't the author be the same as in the
> header comment here? The email address matches that, but the company
> name is usually not a good fit for the MODULE_AUTHOR field.

Agree, will change.

> > +MODULE_DESCRIPTION("STMicroelectronics ST PWM driver");
> > +MODULE_LICENSE("GPL v2");
>=20
> According to the file header comment this should be simply "GPL".

Will check with ST.

> Thierry

Thanks Thierry.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
