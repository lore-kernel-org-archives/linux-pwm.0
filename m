Return-Path: <B47053@freescale.com>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCH 1/4] pwm: add freescale ftm pwm driver support
Date: Wed, 21 Aug 2013 09:24:56 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827D1C51@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-2-git-send-email-Li.Xiubo@freescale.com>
 <20130821073659.GN31036@pengutronix.de>
In-Reply-To: <20130821073659.GN31036@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Guo Shawn-R65073 <r65073@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Lu Jingchang-B35083 <B35083@freescale.com>

TO Sascha,

Thanks very much for your comments.


> Subject: Re: [PATCH 1/4] pwm: add freescale ftm pwm driver support
>=20
> On Wed, Aug 21, 2013 at 11:07:39AM +0800, Xiubo Li wrote:
> > +
> > +#define FTM_CSC_BASE        0x0C
> > +#define FTM_CSC(_CHANNEL) \
> > +	(FTM_CSC_BASE + (_CHANNEL * 0x08))
>=20
> I see this more and more in FSL code. This is unsafe! Consider what
> happens when we call FTM_CSC(1 + 1). The result is certainly not what you
> want.
>=20

Oh yes, I'll fix it in v2.


> > +
> > +static int fsl_pwm_request_channel(struct pwm_chip *chip,
> > +			       struct pwm_device *pwm)
> > +{
> > +	int ret =3D 0;
>=20
> No need to initialize this variable.
>=20

Yeah, I'll fix it in v2.


> > +	ret =3D clk_prepare_enable(fpc->clk);
> > +	if (ret) {
> > +		dev_err(&fpc->pdev->dev,
> > +				"failed to clk_prepare_enable "
> > +				"ftm pwm module clock : %d\n",
> > +				ret);
>=20
> Just return ret. We do not need a message for each failed function in the
> kernel.
>=20

OK, I will remove it in v2.


> > +static int fsl_updata_config(struct fsl_pwm_chip *fpc,
> > +			     struct pwm_device *pwm)
> > +{
> > +	int i;
> > +	unsigned long reg, cntin =3D FTM_CNTIN_VAL;
> > +	struct pwm_chip *chip =3D &fpc->chip;
> > +
> > +	reg =3D readl(fpc->base + FTM_SC);
> > +	reg &=3D ~(FTMSC_CPWMS);
> > +	reg |=3D (fpc->cpwm ? FTMSC_CPWMS : 0x00);
> > +	writel(reg, fpc->base + FTM_SC);
> > +
> > +	if (pwm && fpc->cpwm) {
> > +		writel(fpc->fpwms[pwm->hwpwm].period_cycles / 2 + cntin,
> > +				fpc->base + FTM_MOD);
> > +		writel(fpc->fpwms[pwm->hwpwm].duty_cycles / 2 + cntin,
> > +				fpc->base + FTM_CV(pwm->hwpwm));
> > +	} else if (pwm) {
> > +		writel(fpc->fpwms[pwm->hwpwm].period_cycles + cntin - 1,
> > +				fpc->base + FTM_MOD);
> > +		writel(fpc->fpwms[pwm->hwpwm].duty_cycles + cntin,
> > +				fpc->base + FTM_CV(pwm->hwpwm));
> > +	}
> > +
> > +	if (pwm)
> > +		return 0;
> > +
> > +	for (i =3D 0; i < chip->npwm; i++) {
> > +		if (!test_bit(PWMF_ENABLED, &chip->pwms[i].flags))
> > +			continue;
> > +		if (fpc->cpwm) {
> > +			writel(fpc->fpwms[i].period_cycles / 2 + cntin,
> > +					fpc->base + FTM_MOD);
> > +			writel(fpc->fpwms[i].duty_cycles / 2 + cntin,
> > +					fpc->base + FTM_CV(i));
> > +		} else {
> > +			writel(fpc->fpwms[i].period_cycles + cntin - 1,
> > +					fpc->base + FTM_MOD);
> > +			writel(fpc->fpwms[i].duty_cycles + cntin,
> > +					fpc->base + FTM_CV(i));
> > +		}
> > +	}
> > +
>=20
> The behaviour of this function is completely different for pwm =3D=3D NUL=
L
> and pwm !=3D NULL. This indicates that it should really be two functions.
> This probably makes the intention of this code much clearer.
>=20

OK, I will split it into two functions in v2.


> > +	period_cycles =3D fsl_rate_to_cycles(fpc, period_ns);
> > +	if (period_cycles > 0xFFFF) {
> > +		dev_warn(&fpc->pdev->dev,
> > +				"required PWM period cycles(%lu) "
> > +				"overflow 16-bits counter!\n",
> > +				period_cycles);
> > +		period_cycles =3D 0xFFFF;
>=20
> If you can't fulfill the requirements you have to return an error. It's
> the caller that needs to know the failure. The caller can't read read the
> syslog.
>=20

OK, I will fix it in v2.


> > +static int fsl_pwm_enable_channel(struct pwm_chip *chip,
> > +			      struct pwm_device *pwm)
> > +{
> > +	int ret;
> > +	unsigned long reg;
> > +	struct fsl_pwm_chip *fpc;
> > +	struct pinctrl_state *pins_state;
> > +	const char *statename;
> > +
> > +	fpc =3D to_fsl_chip(chip);
> > +
> > +	if (WARN_ON(!test_bit(PWMF_REQUESTED, &pwm->flags)))
> > +		return -ESHUTDOWN;
> > +
> > +	statename =3D kasprintf(GFP_KERNEL, "en%d", pwm->hwpwm);
> > +	pins_state =3D pinctrl_lookup_state(fpc->pinctrl,
> > +			statename);
> > +	/* enable pins to be muxed in and configured */
> > +	if (!IS_ERR(pins_state)) {
> > +		ret =3D pinctrl_select_state(fpc->pinctrl, pins_state);
> > +		if (ret)
> > +			dev_warn(&fpc->pdev->dev,
> > +					"could not set default pins\n");
>=20
> Why do you need to manipulate the pinctrl to en/disable a channel?
>=20

This is because in Vybrid VF610 TOWER board, there are 4 leds, and each led=
's one point(diode's positive pole) is connected to 3.3V,
and the other point is connected to pwm's one channel. When the 4 pinctrls =
are configured as enable at the same time,=20
the 4 pinctrls is low valtage, and the 4 leds will be lighted up as default=
, then when you enable/disable one led will effects others.

These pinctrls are belong to pwm, and I don't think led or other customer c=
ould control them directly.
So, here I authorize the 4 pinctrls to each channel controls.


> > +static ssize_t fsl_pwm_cpwm_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf,
> > +				  size_t count)
> > +{
> > +	int ret;
> > +	unsigned int val;
> > +	struct fsl_pwm_chip *fpc;
> > +
> > +	fpc =3D dev_get_drvdata(dev);
> > +
> > +	ret =3D kstrtouint(buf, 0, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&fpc->lock);
> > +	if (!!(val) !=3D !!(fpc->cpwm)) {
> > +		fpc->cpwm =3D !!val;
> > +		fsl_updata_config(fpc, NULL);
> > +	}
> > +	mutex_unlock(&fpc->lock);
> > +
> > +	return count;
> > +}
>=20
> What is this cpwm thingy?

Up-down counting mode:
CNTIN(a register) defines the starting value of the count and MOD(a registe=
r) defines the final value of the
count. The value of CNTIN is loaded into the FTM counter, and the counter i=
ncrements
until the value of MOD is reached, at which point the counter is decremente=
d until it
returns to the value of CNTIN and the up-down counting restarts.


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
> Drop this message. You'll never see it.

OK, I will drop it in v2.

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
> > +		return ret;
> > +	}
>=20
> You can only add the PWM when you grabbed all resources, not before this.
>=20

Yeah, I will adjust it in v2.

> > +
> > +static int fsl_pwm_remove(struct platform_device *pdev) {
> > +	struct fsl_pwm_chip *fpc;
> > +
> > +	fpc =3D platform_get_drvdata(pdev);
> > +	if (fpc =3D=3D NULL)
> > +		return -ENODEV;
>=20
> This won't happen.
=20
OK, I will drop it in v2.


Thanks very much.

---

Best Regards,
Xiubo Li
