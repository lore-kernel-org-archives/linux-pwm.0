From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v3 12/13] backlight: as3711_bl: introduce
 backlight_is_blank()
Date: Mon, 1 Jun 2020 11:35:24 +0100
Message-ID: <20200601103524.7s6523ijpfqcolrm@holly.lan>
References: <20200601065207.492614-1-sam@ravnborg.org>
 <20200601065207.492614-13-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKf3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 06:35:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E477C061A0E
        for <linux-pwm@vger.kernel.org>; Mon,  1 Jun 2020 03:35:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so10936082wrw.8
        for <linux-pwm@vger.kernel.org>; Mon, 01 Jun 2020 03:35:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200601065207.492614-13-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe

On Mon, Jun 01, 2020 at 08:52:06AM +0200, Sam Ravnborg wrote:
> Replaces the open-coded checks of the state, with the
> backlight_is_blank() helper. This increases readability
> of the code and aling the functionality across the drivers.
> 
> Futhermore drop the debug prints in update_status().
> If we need debug printing then we can add it to the backlight core.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> ---
>  drivers/video/backlight/as3711_bl.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
> index 33f0f0f2e8b3..cc5628beaffd 100644
> --- a/drivers/video/backlight/as3711_bl.c
> +++ b/drivers/video/backlight/as3711_bl.c
> @@ -107,13 +107,7 @@ static int as3711_bl_update_status(struct backlight_device *bl)
>  	int brightness = bl->props.brightness;
>  	int ret = 0;
>  
> -	dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
> -		__func__, bl->props.brightness, bl->props.power,
> -		bl->props.fb_blank, bl->props.state);
> -
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	if (data->type == AS3711_BL_SU1) {
> -- 
> 2.25.1
> 
