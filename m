From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 12/20] backlight: introduce backlight_get_brightness()
Date: Wed, 8 Jul 2020 11:27:54 +0100
Message-ID: <20200708102754.x3afazd7kbldjg2n@holly.lan>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-13-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200703184546.144664-13-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe
List-Id: linux-pwm@vger.kernel.org

On Fri, Jul 03, 2020 at 08:45:38PM +0200, Sam Ravnborg wrote:
> Based on an idea from Emil Velikov <emil.l.velikov@gmail.com>
> add a helper that checks backlight_is_blank() and return 0 as brightness
> if display is blank or the property value if not.
> 
> This allows us to simplify the update_status() implementation
> in most of the backlight drivers.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
