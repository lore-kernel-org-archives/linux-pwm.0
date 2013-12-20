From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
Date: Fri, 20 Dec 2013 07:47:24 +0000
Message-ID: <ef4b36fcabc7492390834857d5250598@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
	<1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
 <87y53gy07m.fsf@nbsps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:55197
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753854Ab3LTHrj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Dec 2013 02:47:39 -0500
In-Reply-To: <87y53gy07m.fsf@nbsps.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bill Pringlemeir <bpringlemeir@nbsps.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

> > +static int fsl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			  int duty_ns, int period_ns)
> > +{
> > +	unsigned long period_cycles, duty_cycles;
> > +	unsigned long cntin = FTM_CNTIN_VAL;
> > +	struct fsl_pwm_chip *fpc;
> > +
> > +	fpc = to_fsl_chip(chip);
> > +
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
> > +
> > +	writel(FTMCnSC_MSB | FTMCnSC_ELSB, fpc->base + FTM_CSC(pwm->hwpwm));
> > +
> > +	writel(0xF0, fpc->base + FTM_OUTMASK);
> > +	writel(0x0F, fpc->base + FTM_OUTINIT);
> > +	writel(FTM_CNTIN_VAL, fpc->base + FTM_CNTIN);
> > +
> > +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> > +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));
> > +
> > +	return 0;
> > +}
> 
> Even though the module can support eight channels, the FTM_MOD is global and
> is updated in each 'config'.  So, if we have two PWMs, and both call 'config'
> with different periods, the last one to call will win?  There doesn't seem to
> be any locking/inspection of 'MOD'.  I think this is global to the FTM, while
> 'FTM_CV()' is per channel.
> 
> So we may have 8 PWMs, all with the same period, but with different duty
> cycles.  Is this correct?  Or are we only supporting one channel per FTM/PWM?
> 

Yes, that's right.

And in "[PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support" patch, this has
been fixed.

Best Regards,
Xiubo

