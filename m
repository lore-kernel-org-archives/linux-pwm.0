From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 04/16] backlight: improve backlight_ops documentation
Date: Mon, 18 May 2020 16:02:43 +0100
Message-ID: <20200518150243.l3ovckvitwoz4uwy@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-5-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERPCs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 11:02:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D98C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:02:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v12so12210980wrp.12
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:02:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-5-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.

On Sun, May 17, 2020 at 09:01:27PM +0200, Sam Ravnborg wrote:
> Improve the documentation for backlight_ops and
> adapt it to kernel-doc style.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  include/linux/backlight.h | 60 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index a0a083b35c47..519dc61ce7e4 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -55,19 +55,67 @@ enum backlight_scale {
>  struct backlight_device;
>  struct fb_info;
>  
> +/**
> + * struct backlight_ops - backlight operations
> + *
> + * The backlight operations are specifed when the backlight device is registered.
> + */
>  struct backlight_ops {
> +	/**
> +	 * @options:
> +	 *
> +	 * The options parameter is used to adjust the behaviour of the core.
> +	 * Set BL_CORE_SUSPENDRESUME to get the update_status() operation called
> +	 * upon suspend and resume.
> +	 */
>  	unsigned int options;
>  
>  #define BL_CORE_SUSPENDRESUME	(1 << 0)
>  
> -	/* Notify the backlight driver some property has changed */
> +	/**
> +	 * @update_status:
> +	 *
> +	 * Notify the backlight driver some property has changed.
> +	 * The update_status operation is protected by the update_lock.
> +	 *
> +	 * The backlight driver is expected to use backlight_is_blank()
> +	 * to check if the display is blanked and set brightness accordingly.
> +	 * update_status() is called when any of the properties has changed.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * 0 on sucees, negative error code if any failure occured.
> +	 */
>  	int (*update_status)(struct backlight_device *);
> -	/* Return the current backlight brightness (accounting for power,
> -	   fb_blank etc.) */
> +
> +	/**
> +	 * @get_brightness:
> +	 *
> +	 * Return the current backlight brightness.
> +	 * The driver may implement this as a readback from the HW.
> +	 * This operation is optional and if not present then the current brightness
> +	 * property value is used.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * A brightness value which is 0 or a positive numer.
> +	 * On failure a negative error code is returned.
> +	 */
>  	int (*get_brightness)(struct backlight_device *);
> -	/* Check if given framebuffer device is the one bound to this backlight;
> -	   return 0 if not, !=0 if it is. If NULL, backlight always matches the fb. */
> -	int (*check_fb)(struct backlight_device *, struct fb_info *);
> +
> +	/**
> +	 * @check_fb:
> +	 *
> +	 * Check if given framebuffer device is the one bound to this backlight.
> +	 * This operation is optional and if not implemented it is assumed that the
> +	 * fbdev is always the one bound to the backlight.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * If info is NULL or the info matches the fbdev bound to the backlight return true.
> +	 * If info does not match the fbdev bound to the backlight return false.
> +	 */
> +	int (*check_fb)(struct backlight_device *bd, struct fb_info *info);
>  };
>  
>  /* This structure defines all the properties of a backlight */
> -- 
> 2.25.1
> 
