From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v2 03/16] backlight: add backlight_is_blank()
Date: Wed, 20 May 2020 11:45:06 +0100
Message-ID: <CACvgo52AegdsmfOsVoTHH=oporeMMV8bShQMJC11JiO5bNXwrQ@mail.gmail.com>
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-4-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKsC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 06:48:02 -0400
In-Reply-To: <20200517190139.740249-4-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Michael Hennerich <michael.hennerich@analog.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Douglas Anderson <dianders@chromium.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jani Nikula <jani.nikula@intel.com>, Andy Gross <agross@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Thomas

On Sun, 17 May 2020 at 20:02, Sam Ravnborg <sam@ravnborg.org> wrote:
>
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
Nit: please tweak your editor to wrap commit messages at 72 columns.

> v2:
>   - Added fb_blank condition (Daniel)
>
I was going to mention this, but Daniel beat me to it.

Please add an extra NOTE in the commit message. The fb_blank is a
behaviour change, albeit in the right direction.

-Emil
