From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Date: Wed, 18 Jul 2018 09:09:13 +0100
Message-ID: <20180718080913.GB4641@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716210241.9457-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, 16 Jul 2018, Daniel Thompson wrote:

> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix this.
> 
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> brightness-levels")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This line is confusing.  Did you guys author this patch together?

My guess is that this line should be dropped and the RB and TB tags
should remain?  If it was reviewed too, perhaps an AB too?

> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 9ee4c1b735b2..e3c22b79fbcd 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -299,15 +299,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		 * interpolation between each of the values of brightness levels
>  		 * and creates a new pre-computed table.
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
> +		if ((of_property_read_u32(node, "num-interpolated-steps",
> +					  &num_steps) == 0) && num_steps) {

This is pretty ugly, and isn't it suffering from over-bracketing?  My
suggestion would be to break out the invocation of
of_property_read_u32() from the if and test only the result.

		of_property_read_u32(node, "num-interpolated-steps", &num_steps);
		if (!ret && num_steps) {

I haven't checked the underling code, but is it even feasible for
of_property_read_u32() to not succeed AND for num_steps to be set?

If not, the check for !ret if superfluous and you can drop it.

> +			/*
> +			 * Make sure that there is at least two entries in the

s/is/are/

> +			 * brightness-levels table, otherwise we can't
> +			 * interpolate

Why break the line here?

> +			 * between two points.
> +			 */
>  			if (data->max_brightness < 2) {
>  				dev_err(dev, "can't interpolate\n");
>  				return -EINVAL;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
