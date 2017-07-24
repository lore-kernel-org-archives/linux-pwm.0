From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 3/5] pwm-backlight: add support for PWM delays
 proprieties.
Date: Mon, 24 Jul 2017 16:22:21 +0100
Message-ID: <0e2d4f9b-0f27-3793-0c27-2a2df5c32cf0@linaro.org>
References: <20170721104813.5389-1-enric.balletbo@collabora.com>
 <20170721104813.5389-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36873 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753886AbdGXPWY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jul 2017 11:22:24 -0400
Received: by mail-wm0-f52.google.com with SMTP id c184so34686558wmd.0
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2017 08:22:23 -0700 (PDT)
In-Reply-To: <20170721104813.5389-3-enric.balletbo@collabora.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org

On 21/07/17 11:48, Enric Balletbo i Serra wrote:
> Some panels (i.e. N116BGE-L41), in their power sequence specifications,
> request a delay between set the PWM signal and enable the backlight and
> between clear the PWM signal and disable the backlight. Add support for
> the new post-pwm-on-delay-ms and pwm-off-delay-ms proprieties to meet
> the timings.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Changes since v3:
>   - Use two named members instead of pwm_delay[] (Daniel and Pavel)
>   - Use msleep instead of usleep_range. (Pavel)
> Changes since v2:
>   - Move the pwm/enable sequence to another patch (Thierry Reding)
> Changes since v1:
>   - As suggested by Daniel Thompson
>     - Do not assume power-on delay and power-off delay will be the same
>   - Move the check of dt property to the parse dt function.
> 
>   drivers/video/backlight/pwm_bl.c | 19 +++++++++++++++++++
>   include/linux/pwm_backlight.h    |  2 ++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 909a686..6cf6109 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -10,6 +10,7 @@
>    * published by the Free Software Foundation.
>    */
>   
> +#include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/gpio.h>
>   #include <linux/module.h>
> @@ -35,6 +36,8 @@ struct pwm_bl_data {
>   	struct gpio_desc	*enable_gpio;
>   	unsigned int		scale;
>   	bool			legacy;
> +	unsigned int		post_pwm_on_delay;
> +	unsigned int		pwm_off_delay;
>   	int			(*notify)(struct device *,
>   					  int brightness);
>   	void			(*notify_after)(struct device *,
> @@ -56,6 +59,9 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>   
>   	pwm_enable(pb->pwm);
>   
> +	if (pb->post_pwm_on_delay)
> +		msleep(pb->post_pwm_on_delay);
> +
>   	if (pb->enable_gpio)
>   		gpiod_set_value_cansleep(pb->enable_gpio, 1);
>   
> @@ -70,6 +76,9 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>   	if (pb->enable_gpio)
>   		gpiod_set_value_cansleep(pb->enable_gpio, 0);
>   
> +	if (pb->pwm_off_delay)
> +		msleep(pb->pwm_off_delay);
> +
>   	pwm_config(pb->pwm, 0, pb->period);
>   	pwm_disable(pb->pwm);
>   
> @@ -175,6 +184,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
>   		data->max_brightness--;
>   	}
>   
> +	/*
> +	 * These values are optional and set as 0 by default, the out values
> +	 * are modified only if a valid u32 value can be decoded.
> +	 */
> +	of_property_read_u32(node, "post-pwm-on-delay-ms",
> +			     &data->post_pwm_on_delay);
> +	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
> +
>   	data->enable_gpio = -EINVAL;
>   	return 0;
>   }
> @@ -273,6 +290,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   	pb->exit = data->exit;
>   	pb->dev = &pdev->dev;
>   	pb->enabled = false;
> +	pb->post_pwm_on_delay = data->post_pwm_on_delay;
> +	pb->pwm_off_delay = data->pwm_off_delay;
>   
>   	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
>   						  GPIOD_ASIS);
> diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
> index efdd922..62f59c4 100644
> --- a/include/linux/pwm_backlight.h
> +++ b/include/linux/pwm_backlight.h
> @@ -13,6 +13,8 @@ struct platform_pwm_backlight_data {
>   	unsigned int lth_brightness;
>   	unsigned int pwm_period_ns;
>   	unsigned int *levels;
> +	unsigned int post_pwm_on_delay;
> +	unsigned int pwm_off_delay;
>   	/* TODO remove once all users are switched to gpiod_* API */
>   	int enable_gpio;
>   	int (*init)(struct device *dev);
> 
