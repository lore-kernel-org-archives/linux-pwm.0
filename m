From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: The default value of enable_gpio in pwm-backlight driver?
Date: Mon, 14 Sep 2015 11:24:23 +0800
Message-ID: <1442201063.1076.9.camel@mtksdaap41>
References: <1441285704.27600.26.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:39782 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753742AbbINDY2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Sep 2015 23:24:28 -0400
In-Reply-To: <1441285704.27600.26.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>
Cc: YH Huang <yh.huang@mediatek.com>, linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org, djkurtz@chromium.org, lee.jones@linaro.org, jingoohan1@gmail.com, linux-kernel@vger.kernel.org


Hi Alexandre, Thierry,


On Thu, 2015-09-03 at 21:08 +0800, YH Huang wrote:
<...>
> From	Alexandre Courbot <>
> Subject	[PATCH 2/2] pwm-backlight: switch to gpiod interface
> Date	Thu, 27 Feb 2014 14:53:34 +0900
> 
> Switch to the new gpiod interface, which allows to handle GPIO
> properties such as active low transparently and removes a whole bunch of
> code.
> 
> There are still a couple of users of this driver that rely on passing
> the enable GPIO number through platform data, so a fallback mechanism
> using a GPIO number is still available to avoid breaking them. It will
> be removed once current users have switched to the GPIO lookup tables
> provided by the gpiod interface.
> 
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> 
> @@ -265,26 +245,39 @@ static int pwm_backlight_probe(struct
> platform_device *pdev)
>  	pb->dev = &pdev->dev;
>  	pb->enabled = false;
>  
> -	if (gpio_is_valid(pb->enable_gpio)) {
> -		unsigned long flags;
> -
> -		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
> -			flags = GPIOF_OUT_INIT_HIGH;
> -		else
> -			flags = GPIOF_OUT_INIT_LOW;

In commit 257462dbf3ed ("pwm-backlight: switch to gpiod interface").
It seems to me the original code is trying to make it default disable...

> +	pb->enable_gpio = devm_gpiod_get(&pdev->dev, "enable");
> +	if (IS_ERR(pb->enable_gpio)) {
> +		ret = PTR_ERR(pb->enable_gpio);
> +		if (ret == -ENOENT) {
> +			pb->enable_gpio = NULL;
> +			ret = 0;
> +		} else {
> +			goto err_alloc;
> +		}
> +	}
>  
> -		ret = gpio_request_one(pb->enable_gpio, flags, "enable");
> +	/*
> +	 * Compatibility fallback for drivers still using the integer GPIO
> +	 * platform data. Must go away soon.
> +	 */
> +	if (pb->enable_gpio == NULL && gpio_is_valid(data->enable_gpio)) {
> +		ret = devm_gpio_request_one(&pdev->dev, data->enable_gpio,
> +					    GPIOF_OUT_INIT_HIGH, "enable");
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "failed to request GPIO#%d: %d\n",
> -				pb->enable_gpio, ret);
> +				data->enable_gpio, ret);
>  			goto err_alloc;
>  		}
> +		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
>  	}
>  
> +	if (pb->enable_gpio)
> +		gpiod_direction_output(pb->enable_gpio, 1);

But the new code here set it to enable. Is this on purpose, or am I miss
read anything?

Joe.C
