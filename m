From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v10 02/12] hwmon: pwm-fan: Use 64-bit division macro
Date: Thu, 19 Mar 2020 14:12:02 -0700
Message-ID: <4c99e36b-4705-a6a2-0769-301b5e9b5006@roeck-us.net>
References: <cover.1584650604.git.gurus@codeaurora.org>
 <b8d8e51723f99844abc6a3f637ac42be3e084709.1584650604.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39250 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSVMH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 17:12:07 -0400
In-Reply-To: <b8d8e51723f99844abc6a3f637ac42be3e084709.1584650604.git.gurus@codeaurora.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org

On 3/19/20 1:50 PM, Guru Das Srinagesh wrote:
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

https://patchwork.kernel.org/patch/11430549/

includes my previous Ack. v9 included it, in v10 it is dropped.
I don't see a change in the patch. Please explain.

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
> 
