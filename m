From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 05/16] backlight: improve backlight_properties
 documentation
Date: Mon, 18 May 2020 16:53:26 +0100
Message-ID: <20200518155326.a35lny7xtsvynibo@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-6-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgERPxa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 11:53:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264BAC05BD09
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:53:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so12460823wra.7
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:53:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-6-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.

On Sun, May 17, 2020 at 09:01:28PM +0200, Sam Ravnborg wrote:
> Improve the documentation for backlight_properties and
> adapt it to kernel-doc style.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Overall looks good but enough nits that I felt compelled to comment!


> ---
>  include/linux/backlight.h | 101 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 90 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 519dc61ce7e4..7f9cef299d6e 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -118,28 +118,107 @@ struct backlight_ops {
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
> +	 * @brightness:
> +	 *
> +	 * The current requested brightness by the user.

This applies throughout this file (and perhaps I overlooked it in the
previous patc too) but having line breaks after @brightness: differs
from the canonical description of a kerneldoc command in:
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#in-line-member-documentation-comments

Also: s/requested brightness/brightness requested/


> +	 * The backlight core makes sure the range is (0 - max_brightness)

I know this is a copy of the original text but I'd prefer the range not
to use the subtract operator ;-). Maybe 0..max_brightness like the
ranges below?


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
> +	 * @max_brightness:
> +	 *
> +	 * The maximum brightness value.
> +	 *
> +	 * This value must be set in the backlight_properties passed
> +	 * to devm_backlight_device_register().
> +	 *
> +	 * This property must not be modified by a driver except
> +	 * before registering the backlight device as explained above.

Perhaps combine these (rather than "as explained above"):

  This value must be set in the backlight_properties passed to
  devm_backlight_device_register() and shall not be modified by the
  driver after registration.


> +	 */
>  	int max_brightness;
> -	/* Current FB Power mode (0: full on, 1..3: power saving
> -	   modes; 4: full off), see FB_BLANK_XXX */
> +
> +	/**
> +	 * @power:
> +	 *
> +	 * The current power mode. User space configure the power mode using

s/configure/can configure/

> +	 * the sysfs attribute: /sys/class/backlight/<backlight>/bl_power
> +	 * When the power property is updated update_status() is called.
> +	 *
> +	 * The possible values are: (0: full on, 1..3: power saving
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
> +	 * @fb_blank:
> +	 *
> +	 * When the FBIOBLANK ioctl is called fb_blank is set to the
> +	 * blank parameter and the update_status() operation is called.
> +	 *
> +	 * When the backlight device is enabled @fb_blank is set
> +	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
> +	 * @fb_blank is set to FB_BLANK_POWERDOWN.
> +	 *
> +	 * This property must not be modified by a driver.
> +	 * The backlight driver shall never read this variable,
> +	 * as the necessary info is avaialble via the state.

I'd rather be told what to do that what not to do!

Maybe.

  Backlight drivers should avoid using this property. It has been
  replaced by state & BL_CORE_FBLANK (although most drivers should
  use backlight_is_blank() as the preferred means to get the blank
  state.



Daniel.


> +	 *
> +	 * fb_blank is deprecated and will be removed.
> +	 */
>  	int fb_blank;
> -	/* Backlight type */
> +
> +	/**
> +	 * @type:
> +	 *
> +	 * The type of backlight supported.
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
> +	 * @state:
> +	 *
> +	 * The state property is used to inform drivers of state changes
> +	 * when the update_status() operation is called.
> +	 * The state is a bitmask. BL_CORE_FBBLANK is set when the display
> +	 * is expected to be blank. BL_CORE_SUSPENDED is set when the
> +	 * driver is suspended.
> +	 *
> +	 * This property must not be modified by a driver.
> +	 */
>  	unsigned int state;
> -	/* Type of the brightness scale (linear, non-linear, ...) */
> -	enum backlight_scale scale;
>  
>  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
>  #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
>  
> +	/**
> +	 * @scale:
> +	 *
> +	 * The type of the brightness scale (linear, non-linear, ...)
> +	 */
> +	enum backlight_scale scale;
>  };
>  
>  struct backlight_device {
> -- 
> 2.25.1
> 
