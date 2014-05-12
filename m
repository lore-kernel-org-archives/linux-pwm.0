From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH] pwm: samsung: do not set manual update bit in pwm_samsung_config
Date: Mon, 12 May 2014 19:11:40 +0200
Message-ID: <537100CC.8070509@gmail.com>
References: <1399906581-29298-1-git-send-email-ajaykumar.rs@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:46459 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbaELRLt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 May 2014 13:11:49 -0400
In-Reply-To: <1399906581-29298-1-git-send-email-ajaykumar.rs@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ajay Kumar <ajaykumar.rs@samsung.com>, linux-pwm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, ajaynumb@gmail.com, thierry.reding@gmail.com, abrestic@chromium.org, jg1.han@samsung.com, sachin.kamat@linaro.org, joshi@samsung.com, prashanth.g@samsung.com

Hi Ajay,

On 12.05.2014 16:56, Ajay Kumar wrote:
> pwm_samsung_config sets manual update bit via call to
> pwm_samsung_enable even when the channel is already running.
> This causes noticable flickers on display if we try to change
> the backlight value from 0 to MAX, continiously.
> 
> So, we remove the call to pwm_samsung_enable from
> pwm_samsung_config to avoid the flicker and this change doesn't
> harm normal working since the pwm_bl core already takes care of
> calling pwm_samsung_enable whenever needed.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index d66529a..ba6b650 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -335,9 +335,6 @@ static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
>  	writel(tcmp, our_chip->base + REG_TCMPB(pwm->hwpwm));
>  
> -	if (test_bit(PWMF_ENABLED, &pwm->flags))
> -		pwm_samsung_enable(chip, pwm);
> -
>  	chan->period_ns = period_ns;
>  	chan->tin_ns = tin_ns;
>  	chan->duty_ns = duty_ns;
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
