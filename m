From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/4] pwm: lpss: Switch to new atomic API
Date: Thu, 19 Jan 2017 16:32:46 +0200
Message-ID: <1484836366.2133.243.camel@linux.intel.com>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
         <20170102091647.86910-5-andriy.shevchenko@linux.intel.com>
         <20170118111518.GP18989@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:34630 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752656AbdASOeH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Jan 2017 09:34:07 -0500
In-Reply-To: <20170118111518.GP18989@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>

On Wed, 2017-01-18 at 12:15 +0100, Thierry Reding wrote:
> On Mon, Jan 02, 2017 at 11:16:47AM +0200, Andy Shevchenko wrote:
> > Instead of doing things separately, which is not so reliable on some
> > platforms,
> > switch the driver to use new atomic API, i.e. ->apply() callback.
> > 
> > The change has been tested on Intel platforms such as Broxton,
> > BayTrail, and
> > Merrifield.

> > +static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device
> > *pwm,
> > +			  struct pwm_state *state)
> > +{
> > +	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> > +
> > +	if (state->enabled) {
> > +		if (!pwm_is_enabled(pwm)) {
> > +			pm_runtime_get_sync(chip->dev);
> > +			pwm_lpss_config(lpwm, pwm, state-
> > >duty_cycle, state->period);
> > +			pwm_lpss_enable(pwm);
> > +		} else {
> > +			pwm_lpss_config(lpwm, pwm, state-
> > >duty_cycle, state->period);
> > +		}
> > +	} else if (pwm_is_enabled(pwm)) {
> > +		pwm_lpss_disable(pwm);
> > +		pm_runtime_put(chip->dev);
> > +	}
> 
> Would you mind doing another pass over this and inline the
> pwm_lpss_enable(), pwm_lpss_disable() and pwm_lpss_config() functions
> into pwm_lpss_apply()? Your current version effectively duplicates the
> transitional helpers, but the goal should be to fully get rid of the
> remainders of the legacy API.

I don't see how inlining them helps. For me readability of code is more
important than names of the functions.

I can rename functions, but I would like to have them separate from the
->apply() callback.

Compiler inlines them during optimization.

> Besides being much cleaner this also gets rid of slight
> inconsistencies
> between the two APIs.

I don't see how One Big Function can be cleaner than split version. But
I give a try to see it on my side when you have settled with Mika's
patch.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
