From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Date: Tue, 26 May 2020 04:42:17 -0700
Message-ID: <53619c02-8c0f-3eec-cccc-16e779b8c425@roeck-us.net>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbgEZLmU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 07:42:20 -0400
In-Reply-To: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sandipan Patra <spatra@nvidia.com>, treding@nvidia.com, jonathanh@nvidia.com, u.kleine-koenig@pengutronix.de, kamil@wypas.org, jdelvare@suse.com, robh+dt@kernel.org
Cc: bbasu@nvidia.com, bbiswas@nvidia.com, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On 5/25/20 10:06 PM, Sandipan Patra wrote:
> This change has 2 parts:
> 1. Add support for profiles mode settings.
>     This allows different fan settings for trip point temp/hyst/pwm.
>     T194 has multiple fan-profiles support.
> 
> 2. Add pwm-fan remove support. This is essential since the config is
>     tristate capable.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  drivers/hwmon/pwm-fan.c | 112 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 100 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 30b7b3e..26db589 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c

[ ... ]

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
> +
> +	return 0;
> +}
> +

I don't think you actually tested this. I would suggest to make
yourself familiar with 'devm' functions and their use, and
then resubmit.

Thanks,
Guenter
