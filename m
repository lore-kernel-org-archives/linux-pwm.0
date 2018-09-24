Return-Path: <andriy.shevchenko@linux.intel.com>
Date: Mon, 24 Sep 2018 12:16:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] pwm: lpss: Add pwm_lpss_get_put_runtime_pm helper
 function
Message-ID: <20180924091653.GF15943@smile.fi.intel.com>
References: <20180911174533.4484-1-hdegoede@redhat.com>
 <20180911174533.4484-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911174533.4484-2-hdegoede@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Sep 11, 2018 at 07:45:32PM +0200, Hans de Goede wrote:
> Add a helper function to properly get / put the pwm's runtime_pm
> reference when changing from enabled to disable or vice versa.
> 
> And use this to ensure the pwm's runtime_pm reference is properly
> released on remove.
> 

Can you provide a test sequence to reproduce the issue?

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss.c | 47 +++++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index e602835fd6de..d39158800baa 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -120,43 +120,58 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
>  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
>  }
>  
> +static void pwm_lpss_get_put_runtime_pm(struct pwm_chip *chip,
> +					bool old_enabled, bool new_enabled)
> +{
> +	if (new_enabled == old_enabled)
> +		return;
> +
> +	if (new_enabled)
> +		pm_runtime_get(chip->dev);
> +	else
> +		pm_runtime_put(chip->dev);
> +}
> +
>  static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  struct pwm_state *state)
>  {
>  	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> -	int ret;
> +	int ret = 0;
> +
> +	pm_runtime_get_sync(chip->dev);
>  
>  	if (state->enabled) {
>  		if (!pwm_is_enabled(pwm)) {
> -			pm_runtime_get_sync(chip->dev);
>  			ret = pwm_lpss_is_updating(pwm);
> -			if (ret) {
> -				pm_runtime_put(chip->dev);
> -				return ret;
> -			}
> +			if (ret)
> +				goto out;
> +
>  			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>  			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
>  			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
>  			ret = pwm_lpss_wait_for_update(pwm);
> -			if (ret) {
> -				pm_runtime_put(chip->dev);
> -				return ret;
> -			}
> +			if (ret)
> +				goto out;
> +
>  			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
>  		} else {
>  			ret = pwm_lpss_is_updating(pwm);
>  			if (ret)
> -				return ret;
> +				goto out;
> +
>  			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>  			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
> -			return pwm_lpss_wait_for_update(pwm);
> +			ret = pwm_lpss_wait_for_update(pwm);
>  		}
>  	} else if (pwm_is_enabled(pwm)) {
>  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
> -		pm_runtime_put(chip->dev);
>  	}
>  
> -	return 0;
> +	pwm_lpss_get_put_runtime_pm(chip, pwm_is_enabled(pwm), state->enabled);
> +
> +out:
> +	pm_runtime_put(chip->dev);
> +	return ret;
>  }
>  
>  static const struct pwm_ops pwm_lpss_ops = {
> @@ -205,6 +220,10 @@ EXPORT_SYMBOL_GPL(pwm_lpss_probe);
>  
>  int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
>  {
> +	bool enabled = pwm_is_enabled(&lpwm->chip.pwms[0]);
> +
> +	pwm_lpss_get_put_runtime_pm(&lpwm->chip, enabled, false);
> +
>  	return pwmchip_remove(&lpwm->chip);
>  }
>  EXPORT_SYMBOL_GPL(pwm_lpss_remove);
> -- 
> 2.19.0.rc0
> 

-- 
With Best Regards,
Andy Shevchenko
