From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 15/16] backlight: make of_find_backlight_by_node()
 static
Date: Mon, 18 May 2020 17:56:48 +0100
Message-ID: <20200518165648.ltgtofjsteyyse4j@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-16-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERQ4x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:56:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F6C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:56:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so12716731wrn.6
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:56:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-16-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.

On Sun, May 17, 2020 at 09:01:38PM +0200, Sam Ravnborg wrote:
> There are no external users of of_find_backlight_by_node().
> Make it static so we keep it that way.
> 
> v2:
>   - drop EXPORT of of_find_backlight_by_node
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Assuming the 0day-ci comments are because some of the patches have
already been sucked up in a different tree then:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>  drivers/video/backlight/backlight.c | 23 +++++++++--------------
>  include/linux/backlight.h           | 10 ----------
>  2 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 7f3eecaf8317..3fa29330a820 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -627,19 +627,9 @@ static int of_parent_match(struct device *dev, const void *data)
>  	return dev->parent && dev->parent->of_node == data;
>  }
>  
> -/**
> - * of_find_backlight_by_node() - find backlight device by device-tree node
> - * @node: device-tree node of the backlight device
> - *
> - * Returns a pointer to the backlight device corresponding to the given DT
> - * node or NULL if no such backlight device exists or if the device hasn't
> - * been probed yet.
> - *
> - * This function obtains a reference on the backlight device and it is the
> - * caller's responsibility to drop the reference by calling put_device() on
> - * the backlight device's .dev field.
> - */
> -struct backlight_device *of_find_backlight_by_node(struct device_node *node)
> +/* Find backlight device by device-tree node */
> +static struct backlight_device *
> +of_find_backlight_by_node(struct device_node *node)
>  {
>  	struct device *dev;
>  
> @@ -647,7 +637,12 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
>  
>  	return dev ? to_backlight_device(dev) : NULL;
>  }
> -EXPORT_SYMBOL(of_find_backlight_by_node);
> +#else
> +static struct backlight_device *
> +of_find_backlight_by_node(struct device_node *node)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  static struct backlight_device *of_find_backlight(struct device *dev)
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index d92e523650ec..1e29ab43f4f6 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -473,16 +473,6 @@ static inline void * bl_get_data(struct backlight_device *bl_dev)
>  	return dev_get_drvdata(&bl_dev->dev);
>  }
>  
> -#ifdef CONFIG_OF
> -struct backlight_device *of_find_backlight_by_node(struct device_node *node);
> -#else
> -static inline struct backlight_device *
> -of_find_backlight_by_node(struct device_node *node)
> -{
> -	return NULL;
> -}
> -#endif
> -
>  #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  struct backlight_device *devm_of_find_backlight(struct device *dev);
>  #else
> -- 
> 2.25.1
> 
