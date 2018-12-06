From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Thu, 6 Dec 2018 17:16:22 +0100
Message-ID: <20181206161622.okpfiecfphar77jk@pengutronix.de>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181206135902.un2nbreqfmi6mpd6@pengutronix.de>
 <01aaa6ff-fb3e-37a7-0e72-099ad013ee2a@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01aaa6ff-fb3e-37a7-0e72-099ad013ee2a@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Dec 06, 2018 at 03:37:55PM +0000, Vokáč Michal wrote:
> On 6.12.2018 14:59, Uwe Kleine-König wrote:
> > On Thu, Dec 06, 2018 at 01:41:31PM +0000, Vokáč Michal wrote:
> >> +{
> >> +	imx_chip->pinctrl = devm_pinctrl_get(&pdev->dev);
> >> +	if (IS_ERR(imx_chip->pinctrl)) {
> >> +		dev_dbg(&pdev->dev, "can not get pinctrl\n");
> >> +		return PTR_ERR(imx_chip->pinctrl);
> >> +	}
> >> +
> >> +	imx_chip->pinctrl_pins_pwm = pinctrl_lookup_state(imx_chip->pinctrl,
> >> +							  "pwm");
> >> +	imx_chip->pinctrl_pins_gpio = pinctrl_lookup_state(imx_chip->pinctrl,
> >> +							   "gpio");
> >> +	imx_chip->pwm_gpiod = devm_gpiod_get_optional(&pdev->dev, "pwm",
> >> +						      GPIOD_IN);
> >> +
> >> +	if (PTR_ERR(imx_chip->pwm_gpiod) == -EPROBE_DEFER) {
> >> +		return -EPROBE_DEFER;
> >> +	} else if (IS_ERR(imx_chip->pwm_gpiod) ||
> >> +		   IS_ERR(imx_chip->pinctrl_pins_pwm) ||
> >> +		   IS_ERR(imx_chip->pinctrl_pins_gpio)) {
> >> +		dev_dbg(&pdev->dev, "PWM pinctrl information incomplete\n");
> >> +		devm_pinctrl_put(imx_chip->pinctrl);
> >> +		imx_chip->pinctrl = NULL;
> > 
> > Can it happen, that pinctrl_pins_pwm is PTR_ERR(-EPROBE_DEFER)?
> 
> No. The pinctrl_lookup_state either returns pointer to the pinctrl state
> or ERR_PTR(-ENODEV). But I do not explicitly test the pinctrl_pins_pwm
> for PTR_ERR(-EPROBE_DEFER), or do I?

You don't, I just wondered if this could happen and the function should
return -EPROBE_DEFER in this case, too.

> > Maybe you only want to ignore PTR_ERR(-ENODEV) and for example propagate
> > -EIO? I think you want to put the gpio if the failure is because there
> > is a pinctrl related error.
> 
> I think that is what I am doing. In case the GPIO is not ready the probe
> is deferred. In case of any other error with the GPIO or pinctrl failure
> I put the pinctrl. Or maybe I do not really understand what you mean.

Yes, you put the pinctrl, but not the GPIO. I.e. you're not undoing
devm_gpiod_get_optional(). Maybe only do this if the pinctrl stuff
succeeded to not touch the GPIO if it won't be used?

> > ISTR that there was a patch that implements get_state for imx. Is there
> > a dependency on that one? Otherwise the state returned by
> > pwm_get_state() might not be what is actually configured.
> 
> No, it should be independent. One can go without the other. I tested all
> three combinations (mainline with .get_state, mainline with this series,
> mainline with .get_state AND this series) and got the expected results.
> Without the .get_state() patch the core always returns the default which
> is disabled state so the gpio pinctrl state is selected in probe.

Without .get_state it won't be possible to smoothly take over a running
PWM. It doesn't hurt if the PWM isn't running though. Still I'd like to
see the .get_state patch to go in first to not get this (admittedly
small) regression.

> > Do you know if this is required for the old i.MX pwm, e.g. on i.MX21?
> > I ask because of https://patchwork.ozlabs.org/patch/1000071/
> 
> Yep, I am aware of that patch. IMHO this is not needed for the v1 on
> older i.MX SoCs but I do not have a hands-on experience with those.

OK. If you agree with my split and as you have to rework your patch
anyhow: Would you mind to rebase on top of my patch series? (Unless
Thierry disagrees with my patches, but unfortunately he didn't comment
yet.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
