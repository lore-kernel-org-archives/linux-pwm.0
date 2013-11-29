From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
Date: Fri, 29 Nov 2013 06:42:06 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828DD76C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
 <20131128212510.GC14689@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131128212510.GC14689@mithrandir>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <Shawn.Guo@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, Jingchan
List-Id: linux-pwm@vger.kernel.org

> > +#define FTM_CNTIN_VAL       0x00
> 
> Do we really need this?
> 

Maybe not, I think that the initial value maybe modified in the future.
And this can be more easy to ajust it. 


> > +	period_cycles = fsl_rate_to_cycles(fpc, period_ns);
> > +	if (period_cycles > 0xFFFF) {
> > +		dev_err(chip->dev, "required PWM period cycles(%lu) overflow "
> > +				"16-bits counter!\n", period_cycles);
> > +		return -EINVAL;
> > +	}
> > +
> > +	duty_cycles = fsl_rate_to_cycles(fpc, duty_ns);
> > +	if (duty_cycles >= 0xFFFF) {
> > +		dev_err(chip->dev, "required PWM duty cycles(%lu) overflow "
> > +				"16-bits counter!\n", duty_cycles);
> > +		return -EINVAL;
> > +	}
> 
> I'm not sure the error messages are all that useful. A -EINVAL error
> code should make it pretty clear what the problem is.
> 

Yes, these could be absent.

> > +	writel(FTMCnSC_MSB | FTMCnSC_ELSB, fpc->base + FTM_CSC(pwm->hwpwm));
> > +
> > +	writel(0xF0, fpc->base + FTM_OUTMASK);
> > +	writel(0x0F, fpc->base + FTM_OUTINIT);
> 
> The purpose of this eludes me. These seem to be global (not specific to
> channel pwm->hwpwm) registers, so why are they updated whenever a single
> channel is reconfigured?
> 

Well, certainly there has one way to update per channel's configuration 
about this. I will revise it then.


> > +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> > +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));
> 
> And these:
> 
> 	writel(period - 1, fpc->base + FTM_MOD);
> 	writel(duty, fpc->base + FTM_CV(pwm->hwpwm));
> 
> Although now that I think about it, this seems broken. The period is set
> in a global register, so I assume it is valid for all channels. What if
> you want to use different periods for individual channels? The way I
> read this the last one to be configured will win and change the period
> to whatever it wants. Other channels won't even notice.
> 

That's right. And all the 8 channels share the same period settings.

> Is there a way to set the period per channel?
> 

Not yet. Only could we do is to set the duty value individually for each
channel. So here is a limitation for the cusumers that all the 8 channels'
period values should be the same.



> > +static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
> > +{
> > +	int ret;
> > +	unsigned long reg;
> > +
> > +	if (fpc->counter_clk_enable++)
> > +		return 0;
> 
> Are you sure this is safe? I think you'll need to use either an atomic
> or a mutex to lock this.
> 

Maybe a mutex lock is a good choice.


> > +	ret = clk_prepare_enable(fpc->counter_clk);
> > +	if (ret)
> > +		return ret;
> 
> In case clk_prepare_enable() fails, the counter_clk_enable will need to
> be decremented in order to track the state correctly, doesn't it?
> 

Yes, it should be.


> > +static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct fsl_pwm_chip *fpc;
> > +
> > +	fpc = to_fsl_chip(chip);
> > +
> > +	fsl_counter_clock_enable(fpc);
> 
> This can fail. Should the error be propagated?
>

That's better.
 
> > +static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device
> *pwm)
> > +{
> > +	struct fsl_pwm_chip *fpc;
> > +
> > +	fpc = to_fsl_chip(chip);
> > +
> > +	fsl_counter_clock_disable(fpc);
> > +}
> 
> Same here. Since you can't propagate the error, perhaps an error message
> would be appropriate here?
> 

Well, in fsl_counter_clock_disable(fpc); only '0' could be returned, maybe
let it a void type value to return is better.
Just like:
static void fsl_counter_clock_disable(struct fsl_pwm_chip *fpc) {}


> Also for the locking above, perhaps a good solution would be to acquire
> the lock around the calls to fsl_counter_clock_{enable,disable}() so
> that they can safely assume that they are called with the lock held,
> which will make their implementation a lot simpler.
> 
> So what you could do is this:
> 
> 	static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device
> *pwm)
> 	{
> 		struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> 		int ret;
> 
> 		mutex_lock(&fpc->lock);
> 		ret = fsl_counter_clock_enable(fpc);
> 		mutex_unlock(&fpc->lock);
> 
> 		return ret;
> 	}
> 
> And analogously for fsl_pwm_disable().
>

I will think about this.

> 
> > +static int fsl_pwm_calculate_ps(struct fsl_pwm_chip *fpc)
> > +{
> > +	unsigned long long sys_rate, counter_rate, ratio;
> > +
> > +	sys_rate = clk_get_rate(fpc->sys_clk);
> > +	if (!sys_rate)
> > +		return -EINVAL;
> > +
> > +	counter_rate = clk_get_rate(fpc->counter_clk);
> > +	if (!counter_rate) {
> > +		fpc->counter_clk = fpc->sys_clk;
> > +		fpc->counter_clk_select = VF610_CLK_FTM0;
> > +		dev_warn(fpc->chip.dev,
> > +				"the counter source clock is a dummy clock, "
> > +				"so select the system clock as default!\n");
> > +	}
> > +
> > +	switch (fpc->counter_clk_select) {
> > +	case VF610_CLK_FTM0_FIX_SEL:
> > +		ratio = 2 * counter_rate - 1;
> > +		do_div(ratio, sys_rate);
> > +		fpc->clk_ps = ratio;
> > +		break;
> > +	case VF610_CLK_FTM0_EXT_SEL:
> > +		ratio = 4 * counter_rate - 1;
> > +		do_div(ratio, sys_rate);
> > +		fpc->clk_ps = ratio;
> > +		break;
> > +	case VF610_CLK_FTM0:
> > +		fpc->clk_ps = 7;
> 
> Even though it doesn't matter here, you should still add a break.
> Otherwise if you ever modify the code in the default case, you don't
> have to remember to add it in then.
> 
You are right, adding one break is much safer.

--
Best Rwgards,
