From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH] pwm-backlight: fix the panel power sequence
Date: Wed, 14 Oct 2015 18:01:15 +0800
Message-ID: <1444816875.31675.2.camel@mtksdaap41>
References: <1442414556-32381-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:41213 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752214AbbJNKBU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Oct 2015 06:01:20 -0400
In-Reply-To: <1442414556-32381-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, yh.huang@mediatek.com

Hi all,

If you have any suggestion, please let me know.
Thanks.

Regards,
YH Huang

On Wed, 2015-09-16 at 22:42 +0800, YH Huang wrote:
> In order to match the panel power sequence, disable the enable_gpio
> in the probe function. Also, reorder the code in the power_on and
> power_off function to match the timing.
> 
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/video/backlight/pwm_bl.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index eff379b..99eca1e 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>  	if (err < 0)
>  		dev_err(pb->dev, "failed to enable power supply\n");
>  
> +	pwm_enable(pb->pwm);
> +
>  	if (pb->enable_gpio)
>  		gpiod_set_value(pb->enable_gpio, 1);
>  
> -	pwm_enable(pb->pwm);
>  	pb->enabled = true;
>  }
>  
> @@ -66,12 +67,12 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  	if (!pb->enabled)
>  		return;
>  
> -	pwm_config(pb->pwm, 0, pb->period);
> -	pwm_disable(pb->pwm);
> -
>  	if (pb->enable_gpio)
>  		gpiod_set_value(pb->enable_gpio, 0);
>  
> +	pwm_config(pb->pwm, 0, pb->period);
> +	pwm_disable(pb->pwm);
> +
>  	regulator_disable(pb->power_supply);
>  	pb->enabled = false;
>  }
> @@ -241,8 +242,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	pb->dev = &pdev->dev;
>  	pb->enabled = false;
>  
> -	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> -						  GPIOD_OUT_HIGH);
> +	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
>  	if (IS_ERR(pb->enable_gpio)) {
>  		ret = PTR_ERR(pb->enable_gpio);
>  		goto err_alloc;
> @@ -264,6 +264,9 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
>  	}
>  
> +	if (pb->enable_gpio)
> +		gpiod_direction_output(pb->enable_gpio, 0);
> +
>  	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
>  	if (IS_ERR(pb->power_supply)) {
>  		ret = PTR_ERR(pb->power_supply);
