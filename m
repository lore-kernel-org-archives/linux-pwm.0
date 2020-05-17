From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 01/18] drm/omap: display: use devm_of_find_backlight
Date: Sun, 17 May 2020 14:58:05 +0200
Message-ID: <20200517125805.GA620358@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-2-sam@ravnborg.org>
 <6d733332-35d9-7799-c0e5-9f012485d738@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:40454 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgEQM6Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 08:58:16 -0400
Content-Disposition: inline
In-Reply-To: <6d733332-35d9-7799-c0e5-9f012485d738@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Andy Gross <agross@kernel.org>, Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jani Nikula <jani.nikul>

On Fri, May 15, 2020 at 11:24:53AM +0300, Tomi Valkeinen wrote:
> On 14/05/2020 22:09, Sam Ravnborg wrote:
> > Look up backlight device using devm_of_find_backlight().
> > This simplifies the code and prevents us from hardcoding
> > the node name in the driver.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Zheng Bin <zhengbin13@huawei.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: Enrico Weigelt <info@metux.net>
> > Cc: Allison Randal <allison@lohutok.net>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > ---
> >   .../gpu/drm/omapdrm/displays/panel-dsi-cm.c    | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, pushed to drm-misc-next.

	Sam

> 
>  Tomi
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
