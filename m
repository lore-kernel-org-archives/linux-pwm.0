From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 01/16] video: amba-clcd: use devm_of_find_backlight
Date: Mon, 18 May 2020 12:16:09 +0200
Message-ID: <20200518101609.GA759699@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-2-sam@ravnborg.org>
 <CACRpkdbogVA=12Xzh6jC0AaE7DrH8Z7iVuG3s_gS4MQBYF61Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:39208 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERKQX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 06:16:23 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdbogVA=12Xzh6jC0AaE7DrH8Z7iVuG3s_gS4MQBYF61Dw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, MSM <linux-arm-msm@vger.kernel.org>, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.>

Hi Linus.

On Mon, May 18, 2020 at 10:10:12AM +0200, Linus Walleij wrote:
> On Sun, May 17, 2020 at 9:01 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > Look up backlight device using devm_of_find_backlight().
> > This simplifies the code and prevents us from hardcoding
> > the node name in the driver.
> >
> > v2:
> >   - Added Cc: Peter Ujfalusi
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Thanks. I went ahead and applied this now, so we could kill
the last user of of_find_backlight_by_node().

I hope we can make of_find_backlight_by_node() static after the merge window
so no new users appears.

	Sam
