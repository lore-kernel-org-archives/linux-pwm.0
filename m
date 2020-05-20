From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v2 16/16] backlight: use backlight_is_blank() in all
 backlight drivers
Date: Wed, 20 May 2020 11:56:43 +0100
Message-ID: <CACvgo51C6zb_K3DBwG-xhf9=baoxmcp8YeCFEyB3XvqA5p7r2A@mail.gmail.com>
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-17-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETK7l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 06:59:41 -0400
In-Reply-To: <20200517190139.740249-17-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Michael Hennerich <michael.hennerich@analog.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Douglas Anderson <dianders@chromium.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jani Nikula <jani.nikula@intel.com>, Andy Gross <agross@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Thomas

Hi Sam,

On Sun, 17 May 2020 at 20:02, Sam Ravnborg <sam@ravnborg.org> wrote:

> --- a/drivers/video/backlight/88pm860x_bl.c
> +++ b/drivers/video/backlight/88pm860x_bl.c
> @@ -123,13 +123,7 @@ static int pm860x_backlight_update_status(struct backlight_device *bl)
>  {
>         int brightness = bl->props.brightness;
>
> -       if (bl->props.power != FB_BLANK_UNBLANK)
> -               brightness = 0;
> -
> -       if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> -               brightness = 0;
> -
> -       if (bl->props.state & BL_CORE_SUSPENDED)
> +       if (backlight_is_blank(bl))
>                 brightness = 0;
Off the top of my head, the above two lines should really be in backlight core.
There's nothing driver specific to them, plus it minimises the chances
of next-driver getting it wrong.


> --- a/drivers/video/backlight/as3711_bl.c
> +++ b/drivers/video/backlight/as3711_bl.c
> @@ -107,13 +107,11 @@ static int as3711_bl_update_status(struct backlight_device *bl)
>         int brightness = bl->props.brightness;
>         int ret = 0;
>
> -       dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
> +       dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, state %x\n",
>                 __func__, bl->props.brightness, bl->props.power,
> -               bl->props.fb_blank, bl->props.state);
> +               bl->props.state);
>
Let's also move this to backlight core.

-Emil
