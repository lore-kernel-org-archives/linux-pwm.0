From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: Add DesignWare PWM Controller Driver
Date: Thu, 9 Apr 2020 14:45:19 +0200
Message-ID: <20200409124519.hxm3tvii2575iozi@pengutronix.de>
References: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
 <20200409084828.uzqjb65zh3vklqs2@pengutronix.de>
 <1216506a-de51-1f37-7d7a-de7d9bbd9433@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44071 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgDIMpV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 08:45:21 -0400
Content-Disposition: inline
In-Reply-To: <1216506a-de51-1f37-7d7a-de7d9bbd9433@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Raymond Tan <raymond.tan@intel.com>, Felipe Balbi <balbi@kernel.org>

Hi Jarkko,

On Thu, Apr 09, 2020 at 03:10:46PM +0300, Jarkko Nikula wrote:
> > Maybe soon duty_ns and period_ns will become 64 bit integers. I suggest
> > to already cope for this today and introduce proper range checking.
> > 
> Ah, good to know.
> 
> > > +static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
> > > +{
> > > +	u32 reg;
> > > +
> > > +	reg = dwc_pwm_readl(dwc->base, DWC_TIM_CTRL(pwm));
> > > +
> > > +	if (enabled)
> > > +		reg |= DWC_TIM_CTRL_EN;
> > > +	else
> > > +		reg &= ~DWC_TIM_CTRL_EN;
> > > +
> > > +	dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(pwm), reg);
> > 
> > What happens to the output if the EN bit is cleared? Does the hardware
> > complete the currently running period? If not, does the output "freeze"
> > or get inactive?
> ...
> > 
> > Is it necessary to stop the hardware before writing the counter
> > registers? Or is this only done to prevent race conditions that yield
> > unexpected cycles?
>
> Good questions. I need to spend time in the lab next week and debug :-)

So I assume this means modifying registers while the hardware is running
at least isn't prohibited in the reference manual. Note this question
was more out of interest and I think with the register semantics an
atomic update probably doesn't work in a sane way anyhow. (The
background is that with some controllers you can update while the PWM is
running but this might result in bogus output and you can discuss
felicitously about which is the right approach to handle such hardware.
I just wanted to know if this hardware has potential for this discussion
;-) As far as I understood your hardware you would get bogus output for
quite sure and so disable + reconfigure + enable seems sane.)

> > > +static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			 const struct pwm_state *state)
> > > +{
> > > +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> > > +
> > > +	mutex_lock(&dwc->lock);
> > > +
> > > +	if (state->enabled) {
> > > +		if (!pwm_is_enabled(pwm))
> > 
> > If pwm_is_enabled() would be changed to call .get_state() you'd run in a
> > dead lock. Please don't call PWM API functions in driver callbacks.
>
> Oh. I guess we copied this from pwm-lpss.c and pwm-mxs.c.

But at least those don't use locking ...

> > > +			pm_runtime_get_sync(dwc->dev);
> > > +		__dwc_pwm_configure_timer(dwc, pwm, state);
> > > +	} else {
> > > +		if (pwm_is_enabled(pwm)) {
> > > +			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
> > > +			pm_runtime_put_sync(dwc->dev);
> > > +		}
> > > +	}
> > 
> > You don't check state->polarity here.
>
> If I recall correctly I didn't see the polarity bit in HW but will check.
> Should the driver emulate it by recalculating duty etc since I didn't see
> quickly from PWM core can a driver with apply() callback report support for
> polarity?

The usual thing is

	if (state->polarity != PWM_POLARITY_NORMAL)
		return -EINVAL;

in .apply. (Maybe the return code isn't the same everywhere.)

> > > +	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
> > > +		index_base = i * 3;
> > > +		dwc->saved_registers[index_base] =
> > > +			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(i));
> > > +		dwc->saved_registers[index_base+1] =
> > > +			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(i));
> > > +		dwc->saved_registers[index_base+2] =
> > > +			dwc_pwm_readl(dwc->base, DWC_TIM_CTRL(i));
> > > +	}
> > 
> > Does sleeping stop the output? If so (I think) you should prevent going
> > to sleep if the consumers didn't stop the output.
>
> I believe stopping the activity is an expectation during suspend but don't
> have the knowledge here. So in general PWM consumers should stop the PWM in
> their suspend handlers, e.g. in display panel drivers etc, rather than
> blindly stop it here?

Yes.

> How about when PWM is enabled from sysfs?

sysfs isn't different here in a relevant way. The key idea is: Don't
stop the output unless the consumer requested it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
