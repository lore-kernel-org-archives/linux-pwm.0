From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 14/20] backlight: cr_bllcd: introduce
 backlight_is_blank()
Date: Wed, 8 Jul 2020 12:06:27 +0100
Message-ID: <20200708110627.z5ofexh4llk66jey@holly.lan>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-15-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200703184546.144664-15-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe
List-Id: linux-pwm@vger.kernel.org

On Fri, Jul 03, 2020 at 08:45:40PM +0200, Sam Ravnborg wrote:
> The cr_bllcd uses the FB_BLANK states as brightness.
> This results in brightness value equals 0 that turn on
> the display and 4 that turn off the display.

max_brightness is 0 which makes it impossible to set the brightness to
4.


> Simplify the logic but keep current behaviour
> as userspace may expect brightness set to 0 to turn on the display.

I don't deny the possibility but we'd be talking about a userspace
custom enough to explicitly configure the module loader (otherwise
the module wouldn't load and the backlight would be inherited from
the BIOS) and that also contains an explicit write to the brightness
property that sets it to what is already the default (and only
possible) value.

In other words I'm very sceptical such a userspace exists and would be
happy to see this driver modified to use the new helpers and behave
like gpio-backlight (which can be regarded as our reference 1-bit
backlight driver).


Daniel.

> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/cr_bllcd.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
> index 4624b7b7c6a6..edca5fee9689 100644
> --- a/drivers/video/backlight/cr_bllcd.c
> +++ b/drivers/video/backlight/cr_bllcd.c
> @@ -63,22 +63,16 @@ static int cr_backlight_set_intensity(struct backlight_device *bd)
>  	u32 addr = gpio_bar + CRVML_PANEL_PORT;
>  	u32 cur = inl(addr);
>  
> -	if (bd->props.power == FB_BLANK_UNBLANK)
> -		intensity = FB_BLANK_UNBLANK;
> -	if (bd->props.fb_blank == FB_BLANK_UNBLANK)
> -		intensity = FB_BLANK_UNBLANK;
> -	if (bd->props.power == FB_BLANK_POWERDOWN)
> -		intensity = FB_BLANK_POWERDOWN;
> -	if (bd->props.fb_blank == FB_BLANK_POWERDOWN)
> +	if (backlight_is_blank(bd))
>  		intensity = FB_BLANK_POWERDOWN;
>  
> -	if (intensity == FB_BLANK_UNBLANK) { /* FULL ON */
> +	if (intensity != FB_BLANK_POWERDOWN) { /* FULL ON */
>  		cur &= ~CRVML_BACKLIGHT_OFF;
>  		outl(cur, addr);
> -	} else if (intensity == FB_BLANK_POWERDOWN) { /* OFF */
> +	} else { /* OFF */
>  		cur |= CRVML_BACKLIGHT_OFF;
>  		outl(cur, addr);
> -	} /* anything else, don't bother */
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
