From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] hwmon: pwm-fan: remove no longer needed
 suspend/resume code
Date: Mon, 3 Apr 2017 08:52:31 -0700
Message-ID: <20170403155231.GA28014@roeck-us.net>
References: <1491227226-12972-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170403134742epcas1p42a7ea96e9c27d5752796ca9ff86d0f1e@epcas1p4.samsung.com>
 <1491227226-12972-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47113 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbdDCPwk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Apr 2017 11:52:40 -0400
Content-Disposition: inline
In-Reply-To: <1491227226-12972-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jean Delvare <jdelvare@suse.com>, Kamil Debski <kamil@wypas.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Mon, Apr 03, 2017 at 03:47:06PM +0200, Bartlomiej Zolnierkiewicz wrote:
> The suspend/resume is now properly handled by pwm-samsung driver
> (pwm-fan is currently only used by ARM Exynos boards) and the old
> code only handles ctx->pwm_value != 0 case. Just remove it.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume this will be picked up with the rest of the series.
If not please let me know.

Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index f9af393..9dc40f3 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -302,37 +302,6 @@ static int pwm_fan_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int pwm_fan_suspend(struct device *dev)
> -{
> -	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> -
> -	if (ctx->pwm_value)
> -		pwm_disable(ctx->pwm);
> -	return 0;
> -}
> -
> -static int pwm_fan_resume(struct device *dev)
> -{
> -	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> -	struct pwm_args pargs;
> -	unsigned long duty;
> -	int ret;
> -
> -	if (ctx->pwm_value == 0)
> -		return 0;
> -
> -	pwm_get_args(ctx->pwm, &pargs);
> -	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
> -	ret = pwm_config(ctx->pwm, duty, pargs.period);
> -	if (ret)
> -		return ret;
> -	return pwm_enable(ctx->pwm);
> -}
> -#endif
> -
> -static SIMPLE_DEV_PM_OPS(pwm_fan_pm, pwm_fan_suspend, pwm_fan_resume);
> -
>  static const struct of_device_id of_pwm_fan_match[] = {
>  	{ .compatible = "pwm-fan", },
>  	{},
> @@ -344,7 +313,6 @@ static int pwm_fan_resume(struct device *dev)
>  	.remove		= pwm_fan_remove,
>  	.driver	= {
>  		.name		= "pwm-fan",
> -		.pm		= &pwm_fan_pm,
>  		.of_match_table	= of_pwm_fan_match,
>  	},
>  };
> -- 
> 1.9.1
> 
