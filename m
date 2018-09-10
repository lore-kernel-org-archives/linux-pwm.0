From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] backlight: pwm_bl: switch to using "atomic" PWM API
Date: Mon, 10 Sep 2018 15:49:24 +0100
Message-ID: <20180910144924.GU28860@dell>
References: <20180814165059.13219-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180814165059.13219-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com, cl@rock-chips.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, 14 Aug 2018, Enric Balletbo i Serra wrote:

> The "atomic" API allows us to configure PWM period and duty_cycle and
> enable it in one call.
> 
> The patch also moves the pwm_init_state just before any use of the
> pwm_state struct, this fixes a potential bug where pwm_get_state
> can be called before pwm_init_state.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Get rid of duty_cycle variable from pwm_backlight_update_status.
> - Get rid of pb->enabled and use only the status.enabled variable.
> - Make power_on match power_off.
> - Do not share status between ...update_status and ...power_on
> 
> Changes in v2:
> - Do not force the PWM be off in the first call to pwm_apply_state.
> - Delayed applying the state until we know what the period is.
> - Removed pb->period as after the conversion is not needed.
> 
>  drivers/video/backlight/pwm_bl.c | 81 +++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 39 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
