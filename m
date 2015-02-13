From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4] clk: Add PWM clock driver
Date: Fri, 13 Feb 2015 13:16:38 +0100
Message-ID: <1423829798.4182.35.camel@pengutronix.de>
References: <1418381269-26399-1-git-send-email-p.zabel@pengutronix.de>
	 <20150212222923.GA23372@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150212222923.GA23372@mithrandir>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>, Janusz =?UTF-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

thank you for the comments.

Am Donnerstag, den 12.02.2015, 23:29 +0100 schrieb Thierry Reding:
> On Fri, Dec 12, 2014 at 11:47:49AM +0100, Philipp Zabel wrote:
> > Some board designers, when running out of clock output pads, decide to
> > (mis)use PWM output pads to provide a clock to external components.
> > This driver supports this practice by providing an adapter between the
> > PWM and clock bindings in the device tree. As the PWM bindings specify
> > the period in the device tree, this is a fixed clock.
> 
> Typically the period is specified in DT because it is a board-level
> characteristic. In this case where you emulate a clock using the PWM
> channel you could simply ignore the period. After all you can freely
> choose it during pwm_config() irrespective of the period specified in
> DT.

The problem with with dynamic rate changes is that they go through the
PWM API, and due to rounding issues it is often impossible to obtain the
correct clock rate or upper and lower limits of the clock without
knowledge about the reference clock of the PWM itself, for example.

> Other than that looks mostly good to me, just a few nits below.
> 
> [...]
> > diff --git a/Documentation/devicetree/bindings/clock/pwm-clock.txt b/Documentation/devicetree/bindings/clock/pwm-clock.txt
> > new file mode 100644
> > index 0000000..751fff5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/pwm-clock.txt
> > @@ -0,0 +1,26 @@
> > +Binding for an external clock signal driven by a PWM pin.
> > +
> > +This binding uses the common clock binding[1] and the common PWM binding[2].
> > +
> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +[2] Documentation/devicetree/bindings/pwm/pwm.txt
> > +
> > +Required properties:
> > +- compatible : shall be "pwm-clock".
> > +- #clock-cells : from common clock binding; shall be set to 0.
> > +- pwms : from common PWM binding; this determines the clock frequency
> > +  via the PWM period given in the pwm-specifier.
> 
> Perhaps: "the period given in the PWM specifier"?

Yes, I'll change that.

> > +Optional properties:
> > +- clock-output-names : From common clock binding.
> > +- clock-frequency : Exact output frequency, in case the pwm period
> 
> "PWM period"

Ok.

> > +  is not exact but was rounded to nanoseconds.
> 
> Does this make sense?

The PWM binding specifies the period value, but it is not good enough
for pwm-clock's purpose. Due to the rounding issue:
For the Nitrogen6X board I want to produce a 22 MHz 'clock' from a PWM
with 66 MHz reference clock, with a 33% duty cycle.
The period time for this rate is 45.4545 ns, but in the PWM bindings it
is only possible to request 45 ns or 46 ns and hope the PWM driver will
round into the right direction.

>  For one it's now easy to specify two different
> values for the frequency, one using the PWM specifier, the other with
> clock-frequency.

I agree this is suboptimal. At least there is a warning for this case.

> According to the above, clock-frequency takes
> precedence, but in that case, what use is there in having the PWM
> specifier?

Are you suggesting the period given int the PWM specifier should be set
to 0?

> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 455fd17..36a6918a 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -129,6 +129,13 @@ config COMMON_CLK_PALMAS
> >  	  This driver supports TI Palmas devices 32KHz output KG and KG_AUDIO
> >  	  using common clock framework.
> >  
> > +config COMMON_CLK_PWM
> > +	bool "Clock driver for PWMs used as clock outputs"
> > +	depends on PWM
> > +	---help---
> > +	  Adapter driver so that any PWM output can be (mis)used as clock signal
> > +	  at 50% duty cycle.
> 
> Any reason why this isn't tristate?

No, I'll change that.

[...]
> > +#define to_clk_pwm(_hw) container_of(_hw, struct clk_pwm, hw)
> 
> Perhaps use a static inline so you get proper type checking?

Ok.

[...]
> > +	pwm = devm_pwm_get(&pdev->dev, NULL);
> > +	if (IS_ERR(pwm))
> > +		return PTR_ERR(pwm);
> > +
> > +	if (!pwm || !pwm->period) {
> 
> I don't think there's a case where pwm can be NULL here.

I think you are right.

> > +		dev_err(&pdev->dev, "invalid pwm period\n");
> 
> "PWM"

Ok.

[...]
> > +	if (pwm->period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
> > +	    pwm->period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
> > +		dev_err(&pdev->dev,
> > +			"clock-frequency does not match pwm period\n");
> 
> "PWM"
> 
> > +static struct platform_driver clk_pwm_driver = {
> > +	.probe = clk_pwm_probe,
> > +	.remove = clk_pwm_remove,
> > +	.driver = {
> > +		.name = "pwm-clock",
> > +		.of_match_table = of_match_ptr(clk_pwm_dt_ids),
> > +	},
> > +};
> > +
> > +module_platform_driver(clk_pwm_driver);
> 
> This is missing MODULE_AUTHOR, MODULE_DESCRIPTION and MODULE_LICENSE.

Will add them in the next round.

regards
Philipp
