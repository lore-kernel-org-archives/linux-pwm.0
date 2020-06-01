From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v3 04/13] backlight: improve backlight_properties
 documentation
Date: Mon, 1 Jun 2020 11:10:18 +0100
Message-ID: <20200601101018.w4h6hpt5wackndyb@holly.lan>
References: <20200601065207.492614-1-sam@ravnborg.org>
 <20200601065207.492614-5-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKKY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 06:10:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8B2C03E96B
        for <linux-pwm@vger.kernel.org>; Mon,  1 Jun 2020 03:10:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so10953557wro.1
        for <linux-pwm@vger.kernel.org>; Mon, 01 Jun 2020 03:10:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200601065207.492614-5-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe

On Mon, Jun 01, 2020 at 08:51:58AM +0200, Sam Ravnborg wrote:
> Improve the documentation for backlight_properties and
> adapt it to kernel-doc style.
> 
> v2:
>   - Added into for each field (Daniel)
>   - Re-written some parts to explain what to do, rather
>     than what not to do.
>     Partly based on suggestions from the review (Daniel)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  include/linux/backlight.h | 96 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 85 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index b6c1ab6c922a..69a20da03035 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -117,28 +117,102 @@ struct backlight_ops {
>  	int (*check_fb)(struct backlight_device *bd, struct fb_info *info);
>  };
>  
> -/* This structure defines all the properties of a backlight */
> +/**
> + * struct backlight_properties - backlight properties
> + *
> + * This structure defines all the properties of a backlight.
> + */
>  struct backlight_properties {
> -	/* Current User requested brightness (0 - max_brightness) */
> +	/**
> +	 * @brightness: The current brightness requested by the user.
> +	 *
> +	 * The backlight core makes sure the range is (0 to max_brightness)
> +	 * when the brightness is set via the sysfs attribute:
> +	 * /sys/class/backlight/<backlight>/brightness.
> +	 *
> +	 * This value can be set in the backlight_properties passed
> +	 * to devm_backlight_device_register() to set a default brightness
> +	 * value.
> +	 */
>  	int brightness;
> -	/* Maximal value for brightness (read-only) */
> +
> +	/**
> +	 * @max_brightness: The maximum brightness value.
> +	 *
> +	 * This value must be set in the backlight_properties passed to
> +	 * devm_backlight_device_register() and shall not be modified by the
> +	 * driver after registration.
> +	 */
>  	int max_brightness;
> -	/* Current FB Power mode (0: full on, 1..3: power saving
> -	   modes; 4: full off), see FB_BLANK_XXX */
> +
> +	/**
> +	 * @power: The current power mode.
> +	 *
> +	 * User space can configure the power mode using the sysfs
> +	 * attribute: /sys/class/backlight/<backlight>/bl_power
> +	 * When the power property is updated update_status() is called.
> +	 *
> +	 * The possible values are: (0: full on, 1 to 3: power saving
> +	 * modes; 4: full off), see FB_BLANK_XXX.
> +	 *
> +	 * When the backlight device is enabled @power is set
> +	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
> +	 * @power is set to FB_BLANK_POWERDOWN.
> +	 */
>  	int power;
> -	/* FB Blanking active? (values as for power) */
> -	/* Due to be removed, please use (state & BL_CORE_FBBLANK) */
> +
> +	/**
> +	 * @fb_blank: The power state from the FBIOBLANK ioclt.
> +	 *
> +	 * When the FBIOBLANK ioctl is called fb_blank is set to the
> +	 * blank parameter and the update_status() operation is called.
> +	 *
> +	 * When the backlight device is enabled @fb_blank is set
> +	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
> +	 * @fb_blank is set to FB_BLANK_POWERDOWN.
> +	 *
> +	 * Backlight drivers should avoid using this property. It has been
> +	 * replaced by state & BL_CORE_FBLANK (although most drivers should
> +	 * use backlight_is_blank() as the preferred means to get the blank
> +	 * state).
> +	 *
> +	 * fb_blank is deprecated and will be removed.
> +	 */
>  	int fb_blank;
> -	/* Backlight type */
> +
> +	/**
> +	 * @type: The type of backlight supported.
> +	 *
> +	 * The backlight type allows userspace to make appropriate
> +	 * policy desicions based on the backlight type.
> +	 *
> +	 * This value must be set in the backlight_properties
> +	 * passed to devm_backlight_device_register().
> +	 */
>  	enum backlight_type type;
> -	/* Flags used to signal drivers of state changes */
> +
> +	/**
> +	 * @state: The state of the backlight core.
> +	 *
> +	 * The state is a bitmask. BL_CORE_FBBLANK is set when the display
> +	 * is expected to be blank. BL_CORE_SUSPENDED is set when the
> +	 * driver is suspended.
> +	 *
> +	 * backlight drivers are excpected to use backlight_is_blank()
> +	 * in their update_status() operation rather than reading the
> +	 * state property.
> +	 *
> +	 * The state is maintained by the core and drivers may not modify it.
> +	 */
>  	unsigned int state;
> -	/* Type of the brightness scale (linear, non-linear, ...) */
> -	enum backlight_scale scale;
>  
>  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
>  #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
>  
> +	/**
> +	 * @scale: The type of the brightness scale.
> +	 */
> +	enum backlight_scale scale;
>  };
>  
>  struct backlight_device {
> -- 
> 2.25.1
> 
