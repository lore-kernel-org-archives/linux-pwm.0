From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 3/3] backlight: pwm_bl: don't use GPIOF_* with
 gpiod_get_direction
Date: Mon, 15 Jan 2018 10:13:23 +0000
Message-ID: <55b3506a-9192-1b36-9c2a-38ec8502514a@linaro.org>
References: <20180114210711.13863-1-wsa+renesas@sang-engineering.com>
 <20180114210711.13863-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42034 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbeAOKN1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jan 2018 05:13:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id b141so741704wme.1
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jan 2018 02:13:27 -0800 (PST)
In-Reply-To: <20180114210711.13863-4-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-gpio@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org



On 14/01/18 21:07, Wolfram Sang wrote:
> The documentation was wrong, gpiod_get_direction() returns 0/1 instead
> of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
> ("gpio: correct docs about return value of gpiod_get_direction"). Now,
> fix this user (until a better, system-wide solution is in place).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Only build tested!
> 
>   drivers/video/backlight/pwm_bl.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 1c2289ddd555a6..0fa7d2bd0e4811 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -301,14 +301,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   	/*
>   	 * If the GPIO is not known to be already configured as output, that
> -	 * is, if gpiod_get_direction returns either GPIOF_DIR_IN or -EINVAL,
> -	 * change the direction to output and set the GPIO as active.
> +	 * is, if gpiod_get_direction returns either 1 or -EINVAL, change the
> +	 * direction to output and set the GPIO as active.
>   	 * Do not force the GPIO to active when it was already output as it
>   	 * could cause backlight flickering or we would enable the backlight too
>   	 * early. Leave the decision of the initial backlight state for later.
>   	 */
>   	if (pb->enable_gpio &&
> -	    gpiod_get_direction(pb->enable_gpio) != GPIOF_DIR_OUT)
> +	    gpiod_get_direction(pb->enable_gpio) != 0)
>   		gpiod_direction_output(pb->enable_gpio, 1);
>   
>   	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
> 
