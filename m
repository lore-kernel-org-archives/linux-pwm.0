From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 6/6] hwmon: pwm-fan: Update the duty cycle inorder to
 control the pwm-fan
Date: Wed, 08 Apr 2015 10:44:15 +0200
Message-ID: <20150408104415.07e1c821@amdc2363>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
 <1427387955-5129-7-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1427387955-5129-7-git-send-email-linux.amoon@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pwm@vger.kernel.org

Hi Anand,

> Below changes depend on following patch.
> https://patchwork.kernel.org/patch/5944061/
> 
> Update the pwm_config with duty then update the pwm_disable
> to poweroff the cpu fan.
> 
> Tested on OdroidXU3 board.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/hwmon/pwm-fan.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 7c83dc4..f25c841 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -44,26 +44,24 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx,
> unsigned long pwm) int ret = 0;
>  
>  	mutex_lock(&ctx->lock);
> +
>  	if (ctx->pwm_value == pwm)
>  		goto exit_set_pwm_err;
>  
> -	if (pwm == 0) {
> -		pwm_disable(ctx->pwm);
> -		goto exit_set_pwm;
> -	}
> -
>  	duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
>  	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
>  	if (ret)
>  		goto exit_set_pwm_err;
>  
> +	if (pwm == 0)
> +		pwm_disable(ctx->pwm);
> +
>  	if (ctx->pwm_value == 0) {
>  		ret = pwm_enable(ctx->pwm);
>  		if (ret)
>  			goto exit_set_pwm_err;
>  	}
>  
> -exit_set_pwm:
>  	ctx->pwm_value = pwm;
>  exit_set_pwm_err:
>  	mutex_unlock(&ctx->lock);

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

BTW: I've added Guenter to CC.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
