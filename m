From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
Date: Thu, 4 Jun 2020 16:43:04 +0200
Message-ID: <20200604144304.jxbauv5xy4uj55es@pengutronix.de>
References: <202006031539.4198EA6@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgFDOnJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Jun 2020 10:43:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7541C08C5C0
        for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2020 07:43:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <202006031539.4198EA6@keescook>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Wed, Jun 03, 2020 at 03:40:56PM -0700, Kees Cook wrote:
> The IS_ENABLED() use was missing the CONFIG_ prefix which would have
> lead to skipping this code.
> 
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 9973c442b455..6b3cbc0490c6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>  		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
>  		trace_pwm_get(pwm, &pwm->state);
>  
> -		if (IS_ENABLED(PWM_DEBUG))
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG))
>  			pwm->last = pwm->state;

Thanks

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
