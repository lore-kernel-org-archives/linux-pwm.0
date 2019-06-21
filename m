From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Date: Fri, 21 Jun 2019 13:55:50 +0100
Message-ID: <61ed137c-31bb-c695-4174-0484fe667d6c@linaro.org>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-4-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613194326.180889-4-mka@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> For backlight curves calculated with the CIE 1931 algorithm set
> the brightness scale type property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

I'd like to keep discussion on patch 2 open a bit longer (it's not part 
of the thread below patch 2 but Pavel had concerns about the sysfs 
interface) so this ack won't really push things forward but FWIW:

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/pwm_bl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb45f866b923..f067fe7aa35d 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   		goto err_alloc;
>   	}
>   
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +
>   	if (data->levels) {
>   		/*
>   		 * For the DT case, only when brightness levels is defined
> @@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   			pb->levels = data->levels;
>   		}
> +
> +		props.scale = BACKLIGHT_SCALE_CIE1931;
>   	} else {
>   		/*
>   		 * That only happens for the non-DT case, where platform data
> @@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
>   
> -	memset(&props, 0, sizeof(struct backlight_properties));
>   	props.type = BACKLIGHT_RAW;
>   	props.max_brightness = data->max_brightness;
>   	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
> 
