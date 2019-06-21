From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
Date: Fri, 21 Jun 2019 14:10:19 +0100
Message-ID: <9ea1bb40-95a6-7a67-a8a6-ecc77a70e547@linaro.org>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-5-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613194326.180889-5-mka@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> Check if a brightness curve specified in the device tree is linear or
> not and set the corresponding property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> To determine if a curve is linear it is compared to a interpolated linear
> curve between min and max brightness. The curve is considered linear if
> no value deviates more than +/-5% of ${brightness_range} from their
> interpolated value.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>   drivers/video/backlight/pwm_bl.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index f067fe7aa35d..912407b6d67f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -404,6 +404,26 @@ int pwm_backlight_brightness_default(struct device *dev,
>   }
>   #endif
>   
> +static bool pwm_backlight_is_linear(struct platform_pwm_backlight_data *data)
> +{
> +	unsigned int nlevels = data->max_brightness + 1;
> +	unsigned int min_val = data->levels[0];
> +	unsigned int max_val = data->levels[nlevels - 1];
> +	unsigned int slope = (100 * (max_val - min_val)) / nlevels;

Why 100 (rather than a power of 2)?

It would also be good to have a comment here saying what the maximum 
quantization error is. Doesn't have to be over complex just mentioning 
something like the following (assuming you agree that its true ;-) ):

   Multiplying by XXX means that even in pathalogical cases such as
   (max_val - min_val) == nlevels then the error at max_val is less than
   1%.

With a suitable comment in the fixed point code:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> +	unsigned int margin = (max_val - min_val) / 20; /* 5% */
> +	int i;
> +
> +	for (i = 1; i < nlevels; i++) {
> +		unsigned int linear_value = min_val + ((i * slope) / 100);
> +		unsigned int delta = abs(linear_value - data->levels[i]);
> +
> +		if (delta > margin)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
>   {
>   	struct device_node *node = pb->dev->of_node;
> @@ -567,6 +587,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   			pb->levels = data->levels;
>   		}
> +
> +		if (pwm_backlight_is_linear(data))
> +			props.scale = BACKLIGHT_SCALE_LINEAR;
> +		else
> +			props.scale = BACKLIGHT_SCALE_NON_LINEAR;
>   	} else if (!data->max_brightness) {
>   		/*
>   		 * If no brightness levels are provided and max_brightness is
> 
