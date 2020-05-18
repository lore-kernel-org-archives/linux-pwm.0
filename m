From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 12/16] backlight: wire up kernel-doc documentation
Date: Mon, 18 May 2020 17:50:40 +0100
Message-ID: <20200518165040.4es3gdydes4so72k@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-13-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-13-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.
List-Id: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:35PM +0200, Sam Ravnborg wrote:
> Include backlight so the documentation is now generated
> with make htmldocs and friends.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  Documentation/gpu/backlight.rst | 12 ++++++++++++
>  Documentation/gpu/index.rst     |  1 +
>  2 files changed, 13 insertions(+)
>  create mode 100644 Documentation/gpu/backlight.rst
> 
> diff --git a/Documentation/gpu/backlight.rst b/Documentation/gpu/backlight.rst
> new file mode 100644
> index 000000000000..9ebfc9d0aced
> --- /dev/null
> +++ b/Documentation/gpu/backlight.rst
> @@ -0,0 +1,12 @@
> +=================
> +Backlight support
> +=================
> +
> +.. kernel-doc:: drivers/video/backlight/backlight.c
> +   :doc: overview
> +
> +.. kernel-doc:: include/linux/backlight.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/video/backlight/backlight.c
> +   :export:
> diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
> index 1fcf8e851e15..c9a51e3bfb5a 100644
> --- a/Documentation/gpu/index.rst
> +++ b/Documentation/gpu/index.rst
> @@ -12,6 +12,7 @@ Linux GPU Driver Developer's Guide
>     drm-uapi
>     drm-client
>     drivers
> +   backlight
>     vga-switcheroo
>     vgaarbiter
>     todo
> -- 
> 2.25.1
> 
