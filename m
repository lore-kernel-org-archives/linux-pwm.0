From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] pwm: lpss: Fix get_state runtime-pm reference handling
Date: Tue, 12 May 2020 22:01:01 +0300
Message-ID: <20200512190101.GF185537@smile.fi.intel.com>
References: <20200512110044.95984-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200512110044.95984-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, May 12, 2020 at 01:00:44PM +0200, Hans de Goede wrote:
> Before commit cfc4c189bc70 ("pwm: Read initial hardware state at request
> time"), a driver's get_state callback would get called once per PWM from
> pwmchip_add().
> 
> pwm-lpss' runtime-pm code was relying on this, getting a runtime-pm ref for
> PWMs which are enabled at probe time from within its get_state callback,
> before enabling runtime-pm.
> 
> The change to calling get_state at request time causes a number of
> problems:
> 
> 1. PWMs enabled at probe time may get runtime suspended before they are
> requested, causing e.g. a LCD backlight controlled by the PWM to turn off.
> 
> 2. When the request happens when the PWM has been runtime suspended, the
> ctrl register will read all 1 / 0xffffffff, causing get_state to store
> bogus values in the pwm_state.
> 
> 3. get_state was using an async pm_runtime_get() call, because it assumed
> that runtime-pm has not been enabled yet. If shortly after the request an
> apply call is made, then the pwm_lpss_is_updating() check may trigger
> because the resume triggered by the pm_runtime_get() call is not complete
> yet, so the ctrl register still reads all 1 / 0xffffffff.
> 
> This commit fixes these issues by moving the initial pm_runtime_get() call
> for PWMs which are enabled at probe time to the pwm_lpss_probe() function;
> and by making get_state take a runtime-pm ref before reading the ctrl reg.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One thing to consider below.

> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1828927
> Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 75bbfe5f3bc2..9d965ffe66d1 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -158,7 +158,6 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return 0;
>  }
>  
> -/* This function gets called once from pwmchip_add to get the initial state */
>  static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  			       struct pwm_state *state)
>  {
> @@ -167,6 +166,8 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned long long base_unit, freq, on_time_div;
>  	u32 ctrl;
>  
> +	pm_runtime_get_sync(chip->dev);
> +
>  	base_unit_range = BIT(lpwm->info->base_unit_bits);
>  
>  	ctrl = pwm_lpss_read(pwm);
> @@ -187,8 +188,7 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	state->polarity = PWM_POLARITY_NORMAL;
>  	state->enabled = !!(ctrl & PWM_ENABLE);
>  
> -	if (state->enabled)
> -		pm_runtime_get(chip->dev);
> +	pm_runtime_put(chip->dev);
>  }
>  
>  static const struct pwm_ops pwm_lpss_ops = {
> @@ -202,7 +202,8 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>  {
>  	struct pwm_lpss_chip *lpwm;
>  	unsigned long c;
> -	int ret;
> +	int i, ret;
> +	u32 ctrl;
>  
>  	if (WARN_ON(info->npwm > MAX_PWMS))
>  		return ERR_PTR(-ENODEV);
> @@ -232,6 +233,12 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>  		return ERR_PTR(ret);
>  	}
>  
> +	for (i = 0; i < lpwm->info->npwm; i++) {

> +		ctrl = pwm_lpss_read(&lpwm->chip.pwms[i]);
> +		if (ctrl & PWM_ENABLE)

I would create a helper for this as opposite to pwm_lpss_cond_enable(),
something like pwm_lpss_is_enabled().

> +			pm_runtime_get(dev);
> +	}
> +
>  	return lpwm;
>  }
>  EXPORT_SYMBOL_GPL(pwm_lpss_probe);
> -- 
> 2.26.0
> 

-- 
With Best Regards,
Andy Shevchenko
