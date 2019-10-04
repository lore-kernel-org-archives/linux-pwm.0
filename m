From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Add missing curly branches in else
 branch
Date: Fri, 4 Oct 2019 10:53:19 +0100
Message-ID: <20191004095319.dkcjemag65xgsmp5@holly.lan>
References: <20191003213502.102110-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191003213502.102110-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Oct 03, 2019 at 02:35:02PM -0700, Matthias Kaehlcke wrote:
> Add curly braces to an 'else' branch in pwm_backlight_update_status()
> to match the corresponding 'if' branch.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 746eebc411df..130abff2705f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -125,8 +125,9 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  		state.duty_cycle = compute_duty_cycle(pb, brightness);
>  		pwm_apply_state(pb->pwm, &state);
>  		pwm_backlight_power_on(pb);
> -	} else
> +	} else {
>  		pwm_backlight_power_off(pb);
> +	}
>  
>  	if (pb->notify_after)
>  		pb->notify_after(pb->dev, brightness);
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
