From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] backlight: pwm_bl: Fix uninitialized variable
Date: Mon, 23 Jul 2018 08:23:43 +0100
Message-ID: <20180723072343.GD4213@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180719161923.21510-1-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180719161923.21510-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 19 Jul 2018, Daniel Thompson wrote:

> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix this.
> 
> Additionally fix a small grammar error that was identified and
> tighten up return code checking of DT properties, both of which came
> up during review of this patch.
> 
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> brightness-levels")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
> Notes:
>     v2:
>      - Simplify SoB chain (with Marcel's permission)
>      - Separate complex if statement and make other similar calls use same
>        return code checking approach
>      - Tidy up comment formatting and fix pre-existing grammar error
> 
>  drivers/video/backlight/pwm_bl.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

I'm hesitant to provide feedback on this, as I feel as though I've
messed you around enough, however ... ;)

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 9ee4c1b735b2..f7799f62fea0 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -284,30 +284,29 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		ret = of_property_read_u32_array(node, "brightness-levels",
>  						 data->levels,
>  						 data->max_brightness);
> -		if (ret < 0)
> +		if (!ret)
>  			return ret;
> 
>  		ret = of_property_read_u32(node, "default-brightness-level",
>  					   &value);
> -		if (ret < 0)
> +		if (!ret)
>  			return ret;

Just FYI (it didn't even make it to 'nit' status), this should really
be done in a separate patch since it is unrelated to the rest of the
patch.

>  		data->dft_brightness = value;
> 
>  		/*
>  		 * This property is optional, if is set enables linear
> -		 * interpolation between each of the values of brightness levels
> -		 * and creates a new pre-computed table.
> +		 * interpolation between each of the values of brightness
> +		 * levels and creates a new pre-computed table.
>  		 */
> -		of_property_read_u32(node, "num-interpolated-steps",
> -				     &num_steps);
> -
> -		/*
> -		 * Make sure that there is at least two entries in the
> -		 * brightness-levels table, otherwise we can't interpolate
> -		 * between two points.
> -		 */
> -		if (num_steps) {
> +		ret = of_property_read_u32(node, "num-interpolated-steps",
> +					   &num_steps);
> +		if (!ret || num_steps) {

Not sure if it's even possible for of_property_read_u32() to fail AND
still populate num_steps, however this check makes it sound like that's
okay.  Is that correct?

I can't help but think that this all 'just goes away' if you
pre-initialise num_steps.  I wouldn't let the "do not initialise too
far away from the code using variable" affect this.  However, if
you're insistent, perhaps consider moving the declaration to just
below:

  if (data->max_brightness > 0) {

> +			/*
> +			 * Make sure that there are at least two entries in
> +			 * the brightness-levels table, otherwise we can't
> +			 * interpolate between two points.
> +			 */
>  			if (data->max_brightness < 2) {
>  				dev_err(dev, "can't interpolate\n");
>  				return -EINVAL;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
