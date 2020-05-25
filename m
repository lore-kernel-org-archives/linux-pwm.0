From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 01/16] video: amba-clcd: use devm_of_find_backlight
Date: Mon, 25 May 2020 10:42:26 +0200
Message-ID: <CACRpkdY=ROLjHb70=tckOPUDBoinT4XtcUvZSaNxND7HZD5H+g@mail.gmail.com>
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-2-sam@ravnborg.org>
 <CACRpkdbogVA=12Xzh6jC0AaE7DrH8Z7iVuG3s_gS4MQBYF61Dw@mail.gmail.com> <20200518101609.GA759699@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388945AbgEYImj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 04:42:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F187C05BD43
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 01:42:38 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z22so10122645lfd.0
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 01:42:38 -0700 (PDT)
In-Reply-To: <20200518101609.GA759699@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, MSM <linux-arm-msm@vger.kernel.org>, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.>

On Mon, May 18, 2020 at 12:16 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Linus.
>
> On Mon, May 18, 2020 at 10:10:12AM +0200, Linus Walleij wrote:
> > On Sun, May 17, 2020 at 9:01 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > > Look up backlight device using devm_of_find_backlight().
> > > This simplifies the code and prevents us from hardcoding
> > > the node name in the driver.
> > >
> > > v2:
> > >   - Added Cc: Peter Ujfalusi
> > >
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Jani Nikula <jani.nikula@intel.com>
> > > Cc: Douglas Anderson <dianders@chromium.org>
> >
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Thanks. I went ahead and applied this now, so we could kill
> the last user of of_find_backlight_by_node().
>
> I hope we can make of_find_backlight_by_node() static after the merge window
> so no new users appears.

For this driver (drivers/video/fbdev/amba-clcd.c) there are zero
users after the merge window (all users moved over to DRM) so
I plan to retire it completely.

Yours,
Linus Walleij
