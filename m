From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v3 3/5] pwm-backlight: add support for PWM delays
 proprieties.
Date: Tue, 18 Jul 2017 10:38:19 +0100
Message-ID: <d38fa016-ea9c-edf8-9684-5c1235d27c82@linaro.org>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
 <20170717212811.25374-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35026 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdGRJiY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2017 05:38:24 -0400
Received: by mail-wr0-f175.google.com with SMTP id w4so20409782wrb.2
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2017 02:38:23 -0700 (PDT)
In-Reply-To: <20170717212811.25374-3-enric.balletbo@collabora.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org

On 17/07/17 22:28, Enric Balletbo i Serra wrote:
> Some panels (i.e. N116BGE-L41), in their power sequence specifications,
> request a delay between set the PWM signal and enable the backlight and
> between clear the PWM signal and disable the backlight. Add support for
> the new post-pwm-on-delay-us and pwm-off-delay-us proprieties to meet
> the timings.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v2:
>   - Move the pwm/enable sequence to another patch (Thierry Reding)
> Changes since v1:
>   - As suggested by Daniel Thompson
>     - Do not assume power-on delay and power-off delay will be the same
>   - Move the check of dt property to the parse dt function.
> 
>   drivers/video/backlight/pwm_bl.c | 17 +++++++++++++++++
>   include/linux/pwm_backlight.h    |  1 +
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 909a686..528155d 100644
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
> @@ -35,6 +36,7 @@ struct pwm_bl_data {
>   	struct gpio_desc	*enable_gpio;
>   	unsigned int		scale;
>   	bool			legacy;
> +	unsigned int		pwm_delay[2];

Two named members would be better here (eliminating the "magic" 0 and 1).


>   	int			(*notify)(struct device *,
>   					  int brightness);
>   	void			(*notify_after)(struct device *,
> @@ -56,6 +58,9 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>   
>   	pwm_enable(pb->pwm);
>   
> +	if (pb->pwm_delay[0])
> +		usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] * 2);
> +
>   	if (pb->enable_gpio)
>   		gpiod_set_value_cansleep(pb->enable_gpio, 1);
>   
> @@ -70,6 +75,9 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>   	if (pb->enable_gpio)
>   		gpiod_set_value_cansleep(pb->enable_gpio, 0);
>   
> +	if (pb->pwm_delay[1])
> +		usleep_range(pb->pwm_delay[1], pb->pwm_delay[1] * 2);
> +
>   	pwm_config(pb->pwm, 0, pb->period);
>   	pwm_disable(pb->pwm);
>   
> @@ -175,6 +183,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
>   		data->max_brightness--;
>   	}
>   
> +	/*
> +	 * These values are optional and set as 0 by default, the out values
> +	 * are modified only if a valid u32 value can be decoded.
> +	 */
> +	of_property_read_u32(node, "post-pwm-on-delay-us",
> +			     &data->pwm_delay[0]);
> +	of_property_read_u32(node, "pwm-off-delay-us", &data->pwm_delay[1]);
> +
>   	data->enable_gpio = -EINVAL;
>   	return 0;
>   }
> @@ -273,6 +289,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   	pb->exit = data->exit;
>   	pb->dev = &pdev->dev;
>   	pb->enabled = false;
> +	memcpy(pb->pwm_delay, data->pwm_delay, sizeof(pb->pwm_delay));
>   
>   	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
>   						  GPIOD_ASIS);
> diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
> index efdd922..bf37131 100644
> --- a/include/linux/pwm_backlight.h
> +++ b/include/linux/pwm_backlight.h
> @@ -13,6 +13,7 @@ struct platform_pwm_backlight_data {
>   	unsigned int lth_brightness;
>   	unsigned int pwm_period_ns;
>   	unsigned int *levels;
> +	unsigned int pwm_delay[2];
>   	/* TODO remove once all users are switched to gpiod_* API */
>   	int enable_gpio;
>   	int (*init)(struct device *dev);
> 
