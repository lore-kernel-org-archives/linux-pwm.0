From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 07/11] pwm: imx: Provide atomic PWM support for i.MX
 PWMv2
Date: Wed, 23 Nov 2016 09:38:48 +0100
Message-ID: <20161123093848.206ad78f@bbrezillon>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
        <1477984230-18071-8-git-send-email-l.majewski@majess.pl>
        <4f514a235a404d0ab9d26f389fc83f51@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4f514a235a404d0ab9d26f389fc83f51@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Lukasz Majewski <l.majewski@majess.pl>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Tue, 22 Nov 2016 13:55:33 -0800
Stefan Agner <stefan@agner.ch> wrote:

> On 2016-11-01 00:10, Lukasz Majewski wrote:
> > This commit provides apply() callback implementation for i.MX's PWMv2.
> > 
> > Suggested-by: Stefan Agner <stefan@agner.ch>
> > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Changes for v3:
> > - Remove ipg clock enable/disable functions
> > 
> > Changes for v2:
> > - None
> > ---
> >  drivers/pwm/pwm-imx.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index ebe9b0c..cd53c05 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -159,6 +159,75 @@ static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
> >  	}
> >  }
> >  
> > +static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    struct pwm_state *state)
> > +{
> > +	unsigned long period_cycles, duty_cycles, prescale;
> > +	struct imx_chip *imx = to_imx_chip(chip);
> > +	struct pwm_state cstate;
> > +	unsigned long long c;
> > +	u32 cr = 0;
> > +	int ret;
> > +
> > +	pwm_get_state(pwm, &cstate);
> > +  
> 
> Couldn't we do:
> 
> if (cstate.enabled) { ...
> 
> > +	c = clk_get_rate(imx->clk_per);
> > +	c *= state->period;
> > +
> > +	do_div(c, 1000000000);
> > +	period_cycles = c;
> > +
> > +	prescale = period_cycles / 0x10000 + 1;
> > +
> > +	period_cycles /= prescale;
> > +	c = (unsigned long long)period_cycles * state->duty_cycle;
> > +	do_div(c, state->period);
> > +	duty_cycles = c;
> > +
> > +	/*
> > +	 * according to imx pwm RM, the real period value should be
> > +	 * PERIOD value in PWMPR plus 2.
> > +	 */
> > +	if (period_cycles > 2)
> > +		period_cycles -= 2;
> > +	else
> > +		period_cycles = 0;
> > +
> > +	/* Enable the clock if the PWM is being enabled. */
> > +	if (state->enabled && !cstate.enabled) {
> > +		ret = clk_prepare_enable(imx->clk_per);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/*
> > +	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
> > +	 * the FIFO if the PWM was disabled and is about to be enabled.
> > +	 */
> > +	if (cstate.enabled)
> > +		imx_pwm_wait_fifo_slot(chip, pwm);
> > +	else if (state->enabled)
> > +		imx_pwm_sw_reset(chip);
> > +
> > +	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > +
> > +	cr |= MX3_PWMCR_PRESCALER(prescale) |
> > +	      MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> > +	      MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
> > +
> > +	if (state->enabled)
> > +		cr |= MX3_PWMCR_EN;  
> 
> } else if (state->enabled) {
> 	imx_pwm_sw_reset(chip);
> }
> 
> and get rid of the if (state->enabled) in between? This would safe us
> useless recalculation when disabling the controller...

I get your point, but I'm pretty sure your proposal does not do what
you want (remember that cstate is the current state, and state is the
new state to apply).

Something like that would work better:

	if (state->enabled) {
		c = clk_get_rate(imx->clk_per);
		c *= state->period;

		do_div(c, 1000000000);
		period_cycles = c;

		prescale = period_cycles / 0x10000 + 1;

		period_cycles /= prescale;
		c = (unsigned long long)period_cycles *
		    state->duty_cycle;
		do_div(c, state->period);
		duty_cycles = c;

		/*
		 * According to imx pwm RM, the real period value
		 * should be PERIOD value in PWMPR plus 2.
		 */
		if (period_cycles > 2)
			period_cycles -= 2;
		else
			period_cycles = 0;

		/*
		 * Enable the clock if the PWM is not already
		 * enabled.
		 */
		if (!cstate.enabled) {
			ret = clk_prepare_enable(imx->clk_per);
			if (ret)
			return ret;
		}

		/*
		 * Wait for a free FIFO slot if the PWM is already
		 * enabled, and flush the FIFO if the PWM was disabled
		 * and is about to be enabled.
		 */
		if (cstate.enabled)
			imx_pwm_wait_fifo_slot(chip, pwm);
		else
			imx_pwm_sw_reset(chip);

		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
		writel(period_cycles, imx->mmio_base + MX3_PWMPR);

		writel(MX3_PWMCR_PRESCALER(prescale) |
		       MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
		       MX3_PWMCR_EN,
		       imx->mmio_base + MX3_PWMCR);
	} else {

		writel(0, imx->mmio_base + MX3_PWMCR);

		/* Disable the clock if the PWM is currently enabled. */
		if (cstate.enabled)
			clk_disable_unprepare(imx->clk_per);
	}


This being said, I'm a bit concerned by the way this driver handles PWM
config requests.
It seems that the new config request is queued, and nothing guarantees
that it is actually applied when the pwm_apply/config/enable/disable()
functions return.

This approach has several flaws IMO:

1/ I'm not sure this is what the PWM users expect. Getting your request
   queued with no guarantees that it is applied can be weird in some
   cases (especially when the user changes the PWM config several times
   in a short period of time).
2/ In the disable path, you queue a "stop PWM" request, but you're not
   sure that it's actually dequeued before the per clk is disabled.
   What happens in that case? And more importantly, what happens when
   the PWM is re-enabled to apply a new config? AFAICS, there might be
   a short period of time where the re-enabled PWM is actually running
   with the old config until we flush the command queue and queue a new
   command.
3/ The queueing approach complicates the whole logic. You have to
   flush the FIFO in some cases, or wait for an empty slots if too many
   commands are queued.
   Forcing imx_pwm_apply_v2() to wait for the config request to be
   applied should simplify the whole thing, because you will always be
   guaranteed that the FIFO is empty, and that the current
   configuration is the last requested one.

Regards,

Boris
