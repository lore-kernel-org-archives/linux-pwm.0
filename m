From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm: add support for Intel Low Power Subsystem PWM
Date: Tue, 21 Jan 2014 10:52:36 +0200
Message-ID: <20140121085236.GI18029@intel.com>
References: <1390240808-18582-1-git-send-email-chiau.ee.chew@intel.com>
 <20140120132814.212929bd@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56593 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbaAUIpd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 21 Jan 2014 03:45:33 -0500
Content-Disposition: inline
In-Reply-To: <20140120132814.212929bd@alan.etchedpixels.co.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Thierry Reding <thierry.reding@gmail.com>
Cc: Chew Chiau Ee <chiau.ee.chew@intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Chew Kean Ho <kean.ho.chew@intel.com>, Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>

On Mon, Jan 20, 2014 at 01:28:14PM +0000, One Thousand Gnomes wrote:
> > +static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > +	int duty_ns, int period_ns)
> > +{
> > +	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> > +	u8 on_time_div;
> > +	unsigned long c = clk_get_rate(lpwm->clk);
> > +	unsigned long long base_unit, hz = 1000000000UL;
> > +	u32 ctrl;
> > +
> > +	do_div(hz, period_ns);
> > +
> > +	/* The equation is: base_unit = ((hz / c) * 65536) + correction */
> > +	base_unit = hz * 65536;
> > +	do_div(base_unit, c);
> > +	base_unit += PWM_DIVISION_CORRECTION;
> > +	if (base_unit > PWM_LIMIT)
> > +		return -EINVAL;
> > +
> > +	if (duty_ns <= 0)
> > +		duty_ns = 1;
> > +	on_time_div = 255 - (255 * duty_ns / period_ns);
> > +
> > +	ctrl = readl(lpwm->regs + PWM);
> > +	ctrl &= ~(PWM_BASE_UNIT_MASK | PWM_ON_TIME_DIV_MASK);
> > +	ctrl |= (u16) base_unit << PWM_BASE_UNIT_SHIFT;
> > +	ctrl |= on_time_div;
> > +	/* request PWM to update on next cycle */
> > +	ctrl |= PWM_SW_UPDATE;
> > +	writel(ctrl, lpwm->regs + PWM);
> > +
> 
> Who handles the locking on all these functions. The pwm layer doesn't but
> simnply exports stuff like pwm_config() directly to other bits of the
> kernel so you are not guaranteed to be called via sysfs.
> 
> (This btw looks to be a problem with a pile of the other pwm drivers, and
> with the pwm core code which doesn't properly lock its own handling of
> pwm->duty_cycle and pwm->period in pwm_config(), nor pwm->polarity in
> pwm_set_polarity).

Good point. I checked few PWM drivers as well and none of them (including
this one) does any locking around ->config().

> I think the core config methods need some kind of locking ?

Thierry, any comments on this?
