Return-Path: <B47053@freescale.com>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCH 1/4] pwm: add freescale ftm pwm driver support
Date: Mon, 26 Aug 2013 07:32:23 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827E42BD@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-2-git-send-email-Li.Xiubo@freescale.com>
 <20130823090523.GF3535@ulmo>
In-Reply-To: <20130823090523.GF3535@ulmo>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Guo Shawn-R65073 <r65073@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Lu Jingchang-B35083 <B35083@freescale.com>

Hi Thierry,

See the comments below.


> I think the correct capitalizations are: "Freescale", "FTM" and "PWM".
> There are other occurrences in the rest of the driver that I haven't
> explicitly pointed out.
>=20

Yes, that's much better.


> > +config PWM_FTM
>=20
> Perhaps name this PWM_FSL_FTM to match the driver name?
>=20

OK.


> And fix this up to be "pwm-fsl-ftm".

Yes, I will.


> > +#define FTM_CSC_BASE        0x0C
> > +#define FTM_CSC(_CHANNEL) \
> > +	(FTM_CSC_BASE + (_CHANNEL * 0x08))
>=20
> I prefer lowercase variables in macros:
>=20
> 	#define FTM_CSC(channel) \
> 		(FTM_CSC_BASE + (channel * 8))
>=20
Yes, That's better.


> > +#define FTM_PWMMODE         (FTMCnSC_MSB)
> > +#define FTM_HIGH_TRUE       (FTMCnSC_ELSB)
> > +#define FTM_LOW_TRUE        (FTMCnSC_ELSA)
>=20
> What's the reason for redefining these? Can't you just use the FTMCnSC_*
> defines directly?
>=20

Just for more readable and comprehension.
I will revise it by not losing above two key elements.=20

> > +#define FTM_CV(_CHANNEL) \
> > +	(FTM_CV_BASE + (_CHANNEL * 0x08))
>=20
> Same comment as for FTM_CSC above.
>

Yes.
=20
> > +#define FTM_MAX_CHANNEL     0x08
>=20
> There should be no need for this. The only place where you use this is
> when assigning it to pwm_chip.npwm, so you may as well use the literal
> there.
>=20

I have recoded the driver, and the macro is used more than one time now.


> > +	struct platform_device *pdev;
>=20
> You never use this platform_device. And you have to assign &pdev->dev to
> the pwm_chip.dev anyway, so why not just use that consistently and drop
> the pdev field?
>

Yes, I have droped the pdev field now.
=20

> > +	unsigned int	cpwm;
> > +	struct fsl_pwm fpwms[FTM_MAX_CHANNEL];
>=20
> Please don't do this. Use pwm_set_chip_data()/pwm_get_chip_data() to
> associate per-channel specific data.
>

I have replaced them now.
=20
> > +	/* pinctrl handles */
>=20
> Nit: it's only a single handle.
>=20

Yes.

> > +	struct pinctrl          *pinctrl;
>=20
> You also use tabs and spaces inconsistently here. I suggest you use a
> single space between the data type and the field name, that way it's much
> easier to stay consistent.
>=20

Now I have revised all about this.

> > +static int fsl_pwm_request_channel(struct pwm_chip *chip,
> > +			       struct pwm_device *pwm)
>=20
> The arguments on the trailing line aren't properly aligned. They should
> be aligned with the arguments on the first line.
>=20

The same as the above comment.


> > +	ret =3D clk_prepare_enable(fpc->clk);
>=20
> This should probably be just clk_prepare(). Or is there some reason why
> you can't delay clk_enable() to the .enable() operation?
>=20

Firstly, we should be clear that the fpc->clk is chip's work clock.
If so, after the .request() is called and before .enable() is called, the c=
ustumer will call .config(),=20
in which will read/write the pwm chip registers, if the module clock is sti=
ll disabled, then the system will hang up.


> > +static int fsl_updata_config(struct fsl_pwm_chip *fpc,
> > +			     struct pwm_device *pwm)
>=20
> Parameter alignment again. Please also check all other functions.
>=20

Yes, I have revise all about this.

