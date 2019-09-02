From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: Set scale type for CIE 1931
 curves
Date: Mon, 2 Sep 2019 10:41:50 +0100
Message-ID: <20190902094150.GN32232@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-4-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190709190007.91260-4-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, 09 Jul 2019, Matthias Kaehlcke wrote:

> For backlight curves calculated with the CIE 1931 algorithm set
> the brightness scale type to non-linear. This makes the scale type
> available to userspace via the 'scale' sysfs attribute.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes in v3:
> - mark scale as non-linear instead of using the CIE1931 type which
>   has been removed
> - updated commit message
> 
> Changes in v2:
> - added Enric's 'Tested-by' tag
> - added Daniel's 'Acked-by' tag
> ---
>  drivers/video/backlight/pwm_bl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
