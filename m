Return-Path: <B47053@freescale.com>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
Date: Mon, 2 Sep 2013 03:33:37 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827F785F@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
 <1377856132-11290-2-git-send-email-Li.Xiubo@freescale.com>
 <20130830174909.GF30088@pengutronix.de>
In-Reply-To: <20130830174909.GF30088@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Guo Shawn-R65073 <r65073@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Lu Jingchang-B35083 <B35083@freescale.com>


> > +static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	struct fsl_pwm_chip *fpc;
> > +	struct fsl_pwm_data *pwm_data;
> > +
> > +	fpc =3D to_fsl_chip(chip);
> > +
> > +	pwm_data =3D pwm_get_chip_data(pwm);
> > +	if (!pwm_data)
> > +		return;
>=20
> THis check seems unnecessary.
>=20

But if do not check it here, I must check it in the following code.

> > +
> > +	if (pwm_data->available !=3D FSL_AVAILABLE)
> > +		return;
> > +

So the ' struct fsl_pwm_data' may be removed in the future.

>=20
> > +
> > +
> > +	pwm_data->period_cycles =3D period_cycles;
> > +	pwm_data->duty_cycles =3D duty_cycles;
>=20
> These fields are set but never read. Please drop them.
>=20
> If you drop the 'available' field also the you can drop chip_data
> completely.
>=20

I think I may move the 'available' field to the PWM driver data struct.

> > +
> > +	writel(FTMCnSC_MSB | FTMCnSC_ELSB, fpc->base + FTM_CSC(pwm->hwpwm));
> > +
> > +	writel(0xF0, fpc->base + FTM_OUTMASK);
> > +	writel(0x0F, fpc->base + FTM_OUTINIT);
> > +	writel(FTM_CNTIN_VAL, fpc->base + FTM_CNTIN);
> > +
> > +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> > +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_pwm_set_polarity(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +				enum pwm_polarity polarity)
> > +{
> > +	unsigned long reg;
> > +	struct fsl_pwm_data *pwm_data;
> > +	struct fsl_pwm_chip *fpc;
> > +
> > +	fpc =3D to_fsl_chip(chip);
> > +
> > +	pwm_data =3D pwm_get_chip_data(pwm);
> > +	if (!pwm_data)
> > +		return -EINVAL;
> > +
> > +	if (pwm_data->available !=3D FSL_AVAILABLE)
> > +		return -EINVAL;
> > +
> > +	reg =3D readl(fpc->base + FTM_POL);
> > +	reg &=3D ~BIT(pwm->hwpwm);
>=20
> Either drop this line...
>=20

This is just for unmasking this bit field.
Here it's not needed, so I will revise it.

> > +	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> > +		reg |=3D BIT(pwm->hwpwm);
> > +	else
> > +		reg &=3D ~BIT(pwm->hwpwm);
>=20
> ...or this one
>=20

> > +static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	int ret;
> > +	struct fsl_pwm_chip *fpc;
> > +	struct pinctrl_state *pins_state;
> > +	struct fsl_pwm_data *pwm_data;
> > +	const char *statename;
> > +
> > +	fpc =3D to_fsl_chip(chip);
> > +
> > +	pwm_data =3D pwm_get_chip_data(pwm);
> > +	if (!pwm_data)
> > +		return -EINVAL;
> > +
> > +	if (pwm_data->available !=3D FSL_AVAILABLE)
> > +		return -EINVAL;
> > +
> > +	statename =3D kasprintf(GFP_KERNEL, "ch%d-active", pwm->hwpwm);
>=20
> You loose memory here and in fsl_pwm_disable aswell.
>=20

Yes, I will revise it.

> > +	pins_state =3D pinctrl_lookup_state(fpc->pinctrl,
> > +			statename);
> > +	/* enable pins to be muxed in and configured */
> > +	if (!IS_ERR(pins_state)) {
> > +		ret =3D pinctrl_select_state(fpc->pinctrl, pins_state);
> > +		if (ret)
> > +			dev_warn(chip->dev, "could not set default pins\n");
> > +	} else
> > +		dev_warn(chip->dev, "could not get default pinstate\n");
>=20
> Either it's ok to do without pinctrl or it's not ok, so either return an
> error or drop the warnings. Polluting the kernel log with such messages
> from a frequently called function is not a good idea.
>=20

Well, I will just print out some error logs and return the error.

--
Best Regards.
Xiubo
