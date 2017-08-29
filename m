From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2] pwm_bl: Fix overflow condition
Date: Tue, 29 Aug 2017 13:46:58 -0700
Message-ID: <20170829204656.GA12941@google.com>
References: <20170829203434.6826-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170829203434.6826-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, thierry.reding@gmail.com, jingoohan1@gmail.com, lee.jones@linaro.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 29, 2017 at 01:34:34PM -0700, Derek Basehore wrote:
> This fixes an overflow condition that can happen with high max
> brightness and period values in compute_duty_cycle. This fixes it by
> using a 64 bit variable for computing the duty cycle.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---

I believe this is the correct v2 patch, and I agree that Derek is
confused by his mail client :)

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  drivers/video/backlight/pwm_bl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 76311ec5e400..5ccc8e34b7a6 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -88,14 +88,17 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
>  {
>  	unsigned int lth = pb->lth_brightness;
> -	int duty_cycle;
> +	u64 duty_cycle;
>  
>  	if (pb->levels)
>  		duty_cycle = pb->levels[brightness];
>  	else
>  		duty_cycle = brightness;
>  
> -	return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
> +	duty_cycle *= pb->period - lth;
> +	do_div(duty_cycle, pb->scale);
> +
> +	return duty_cycle + lth;
>  }
>  
>  static int pwm_backlight_update_status(struct backlight_device *bl)
> -- 
> 2.14.1.342.g6490525c54-goog
> 
