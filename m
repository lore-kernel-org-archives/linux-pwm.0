From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Date: Tue, 26 May 2020 09:04:50 +0200
Message-ID: <20200526070450.sackolk6m3qv7omy@pengutronix.de>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1590469565-14953-1-git-send-email-spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, bbiswas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, May 26, 2020 at 10:36:04AM +0530, Sandipan Patra wrote:
> This change has 2 parts:
> 1. Add support for profiles mode settings.
>     This allows different fan settings for trip point temp/hyst/pwm.
>     T194 has multiple fan-profiles support.
> 
> 2. Add pwm-fan remove support. This is essential since the config is
>     tristate capable.

These two are orthogonal, aren't they? So they belong in two patches.

You have to expand the binding documentation.

> Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/hwmon/pwm-fan.c | 112 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 100 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 30b7b3e..26db589 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -3,8 +3,10 @@
>   * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
>   *
>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2020, NVIDIA Corporation.
>   *
>   * Author: Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + * Author: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>   */
>  
>  #include <linux/hwmon.h>
> @@ -21,6 +23,8 @@
>  #include <linux/timer.h>
>  
>  #define MAX_PWM 255
> +/* Based on OF max device tree node name length */
> +#define MAX_PROFILE_NAME_LENGTH	31
>  
>  struct pwm_fan_ctx {
>  	struct mutex lock;
> @@ -38,6 +42,12 @@ struct pwm_fan_ctx {
>  	unsigned int pwm_fan_state;
>  	unsigned int pwm_fan_max_state;
>  	unsigned int *pwm_fan_cooling_levels;
> +
> +	unsigned int pwm_fan_profiles;
> +	const char **fan_profile_names;
> +	unsigned int **fan_profile_cooling_levels;
> +	unsigned int fan_current_profile;
> +
>  	struct thermal_cooling_device *cdev;
>  };
>  
> @@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>  				       struct pwm_fan_ctx *ctx)
>  {
>  	struct device_node *np = dev->of_node;
> +	struct device_node *base_profile = NULL;
> +	struct device_node *profile_np = NULL;
> +	const char *default_profile = NULL;
>  	int num, i, ret;
>  
> -	if (!of_find_property(np, "cooling-levels", NULL))
> -		return 0;
> +	num = of_property_count_u32_elems(np, "cooling-levels");
> +	if (num <= 0) {
> +		base_profile = of_get_child_by_name(np, "profiles");
> +		if (!base_profile) {
> +			dev_err(dev, "Wrong Data\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (base_profile) {
> +		ctx->pwm_fan_profiles =
> +			of_get_available_child_count(base_profile);
> +
> +		if (ctx->pwm_fan_profiles <= 0) {
> +			dev_err(dev, "Profiles used but not defined\n");
> +			return -EINVAL;
> +		}
>  
> -	ret = of_property_count_u32_elems(np, "cooling-levels");
> -	if (ret <= 0) {
> -		dev_err(dev, "Wrong data!\n");
> -		return ret ? : -EINVAL;
> +		ctx->fan_profile_names = devm_kzalloc(dev,
> +			sizeof(const char *) * ctx->pwm_fan_profiles,
> +							GFP_KERNEL);
> +		ctx->fan_profile_cooling_levels = devm_kzalloc(dev,
> +			sizeof(int *) * ctx->pwm_fan_profiles,
> +							GFP_KERNEL);
> +
> +		if (!ctx->fan_profile_names
> +				|| !ctx->fan_profile_cooling_levels)
> +			return -ENOMEM;
> +
> +		ctx->fan_current_profile = 0;
> +		i = 0;
> +		for_each_available_child_of_node(base_profile, profile_np) {
> +			num = of_property_count_u32_elems(profile_np,
> +							"cooling-levels");
> +			if (num <= 0) {
> +				dev_err(dev, "No data in cooling-levels inside profile node!\n");
> +				return -EINVAL;
> +			}
> +
> +			of_property_read_string(profile_np, "name",
> +						&ctx->fan_profile_names[i]);
> +			if (default_profile &&
> +				!strncmp(default_profile,
> +				ctx->fan_profile_names[i],
> +				MAX_PROFILE_NAME_LENGTH))
> +				ctx->fan_current_profile = i;
> +
> +			ctx->fan_profile_cooling_levels[i] =
> +				devm_kzalloc(dev, sizeof(int) * num,
> +							GFP_KERNEL);
> +			if (!ctx->fan_profile_cooling_levels[i])
> +				return -ENOMEM;
> +
> +			of_property_read_u32_array(profile_np, "cooling-levels",
> +				ctx->fan_profile_cooling_levels[i], num);
> +			i++;
> +		}
>  	}
>  
> -	num = ret;
>  	ctx->pwm_fan_cooling_levels = devm_kcalloc(dev, num, sizeof(u32),
>  						   GFP_KERNEL);
>  	if (!ctx->pwm_fan_cooling_levels)
>  		return -ENOMEM;
>  
> -	ret = of_property_read_u32_array(np, "cooling-levels",
> -					 ctx->pwm_fan_cooling_levels, num);
> -	if (ret) {
> -		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
> -		return ret;
> +	if (base_profile) {
> +		memcpy(ctx->pwm_fan_cooling_levels,
> +		  ctx->fan_profile_cooling_levels[ctx->fan_current_profile],
> +						num);
> +	} else {
> +		ret = of_property_read_u32_array(np, "cooling-levels",
> +				ctx->pwm_fan_cooling_levels, num);
> +		if (ret) {
> +			dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	for (i = 0; i < num; i++) {
> @@ -390,6 +458,25 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int pwm_fan_remove(struct platform_device *pdev)
> +{
> +	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> +	struct pwm_args args;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	if (IS_ENABLED(CONFIG_THERMAL))
> +		thermal_cooling_device_unregister(ctx->cdev);
> +
> +	pwm_get_args(ctx->pwm, &args);
> +	pwm_config(ctx->pwm, 0, args.period);
> +	pwm_disable(ctx->pwm);

What is what you really here? Is it only that the PWM stops oscillating,
or is it crucial that the output goes to its inactive level?

(The intended semantic of pwm_disable includes that the output goes low,
but not all implementations enforce this.)

Also please don't introduce new users of pwm_config() and pwm_disable()
use pwm_apply() instead.

I wonder if this unregistration is "safe". When the driver is in use I'd
expect that the hwmon device doesn't go away and so the devm
unregistration callback that belongs to
devm_hwmon_device_register_with_groups() blocks. But at this time the
PWM is already stopped and so the device stops functioning earlier.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
