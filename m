From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 1/5] pwm-backlight: enable/disable the PWM before/after
 LCD enable toggle.
Date: Mon, 24 Jul 2017 16:13:55 +0100
Message-ID: <3e986794-f09c-b1be-6b28-ab33befdc64f@linaro.org>
References: <20170721104813.5389-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35158 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbdGXPN6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jul 2017 11:13:58 -0400
Received: by mail-wr0-f175.google.com with SMTP id k71so54044435wrc.2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2017 08:13:58 -0700 (PDT)
In-Reply-To: <20170721104813.5389-1-enric.balletbo@collabora.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org

On 21/07/17 11:48, Enric Balletbo i Serra wrote:
> Before this patch the enable signal was set before the PWM signal and
> vice-versa on power off. This sequence is wrong, at least, it is on
> the different panels datasheets that I checked, so I inverted the sequence
> to follow the specs.
> 
> For reference the following panels have the mentioned sequence:
>    - N133HSE-EA1 (Innolux)
>    - N116BGE (Innolux)
>    - N156BGE-L21 (Innolux)
>    - B101EAN0 (Auo)
>    - B101AW03 (Auo)
>    - LTN101NT05 (Samsung)
>    - CLAA101WA01A (Chunghwa)
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> Changes since v3:
>   - List the part numbers for the panel checked (Daniel Thompson)
> Changes since v2:
>   - Add this as a separate patch (Thierry Reding)
> Changes since v1:
>   - None
> 
>   drivers/video/backlight/pwm_bl.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 002f1ce..909a686 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>   	if (err < 0)
>   		dev_err(pb->dev, "failed to enable power supply\n");
>   
> +	pwm_enable(pb->pwm);
> +
>   	if (pb->enable_gpio)
>   		gpiod_set_value_cansleep(pb->enable_gpio, 1);
>   
> -	pwm_enable(pb->pwm);
>   	pb->enabled = true;
>   }
>   
> @@ -66,12 +67,12 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>   	if (!pb->enabled)
>   		return;
>   
> -	pwm_config(pb->pwm, 0, pb->period);
> -	pwm_disable(pb->pwm);
> -
>   	if (pb->enable_gpio)
>   		gpiod_set_value_cansleep(pb->enable_gpio, 0);
>   
> +	pwm_config(pb->pwm, 0, pb->period);
> +	pwm_disable(pb->pwm);
> +
>   	regulator_disable(pb->power_supply);
>   	pb->enabled = false;
>   }
> 
