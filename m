From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4] backlight: pwm_bl: Fix uninitialized variable
Date: Wed, 25 Jul 2018 09:03:55 +0100
Message-ID: <20180725080355.GC5835@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180725073830.31421-1-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180725073830.31421-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 25 Jul 2018, Daniel Thompson wrote:

> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix with a simple initialize to zero.
> 
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between brightness-levels")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Notes:
>     v4:
>      - Remove line break from Fixes: and update the *-by:s
>     
>     v3:
>      - Switch to the simplest fix and zero the uninitialized variable. git
>        grep indicates that ~25% of calls to of_property_read_u32() use this
>        pattern (pre-initialize optional properties with sane values and
>        ignore the return code).
>     
>     v2:
>      - Simplify SoB chain (with Marcel's permission)
>      - Separate complex if statement and make other similar calls use same
>        return code checking approach
>      - Tidy up comment formatting and fix pre-existing grammar error
> 
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
