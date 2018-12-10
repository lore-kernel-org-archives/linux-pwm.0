From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Mon, 10 Dec 2018 12:17:46 +0100
Message-ID: <20181210111746.36zyedeaajfcdfeh@pengutronix.de>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181206135902.un2nbreqfmi6mpd6@pengutronix.de>
 <01aaa6ff-fb3e-37a7-0e72-099ad013ee2a@ysoft.com>
 <20181206161622.okpfiecfphar77jk@pengutronix.de>
 <8b88d225-efc7-623a-d1a6-8b3cfcfd5e07@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8b88d225-efc7-623a-d1a6-8b3cfcfd5e07@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Dec 10, 2018 at 11:15:05AM +0000, Vokáč Michal wrote:
> On 6.12.2018 17:16, Uwe Kleine-König wrote:
> > On Thu, Dec 06, 2018 at 03:37:55PM +0000, Vokáč Michal wrote:
> >> On 6.12.2018 14:59, Uwe Kleine-König wrote:
> >>> On Thu, Dec 06, 2018 at 01:41:31PM +0000, Vokáč Michal wrote:
> >>>
> >>> Can it happen, that pinctrl_pins_pwm is PTR_ERR(-EPROBE_DEFER)?
> >>
> >> No. The pinctrl_lookup_state either returns pointer to the pinctrl state
> >> or ERR_PTR(-ENODEV). But I do not explicitly test the pinctrl_pins_pwm
> >> for PTR_ERR(-EPROBE_DEFER), or do I?
> > 
> > You don't, I just wondered if this could happen and the function should
> > return -EPROBE_DEFER in this case, too.
> 
> OK.
> 
> >>> Maybe you only want to ignore PTR_ERR(-ENODEV) and for example propagate
> >>> -EIO? I think you want to put the gpio if the failure is because there
> >>> is a pinctrl related error.
> >>
> >> I think that is what I am doing. In case the GPIO is not ready the probe
> >> is deferred. In case of any other error with the GPIO or pinctrl failure
> >> I put the pinctrl. Or maybe I do not really understand what you mean.
> > 
> > Yes, you put the pinctrl, but not the GPIO. I.e. you're not undoing
> > devm_gpiod_get_optional(). Maybe only do this if the pinctrl stuff
> > succeeded to not touch the GPIO if it won't be used?
> 
> OK, I agree it seems better to get the pinctrl first and if it succeeds
> only then try to get the GPIO. In that case I need to use the non-optional
> variant of devm_gpio_get(). Note that then I do not really need to put the
> GPIO in the error path as it means I did not get it.
> The code would look like:
> 
> +static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
> +				      struct platform_device *pdev)
> +{
> +	imx_chip->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(imx_chip->pinctrl)) {
> +		dev_dbg(&pdev->dev, "can not get pinctrl\n");
> +		return PTR_ERR(imx_chip->pinctrl);
> +	}
> +
> +	imx_chip->pinctrl_pins_pwm = pinctrl_lookup_state(imx_chip->pinctrl,
> +							  "pwm");
> +	imx_chip->pinctrl_pins_gpio = pinctrl_lookup_state(imx_chip->pinctrl,
> +							   "gpio");
> +
> +	if (IS_ERR(imx_chip->pinctrl_pins_pwm) ||
> +	    IS_ERR(imx_chip->pinctrl_pins_gpio)) {
> +		dev_dbg(&pdev->dev, "pinctrl information incomplete\n");
> +		goto out;
> +	}
> +
> +	imx_chip->pwm_gpiod = devm_gpiod_get(&pdev->dev, "pwm", GPIOD_IN);
> +	if (PTR_ERR(imx_chip->pwm_gpiod) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(imx_chip->pwm_gpiod)) {
> +		dev_dbg(&pdev->dev, "GPIO information incomplete\n");
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	devm_pinctrl_put(imx_chip->pinctrl);
> +	imx_chip->pinctrl = NULL;
> +
> +	return 0;
> +}

This looks right.

> >>> ISTR that there was a patch that implements get_state for imx. Is there
> >>> a dependency on that one? Otherwise the state returned by
> >>> pwm_get_state() might not be what is actually configured.
> >>
> >> No, it should be independent. One can go without the other. I tested all
> >> three combinations (mainline with .get_state, mainline with this series,
> >> mainline with .get_state AND this series) and got the expected results.
> >> Without the .get_state() patch the core always returns the default which
> >> is disabled state so the gpio pinctrl state is selected in probe.
> > 
> > Without .get_state it won't be possible to smoothly take over a running
> > PWM.
> 
> But that is exactly how the current pwm-imx code works, right?

But then at least the pwm would run until the first consumer
reconfigures it.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
