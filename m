From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 08/18] backlight: add backlight_is_blank()
Date: Thu, 14 May 2020 21:41:16 +0200
Message-ID: <20200514194116.GB206103@phenom.ffwll.local>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-9-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727909AbgENTlW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:41:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA346C061A0E
        for <linux-pwm@vger.kernel.org>; Thu, 14 May 2020 12:41:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so31956617wmj.3
        for <linux-pwm@vger.kernel.org>; Thu, 14 May 2020 12:41:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200514191001.457441-9-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Allison Randal <allison@lohutok.net>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Enrico Weigelt <info@metux.net>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-ms

On Thu, May 14, 2020 at 09:09:51PM +0200, Sam Ravnborg wrote:
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
> as thus not needed in this helper function.
> Rolling out this helper to all relevant backlight drivers
> will eliminate almost all accesses to fb_blank.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  include/linux/backlight.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index b7839ea9d00a..e67e926de1e2 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -165,6 +165,23 @@ static inline int backlight_disable(struct backlight_device *bd)
>  	return backlight_update_status(bd);
>  }
>  
> +/**
> + * backlight_is_blank - Return true if display is expected to be blank
> + * @bd: the backlight device
> + *
> + * Display is expected to be blank if any of these is true::
> + *
> + *   1) if power in not UNBLANK
> + *   2) if state indicate BLANK or SUSPENDED
> + *
> + * Returns true if display is expected to be blank, false otherwise.
> + */
> +static inline bool backlight_is_blank(struct backlight_device *bd)
> +{
> +	return bd->props.power != FB_BLANK_UNBLANK ||
> +	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);

This definition here doesn't match backlight_enabled/disable() functions
we added. I think to avoid lots of pondering and surprises we should try
to make sure these are all matching, so that once we rolled them out
everywhere, we can just replace the complicated state with one flag.
-Daniel

> +}
> +
>  extern struct backlight_device *backlight_device_register(const char *name,
>  	struct device *dev, void *devdata, const struct backlight_ops *ops,
>  	const struct backlight_properties *props);
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
