From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 02/16] backlight: refactor fb_notifier_callback()
Date: Mon, 18 May 2020 15:54:57 +0100
Message-ID: <20200518145457.zonqhzkeybxdrq6b@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-3-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-3-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.
List-Id: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:25PM +0200, Sam Ravnborg wrote:
> Increase readability of fb_notifier_callback() by removing
> a few indent levels.
> No functional change.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/backlight.c | 43 +++++++++++++++--------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index cac3e35d7630..17f04cff50ab 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -58,28 +58,29 @@ static int fb_notifier_callback(struct notifier_block *self,
>  
>  	bd = container_of(self, struct backlight_device, fb_notif);
>  	mutex_lock(&bd->ops_lock);
> -	if (bd->ops)
> -		if (!bd->ops->check_fb ||
> -		    bd->ops->check_fb(bd, evdata->info)) {
> -			fb_blank = *(int *)evdata->data;
> -			if (fb_blank == FB_BLANK_UNBLANK &&
> -			    !bd->fb_bl_on[node]) {
> -				bd->fb_bl_on[node] = true;
> -				if (!bd->use_count++) {
> -					bd->props.state &= ~BL_CORE_FBBLANK;
> -					bd->props.fb_blank = FB_BLANK_UNBLANK;
> -					backlight_update_status(bd);
> -				}
> -			} else if (fb_blank != FB_BLANK_UNBLANK &&
> -				   bd->fb_bl_on[node]) {
> -				bd->fb_bl_on[node] = false;
> -				if (!(--bd->use_count)) {
> -					bd->props.state |= BL_CORE_FBBLANK;
> -					bd->props.fb_blank = fb_blank;
> -					backlight_update_status(bd);
> -				}
> -			}
> +
> +	if (!bd->ops)
> +		goto out;
> +	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
> +		goto out;
> +
> +	fb_blank = *(int *)evdata->data;
> +	if (fb_blank == FB_BLANK_UNBLANK && !bd->fb_bl_on[node]) {
> +		bd->fb_bl_on[node] = true;
> +		if (!bd->use_count++) {
> +			bd->props.state &= ~BL_CORE_FBBLANK;
> +			bd->props.fb_blank = FB_BLANK_UNBLANK;
> +			backlight_update_status(bd);
> +		}
> +	} else if (fb_blank != FB_BLANK_UNBLANK && bd->fb_bl_on[node]) {
> +		bd->fb_bl_on[node] = false;
> +		if (!(--bd->use_count)) {
> +			bd->props.state |= BL_CORE_FBBLANK;
> +			bd->props.fb_blank = fb_blank;
> +			backlight_update_status(bd);
>  		}
> +	}
> +out:
>  	mutex_unlock(&bd->ops_lock);
>  	return 0;
>  }
> -- 
> 2.25.1
> 
