From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 0/18] backlight updates
Date: Fri, 15 May 2020 22:48:29 +0200
Message-ID: <20200515204829.GB543522@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Allison Randal <allison@lohutok.net>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Enrico Weigelt <info@metux.net>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael
List-Id: linux-pwm@vger.kernel.org

Hi all.
i
...

> Sam Ravnborg (18):
>       drm/omap: display: use devm_of_find_backlight
>       drm/tilcdc: use devm_of_find_backlight
Tomi - thanks for the prompt review of the above two patches.

>       video: amba-clcd: use devm_of_find_backlight
Any takes for review/ack of this patch?

>       backlight: make of_find_backlight static
>       backlight: drop backlight_put()
>       backlight: make of_find_backlight_by_node() static
The above three patches are moved to the end of the patchset in v2.
They cannot be applied before the users are gone.
As we will remove users of of_find_backlight_by_node() in
drm-misc-next, we can only merge the "make static" patches in the
backlight tree after the merge window.
So move them to the end so we may apply other patches before.

I plan to send v2 end of the weekend, and hope for some feedback on the
doc pathches until then.

	Sam

>       backlight: refactor fb_notifier_callback()
>       backlight: add backlight_is_blank()
>       backlight: improve backlight_ops documentation
>       backlight: improve backlight_properties documentation
>       backlight: improve backlight_device documentation
>       backlight: document inline functions in backlight.h
>       backlight: document enums in backlight.h
>       backlight: remove the unused backlight_bl driver
>       backlight: drop extern from prototypes
>       backlight: add overview and update doc
>       backlight: wire up kernel-doc documentation
>       backlight: use backlight_is_blank() in all backlight drivers
> 
>  Documentation/gpu/backlight.rst                 |  12 +
>  Documentation/gpu/index.rst                     |   1 +
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c |  18 +-
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c           |  17 +-
>  drivers/video/backlight/88pm860x_bl.c           |   8 +-
>  drivers/video/backlight/Kconfig                 |   8 -
>  drivers/video/backlight/Makefile                |   1 -
>  drivers/video/backlight/adp5520_bl.c            |   5 +-
>  drivers/video/backlight/adp8860_bl.c            |   5 +-
>  drivers/video/backlight/adp8870_bl.c            |   5 +-
>  drivers/video/backlight/as3711_bl.c             |   8 +-
>  drivers/video/backlight/backlight.c             | 237 ++++++++------
>  drivers/video/backlight/bd6107.c                |   4 +-
>  drivers/video/backlight/corgi_lcd.c             |   5 +-
>  drivers/video/backlight/cr_bllcd.c              |  22 +-
>  drivers/video/backlight/da903x_bl.c             |   8 +-
>  drivers/video/backlight/ep93xx_bl.c             |   3 +-
>  drivers/video/backlight/generic_bl.c            | 110 -------
>  drivers/video/backlight/gpio_backlight.c        |   4 +-
>  drivers/video/backlight/hp680_bl.c              |   4 +-
>  drivers/video/backlight/jornada720_bl.c         |   2 +-
>  drivers/video/backlight/kb3886_bl.c             |   4 +-
>  drivers/video/backlight/led_bl.c                |   4 +-
>  drivers/video/backlight/lm3533_bl.c             |   4 +-
>  drivers/video/backlight/locomolcd.c             |   4 +-
>  drivers/video/backlight/lv5207lp.c              |   4 +-
>  drivers/video/backlight/max8925_bl.c            |   8 +-
>  drivers/video/backlight/pwm_bl.c                |   4 +-
>  drivers/video/backlight/qcom-wled.c             |   4 +-
>  drivers/video/backlight/tps65217_bl.c           |   4 +-
>  drivers/video/backlight/wm831x_bl.c             |   8 +-
>  drivers/video/fbdev/amba-clcd.c                 |  19 +-
>  include/linux/backlight.h                       | 415 +++++++++++++++++++-----
>  33 files changed, 536 insertions(+), 433 deletions(-)
> 
