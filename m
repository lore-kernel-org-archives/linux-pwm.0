From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 03/16] backlight: add backlight_is_blank()
Date: Mon, 18 May 2020 16:00:55 +0100
Message-ID: <20200518150055.2vaaoucf4nodwoz5@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-4-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERPBB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 11:01:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8402C05BD09
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:01:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z4so8462294wmi.2
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:01:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-4-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.

On Sun, May 17, 2020 at 09:01:26PM +0200, Sam Ravnborg wrote:
> The backlight support has two properties that express the state:
> - power
> - state
> 
> It is un-documented and easy to get wrong.
> Add backlight_is_blank() helper to make it simpler for drivers
> to get the check of the state correct.
> 
> A lot of drivers also includes checks for fb_blank.
> This check is redundant when the state is checked
> and thus not needed in this helper function.
> But added anyway to avoid introducing subtle bug
> due to the creative use in some drivers.
> 
> Rolling out this helper to all relevant backlight drivers
> will eliminate almost all accesses to fb_blank.
> 
> v2:
>   - Added fb_blank condition (Daniel)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  include/linux/backlight.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index c7d6b2e8c3b5..a0a083b35c47 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -175,6 +175,25 @@ static inline void backlight_put(struct backlight_device *bd)
>  		put_device(&bd->dev);
>  }
>  
> +/**
> + * backlight_is_blank - Return true if display is expected to be blank
> + * @bd: the backlight device
> + *
> + * Display is expected to be blank if any of these is true::
> + *
> + *   1) if power in not UNBLANK
> + *   2) if fb_blank is not UNBLANK
> + *   3) if state indicate BLANK or SUSPENDED
> + *
> + * Returns true if display is expected to be blank, false otherwise.
> + */
> +static inline bool backlight_is_blank(struct backlight_device *bd)
> +{
> +	return bd->props.power != FB_BLANK_UNBLANK ||
> +	       bd->props.fb_blank != FB_BLANK_UNBLANK ||
> +	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
> +}
> +
>  extern struct backlight_device *backlight_device_register(const char *name,
>  	struct device *dev, void *devdata, const struct backlight_ops *ops,
>  	const struct backlight_properties *props);
> -- 
> 2.25.1
> 
