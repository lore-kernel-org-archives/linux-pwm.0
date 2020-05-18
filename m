From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 10/16] backlight: drop extern from prototypes
Date: Mon, 18 May 2020 17:22:35 +0100
Message-ID: <20200518162235.nn4zuv3uuteaq36k@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-11-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgERQWj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:22:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC5C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:22:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g14so365672wme.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:22:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-11-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.

On Sun, May 17, 2020 at 09:01:33PM +0200, Sam Ravnborg wrote:
> No need to put "extern" in front of prototypes.
> While touching the prototypes adjust indent to follow
> the kernel style.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>



> ---
>  include/linux/backlight.h | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index eae7a5e66248..308aec67fa4f 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -444,22 +444,25 @@ static inline bool backlight_is_blank(struct backlight_device *bd)
>  	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
>  }
>  
> -extern struct backlight_device *backlight_device_register(const char *name,
> -	struct device *dev, void *devdata, const struct backlight_ops *ops,
> -	const struct backlight_properties *props);
> -extern struct backlight_device *devm_backlight_device_register(
> -	struct device *dev, const char *name, struct device *parent,
> -	void *devdata, const struct backlight_ops *ops,
> -	const struct backlight_properties *props);
> -extern void backlight_device_unregister(struct backlight_device *bd);
> -extern void devm_backlight_device_unregister(struct device *dev,
> -					struct backlight_device *bd);
> -extern void backlight_force_update(struct backlight_device *bd,
> -				   enum backlight_update_reason reason);
> -extern int backlight_register_notifier(struct notifier_block *nb);
> -extern int backlight_unregister_notifier(struct notifier_block *nb);
> -extern struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
> -extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned long brightness);
> +struct backlight_device *
> +backlight_device_register(const char *name, struct device *dev, void *devdata,
> +			  const struct backlight_ops *ops,
> +			  const struct backlight_properties *props);
> +struct backlight_device *
> +devm_backlight_device_register(struct device *dev, const char *name,
> +			       struct device *parent, void *devdata,
> +			       const struct backlight_ops *ops,
> +			       const struct backlight_properties *props);
> +void backlight_device_unregister(struct backlight_device *bd);
> +void devm_backlight_device_unregister(struct device *dev,
> +				      struct backlight_device *bd);
> +void backlight_force_update(struct backlight_device *bd,
> +			    enum backlight_update_reason reason);
> +int backlight_register_notifier(struct notifier_block *nb);
> +int backlight_unregister_notifier(struct notifier_block *nb);
> +struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
> +int backlight_device_set_brightness(struct backlight_device *bd,
> +				    unsigned long brightness);
>  
>  #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
>  
> -- 
> 2.25.1
> 
