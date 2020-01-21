From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (pwm-fan) stop fan on shutdown
Date: Mon, 20 Jan 2020 18:16:23 -0800
Message-ID: <20200121021623.GA32430@roeck-us.net>
References: <1579534344-11694-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55856 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCQ0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 21:16:26 -0500
Content-Disposition: inline
In-Reply-To: <1579534344-11694-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

On Tue, Jan 21, 2020 at 12:32:24AM +0900, Akinobu Mita wrote:
> The pwm-fan driver stops the fan in suspend but leaves the fan on in
> shutdown.  It seems strange to leave the fan on in shutdown because there
> is no use case in my mind and the gpio-fan driver on the other hand stops
> in shutdown.
> 
> This change turns off the fan in shutdown.  If anyone complains then we'll
> add an optional property to switch the behavior.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kamil Debski <kamil@wypas.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Applied.

Thanks,
Guenter

> ---
> * v2
> - remove optional property and just turn off the fan in shutdown
> 
>  drivers/hwmon/pwm-fan.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 42ffd2e..30b7b3e 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -390,8 +390,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int pwm_fan_suspend(struct device *dev)
> +static int pwm_fan_disable(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>  	struct pwm_args args;
> @@ -418,6 +417,17 @@ static int pwm_fan_suspend(struct device *dev)
>  	return 0;
>  }
>  
> +static void pwm_fan_shutdown(struct platform_device *pdev)
> +{
> +	pwm_fan_disable(&pdev->dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int pwm_fan_suspend(struct device *dev)
> +{
> +	return pwm_fan_disable(dev);
> +}
> +
>  static int pwm_fan_resume(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> @@ -455,6 +465,7 @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
>  
>  static struct platform_driver pwm_fan_driver = {
>  	.probe		= pwm_fan_probe,
> +	.shutdown	= pwm_fan_shutdown,
>  	.driver	= {
>  		.name		= "pwm-fan",
>  		.pm		= &pwm_fan_pm,
