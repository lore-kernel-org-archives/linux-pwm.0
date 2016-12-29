From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 RESEND 07/11] pwm: imx: Provide atomic PWM support
 for i.MX PWMv2
Date: Thu, 29 Dec 2016 18:08:38 +0100
Message-ID: <20161229180838.66ca218f@bbrezillon>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-8-git-send-email-l.majewski@majess.pl>
        <20161229172117.523a42a4@bbrezillon>
        <20161229174535.01b87fb7@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161229174535.01b87fb7@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hi Lukasz,

On Thu, 29 Dec 2016 17:45:35 +0100
Lukasz Majewski <l.majewski@majess.pl> wrote:

> Hi Boris,
> 
> > Hi Lukasz,
> > 
> > On Mon, 26 Dec 2016 23:55:57 +0100
> > Lukasz Majewski <l.majewski@majess.pl> wrote:
> >   
> > > This commit provides apply() callback implementation for i.MX's
> > > PWMv2.
> > > 
> > > Suggested-by: Stefan Agner <stefan@agner.ch>
> > > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > > Changes for v3:
> > > - Remove ipg clock enable/disable functions
> > > 
> > > Changes for v2:
> > > - None
> > > ---
> > >  drivers/pwm/pwm-imx.c | 70
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed,
> > > 70 insertions(+)
> > > 
> > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > index ebe9b0c..cd53c05 100644
> > > --- a/drivers/pwm/pwm-imx.c
> > > +++ b/drivers/pwm/pwm-imx.c
> > > @@ -159,6 +159,75 @@ static void imx_pwm_wait_fifo_slot(struct
> > > pwm_chip *chip, }
> > >  }
> > >  
> > > +static int imx_pwm_apply_v2(struct pwm_chip *chip, struct
> > > pwm_device *pwm,
> > > +			    struct pwm_state *state)
> > > +{
> > > +	unsigned long period_cycles, duty_cycles, prescale;
> > > +	struct imx_chip *imx = to_imx_chip(chip);
> > > +	struct pwm_state cstate;
> > > +	unsigned long long c;
> > > +	u32 cr = 0;
> > > +	int ret;
> > > +
> > > +	pwm_get_state(pwm, &cstate);
> > > +
> > > +	c = clk_get_rate(imx->clk_per);
> > > +	c *= state->period;
> > > +
> > > +	do_div(c, 1000000000);
> > > +	period_cycles = c;
> > > +
> > > +	prescale = period_cycles / 0x10000 + 1;
> > > +
> > > +	period_cycles /= prescale;
> > > +	c = (unsigned long long)period_cycles * state->duty_cycle;
> > > +	do_div(c, state->period);
> > > +	duty_cycles = c;
> > > +
> > > +	/*
> > > +	 * according to imx pwm RM, the real period value should be
> > > +	 * PERIOD value in PWMPR plus 2.
> > > +	 */
> > > +	if (period_cycles > 2)
> > > +		period_cycles -= 2;
> > > +	else
> > > +		period_cycles = 0;
> > > +
> > > +	/* Enable the clock if the PWM is being enabled. */
> > > +	if (state->enabled && !cstate.enabled) {
> > > +		ret = clk_prepare_enable(imx->clk_per);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Wait for a free FIFO slot if the PWM is already
> > > enabled, and flush
> > > +	 * the FIFO if the PWM was disabled and is about to be
> > > enabled.
> > > +	 */
> > > +	if (cstate.enabled)
> > > +		imx_pwm_wait_fifo_slot(chip, pwm);
> > > +	else if (state->enabled)
> > > +		imx_pwm_sw_reset(chip);
> > > +
> > > +	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > +	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > > +
> > > +	cr |= MX3_PWMCR_PRESCALER(prescale) |
> > > +	      MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> > > +	      MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
> > > +
> > > +	if (state->enabled)
> > > +		cr |= MX3_PWMCR_EN;
> > > +
> > > +	writel(cr, imx->mmio_base + MX3_PWMCR);
> > > +
> > > +	/* Disable the clock if the PWM is being disabled. */
> > > +	if (!state->enabled && cstate.enabled)
> > > +		clk_disable_unprepare(imx->clk_per);
> > > +
> > > +	return 0;
> > > +}
> > > +  
> > 
> > Stefan suggested to rework this function to avoid unneeded
> > duty/period calculation and reg write when disabling the PWM. Why
> > didn't you send a v4 addressing that instead of resending the exact
> > same v3?  
> 
> The discussion between you and Stefan was in this thread:
> http://patchwork.ozlabs.org/patch/689790/
> 
> Stefan proposed change, you replied with your concerns and that is all.

Well, regarding the imx_pwm_apply_v2() suggested by Stefan, I think we
both agreed that most of the code was unneeded when all we want to do
is disable the PWM.

My concern was more about the way PWM changes are applied (->apply()
returns before the change is actually applied), but I agreed that it
could be fixed later on (if other people think it's really needed),
since the existing code already handles it this way.

> No clear decision what to change until today when Stefan prepared
> separate (concise) patch (now I see what is the problem).
> 

The patch proposed by Stefan is addressing a different problem: the
periph clock has to be enabled before accessing registers.

> 
> > 
> > Same goes for the regression introduced in patch 2: I think it's
> > better to keep things bisectable on all platforms (even if it
> > appeared to work by chance on imx7, it did work before this change).  
> 
> Could you be more specific about your idea to solve this problem?

Stefan already provided a patch, I just think it should be fixed before
patch 2 to avoid breaking bisectibility.

> 
> > 
> > That's just my opinion, but when you get reviews on a patch series,
> > it's better to address them directly (especially when issues can be
> > easily fixed) than provide follow-up patches.  
> 
> I do not have iMX7 for testing/development, so I could not reproduce
> the error and address the issue directly.

Well, the description made by Stefan seemed pretty clear to me: you
need to enable the periph clock before accessing PWM registers.

> 
> I can at best integrate Stefan's patch and hope to not introduce
> regression.

You can ask others to test your own patches. In this case, just
clearly state that the patch is untested and that you'd like people
owning a specific platform to test it.

Regards,

Boris
