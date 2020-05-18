From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 14/16] backlight: drop backlight_put()
Date: Mon, 18 May 2020 17:53:50 +0100
Message-ID: <20200518165350.batfdp2tp4rvamzb@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-15-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQxy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:53:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60567C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:53:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g14so426544wme.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:53:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-15-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.

On Sun, May 17, 2020 at 09:01:37PM +0200, Sam Ravnborg wrote:
> There are no external users of backlight_put().
> Drop it and open code the two users in backlight.c.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/backlight.c |  7 +++++--
>  include/linux/backlight.h           | 10 ----------
>  2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index e23b09d03a65..7f3eecaf8317 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -679,7 +679,10 @@ static struct backlight_device *of_find_backlight(struct device *dev)
>  
>  static void devm_backlight_release(void *data)
>  {
> -	backlight_put(data);
> +	struct backlight_device *bd = data;
> +
> +	if (bd)
> +		put_device(&bd->dev);
>  }
>  
>  /**
> @@ -707,7 +710,7 @@ struct backlight_device *devm_of_find_backlight(struct device *dev)
>  		return bd;
>  	ret = devm_add_action(dev, devm_backlight_release, bd);
>  	if (ret) {
> -		backlight_put(bd);
> +		put_device(&bd->dev);
>  		return ERR_PTR(ret);
>  	}
>  	return bd;
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 99e7cdace2be..d92e523650ec 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -415,16 +415,6 @@ static inline int backlight_disable(struct backlight_device *bd)
>  	return backlight_update_status(bd);
>  }
>  
> -/**
> - * backlight_put - Drop backlight reference
> - * @bd: the backlight device to put
> - */
> -static inline void backlight_put(struct backlight_device *bd)
> -{
> -	if (bd)
> -		put_device(&bd->dev);
> -}
> -
>  /**
>   * backlight_is_blank - Return true if display is expected to be blank
>   * @bd: the backlight device
> -- 
> 2.25.1
> 
