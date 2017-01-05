From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v4 07/11] pwm: imx: Provide atomic PWM support for i.MX
 PWMv2
Date: Thu, 5 Jan 2017 10:35:05 +0100
Message-ID: <20170105103505.7b9e32ba@jawa>
References: <1483573014-13185-1-git-send-email-lukma@denx.de>
        <1483573014-13185-8-git-send-email-lukma@denx.de>
        <20170105095035.2f1fe6db@bbrezillon>
        <20170105100347.1358df34@jawa>
        <20170105101935.2365d647@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:47084 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936654AbdAEJgy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Jan 2017 04:36:54 -0500
In-Reply-To: <20170105101935.2365d647@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>

On Thu, 5 Jan 2017 10:19:35 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Thu, 5 Jan 2017 10:03:47 +0100
> Lukasz Majewski <lukma@denx.de> wrote:
> 
> > On Thu, 5 Jan 2017 09:50:35 +0100
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> > 
> > > On Thu,  5 Jan 2017 00:36:50 +0100
> > > Lukasz Majewski <lukma@denx.de> wrote:
> > >   
> > > > This commit provides apply() callback implementation for i.MX's
> > > > PWMv2.
> > > > 
> > > > Suggested-by: Stefan Agner <stefan@agner.ch>
> > > > Suggested-by: Boris Brezillon
> > > > <boris.brezillon@free-electrons.com> Signed-off-by: Lukasz
> > > > Majewski <l.majewski@majess.pl> Reviewed-by: Boris Brezillon
> > > > <boris.brezillon@free-electrons.com> ---
> > > > Changes for v4:
> > > > - Avoid recalculation of PWM parameters when disabling PWM
> > > > signal
> > > > - Unconditionally call clk_prepare_enable(imx->clk_per) and
> > > >   clk_disable_unprepare(imx->clk_per)  
> > > 
> > > I don't see that one, but I'm not sure this is actually needed.
> > > In the enabled path we enable the clk before accessing the
> > > registers, and in the disable path, assuming you change the code
> > > according to my suggestion, the clk should already be enabled
> > > when you write to MX3_PWMCR.
> > >   
> > > > 
> > > > Changes for v3:
> > > > - Remove ipg clock enable/disable functions
> > > > 
> > > > Changes for v2:
> > > > - None
> > > > ---
> > > >  drivers/pwm/pwm-imx.c | 67
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file
> > > > changed, 67 insertions(+)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > > index 60cdc5c..134dd66 100644
> > > > --- a/drivers/pwm/pwm-imx.c
> > > > +++ b/drivers/pwm/pwm-imx.c
> > > > @@ -249,6 +249,72 @@ static int imx_pwm_config(struct pwm_chip
> > > > *chip, return ret;
> > > >  }
> > > >  
> > > > +static int imx_pwm_apply_v2(struct pwm_chip *chip, struct
> > > > pwm_device *pwm,
> > > > +			    struct pwm_state *state)
> > > > +{
> > > > +	unsigned long period_cycles, duty_cycles, prescale;
> > > > +	struct imx_chip *imx = to_imx_chip(chip);
> > > > +	struct pwm_state cstate;
> > > > +	unsigned long long c;
> > > > +	int ret;
> > > > +
> > > > +	pwm_get_state(pwm, &cstate);
> > > > +
> > > > +	if (state->enabled) {
> > > > +		c = clk_get_rate(imx->clk_per);
> > > > +		c *= state->period;
> > > > +
> > > > +		do_div(c, 1000000000);
> > > > +		period_cycles = c;
> > > > +
> > > > +		prescale = period_cycles / 0x10000 + 1;
> > > > +
> > > > +		period_cycles /= prescale;
> > > > +		c = (unsigned long long)period_cycles *
> > > > state->duty_cycle;
> > > > +		do_div(c, state->period);
> > > > +		duty_cycles = c;
> > > > +
> > > > +		/*
> > > > +		 * according to imx pwm RM, the real period
> > > > value should be
> > > > +		 * PERIOD value in PWMPR plus 2.
> > > > +		 */
> > > > +		if (period_cycles > 2)
> > > > +			period_cycles -= 2;
> > > > +		else
> > > > +			period_cycles = 0;
> > > > +  
> > > 
> > > Starting here...
> > >   
> > > > +		ret = clk_prepare_enable(imx->clk_per);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		/*
> > > > +		 * Wait for a free FIFO slot if the PWM is
> > > > already enabled, and
> > > > +		 * flush the FIFO if the PWM was disabled and
> > > > is about to be
> > > > +		 * enabled.
> > > > +		 */
> > > > +		if (cstate.enabled)
> > > > +			imx_pwm_wait_fifo_slot(chip, pwm);
> > > > +		else if (state->enabled)
> > > > +			imx_pwm_sw_reset(chip);  
> > > 
> > > ... till here, should be replaced by:
> > > 
> > > 
> > > 		/*
> > > 		 * Wait for a free FIFO slot if the PWM is already
> > > enabled, and
> > > 		 * flush the FIFO if the PWM was disabled and is
> > > about to be
> > > 		 * enabled.
> > > 		 */
> > > 		if (cstate.enabled) {
> > > 			imx_pwm_wait_fifo_slot(chip, pwm);
> > > 		} else {
> > > 			ret = clk_prepare_enable(imx->clk_per);
> > > 			if (ret)
> > > 				return ret;  
> > 
> > In the other mail you mentioned that the clock should be enabled
> > unconditionally to fix issue on iMX7 when we want to access
> > registers.
> 
> When I said unconditionally, I meant call
> clk_prepare_enable(imx->clk_per) just after pwm_get_state() (at the
> beginning of the function) and call clk_disable_(imx->clk_per) just
> before returning 0 at the end of the function. This way you're
> guaranteed that the clk is always enabled when you access registers in
> between. Of course, you still need the the clk_prepare_enable() and
> clk_disable_unprepare() in the enable and disable path to keep the clk
> enabled when the PWM is enabled, and to disable it when the clk is
> being disabled.

Why you didn't said this when I pasted pseudo code to the other e-mail
and explicitly asked if this is correct? By doing that I wanted to
avoid situations like this (so I will have to repost this again and
again .....).


> 
> But, while reviewing your patch I realized this was actually unneeded
> (see the explanation in my previous review).
> 
> > 
> > Now it depends on cstate.enabled flag. 
> > 
> > So we end up with 
> > 
> > if (state.enabled && !cstate.enabled)
> > 	clk_preapre_enable();
> 
> Yep, and that's correct.

And following patch:
http://patchwork.ozlabs.org/patch/709510/

address this issue.

> 
> > 
> > which was the reason of iMX7 failure reported by Stefan to v3.
> 
> Stefan, do you confirm that? I don't see how this can possibly fail
> since the clk is either already enabled (cstate.enabled) or we enable
> it (!cstate.enable) before accessing registers.

http://patchwork.ozlabs.org/patch/709510/

> 
> What's for sure is that your implementation is introducing possible
> unbalanced ref counting on the per clk.

You mean when somebody call twice ->apply() with "state->enabled".

> 
> > 
> > 
> > > 
> > > 			imx_pwm_sw_reset(chip);
> > > 		}
> > > 
> > > Otherwise you keep incrementing the prepare/enable counters of
> > > the clk when you change the config of an already enabled PWM.
> > >   
> > > > +
> > > > +		writel(duty_cycles, imx->mmio_base +
> > > > MX3_PWMSAR);
> > > > +		writel(period_cycles, imx->mmio_base +
> > > > MX3_PWMPR); +
> > > > +		writel(MX3_PWMCR_PRESCALER(prescale) |
> > > > +		       MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> > > > +		       MX3_PWMCR_DBGEN |
> > > > MX3_PWMCR_CLKSRC_IPG_HIGH |
> > > > +		       MX3_PWMCR_EN,
> > > > +		       imx->mmio_base + MX3_PWMCR);
> > > > +
> > > > +	} else {  
> > > 
> > > 	} else if (cstate.enabled) {
> > > 
> > > Again, this is to avoid unbalanced prepare/enable counters on the
> > > per clk if the PWM config is changed several times when the PWM is
> > > disabled.
> > >   
> > > > +		writel(0, imx->mmio_base + MX3_PWMCR);
> > > > +
> > > > +		clk_disable_unprepare(imx->clk_per);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int imx_pwm_enable(struct pwm_chip *chip, struct
> > > > pwm_device *pwm) {
> > > >  	struct imx_chip *imx = to_imx_chip(chip);
> > > > @@ -280,6 +346,7 @@ static struct pwm_ops imx_pwm_ops_v1 = {
> > > >  };
> > > >  
> > > >  static struct pwm_ops imx_pwm_ops_v2 = {
> > > > +	.apply = imx_pwm_apply_v2,
> > > >  	.enable = imx_pwm_enable,
> > > >  	.disable = imx_pwm_disable,
> > > >  	.config = imx_pwm_config,  
> > >   
> > 
> > 
> > 
> > 
> > Best regards,
> > 
> > Lukasz Majewski
> > 
> > --
> > 
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> > Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email:
> > wd@denx.de
> 




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
