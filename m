From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v2 02/16] backlight: refactor fb_notifier_callback()
Date: Wed, 20 May 2020 11:41:46 +0100
Message-ID: <CACvgo50p6M59C-cdwCUFYNE7pWBA-oTwa9EN90yrkOkW2S-BKA@mail.gmail.com>
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-3-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETKon (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 06:44:43 -0400
In-Reply-To: <20200517190139.740249-3-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Michael Hennerich <michael.hennerich@analog.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Douglas Anderson <dianders@chromium.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jani Nikula <jani.nikula@intel.com>, Andy Gross <agross@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Thomas

Hi Sam,

On Sun, 17 May 2020 at 20:02, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Increase readability of fb_notifier_callback() by removing
> a few indent levels.
> No functional change.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/backlight.c | 43 +++++++++++++++--------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index cac3e35d7630..17f04cff50ab 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -58,28 +58,29 @@ static int fb_notifier_callback(struct notifier_block *self,
>
>         bd = container_of(self, struct backlight_device, fb_notif);
>         mutex_lock(&bd->ops_lock);
> -       if (bd->ops)
> -               if (!bd->ops->check_fb ||
> -                   bd->ops->check_fb(bd, evdata->info)) {
> -                       fb_blank = *(int *)evdata->data;
> -                       if (fb_blank == FB_BLANK_UNBLANK &&
> -                           !bd->fb_bl_on[node]) {
> -                               bd->fb_bl_on[node] = true;
> -                               if (!bd->use_count++) {
> -                                       bd->props.state &= ~BL_CORE_FBBLANK;
> -                                       bd->props.fb_blank = FB_BLANK_UNBLANK;
> -                                       backlight_update_status(bd);
> -                               }
> -                       } else if (fb_blank != FB_BLANK_UNBLANK &&
> -                                  bd->fb_bl_on[node]) {
> -                               bd->fb_bl_on[node] = false;
> -                               if (!(--bd->use_count)) {
> -                                       bd->props.state |= BL_CORE_FBBLANK;
> -                                       bd->props.fb_blank = fb_blank;
> -                                       backlight_update_status(bd);
> -                               }
> -                       }
> +
> +       if (!bd->ops)
> +               goto out;
> +       if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
Mildly related: Would be a nice to define which ops are mandatory and
which aren't.
That plus enforcement in backlight_device_register.

But that's for another patchset.

> +               goto out;
> +
> +       fb_blank = *(int *)evdata->data;
> +       if (fb_blank == FB_BLANK_UNBLANK && !bd->fb_bl_on[node]) {
> +               bd->fb_bl_on[node] = true;
> +               if (!bd->use_count++) {
> +                       bd->props.state &= ~BL_CORE_FBBLANK;
> +                       bd->props.fb_blank = FB_BLANK_UNBLANK;
> +                       backlight_update_status(bd);
> +               }
> +       } else if (fb_blank != FB_BLANK_UNBLANK && bd->fb_bl_on[node]) {
> +               bd->fb_bl_on[node] = false;
> +               if (!(--bd->use_count)) {
> +                       bd->props.state |= BL_CORE_FBBLANK;
> +                       bd->props.fb_blank = fb_blank;
> +                       backlight_update_status(bd);
>                 }
Something like the following reads better, plus one could simplify it
with follow-on patch.

if (fb_blank == FB_BLANK_UNBLANK)
    if (!bd->fb_bl_on[node] && !bd->use_count++) {
        bd->props.state &= ~BL_CORE_FBBLANK;
        bd->props.fb_blank = FB_BLANK_UNBLANK;
        backlight_update_status(bd);
        // above is backlight_enable()
    }
    bd->fb_bl_on[node] = true;
} else {
    if (bd->fb_bl_on[node] && !(--bd->use_count)) {
        bd->props.state |= BL_CORE_FBBLANK;
        bd->props.fb_blank = fb_blank;
        backlight_update_status(bd);
        // above is backlight_disable()
   }
    bd->fb_bl_on[node] = false;
}

As-is, one cannot use the backlight helpers indicated, since it
touches .power. First one should ensure the drivers honour .power - by
using the helper introduced later.

-Emil
