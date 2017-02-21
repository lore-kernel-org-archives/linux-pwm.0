From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] pwm: lpss: Add get_state callback
Date: Tue, 21 Feb 2017 12:33:16 +0200
Message-ID: <1487673196.20145.7.camel@linux.intel.com>
References: <20170220201657.24801-1-hdegoede@redhat.com>
         <20170220201657.24801-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:16033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdBUKdT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 21 Feb 2017 05:33:19 -0500
In-Reply-To: <20170220201657.24801-4-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On Mon, 2017-02-20 at 21:16 +0100, Hans de Goede wrote:
> Add a get_state callback so that the initial state correctly reflects
> the actual hardware state.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

 
> +static void pwm_lpss_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> +	unsigned long base_unit_range, freq;
> +	unsigned long long base_unit, on_time_div;

Something with types.

on_time_div is 8-bit only.
OTOH freq (due to multiplication below) might need bigger type.

Have you tried 32-bit compilation, btw? No warnings for division?

> +	u32 ctrl;
> +
> +	base_unit_range = BIT(lpwm->info->base_unit_bits);
> +
> +	ctrl = pwm_lpss_read(pwm);
> +	on_time_div = ctrl & PWM_ON_TIME_DIV_MASK;
> +	base_unit = (ctrl >> PWM_BASE_UNIT_SHIFT) & (base_unit_range
> - 1);
> +
> +	freq = base_unit * lpwm->info->clk_rate / base_unit_range;

> +	if (freq == 0)
> +		freq = 1;

Why?
I'm not sure it will give correct value.

> +

> +	state->period = NSEC_PER_SEC / freq;


> +	state->duty_cycle = state->period * on_time_div / 255ULL;
> +	state->polarity = PWM_POLARITY_NORMAL;

> +	state->enabled = (ctrl & PWM_ENABLE) ? true : false;

!!(ctrl & PWM_ENABLE)

> +

> +	if (state->enabled)
> +		pm_runtime_get_sync(chip->dev);

How is this supposed to work in balance with ->apply() ?

> +}
> +
>  static const struct pwm_ops pwm_lpss_ops = {
>  	.apply = pwm_lpss_apply,
> +	.get_state = pwm_lpss_get_state,
>  	.owner = THIS_MODULE,
>  };
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
