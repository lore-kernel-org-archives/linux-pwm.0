From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v3] pwm: bcm-iproc: handle clk_get_rate() return
Date: Fri, 17 Jul 2020 16:57:44 -0700
Message-ID: <ebf62731-29bd-078b-e815-55751c9c7ccf@broadcom.com>
References: <20200717231954.11695-1-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQX5v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 19:57:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B80C0619D2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:57:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so12661684eje.1
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:57:51 -0700 (PDT)
In-Reply-To: <20200717231954.11695-1-scott.branden@broadcom.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>



On 7/17/2020 4:19 PM, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Handle clk_get_rate() returning 0 to avoid possible division by zero.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-off-by: Ray Jui <ray.jui@broadcom.com>

Typo. Should be 'Reviewed-by: Ray Jui <ray.jui@broadcom.com>', :)

> 
> ---
> Changes from v2: update commit message to remove <= condition
> as clk_get_rate only returns value >= 0
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee7..d392a828fc49 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -85,8 +85,6 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u64 tmp, multi, rate;
>  	u32 value, prescale;
>  
> -	rate = clk_get_rate(ip->clk);
> -
>  	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>  
>  	if (value & BIT(IPROC_PWM_CTRL_EN_SHIFT(pwm->hwpwm)))
> @@ -99,6 +97,13 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	else
>  		state->polarity = PWM_POLARITY_INVERSED;
>  
> +	rate = clk_get_rate(ip->clk);
> +	if (rate == 0) {
> +		state->period = 0;
> +		state->duty_cycle = 0;
> +		return;
> +	}
> +
>  	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
>  	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
>  	prescale &= IPROC_PWM_PRESCALE_MAX;
> 
