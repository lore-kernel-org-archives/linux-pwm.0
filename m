Return-Path: <sha@pengutronix.de>
Date: Fri, 30 Aug 2013 19:49:09 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
Message-ID: <20130830174909.GF30088@pengutronix.de>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
 <1377856132-11290-2-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377856132-11290-2-git-send-email-Li.Xiubo@freescale.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: r65073@freescale.com, thierry.reding@gmail.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jingchang Lu <b35083@freescale.com>

On Fri, Aug 30, 2013 at 05:48:49PM +0800, Xiubo Li wrote:
> +
> +#define FTM_CSC_BASE        0x0C
> +#define FTM_CSC(_channel) \
> +	(FTM_CSC_BASE + ((_channel) * 8))

Put into a single line.

> +#define FTMCnSC_MSB         BIT(5)
> +#define FTMCnSC_MSA         BIT(4)
> +#define FTMCnSC_ELSB        BIT(3)
> +#define FTMCnSC_ELSA        BIT(2)
> +
> +#define FTM_CV_BASE         0x10
> +#define FTM_CV(_channel) \
> +	(FTM_CV_BASE + ((_channel) * 8))

ditto.

> +static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	int ret;
> +	struct fsl_pwm_chip *fpc;
> +	struct fsl_pwm_data *pwm_data;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	pwm_data = pwm_get_chip_data(pwm);
> +	if (!pwm_data)
> +		return -EINVAL;
> +
> +	if (pwm_data->available != FSL_AVAILABLE)
> +		return -EINVAL;
> +
> +	ret = clk_enable(fpc->sys_clk);
> +	if (ret)
> +		return ret;

This is non atomic context. You can also prepare the clocks here instead
of doing it in probe().

> +
> +	return 0;
> +}
> +
> +static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct fsl_pwm_chip *fpc;
> +	struct fsl_pwm_data *pwm_data;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	pwm_data = pwm_get_chip_data(pwm);
> +	if (!pwm_data)
> +		return;

THis check seems unnecessary.

> +
> +	if (pwm_data->available != FSL_AVAILABLE)
> +		return;
> +
> +	clk_disable(fpc->sys_clk);
> +}
> +

[...]

> +
> +
> +	pwm_data->period_cycles = period_cycles;
> +	pwm_data->duty_cycles = duty_cycles;

These fields are set but never read. Please drop them.

If you drop the 'available' field also the you can drop chip_data
completely.

> +
> +	writel(FTMCnSC_MSB | FTMCnSC_ELSB, fpc->base + FTM_CSC(pwm->hwpwm));
> +
> +	writel(0xF0, fpc->base + FTM_OUTMASK);
> +	writel(0x0F, fpc->base + FTM_OUTINIT);
> +	writel(FTM_CNTIN_VAL, fpc->base + FTM_CNTIN);
> +
> +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> +static int fsl_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> +				enum pwm_polarity polarity)
> +{
> +	unsigned long reg;
> +	struct fsl_pwm_data *pwm_data;
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	pwm_data = pwm_get_chip_data(pwm);
> +	if (!pwm_data)
> +		return -EINVAL;
> +
> +	if (pwm_data->available != FSL_AVAILABLE)
> +		return -EINVAL;
> +
> +	reg = readl(fpc->base + FTM_POL);
> +	reg &= ~BIT(pwm->hwpwm);

Either drop this line...

> +	if (polarity == PWM_POLARITY_INVERSED)
> +		reg |= BIT(pwm->hwpwm);
> +	else
> +		reg &= ~BIT(pwm->hwpwm);

...or this one

> +static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	int ret;
> +	struct fsl_pwm_chip *fpc;
> +	struct pinctrl_state *pins_state;
> +	struct fsl_pwm_data *pwm_data;
> +	const char *statename;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	pwm_data = pwm_get_chip_data(pwm);
> +	if (!pwm_data)
> +		return -EINVAL;
> +
> +	if (pwm_data->available != FSL_AVAILABLE)
> +		return -EINVAL;
> +
> +	statename = kasprintf(GFP_KERNEL, "ch%d-active", pwm->hwpwm);

You loose memory here and in fsl_pwm_disable aswell.

> +	pins_state = pinctrl_lookup_state(fpc->pinctrl,
> +			statename);
> +	/* enable pins to be muxed in and configured */
> +	if (!IS_ERR(pins_state)) {
> +		ret = pinctrl_select_state(fpc->pinctrl, pins_state);
> +		if (ret)
> +			dev_warn(chip->dev, "could not set default pins\n");
> +	} else
> +		dev_warn(chip->dev, "could not get default pinstate\n");

Either it's ok to do without pinctrl or it's not ok, so either return
an error or drop the warnings. Polluting the kernel log with such
messages from a frequently called function is not a good idea.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
