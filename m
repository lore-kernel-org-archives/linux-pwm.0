From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 08/16] backlight: document enums in backlight.h
Date: Mon, 18 May 2020 17:15:24 +0100
Message-ID: <20200518161524.tbgrgle6hbsdpm4c@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-9-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQP2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:15:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6175C05BD09
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:15:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j5so12605283wrq.2
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:15:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-9-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.

On Sun, May 17, 2020 at 09:01:31PM +0200, Sam Ravnborg wrote:
> Add kernel-doc documentation for the backlight enums
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Other than the usual comment about the form in the kernel-doc howto:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>



> ---
>  include/linux/backlight.h | 84 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 98349a2984dc..b779c29142fd 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -14,26 +14,110 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  
> +/**
> + * enum backlight_update_reason - what method was used to update backlight
> + *
> + * A driver indicates the method (reason) used for updating the backlight
> + * when calling backlight_force_update().
> + */
>  enum backlight_update_reason {
> +	/**
> +	 * @BACKLIGHT_UPDATE_HOTKEY:
> +	 *
> +	 * The backlight was updated using a hot-key.
> +	 */
>  	BACKLIGHT_UPDATE_HOTKEY,
> +
> +	/**
> +	 * @BACKLIGHT_UPDATE_SYSFS:
> +	 *
> +	 * The backlight was updated using sysfs.
> +	 */
>  	BACKLIGHT_UPDATE_SYSFS,
>  };
>  
> +/**
> + * enum backlight_type - the type of backlight control
> + *
> + * The type of interface used to control the backlight.
> + */
>  enum backlight_type {
> +	/**
> +	 * @BACKLIGHT_RAW:
> +	 *
> +	 * The backlight is controlled using hardware registers directly.
> +	 */
>  	BACKLIGHT_RAW = 1,
> +
> +	/**
> +	 * @BACKLIGHT_PLATFORM:
> +	 *
> +	 * The backlight is controller using a platform-specific interface.
> +	 */
>  	BACKLIGHT_PLATFORM,
> +
> +	/**
> +	 * @BACKLIGHT_FIRMWARE:
> +	 *
> +	 * The backlight is controlled using a standard firmware interface.
> +	 */
>  	BACKLIGHT_FIRMWARE,
> +
> +	/**
> +	 * @BACKLIGHT_TYPE_MAX: Number of entries.
> +	 */
>  	BACKLIGHT_TYPE_MAX,
>  };
>  
> +/**
> + * enum backlight_notification - the type of notification
> + *
> + * The notifications that is used for notification sent to the receiver
> + * that registered notifications using backlight_register_notifier().
> + */
>  enum backlight_notification {
> +	/**
> +	 * @BACKLIGHT_REGISTERED:
> +	 *
> +	 * The backlight device is registered.
> +	 */
>  	BACKLIGHT_REGISTERED,
> +
> +	/**
> +	 * @BACKLIGHT_UNREGISTERED:
> +	 *
> +	 * The backlight revice is unregistered.
> +	 */
>  	BACKLIGHT_UNREGISTERED,
>  };
>  
> +/** enum backlight_scale - the type of scale used for brightness values
> + *
> + * The type of scale used for brightness values.
> + */
>  enum backlight_scale {
> +	/**
> +	 * @BACKLIGHT_SCALE_UNKNOWN:
> +	 *
> +	 * The scale is unknown.
> +	 */
>  	BACKLIGHT_SCALE_UNKNOWN = 0,
> +
> +	/**
> +	 * @BACKLIGHT_SCALE_LINEAR:
> +	 *
> +	 * The scale is linear, so the brigness increase is the same
> +	 * when increasing with the same steps (more or less).
> +	 */
>  	BACKLIGHT_SCALE_LINEAR,
> +
> +	/**
> +	 * @BACKLIGHT_SCALE_NON_LINEAR:
> +	 *
> +	 * The scale is not linear. This is often used when the brightness
> +	 * values tries to adjust to the relative perception of the eye
> +	 * demanding a non-linear scale.
> +	 */
>  	BACKLIGHT_SCALE_NON_LINEAR,
>  };
>  
> -- 
> 2.25.1
> 
