From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] pwm: lpss: Use positive condition in
 pwm_lpss_prepare()
Date: Wed, 15 Jan 2020 18:31:36 +0200
Message-ID: <20200115163136.GE32742@smile.fi.intel.com>
References: <20200115150849.74036-1-andriy.shevchenko@linux.intel.com>
 <20200115155425.n6nt7srrh4kxuczg@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:46420 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgAOQbh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 15 Jan 2020 11:31:37 -0500
Content-Disposition: inline
In-Reply-To: <20200115155425.n6nt7srrh4kxuczg@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Wed, Jan 15, 2020 at 04:54:25PM +0100, Uwe Kleine-König wrote:
> On Wed, Jan 15, 2020 at 05:08:49PM +0200, Andy Shevchenko wrote:

...

> > -	if (orig_ctrl != ctrl) {
> > -		pwm_lpss_write(pwm, ctrl);
> > -		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
> > -	}
> > +	if (orig_ctrl == ctrl)
> > +		return;
> > +
> > +	pwm_lpss_write(pwm, ctrl);
> > +	pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
> 
> I personally don't think that readability improved much and think that
> the old code is more intuitive. ("If the wanted register value doesn't
> match the actual value, write the value out.")
> 
> But I agree that the patch doesn't introduce a semantic difference.
> 
> What made you create that patch? Is it really that you read through the
> driver and thought "Huh, this is more complicated than necessary."?

My personal preferable style. So, I can survive with the current code.
Thanks for review!

-- 
With Best Regards,
Andy Shevchenko
