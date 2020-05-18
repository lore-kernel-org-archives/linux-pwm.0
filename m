From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 13/16] backlight: make of_find_backlight static
Date: Mon, 18 May 2020 17:53:02 +0100
Message-ID: <20200518165302.4andpp27rxj5ub2x@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-14-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQxI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:53:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F8C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:53:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so12703666wrt.5
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:53:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-14-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.

On Sun, May 17, 2020 at 09:01:36PM +0200, Sam Ravnborg wrote:
> There are no external users of of_find_backlight,
> as they have all changed to use the managed version.
> Make of_find_backlight static to prevent new external users.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

In principle I'm OK with this... just a couple of tiny nitpicks in the
new documentation.


Daniel.


> ---
>  drivers/video/backlight/backlight.c | 31 ++++++++++-------------------
>  include/linux/backlight.h           |  6 ------
>  2 files changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 2212f0e3570e..e23b09d03a65 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -650,22 +650,7 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
>  EXPORT_SYMBOL(of_find_backlight_by_node);
>  #endif
>  
> -/**
> - * of_find_backlight - Get backlight device
> - * @dev: Device
> - *
> - * This function looks for a property named 'backlight' on the DT node
> - * connected to @dev and looks up the backlight device.
> - *
> - * Call backlight_put() to drop the reference on the backlight device.
> - *
> - * Returns:
> - * A pointer to the backlight device if found.
> - * Error pointer -EPROBE_DEFER if the DT property is set, but no backlight
> - * device is found.
> - * NULL if there's no backlight property.
> - */
> -struct backlight_device *of_find_backlight(struct device *dev)
> +static struct backlight_device *of_find_backlight(struct device *dev)
>  {
>  	struct backlight_device *bd = NULL;
>  	struct device_node *np;
> @@ -691,7 +676,6 @@ struct backlight_device *of_find_backlight(struct device *dev)
>  
>  	return bd;
>  }
> -EXPORT_SYMBOL(of_find_backlight);
>  
>  static void devm_backlight_release(void *data)
>  {
> @@ -702,9 +686,16 @@ static void devm_backlight_release(void *data)
>   * devm_of_find_backlight - find backlight for a device
>   * @dev: the device
>   *
> - * Device managed version of of_find_backlight().
> - * The reference on the backlight device is automatically
> - * dropped on driver detach.
> + * This function looks for a property named 'backlight' on the DT node
> + * connected to @dev and looks up the backlight device.

Should this be a full paragraph?

> + * The lookup is device managed so the reference to the backlight device
> + * is automatically dropped on driver detach.
> + *
> + * Returns:

Wasn't this upper case everywhere else?


> + * A pointer to the backlight device if found.
> + * Error pointer -EPROBE_DEFER if the DT property is set, but no backlight
> + * device is found.
> + * NULL if there's no backlight property.
>   */
>  struct backlight_device *devm_of_find_backlight(struct device *dev)
>  {
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 308aec67fa4f..99e7cdace2be 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -494,14 +494,8 @@ of_find_backlight_by_node(struct device_node *node)
>  #endif
>  
>  #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
> -struct backlight_device *of_find_backlight(struct device *dev);
>  struct backlight_device *devm_of_find_backlight(struct device *dev);
>  #else
> -static inline struct backlight_device *of_find_backlight(struct device *dev)
> -{
> -	return NULL;
> -}
> -
>  static inline struct backlight_device *
>  devm_of_find_backlight(struct device *dev)
>  {
> -- 
> 2.25.1
> 
