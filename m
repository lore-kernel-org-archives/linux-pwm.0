From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
Date: Mon, 2 Sep 2019 10:42:11 +0100
Message-ID: <20190902094211.GO32232@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-5-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190709190007.91260-5-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, 09 Jul 2019, Matthias Kaehlcke wrote:

> Check if a brightness curve specified in the device tree is linear or
> not and set the corresponding property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> To determine if a curve is linear it is compared to a interpolated linear
> curve between min and max brightness. The curve is considered linear if
> no value deviates more than +/-5% of ${brightness_range} from their
> interpolated value.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes in v3:
> - none
> 
> Changes in v2:
> - use 128 (power of two) instead of 100 as factor for the slope
> - add comment about max quantization error
> - added Daniel's 'Acked-by' tag
> ---
>  drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
