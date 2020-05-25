From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 01/16] video: amba-clcd: use devm_of_find_backlight
Date: Mon, 25 May 2020 13:01:11 +0200
Message-ID: <20200525110111.GA14873@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-2-sam@ravnborg.org>
 <CACRpkdbogVA=12Xzh6jC0AaE7DrH8Z7iVuG3s_gS4MQBYF61Dw@mail.gmail.com>
 <20200518101609.GA759699@ravnborg.org>
 <CACRpkdY=ROLjHb70=tckOPUDBoinT4XtcUvZSaNxND7HZD5H+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:60998 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYLBU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 07:01:20 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdY=ROLjHb70=tckOPUDBoinT4XtcUvZSaNxND7HZD5H+g@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, MSM <linux-arm-msm@vger.kernel.org>, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.>

Hi Linus.

> For this driver (drivers/video/fbdev/amba-clcd.c) there are zero
> users after the merge window (all users moved over to DRM) so
> I plan to retire it completely.

Sounds like a brilliant plan.

	Sam
