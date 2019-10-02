From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Don't assign levels table repeatedly
Date: Wed, 2 Oct 2019 11:07:37 +0100
Message-ID: <20191002100737.orm5ghpnw6oe6b3r@holly.lan>
References: <20191001162835.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001162835.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Oct 01, 2019 at 04:29:24PM -0700, Matthias Kaehlcke wrote:
> pwm_backlight_probe() re-assigns pb->levels for every brightness
> level. This is not needed and was likely not intended, since
> neither side of the assignment changes during the loop. Assign
> the field only once.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Makes sense but this should probably be dropping the curly braces too.


Daniel.

> ---
> 
>  drivers/video/backlight/pwm_bl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 746eebc411df..959436b9e92b 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -564,6 +564,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  
>  	if (data->levels) {
> +		pb->levels = data->levels;
> +
>  		/*
>  		 * For the DT case, only when brightness levels is defined
>  		 * data->levels is filled. For the non-DT case, data->levels
> @@ -572,8 +574,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		for (i = 0; i <= data->max_brightness; i++) {
>  			if (data->levels[i] > pb->scale)
>  				pb->scale = data->levels[i];
> -
> -			pb->levels = data->levels;
>  		}
>  
>  		if (pwm_backlight_is_linear(data))
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
