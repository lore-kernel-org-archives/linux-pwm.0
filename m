Return-Path: <andriy.shevchenko@linux.intel.com>
Date: Tue, 25 Sep 2018 12:40:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] pwm: lpss: Add get_state callback
Message-ID: <20180925094025.GT15943@smile.fi.intel.com>
References: <20180925072536.17406-1-hdegoede@redhat.com>
 <20180925072536.17406-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925072536.17406-2-hdegoede@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Sep 25, 2018 at 09:25:36AM +0200, Hans de Goede wrote:
> Add a get_state callback so that the initial state correctly reflects
> the actual hardware state.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Stop using the dropped pwm_lpss_get_put_runtime_pm() helper
> ---
>  drivers/pwm/pwm-lpss.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 723ca9de8325..ea93ef9f3672 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -159,8 +159,42 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return 0;
>  }
>  
> +/* This function gets called once from pwmchip_add to get the initial state */
> +static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> +	unsigned long base_unit_range;
> +	unsigned long long base_unit, freq, on_time_div;
> +	u32 ctrl;
> +
> +	base_unit_range = BIT(lpwm->info->base_unit_bits);
> +
> +	ctrl = pwm_lpss_read(pwm);
> +	on_time_div = 255 - (ctrl & PWM_ON_TIME_DIV_MASK);
> +	base_unit = (ctrl >> PWM_BASE_UNIT_SHIFT) & (base_unit_range - 1);
> +
> +	freq = base_unit * lpwm->info->clk_rate;
> +	do_div(freq, base_unit_range);
> +	if (freq == 0)
> +		state->period = NSEC_PER_SEC;
> +	else
> +		state->period = NSEC_PER_SEC / (unsigned long)freq;
> +
> +	on_time_div *= state->period;
> +	do_div(on_time_div, 255);
> +	state->duty_cycle = on_time_div;
> +
> +	state->polarity = PWM_POLARITY_NORMAL;
> +	state->enabled = !!(ctrl & PWM_ENABLE);
> +
> +	if (state->enabled)
> +		pm_runtime_get(chip->dev);
> +}
> +
>  static const struct pwm_ops pwm_lpss_ops = {
>  	.apply = pwm_lpss_apply,
> +	.get_state = pwm_lpss_get_state,
>  	.owner = THIS_MODULE,
>  };
>  
> -- 
> 2.19.0.rc1
> 

-- 
With Best Regards,
Andy Shevchenko
