From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] backlight: pwm_bl: Fix brightness levels for non-DT case.
Date: Sat, 25 Aug 2018 10:04:10 +0200
Message-ID: <87h8ji98jp.fsf@belgarion.home>
References: <20180824155402.2822-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824155402.2822-1-enric.balletbo@collabora.com> (Enric
        Balletbo i. Serra's message of "Fri, 24 Aug 2018 17:54:02 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org, lee.jones@linaro.org, kernel@collabora.com, heiko@sntech.de, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Enric Balletbo i Serra <enric.balletbo@collabora.com> writes:

> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye")' allows the possibility to compute a default
> brightness table when there isn't the brightness-levels property in the
> DT. Unfortunately the changes made broke the pwm backlight for the
> non-DT boards.
>
> Usually, the non-DT boards don't pass the brightness levels via platform
> data, instead, they set the max_brightness in their platform data and the
> driver calculates the level without a table. The ofending patch assumed
> that when there is no brightness levels table we should create one, but this
> is clearly wrong for the non-DT case.
>
> After this patch the code handles the DT and the non-DT case taking in
> consideration also if max_brightness is set or not. The default table is
> only created when neither, brightness-levels and max_brightness, are
> set.
>
> The patch also fixes another issue found by Robert. Before this patch
> looks like a division by 0 was possible when state.period returned 0 by
> pwm_get_state(). This is because pwm_get_state() was called before
> pwm_apply_args() so state.period was not initialized. The patch moves
> the pwm_apply_args() call before any call to pwm_get_state().
>
> Fixes: '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")'
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
