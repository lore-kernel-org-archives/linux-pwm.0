From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3] backlight: pwm_bl: Fix uninitialized variable
Date: Tue, 24 Jul 2018 16:56:07 -0700
Message-ID: <CAD=FV=W9WZVS28++mF+yOCREW3iHWahJuAx=ySODA18ResDXog@mail.gmail.com>
References: <20180716210241.9457-1-daniel.thompson@linaro.org> <20180724071223.18901-1-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724071223.18901-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Patch Tracking <patches@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 12:12 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix with a simple initialize to zero.
>
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> brightness-levels")

I think it may be incorrect to word-wrap the Fixes line.  A quick grep
through the source code looks like others agree.

> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>
> Notes:
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

Other than the nit on the commit message, this simple fix seems sane.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
