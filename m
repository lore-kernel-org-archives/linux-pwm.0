From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 07/16] backlight: document inline functions in
 backlight.h
Date: Mon, 18 May 2020 17:04:44 +0100
Message-ID: <20200518160444.huxyjm2wxajnyfmx@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-8-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-8-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.
List-Id: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:30PM +0200, Sam Ravnborg wrote:
> Add documentation for the inline functions in backlight.h
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  include/linux/backlight.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index e2d72936bf05..98349a2984dc 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -283,6 +283,10 @@ struct backlight_device {
>  	int use_count;
>  };
>  
> +/**
> + * backlight_update_status - force an update of the backligt device status

Typo.

Other than that,

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> + * @bd: the backlight device
> + */
>  static inline int backlight_update_status(struct backlight_device *bd)
>  {
>  	int ret = -ENOENT;
> @@ -375,6 +379,18 @@ extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned
>  
>  #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
>  
> +/**
> + * bl_get_data - access devdata
> + * @bl_dev: pointer to backlight device
> + *
> + * When a backlight device is registered the driver has the possibility
> + * to supply a void * devdata. bl_get_data() return a pointer to the
> + * devdata.
> + *
> + * RETURNS:
> + *
> + * pointer to devdata stored while registering the backlight device.
> + */
>  static inline void * bl_get_data(struct backlight_device *bl_dev)
>  {
>  	return dev_get_drvdata(&bl_dev->dev);
> -- 
> 2.25.1
> 