> > +{
> > +	int i;
>=20
> This should be unsigned int.
>=20

I will revise it.

> > +static unsigned long
> > +fsl_rate_to_cycles(struct fsl_pwm_chip *fpc, int time_ns)
>=20
> The above two lines are 78 characters when joined, so there's no need to
> split them.
>=20

OK, I have revise all about this.

> Perhaps time_ns should be "unsigned long"?
>=20

Shouldn't this be same with "int duty_ns" and "int period_ns", which are de=
fined by=20
struct pwm_ops {
...
	int (*config)(struct pwm_chip *chip,
                    struct pwm_device *pwm,
                    int duty_ns, int period_ns);
...
}  ?


> > +	ps =3D (0x01 << fpc->clk_ps);
>=20
> This is fairly short, so you could do it along with the variable
> declaration. Also there's no need for the parentheses or the hexadecimal
> prefix (0x01 =3D=3D 1):
>=20
> 	unsigned long ps =3D 1 << fpc->clk_ps;
>=20

OK, I will revise it then.

> > +	/* The module clk is HZ/s, the time_ns parameter
> > +	 * is based nanosecond, so here should divide
> > +	 * 1000000000UL.
> > +	 */
>=20
> Block comments should be:
>=20
> 	/*
> 	 * ...
> 	 * ...
> 	 */
>=20
> Also HZ/s isn't a valid unit for a clock frequency. And time_ns also has
> the _ns suffix to designate the unit, so as a whole that comment doesn't
> add any real information and can just as well be dropped.
>=20

I will revise it.

> > +static int fsl_pwm_config_channel(struct pwm_chip *chip,
>=20
> I think you can safely drop the _channel suffix from the PWM operations.
>=20

By adding _channel suffix just for more comprehensave about the pwm's muti-=
channel operation.
If this is redundant here, I will drop it.


> > +	fpc =3D to_fsl_chip(chip);
> > +
> > +	if (WARN_ON(!test_bit(PWMF_REQUESTED, &pwm->flags)))
> > +		return -ESHUTDOWN;
>=20
> Erm... how do you think this could ever happen? Users need to request a
> PWM to obtain a struct pwm_device, in which case PWMF_REQUESTED will
> always be set. There are a few other occurrences throughout the rest of
> the driver that I haven't pointed out explicitly.
>=20

Does the following case is exist ?
The customer in one thread has .free(pwm_1), while in another thread,=20
which maybe had slept in for some reason, will call .config/.enable/.disabl=
e?

If so, as I have explained before, if the pwm_1 has been freed, the module =
clock maybe
disabled too, so if the .config is call the system will hang up.



> > +	fpc->fpwms[pwm->hwpwm].period_cycles =3D period_cycles;
> > +	fpc->fpwms[pwm->hwpwm].duty_cycles =3D duty_cycles;
>=20
> You use these for the sole purpose of passing them into the
> fsl_updata_config() function, so I wonder why you can't just pass them as
> parameters and get rid of struct fsl_pwm as a bonus?
>=20

Before I think the fpc has all the information the fsl_update_config() func=
tion needed.

Now, I have dropt the fsl_update_config() function.


> > +	fsl_updata_config(fpc, pwm);
>=20
> And now that I think about it: perhaps this was supposed to be called
> fsl_update_config() instead of fsl_updat*a*_config()?
>=20
Well, a written mistake.


> > +	reg &=3D ~(0x01 << pwm->hwpwm);
>=20
> This would be slightly more canonical as:
>=20
> 	reg &=3D ~BIT(pwm->hwpwm);
>=20

Yes, looks much better.

> > +	reg |=3D (polarity << pwm->hwpwm);
>=20
> And perhaps here it would be better to be explicit. I think it's unlikely
> that enum pwm_polarity will even gain a third entry, but better be safe
> than sorry:
>=20
> 	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> 		reg |=3D BIT(pwm->hwpwm);
> 	else
> 		reg &=3D ~BIT(pwm->hwpwm);
>=20

I will think it over.
While only the polarity's bit0 is used for polarity's statement. If other b=
it won't has any other
meaning and purpose in the feature, I will replace it derictly.

> > +static int is_any_other_channel_enabled(struct pwm_chip *chip,
> > +				    unsigned int cur)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < chip->npwm; i++) {
> > +		if (i =3D=3D cur)
> > +			continue;
> > +		if (test_bit(PWMF_ENABLED, &chip->pwms[i].flags))
> > +			return 1;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> This can probably be better done using a reference/enable count. Instead
> of having to iterate over all PWM channels of the chip and checking their
> flags, just keep track of how many times .enable() and .disable() are
> called.
>=20
> To make it easier you can probably wrap that into two functions, such as
> fsl_clock_enable() and fsl_clock_disable().
>=20
> > +static int fsl_pwm_enable_channel(struct pwm_chip *chip,
> > +			      struct pwm_device *pwm)
> > +{
> [...]
> > +	if (is_any_other_channel_enabled(chip, pwm->hwpwm))
> > +		return 0;
>=20
> This is where you'd call fsl_clock_enable()...
>=20
> > +	reg =3D readl(fpc->base + FTM_SC);
> > +	reg &=3D ~((FTMSC_CLK_MASK << FTMSC_CLK_OFFSET) |
> > +			(FTMSC_PS_MASK << FTMSC_PS_OFFSET));
> > +	/* select system clock source */
> > +	reg |=3D (FTMSC_CLKSYS | fpc->clk_ps);
> > +	writel(reg, fpc->base + FTM_SC);
>=20
> ... and run this code in fsl_clock_enable() if the enable count is 0 to
> select the system clock when the first PWM is enabled.
>=20
> > +static void fsl_pwm_disable_channel(struct pwm_chip *chip,
> > +				struct pwm_device *pwm)
> > +{
> [...]
> > +	if (is_any_other_channel_enabled(chip, pwm->hwpwm))
> > +		return;
>=20
> Then call fsl_clock_disable() here...
>=20
> > +	writel(0xFF, fpc->base + FTM_OUTMASK);
> > +	reg =3D readl(fpc->base + FTM_SC);
> > +	reg &=3D ~(FTMSC_CLK_MASK << FTMSC_CLK_OFFSET);
> > +	writel(reg, fpc->base + FTM_SC);
>=20
> ... and run this code in fsl_clock_disable() if the enable count reaches
> 0 so that the clock is disabled when no PWM channels remain on.
>=20

I will think it over and recode about this.


> > +static int fsl_pwm_parse_dt(struct fsl_pwm_chip *fpc) {
> [...]
> > +	int ret =3D 0;
> > +	u32 chs[FTM_MAX_CHANNEL];
> > +	struct device_node *np =3D fpc->pdev->dev.of_node;
> > +
> > +	ret =3D of_property_read_u32(np, "fsl,pwm-clk-ps",
> > +				   &fpc->clk_ps);
> > +	if (ret < 0) {
> > +		dev_err(&fpc->pdev->dev,
> > +				"failed to get pwm "
> > +				"clk prescaler : %d\n",
> > +				ret);
>=20
> Perhaps it's more useful to mention the missing property explicitly in
> the error message:
>=20
> 		dev_err(fpc->chip.dev,
> 			"failed to parse \"fsl,pwm-clk-ps\" property: %d\n",
> 			ret);
>=20

Whil I think the following is better in code.=20
=20
 		dev_err(fpc->chip.dev,
 			"failed to parse <fsl,pwm-clk-ps> property: %d\n",
 			ret);



>=20
> > +		return ret;
> > +	}
> > +	if (fpc->clk_ps > 7 || fpc->clk_ps < 0)
>=20
> clk_ps is unsigned and therefore can't be < 0. And a blank line would be
> useful between the previous line ("}") and this line.
>=20

I will revise it.

> > +static int fsl_pwm_probe(struct platform_device *pdev) {
> > +	int ret =3D 0;
> > +	struct fsl_pwm_chip *fpc;
> > +	struct resource *res;
> > +
> > +	fpc =3D devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> > +	if (!fpc) {
> > +		dev_err(&pdev->dev,
> > +				"failed to allocate memory\n");
>=20
> I don't think that's very useful either. If this should indeed ever fail,
> then the driver core will complain about the probe failing and include
> the error code. Since it's the only location where you return that error
> code you know immediately what went wrong.
>=20

Yes, for the devm_kzlloc() have print out the fail reason, this will be red=
undant.
I have revised all about this.

> > +		return -ENOMEM;
> > +	}
> > +
> > +	mutex_init(&fpc->lock);
> > +
> > +	fpc->pdev =3D pdev;
> > +
> > +	ret =3D fsl_pwm_parse_dt(fpc);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	fpc->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(fpc->base)) {
> > +		dev_err(&pdev->dev,
> > +				"failed to ioremap() registers\n");
>=20
> No need for this error message. devm_ioremap_resource() prints out errors
> already on failure.
>=20

The same comment as the last one.

> > +	fpc->chip.dev =3D &pdev->dev;
> > +	fpc->chip.ops =3D &fsl_pwm_ops;
> > +	fpc->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > +	fpc->chip.of_pwm_n_cells =3D 3;
> > +	fpc->chip.base =3D -1;
> > +
> > +	ret =3D pwmchip_add(&fpc->chip);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev,
> > +				"failed to add ftm0 pwm chip %d\n",
> > +				ret);
>=20
> dev_err() will already include the device name in the error message, so I
> don't think you need the "ftm0" here. Also make sure to use the correct
> capitalization for "PWM". And there is no need to split this over so many
> lines, it all fits on a single line just fine. There are other
> occurrences of this, so please double-check.
>=20

Yes.
I have revise all about this.



Thanks very much.

--
Best Regards.
Xiubo
