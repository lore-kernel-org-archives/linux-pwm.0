From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] pwm: lpss: Do not set / wait_for update_bit when
 not enabled
Date: Tue, 28 Feb 2017 11:46:25 +0200
Message-ID: <1488275185.20145.48.camel@linux.intel.com>
References: <20170220201657.24801-1-hdegoede@redhat.com>
         <20170220201657.24801-2-hdegoede@redhat.com>
         <20170223080623.GB61837@kammari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27226 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbdB1Jr4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Feb 2017 04:47:56 -0500
In-Reply-To: <20170223080623.GB61837@kammari>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Thu, 2017-02-23 at 00:06 -0800, Ilkka Koskinen wrote:

> > At least on cherrytrail, the update bit will never go low when the
> > enabled bit is not set.
> > 
> > This causes the backlight on my cube iwork8 air tablet to never go
> > on
> > again after being turned off, because the enable path does:
> > 
> > 	pwm_lpss_prepare();
> > 	ret = pwm_lpss_update(pwm);
> > 	if (ret)
> > 		return ret;
> > 	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
> > 
> > And the pwm_lpss_update() call fails, as the setting of the
> > UPDATE bit never gets acked, because the ENABLE bit is not set.
> > 
> > Subsequent calls then all fail because of the pwm_lpss_is_updating()
> > check done by pwm_lpss_apply().
> > 

> > This commit fixes this by setting the enable bit before calling
> > pwm_lpss_update().

This might break other systems.

> > @@ -137,12 +137,12 @@ static int pwm_lpss_apply(struct pwm_chip
> > *chip, struct pwm_device *pwm,
> >  				return ret;
> >  			}
> >  			pwm_lpss_prepare(lpwm, pwm, state-
> > >duty_cycle, state->period);
> > +			pwm_lpss_write(pwm, pwm_lpss_read(pwm) |
> > PWM_ENABLE);
> >  			ret = pwm_lpss_update(pwm);
> 
> The BXT documentation that I have recommends to set update bit before
> enable
> one.

We have the same work flow for all SoCs that have this PWM IP. I suspect
it might be a silicon bug somewhere, but I have never heard of it.

>  However, based on your experiment on Cherryview, we still have to set
> it
> before read_poll_timeout(). 

I would test and confirm the issue on our machines to see that the fix
doesn't break the rest. Seems like we have several subtle different
implementation of it: BYT, CHT, MRFLD, BXT.

> Andy, should we indeed remove the return value from apply() and just
> print a warning
> like Mika initially suggested?

I definitely consider it better than Hans' initial proposal.

Hans, can you just replace

 return ret;

by

 dev_warn(..., "UPDATE bit is not cleared!\n");

and test it?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
