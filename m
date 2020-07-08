From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 19/20] backlight: make of_find_backlight static
Date: Wed, 8 Jul 2020 12:17:16 +0100
Message-ID: <20200708111716.rsk2ogutkjpku7kc@holly.lan>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-20-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200703184546.144664-20-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe
List-Id: linux-pwm@vger.kernel.org

On Fri, Jul 03, 2020 at 08:45:45PM +0200, Sam Ravnborg wrote:
> There are no external users of of_find_backlight,
> as they have all changed to use the managed version.
> Make of_find_backlight static to prevent new external users.
> 
> v3:
>   - Move doc for devm_of_find_backlight out of this patch
> 
> v2:
>   - Editorial corrections (Daniel)
>   - Returns => RETURNS (Daniel)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
