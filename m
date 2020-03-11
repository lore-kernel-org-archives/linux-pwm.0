From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v8 03/12] hwmon: pwm-fan: Use 64-bit division macro
Date: Wed, 11 Mar 2020 08:08:16 -0700
Message-ID: <20200311150816.GA10018@roeck-us.net>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <237b1b5ae59d072b576d300cdc0c2a1242b18516.1583889178.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <237b1b5ae59d072b576d300cdc0c2a1242b18516.1583889178.git.gurus@codeaurora.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 10, 2020 at 06:41:12PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by using DIV_ROUND_UP_ULL to handle
> a 64-bit dividend.
> 
> Cc: Kamil Debski <kamil@wypas.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-hwmon@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Not sure if I entirely buy the use case, but then the performance
impact is minimal, at least for this driver, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 42ffd2e..283423a 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -437,7 +437,7 @@ static int pwm_fan_resume(struct device *dev)
>  		return 0;
>  
>  	pwm_get_args(ctx->pwm, &pargs);
> -	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
> +	duty = DIV_ROUND_UP_ULL(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
>  	ret = pwm_config(ctx->pwm, duty, pargs.period);
>  	if (ret)
>  		return ret;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
