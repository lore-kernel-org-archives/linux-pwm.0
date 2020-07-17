From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH] pwm: bcm-iproc: handle clk_get_rate() return
Date: Fri, 17 Jul 2020 10:22:13 -0700
Message-ID: <94f2aed1-d88d-3ee0-6e57-917f665951f2@broadcom.com>
References: <20200717170743.25466-1-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgGQRWU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 13:22:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B8C0619D2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 10:22:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so18384231wmf.0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 10:22:20 -0700 (PDT)
In-Reply-To: <20200717170743.25466-1-scott.branden@broadcom.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>



On 7/17/2020 10:07 AM, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Handle clk_get_rate() returning <= 0 condition to avoid
> possible division by zero.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee7..72a8607b6c8d 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -86,6 +86,11 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u32 value, prescale;
>  
>  	rate = clk_get_rate(ip->clk);
> +	if (rate == 0) {
> +		state->period = 0;
> +		state->duty_cycle = 0;
> +		return;
> +	}

Based on the pwm core code, 'get_state' expects the following fields to
be populated: 'polarity', 'enabled', 'period', and 'duty cycle'.

The above logic will leave 'polarity' and 'enabled' completely
unpopulated when clock rate is zero.

>  
>  	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>  
> 
