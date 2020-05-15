From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v1 01/18] drm/omap: display: use devm_of_find_backlight
Date: Fri, 15 May 2020 11:24:53 +0300
Message-ID: <6d733332-35d9-7799-c0e5-9f012485d738@ti.com>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-2-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44720 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgEOI0Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 May 2020 04:26:24 -0400
In-Reply-To: <20200514191001.457441-2-sam@ravnborg.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Allison Randal <allison@lohutok.net>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Enrico Weigelt <info@metux.net>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael

On 14/05/2020 22:09, Sam Ravnborg wrote:
> Look up backlight device using devm_of_find_backlight().
> This simplifies the code and prevents us from hardcoding
> the node name in the driver.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Zheng Bin <zhengbin13@huawei.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Enrico Weigelt <info@metux.net>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>   .../gpu/drm/omapdrm/displays/panel-dsi-cm.c    | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
